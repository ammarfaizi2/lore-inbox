Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTCJTt3>; Mon, 10 Mar 2003 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbTCJTt3>; Mon, 10 Mar 2003 14:49:29 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23440 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261453AbTCJTt1>; Mon, 10 Mar 2003 14:49:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 10 Mar 2003 20:59:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: drivers/media Kconfig changes.
Message-ID: <20030310195848.GA6202@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds a few new config options for modules which are shared
by multiple video4linux drivers (bttv * saa7134).  This simplifies the
Makefiles and also prepares the merge of Michael's saa7146 driver which
will also use these modules.

Please apply,

  Gerd

--- linux-2.5.64/drivers/media/Kconfig	2003-03-06 15:10:35.000000000 +0100
+++ linux/drivers/media/Kconfig	2003-03-06 15:08:18.000000000 +0100
@@ -32,5 +32,24 @@
 
 source "drivers/media/dvb/Kconfig"
 
+# source "drivers/media/common/Kconfig"
+
+config VIDEO_TUNER
+	tristate
+	default y if VIDEO_BT848=y || VIDEO_SAA7134=y
+	default m if VIDEO_BT848=m || VIDEO_SAA7134=m
+	depends on VIDEO_DEV
+
+config VIDEO_BUF
+	tristate
+	default y if VIDEO_BT848=y || VIDEO_SAA7134=y
+	default m if VIDEO_BT848=m || VIDEO_SAA7134=m
+	depends on VIDEO_DEV
+
+config VIDEO_BTCX
+	tristate
+	default VIDEO_BT848
+	depends on VIDEO_DEV
+
 endmenu
 
--- linux-2.5.64/drivers/media/video/Makefile	2003-03-06 14:56:44.000000000 +0100
+++ linux/drivers/media/video/Makefile	2003-03-06 15:01:04.000000000 +0100
@@ -9,7 +9,7 @@
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o tuner.o video-buf.o tda9887.o
+	tda7432.o tda9875.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
@@ -29,5 +29,10 @@
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o video-buf.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
+
+obj-$(CONFIG_VIDEO_TUNER) += tuner.o tda9887.o
+obj-$(CONFIG_VIDEO_BUF)   += video-buf.o
+obj-$(CONFIG_VIDEO_BTCX)  += btcx-risc.o
+

-- 
/join #zonenkinder
