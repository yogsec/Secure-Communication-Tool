#!/bin/bash

# 🛡️ Secure Communication Tool - Designed by YogSec

BANNER="
🛡️ Secure Communication - Designed by YogSec 🛡️
"
echo "$BANNER"

encrypt_message() {
    read -sp "🔑 Enter password (Share with receiver): " password
    echo
    read -p "💬 Enter message to encrypt: " message

    # Encrypt the message
    encrypted=$(echo -n "$message" | openssl enc -aes-256-cbc -salt -pass pass:"$password" | base64)

    echo "🔐 Encrypted Message: $encrypted"
}

decrypt_message() {
    read -sp "🔑 Enter password: " password
    echo
    read -p "🔏 Enter encrypted message: " encrypted_msg

    # Decrypt the message
    decrypted=$(echo -n "$encrypted_msg" | base64 -d | openssl enc -aes-256-cbc -d -salt -pass pass:"$password" 2>/dev/null)

    if [[ -z "$decrypted" ]]; then
        echo "❌ Decryption failed! Wrong password."
    else
        echo "✅ Decrypted Message: $decrypted"
    fi
}

echo "🔹 1. Encrypt Message"
echo "🔹 2. Decrypt Message"
read -p "Choose an option (1/2): " choice

if [[ $choice -eq 1 ]]; then
    encrypt_message
elif [[ $choice -eq 2 ]]; then
    decrypt_message
else
    echo "❌ Invalid option!"
fi
