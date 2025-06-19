#!/bin/bash

# This script generates a multiplication table based on user input
# Purpose: Practice loops, conditional logic, and user interaction

# Function to display multiplication table
generate_table() {
    local num=$1
    local start=$2
    local end=$3
    local order=$4

    # Validate range
    if [ "$start" -lt 1 ] || [ "$end" -gt 10 ] || [ "$start" -gt "$end" ]; then
        echo "Invalid range. Showing full table from 1 to 10 instead."
        start=1
        end=10
    fi

    echo "The multiplication table for $num from $start to $end:"
    # List form for loop
    if [ "$order" == "ascending" ]; then
        # List form loop for ascending order
        for i in $(seq $start $end); do
            echo "$num x $i = $((num * i))"
        done
    else
        # List form loop for descending order
        for i in $(seq $end -1 $start); do
            echo "$num x $i = $((num * i))"
        done
    fi
}

# Prompt for number and validate
read -p "Enter a number for the multiplication table: " num
if ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid positive number."
    exit 1
fi

# Ask for table type and range
read -p "Do you want a full table or partial table? (f/p): " choice
if [ "$choice" == "f" ]; then
    start=1
    end=10
elif [ "$choice" == "p" ]; then
    read -p "Enter the starting number (1-10): " start
    read -p "Enter the ending number (1-10): " end
    if ! [[ "$start" =~ ^[0-9]+$ ]] || ! [[ "$end" =~ ^[0-9]+$ ]]; then
        echo "Error: Start and end must be valid numbers."
        exit 1
    fi
else
    echo "Invalid choice. Defaulting to full table."
    start=1
    end=10
fi

# Bonus: Ask for order preference
read -p "Display in ascending or descending order? (a/d): " order_choice
order="ascending"
if [ "$order_choice" == "d" ]; then
    order="descending"
elif [ "$order_choice" != "a" ]; then
    echo "Invalid order. Defaulting to ascending."
fi

# Call function to generate table
generate_table "$num" "$start" "$end" "$order"

# Bonus: Offer to repeat
read -p "Would you like to generate another table? (y/n): " repeat
if [ "$repeat" == "y" ]; then
    bash "$0"
fi