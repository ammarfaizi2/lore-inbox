Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTFKUU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTFKUU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:20:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25326 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264272AbTFKUUx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:20:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553638063543@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
In-Reply-To: <10553638061285@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 11 Jun 2003 13:36:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1419.1.7, 2003/06/11 12:29:31-07:00, greg@kroah.com

[PATCH] I2C: fix up sparse warnings in drivers/i2c/i2c-core.c


 drivers/i2c/i2c-core.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Wed Jun 11 13:24:53 2003
+++ b/drivers/i2c/i2c-core.c	Wed Jun 11 13:24:53 2003
@@ -510,7 +510,7 @@
 		msg.addr   = client->addr;
 		msg.flags = client->flags & I2C_M_TEN;
 		msg.len = count;
-		(const char *)msg.buf = buf;
+		msg.buf = (char *)buf;
 	
 		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
 				count));
@@ -861,13 +861,13 @@
 	return 0;	
 }
 
-extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value)
+s32 i2c_smbus_write_quick(struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
  	                      value,0,I2C_SMBUS_QUICK,NULL);
 }
 
-extern s32 i2c_smbus_read_byte(struct i2c_client * client)
+s32 i2c_smbus_read_byte(struct i2c_client *client)
 {
 	union i2c_smbus_data data;
 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
@@ -877,14 +877,14 @@
 		return 0x0FF & data.byte;
 }
 
-extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value)
+s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value)
 {
 	union i2c_smbus_data data;	/* only for PEC */
 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 	                      I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,&data);
 }
 
-extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command)
+s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
@@ -894,8 +894,7 @@
 		return 0x0FF & data.byte;
 }
 
-extern s32 i2c_smbus_write_byte_data(struct i2c_client * client, u8 command,
-                                     u8 value)
+s32 i2c_smbus_write_byte_data(struct i2c_client *client, u8 command, u8 value)
 {
 	union i2c_smbus_data data;
 	data.byte = value;
@@ -904,7 +903,7 @@
 	                      I2C_SMBUS_BYTE_DATA,&data);
 }
 
-extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command)
+s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
@@ -914,8 +913,7 @@
 		return 0x0FFFF & data.word;
 }
 
-extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
-                                     u8 command, u16 value)
+s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command, u16 value)
 {
 	union i2c_smbus_data data;
 	data.word = value;
@@ -924,8 +922,7 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
-extern s32 i2c_smbus_process_call(struct i2c_client * client,
-                                  u8 command, u16 value)
+s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
 {
 	union i2c_smbus_data data;
 	data.word = value;
@@ -938,8 +935,7 @@
 }
 
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                     u8 command, u8 *values)
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -954,8 +950,7 @@
 	}
 }
 
-extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-                                      u8 command, u8 length, u8 *values)
+s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -970,8 +965,7 @@
 }
 
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_block_process_call(struct i2c_client * client,
-                                        u8 command, u8 length, u8 *values)
+s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -990,8 +984,7 @@
 }
 
 /* Returns the number of read bytes */
-extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
-                                         u8 command, u8 *values)
+s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -1006,8 +999,7 @@
 	}
 }
 
-extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
-                                          u8 command, u8 length, u8 *values)
+s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;

