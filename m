Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTBKRt3>; Tue, 11 Feb 2003 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267891AbTBKRt3>; Tue, 11 Feb 2003 12:49:29 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:45273 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267366AbTBKRt1>; Tue, 11 Feb 2003 12:49:27 -0500
Date: Tue, 11 Feb 2003 13:09:44 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.60 : drivers/media/video/saa7110.c
Message-ID: <Pine.LNX.4.44.0302111306300.15042-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses bugzilla bug # 341. Please review. 

Regards.
Frank

--- linux/drivers/media/video/saa7110.c.old	2003-01-16 21:21:33.000000000 -0500
+++ linux/drivers/media/video/saa7110.c	2003-02-11 13:04:37.000000000 -0500
@@ -381,20 +381,18 @@
 
 static struct i2c_driver i2c_driver_saa7110 =
 {
-	IF_NAME,			/* name */
-	I2C_DRIVERID_SAA7110,	/* in i2c.h */
-	I2C_DF_NOTIFY,	/* Addr range */
-	saa7110_probe,
-	saa7110_detach,
-	saa7110_command
+	.owner 		= THIS_MODULE,
+	.name 		= IF_NAME,			/* name */
+	.id  		= I2C_DRIVERID_SAA7110,	/* in i2c.h */
+	.flags 		= I2C_DF_NOTIFY,	/* Addr range */
+	.attach_adapter = saa7110_probe,
+	.detach_client 	= saa7110_detach,
+	.command 	= saa7110_command
 };
 static struct i2c_client client_template = {
-	"saa7110_client",
-	-1,
-	0,
-	0,
-	NULL,
-	&i2c_driver_saa7110
+	.name 		= "saa7110_client",
+	.id 		= -1,
+	.driver 	= &i2c_driver_saa7110
 };
 
 static int saa7110_init(void)

