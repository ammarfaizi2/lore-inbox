Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGFJUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGFJUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 05:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUGFJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 05:20:25 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:56500 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263736AbUGFJUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 05:20:12 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 6 Jul 2004 10:53:36 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Geng <linux@MichaelGeng.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] saa5246a Videotext driver update
Message-ID: <20040706085336.GB11055@bytesex>
References: <20040630200413.GA8834@t-online.de> <20040630131114.480a124e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630131114.480a124e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 01:11:14PM -0700, Andrew Morton wrote:
> linux@MichaelGeng.de (Michael Geng) wrote:
> >
> >  I uploaded an update to the Videotext driver for the
> >  SAA5246A videotext decoder
> 
> Gerd, could you please process this patch?

Looks perfectly fine to me.  The patch updates docs, comments + strings
to also mention the SAA5281 chip (which is compatible to the SAA5246A)
as supported.

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Michael Geng <linux@MichaelGeng.de>
==============================[ cut here ]==============================
diff -u -N linux-2.6.7/drivers/media/video/Kconfig linux-2.6.7-saa5246a/drivers/media/video/Kconfig
--- linux-2.6.7/drivers/media/video/Kconfig	Wed Jun 16 07:20:03 2004
+++ linux-2.6.7-saa5246a/drivers/media/video/Kconfig	Mon Jun 21 09:27:02 2004
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
Common subdirectories: linux-2.6.7/drivers/media/video/cx88 and linux-2.6.7-saa5246a/drivers/media/video/cx88
diff -u -N linux-2.6.7/drivers/media/video/saa5246a.c linux-2.6.7-saa5246a/drivers/media/video/saa5246a.c
--- linux-2.6.7/drivers/media/video/saa5246a.c	Wed Jun 16 07:19:22 2004
+++ linux-2.6.7-saa5246a/drivers/media/video/saa5246a.c	Mon Jun 21 09:22:44 2004
@@ -1,9 +1,10 @@
 /*
- * Driver for the SAA5246A videotext decoder chip from Philips.
+ * Driver for the SAA5246A or SAA5281 Teletext (=Videotext) decoder chips from 
+ * Philips.
  *
- * Only capturing of videotext pages is tested. The SAA5246A chip also has
- * a TV output but my hardware doesn't use it. For this reason this driver
- * does not support changing any TV display settings.
+ * Only capturing of Teletext pages is tested. The videotext chips also have a 
+ * TV output but my hardware doesn't use it. For this reason this driver does 
+ * not support changing any TV display settings.
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
diff -u -N linux-2.6.7/drivers/media/video/saa5246a.h linux-2.6.7-saa5246a/drivers/media/video/saa5246a.h
--- linux-2.6.7/drivers/media/video/saa5246a.h	Wed Jun 16 07:19:44 2004
+++ linux-2.6.7-saa5246a/drivers/media/video/saa5246a.h	Mon Jun 21 09:23:48 2004
@@ -1,5 +1,7 @@
 /*
-   Driver for the SAA5246A videotext decoder chip from Philips.
+   Driver for the SAA5246A or SAA5281 Teletext (=Videotext) decoder chips from 
+   Philips.
+
    Copyright (C) 2004 Michael Geng (linux@MichaelGeng.de)
 
    This program is free software; you can redistribute it and/or modify
@@ -21,7 +23,7 @@
 #define __SAA5246A_H__
 
 #define MAJOR_VERSION 1		/* driver major version number */
-#define MINOR_VERSION 6		/* driver minor version number */
+#define MINOR_VERSION 7		/* driver minor version number */
 
 #define IF_NAME "SAA5246A"
 
Common subdirectories: linux-2.6.7/drivers/media/video/saa7134 and linux-2.6.7-saa5246a/drivers/media/video/saa7134
