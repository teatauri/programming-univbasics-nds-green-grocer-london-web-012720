def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if name == collection[i][:item] 
      return collection[i]
    else
      nil
    end
    i += 1  
  end
end 
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

def consolidate_cart(cart)
  consol_cart = []
  i = 0
  while i < cart.length
    new_item = find_item_by_name_in_collection(cart[i][:item], consol_cart)
    if new_item
      new_item[:count] += 1
    else
      new_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
      consol_cart << new_item
    end
  i += 1
  end
  consol_cart
end

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length
    item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item = "#{coupons[i][:item]} W/COUPON"
    cart_item_coupon = find_item_by_name_in_collection(couponed_item, cart)
    if item && item[:count] >= coupons[i][:num]
      if cart_item_coupon
        cart_item_coupon[:count] += coupons[i][:num]
        item[:count] -= coupons[:counter][:num]
      else
        cart_item_coupon = {
          :item => couponed_item,
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => item[:clearance]
        }
        cart << cart_item_coupon
        item[:count] -= coupons[i][:num]
      end
    end
  i += 1
  end
  cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end 
  i += 1
  end 
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  fin_cart = apply_clearance(couponed_cart)
  total = 0
  i = 0
  while i < fin_cart.length
    total += (fin_cart[i][:price] * fin_cart[i][:count])
  i += 1 
  end 
  total >= 100 ? (total = total * 0.9) : total  
 total 
end

