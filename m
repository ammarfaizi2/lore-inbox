Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUJ0NBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUJ0NBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUJ0NBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:01:32 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:50909 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262419AbUJ0NAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:00:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 27 Oct 2004 14:37:09 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: config cleanups
Message-ID: <20041027123709.GA24663@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Cleanup the video4linux driver configuration by using "select"
instead of "default if ...".

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/Kconfig       |   12 ------------
 drivers/media/video/Kconfig |   17 +++++++++++++++--
 2 files changed, 15 insertions(+), 14 deletions(-)

--- x/drivers/media/video/Kconfig.o	2004-10-26 10:13:42.488798354 +0200
+++ y/drivers/media/video/Kconfig	2004-10-26 10:09:33.863670037 +0200
@@ -9,8 +9,13 @@
 
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C && FW_LOADER
+	depends on VIDEO_DEV && PCI && I2C
 	select I2C_ALGOBIT
+	select FW_LOADER
+	select VIDEO_BTCX
+	select VIDEO_BUF
+	select VIDEO_IR
+	select VIDEO_TUNER
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in
@@ -230,6 +235,9 @@
 config VIDEO_SAA7134
 	tristate "Philips SAA7134 support"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_BUF
+	select VIDEO_IR
+	select VIDEO_TUNER
 	---help---
 	  This is a video4linux driver for Philips SAA7130/7134 based
 	  TV cards.
@@ -241,6 +249,7 @@
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
 	depends on VIDEO_DEV && PCI
 	select VIDEO_SAA7146_VV
+	select VIDEO_TUNER
 	---help---
 	  This is a video4linux driver for the 'Multimedia eXtension Board'
 	  TV card by Siemens-Nixdorf.
@@ -287,7 +296,11 @@
 
 config VIDEO_CX88
 	tristate "Conexant 2388x (bt878 successor) support"
-	depends on VIDEO_DEV && PCI && I2C_ALGOBIT && EXPERIMENTAL
+	depends on VIDEO_DEV && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	select VIDEO_BTCX
+	select VIDEO_BUF
+	select VIDEO_TUNER
 	---help---
 	  This is a video4linux driver for Conexant 2388x based
 	  TV cards.
--- x/drivers/media/Kconfig.o	2004-10-26 10:13:33.849426936 +0200
+++ y/drivers/media/Kconfig	2004-10-26 10:12:01.784782395 +0200
@@ -34,27 +34,15 @@
 
 config VIDEO_TUNER
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_SAA7134=y || VIDEO_MXB=y || VIDEO_CX88=y
-	default m if VIDEO_BT848=m || VIDEO_SAA7134=m || VIDEO_MXB=m || VIDEO_CX88=m
-	depends on VIDEO_DEV
 
 config VIDEO_BUF
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_SAA7134=y || VIDEO_SAA7146=y || VIDEO_CX88=y
-	default m if VIDEO_BT848=m || VIDEO_SAA7134=m || VIDEO_SAA7146=m || VIDEO_CX88=m
-	depends on VIDEO_DEV
 
 config VIDEO_BTCX
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_CX88=y
-	default m if VIDEO_BT848=m || VIDEO_CX88=m
-	depends on VIDEO_DEV
 
 config VIDEO_IR
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_SAA7134=y
-	default m if VIDEO_BT848=m || VIDEO_SAA7134=m
-	depends on VIDEO_DEV
 
 endmenu
 

-- 
#define printk(args...) fprintf(stderr, ## args)
