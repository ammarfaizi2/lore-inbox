Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUDFPre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUDFPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:47:34 -0400
Received: from uranus.md1.de ([217.160.177.133]:28295 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S263869AbUDFPra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:47:30 -0400
Date: Tue, 6 Apr 2004 17:45:10 +0200
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org
Subject: [PATCH] SAA5246A Teletext driver also works with SAA5281
Message-ID: <20040406154510.GA2075@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the SAA5246A Teletext processor driver also works for the
SAA5281 (I am the author of this driver).

This is not surprising because according to the data sheet of 
the SAA5281 it is compatible to the SAA5246A. But now I have 
tested this with a Siemens Multimedia Extension Board (MXB).

The following patch only changes comments in 
/drivers/media/video/Kconfig and in the sources of the driver.

I also added MODULE_AUTHOR and MODULE_DESCRIPTION macros which
were missing up to now.

Michael

diff -u -N linux-2.6.5/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.5/drivers/media/video/Kconfig	Sun Apr  4 05:38:16 2004
+++ linux/drivers/media/video/Kconfig	Mon Apr  5 21:25:31 2004
@@ -112,11 +112,11 @@
 	  It is also available as a module (cpia_usb).
 
 config VIDEO_SAA5246A
-	tristate "SAA5246A Teletext processor"
+	tristate "SAA5246A, SAA5281 Teletext processor"
 	depends on VIDEO_DEV && I2C
 	help
-	  Support for I2C bus based teletext using the SAA5246A chip. Useful
-	  only if you live in Europe.
+	  Support for I2C bus based teletext using the SAA5246A or SAA5281 
+	  chip. Useful only if you live in Europe.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa5246a.
Common subdirectories: linux-2.6.5/drivers/media/video/cx88 and linux/drivers/media/video/cx88
diff -u -N linux-2.6.5/drivers/media/video/saa5246a.c linux/drivers/media/video/saa5246a.c
--- linux-2.6.5/drivers/media/video/saa5246a.c	Sun Apr  4 05:36:58 2004
+++ linux/drivers/media/video/saa5246a.c	Mon Apr  5 21:20:40 2004
@@ -1,9 +1,10 @@
 /*
- * Driver for the SAA5246A videotext decoder chip from Philips.
+ * Driver for the SAA5246A or SAA5281 Teletext (=Videotext) decoder chips from 
+ * Philips.
  *
- * Only capturing of videotext pages is tested. The SAA5246A chip also has
- * a TV output but my hardware doesn't use it. For this reason this driver
- * does not support changing any TV display settings.
+ * Only capturing of Teletext pages is tested. The chip also has a TV output 
+ * but my hardware doesn't use it. For this reason this driver does not support 
+ * changing any TV display settings.
  *
  * Copyright (C) 2004 Michael Geng <linux@MichaelGeng.de>
  *
@@ -47,6 +48,10 @@
 #include <linux/videodev.h>
 #include "saa5246a.h"
 
+MODULE_AUTHOR("Michael Geng <linux@MichaelGeng.de>");
+MODULE_DESCRIPTION("Philips SAA5246A, SAA5281 Teletext decoder driver");
+MODULE_LICENSE("GPL");
+
 struct saa5246a_device
 {
 	u8     pgbuf[NUM_DAUS][VTX_VIRTUALSIZE];
@@ -764,8 +769,8 @@
 
 static int __init init_saa_5246a (void)
 {
-	printk(KERN_INFO "SAA5246A driver (" IF_NAME
-		" interface) for VideoText version %d.%d\n",
+	printk(KERN_INFO 
+		"SAA5246A (or compatible) Teletext decoder driver version %d.%d\n",
 		MAJOR_VERSION, MINOR_VERSION);
 	return i2c_add_driver(&i2c_driver_videotext);
 }
@@ -796,5 +801,3 @@
 	.release  = video_device_release,
 	.minor    = -1,
 };
-
-MODULE_LICENSE("GPL");
diff -u -N linux-2.6.5/drivers/media/video/saa5246a.h linux/drivers/media/video/saa5246a.h
--- linux-2.6.5/drivers/media/video/saa5246a.h	Sun Apr  4 05:37:39 2004
+++ linux/drivers/media/video/saa5246a.h	Mon Apr  5 21:20:30 2004
@@ -1,5 +1,7 @@
 /*
-   Driver for the SAA5246A videotext decoder chip from Philips.
+   Driver for the SAA5246A or SAA5281 Teletext (=Videotext) decoder chips from 
+   Philips.
+
    Copyright (C) 2004 Michael Geng (linux@MichaelGeng.de)
 
    This program is free software; you can redistribute it and/or modify
Common subdirectories: linux-2.6.5/drivers/media/video/saa7134 and linux/drivers/media/video/saa7134
