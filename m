Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUKIFzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUKIFzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKIFuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:50:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:64414 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261385AbUKIFZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:00 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778552595@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:15 -0800
Message-Id: <10999778553443@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.8, 2004/11/05 13:42:18-08:00, arjan@infradead.org

[PATCH] I2C: remove dead code from i2c

i2c-core.c has a few never used functions, patch below removes these dead
functions.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |   60 -------------------------------------------------
 1 files changed, 60 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-08 18:55:48 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-08 18:55:48 -08:00
@@ -1008,48 +1008,6 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
-s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_WRITE,command,
-	                   I2C_SMBUS_PROC_CALL, &data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-/* Returns the number of read bytes */
-s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command, u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,command,
-	                   I2C_SMBUS_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command, u8 length, u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > I2C_SMBUS_BLOCK_MAX)
-		length = I2C_SMBUS_BLOCK_MAX;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                      I2C_SMBUS_WRITE,command,
-	                      I2C_SMBUS_BLOCK_DATA,&data);
-}
-
 /* Returns the number of read bytes */
 s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
@@ -1085,20 +1043,6 @@
 	}
 }
 
-s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command, u8 length, u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > I2C_SMBUS_I2C_BLOCK_MAX)
-		length = I2C_SMBUS_I2C_BLOCK_MAX;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                      I2C_SMBUS_WRITE,command,
-	                      I2C_SMBUS_I2C_BLOCK_DATA,&data);
-}
-
 /* Simulate a SMBus command using the i2c protocol 
    No checking of parameters is done!  */
 static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr, 
@@ -1322,11 +1266,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
-EXPORT_SYMBOL(i2c_smbus_process_call);
-EXPORT_SYMBOL(i2c_smbus_read_block_data);
-EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
-EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);

