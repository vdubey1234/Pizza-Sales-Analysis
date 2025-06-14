
--  Total Revenue

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;
 
-- Average Order Value

SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales;
 
-- Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;
 
-- Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;
 
--  Average Pizzas Per Order

SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) / 
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
        AS DECIMAL(10,2)
    ) AS Average_Pizzas_Sold_PerOrder
FROM pizza_sales;
 
 --Chart Queries
-- Daily Trend for Total Orders

SELECT 
    COUNT(DISTINCT order_id) AS Number_Of_Order,
    order_date
FROM pizza_sales
GROUP BY order_date;

   --By Day of Week

SELECT 
    DATENAME(DW, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS Number_Of_Order
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);
 
-- Hourly Trend

SELECT 
    DATEPART(HOUR, order_time) AS order_time,
    COUNT(DISTINCT order_id) AS Number_Of_Order
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);
 
--Sales by Category (January)

SELECT 
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 / 
        (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) 
        AS Percentage_Category_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;
 
 --Quarterly Sales by Category (Q1)

SELECT 
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 / 
        (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) 
        AS Percentage_Category_Sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_category;
 
--Percentage Sales by Pizza Size

SELECT 
    pizza_size,
    SUM(total_price) AS Total_Sales,
    CAST(SUM(total_price) AS DECIMAL(10,2)) * 100 / 
        (SELECT SUM(total_price) FROM pizza_sales) 
        AS Percentage_Category_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_Category_Sales DESC;
 
-- Total Pizzas Sold by Category

SELECT 
    pizza_category,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;
 
-- Top 5 Best Performing Pizzas

SELECT TOP 5 
    pizza_name,
    SUM(quantity) AS Total_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Sold DESC;
 


