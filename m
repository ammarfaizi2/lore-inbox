Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbUCPCWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbUCPBYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:24:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:43439 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262926AbUCPAC5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:57 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913931516@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913931477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.2, 2004/03/09 14:57:49-08:00, khali@linux-fr.org

[PATCH] I2C: Prevent i2c-dev oops with debug

Looks like i2c-dev suffers the same problem with dev_dbg as i2c-core did
twice. Here is a patch that fixed a oops I and another user were
experiencing when running sensors-detect.


 drivers/i2c/i2c-dev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:13 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:13 2004
@@ -189,7 +189,7 @@
 	int i,datasize,res;
 	unsigned long funcs;
 
-	dev_dbg(&client->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
+	dev_dbg(&client->adapter->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
 		iminor(inode),cmd, arg);
 
 	switch ( cmd ) {
@@ -310,7 +310,7 @@
 		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"size out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.size);
 			return -EINVAL;
@@ -319,7 +319,7 @@
 		   so the check is valid if size==I2C_SMBUS_QUICK too. */
 		if ((data_arg.read_write != I2C_SMBUS_READ) && 
 		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
-			dev_dbg(&client->dev, 
+			dev_dbg(&client->adapter->dev, 
 				"read_write out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.read_write);
 			return -EINVAL;
@@ -338,7 +338,7 @@
 					      data_arg.size, NULL);
 
 		if (data_arg.data == NULL) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"data is NULL pointer in ioctl I2C_SMBUS.\n");
 			return -EINVAL;
 		}

