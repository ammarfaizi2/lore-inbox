Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268496AbTBNVkh>; Fri, 14 Feb 2003 16:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTBNUyY>; Fri, 14 Feb 2003 15:54:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17930 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267466AbTBNUwy>; Fri, 14 Feb 2003 15:52:54 -0500
Subject: PATCH: fix 3036 tuner
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:02:50 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmyw-0005f9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/media/video/tuner-3036.c linux-2.5.60-ac1/drivers/media/video/tuner-3036.c
--- linux-2.5.60-ref/drivers/media/video/tuner-3036.c	2003-02-14 21:21:32.000000000 +0000
+++ linux-2.5.60-ac1/drivers/media/video/tuner-3036.c	2003-02-14 19:10:34.000000000 +0000
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
+	.owner		=	THIS_MODULE,
+	.name		=	"sab3036",
+	.id		=	I2C_DRIVERID_SAB3036,
+        .flags		=	I2C_DF_NOTIFY,
+	.attach_adapter =	tuner_probe,
+	.detach_client  =	tuner_detach,
+	.command	=	tuner_command
 };
 
 static struct i2c_client client_template =
 {
-        "SAB3036",		/* name       */
-        -1,
-        0,
-        0,
-        NULL,
-        &i2c_driver_tuner
+        .name 		= "SAB3036",
+        .id 		= -1,
+        .driver		= &i2c_driver_tuner
 };
 
 int __init
