Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267813AbTBEGJ5>; Wed, 5 Feb 2003 01:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTBEGJ5>; Wed, 5 Feb 2003 01:09:57 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:8324 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267813AbTBEGJ4>; Wed, 5 Feb 2003 01:09:56 -0500
Date: Wed, 5 Feb 2003 01:28:14 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.59 : drivers/media/video/saa7185.c
Message-ID: <Pine.LNX.4.44.0302050126160.16512-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  The following patch addresses buzilla bug #168. Please review for 
inclusion.

Regards,
Frank

--- linux/drivers/media/video/saa7185.c.old	2003-02-05 01:10:58.000000000 -0500
+++ linux/drivers/media/video/saa7185.c	2003-02-05 01:24:22.000000000 -0500
@@ -186,7 +186,7 @@
 {
 	int i;
 	struct saa7185 *encoder;
-	struct i2c_client client;
+	struct i2c_client *client;
 
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
 	if (client == NULL)
@@ -194,14 +194,14 @@
 	client_template.adapter = adap;
 	client_template.addr = addr;
 	memcpy(client, &client_template, sizeof(*client));
-	encoder = kmalloc(sizeof(*decoder), GFP_KERNEL);
+	encoder = kmalloc(sizeof(*encoder), GFP_KERNEL);
 	if (encoder == NULL) {
 		kfree(client);
 		return -ENOMEM;
 	}
 
 
-	memset(encoder, 0, sizeof(*decoder));
+	memset(encoder, 0, sizeof(*encoder));
 	strcpy(client->name, "saa7185");
 	encoder->client = client;
 	client->data = encoder;
@@ -221,7 +221,7 @@
 		printk(KERN_INFO "%s_attach: chip version %d\n",
 		       client->name, i2c_smbus_read_byte(client) >> 5);
 	}
-	init_MUTEX(&decoder->lock);
+	init_MUTEX(&encoder->lock);
 	i2c_attach_client(client);
 	MOD_INC_USE_COUNT;
 	return 0;
@@ -355,6 +355,7 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_saa7185 = {
+	.owner 		= THIS_MODULE,
 	.name	 	= "saa7185",		 /* name */
 	.id 		= I2C_DRIVERID_SAA7185B, /* ID */
 	.flags 		= I2C_DF_NOTIFY,

