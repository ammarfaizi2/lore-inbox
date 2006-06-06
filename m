Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWFFOlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWFFOlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWFFOlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:41:15 -0400
Received: from khc.piap.pl ([195.187.100.11]:16907 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932191AbWFFOlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:41:14 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Subject: [PATCH] I2C: *write_block* doesn't modify the data - mark as const
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 16:41:09 +0200
Message-ID: <m364jez6re.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch marks i2c_smbus_write_block_data() and
i2c_smbus_write_i2c_block_data() buffers as const.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -916,6 +916,6 @@ s32 i2c_smbus_write_word_data(struct i2c
 }
 
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
-			       u8 length, u8 *values)
+			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
@@ -947,7 +947,7 @@ s32 i2c_smbus_read_i2c_block_data(struct
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-				   u8 length, u8 *values)
+				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -94,15 +94,14 @@ extern s32 i2c_smbus_write_byte_data(str
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
-extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-				      u8 command, u8 length,
-				      u8 *values);
+extern s32 i2c_smbus_write_block_data(struct i2c_client * client, u8 command,
+				      u8 length, const u8 *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
 					  u8 command, u8 length,
-					  u8 *values);
+					  const u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on
