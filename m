Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbTBKRkA>; Tue, 11 Feb 2003 12:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBKRkA>; Tue, 11 Feb 2003 12:40:00 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:27345 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267900AbTBKRj5>; Tue, 11 Feb 2003 12:39:57 -0500
Date: Tue, 11 Feb 2003 13:00:13 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.60 : drivers/media/video/tuner-3036.c
Message-ID: <Pine.LNX.4.44.0302111258150.15042-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses bugzilla bug #342. Please review.

Regards,
Frank

--- linux/drivers/media/video/tuner-3036.c.old	2003-01-16 21:22:04.000000000 -0500
+++ linux/drivers/media/video/tuner-3036.c	2003-02-11 12:57:05.000000000 -0500
@@ -185,22 +185,20 @@
 static struct i2c_driver 
 i2c_driver_tuner = 
 {
-	"sab3036",		/* name       */
-	I2C_DRIVERID_SAB3036,	/* ID         */
-        I2C_DF_NOTIFY,
-	tuner_probe,
-	tuner_detach,
-	tuner_command
+	.owner 		= THIS_MODULE,
+	.name 		= "sab3036",		/* name       */
+	.id 		= I2C_DRIVERID_SAB3036,	/* ID         */
+        .flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = tuner_probe,
+	.detach_client 	= tuner_detach,
+	.command 	= tuner_command
 };
 
 static struct i2c_client client_template =
 {
-        "SAB3036",		/* name       */
-        -1,
-        0,
-        0,
-        NULL,
-        &i2c_driver_tuner
+        .name 		= "SAB3036",		/* name       */
+        .id 		= -1,
+        .driver 	= &i2c_driver_tuner
 };
 
 int __init

