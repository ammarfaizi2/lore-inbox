Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267801AbTBKSRJ>; Tue, 11 Feb 2003 13:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbTBKSRI>; Tue, 11 Feb 2003 13:17:08 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:29870 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267801AbTBKSRF>; Tue, 11 Feb 2003 13:17:05 -0500
Date: Tue, 11 Feb 2003 13:37:22 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.60 : drivers/media/video/saa5249.c
Message-ID: <Pine.LNX.4.44.0302111335510.15042-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following addresses bugzilla bug # 340. Please review.

Regards,
Frank

--- linux/drivers/media/video/saa5249.c.old	2003-02-10 15:33:58.000000000 -0500
+++ linux/drivers/media/video/saa5249.c	2003-02-11 13:34:07.000000000 -0500
@@ -254,21 +254,19 @@
 
 static struct i2c_driver i2c_driver_videotext = 
 {
-	IF_NAME,		/* name */
-	I2C_DRIVERID_SAA5249, /* in i2c.h */
-	I2C_DF_NOTIFY,
-	saa5249_probe,
-	saa5249_detach,
-	saa5249_command
+	.owner 		= THIS_MODULE,
+	.name 		= IF_NAME,		/* name */
+	.id 		= I2C_DRIVERID_SAA5249, /* in i2c.h */
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = saa5249_probe,
+	.detach_client  = saa5249_detach,
+	.command 	= saa5249_command
 };
 
 static struct i2c_client client_template = {
-	"(unset)",
-	-1,
-	0,
-	0,
-	NULL,
-	&i2c_driver_videotext
+	.name 		= "(unset)",
+	.id 		= -1,
+	.driver 	= &i2c_driver_videotext
 };
 
 /*

