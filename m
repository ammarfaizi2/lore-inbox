Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUGBWlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUGBWlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUGBWlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:41:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52951 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264948AbUGBWlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:41:09 -0400
Date: Sat, 3 Jul 2004 00:41:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove drivers/char/h8.{c,h}
Message-ID: <20040702224101.GN28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I didn't get an answer regarding the following mail sent one year ago:


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 14 Jul 2003 00:43:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: Remove CONFIG_H8 in 2.5?

CONFIG_H8 in drivers/char/ depend in both 2.4 and 2.5 on 
CONFIG_OBSOLETE.
 
Since CONFIG_OBSOLETE is never set it is not selectable.
Is there any reason why this driver should stay in the kernel or would
you accept a patch that removes this driver?

cu
Adrian


----- End forwarded message -----


Since this issue is still present in current 2.6 kernels, I'd suggest 
the following:


rm drivers/char/h8.c
rm drivers/char/h8.h

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/drivers/char/Kconfig.old	2004-07-03 00:36:17.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/char/Kconfig	2004-07-03 00:36:39.000000000 +0200
@@ -795,16 +795,6 @@
 	  This option enables support for the LCD display and buttons found
 	  on Cobalt systems through a misc device.
 
-config H8
-	bool "Tadpole ANA H8 Support (OBSOLETE)"
-	depends on OBSOLETE && ALPHA_BOOK1
-	help
-	  The Hitachi H8/337 is a microcontroller used to deal with the power
-	  and thermal environment. If you say Y here, you will be able to
-	  communicate with it via a character special device.
-
-	  If unsure, say N.
-
 config DTLK
 	tristate "Double Talk PC internal speech card support"
 	help
--- linux-2.6.7-mm5-full/drivers/char/Makefile.old	2004-07-03 00:37:03.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/char/Makefile	2004-07-03 00:37:14.000000000 +0200
@@ -69,7 +69,6 @@
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 obj-$(CONFIG_FTAPE) += ftape/
 obj-$(CONFIG_COBALT_LCD) += lcd.o
-obj-$(CONFIG_H8) += h8.o
 obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o


