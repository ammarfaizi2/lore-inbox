Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbTDBQSu>; Wed, 2 Apr 2003 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263051AbTDBQSu>; Wed, 2 Apr 2003 11:18:50 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:49377 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263049AbTDBQSl>; Wed, 2 Apr 2003 11:18:41 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 18:38:48 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 21_video_config
Message-ID: <20030402163848.GA24731@bytesex.org>
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

  Gerd

diff -u linux-2.5.66/drivers/media/Kconfig linux/drivers/media/Kconfig
--- linux-2.5.66/drivers/media/Kconfig	2003-04-02 11:42:22.377563247 +0200
+++ linux/drivers/media/Kconfig	2003-04-02 11:49:36.065600766 +0200
@@ -32,5 +32,19 @@
 
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
 endmenu
 
diff -u linux-2.5.66/drivers/media/video/Makefile linux/drivers/media/video/Makefile
--- linux-2.5.66/drivers/media/video/Makefile	2003-04-02 11:42:44.375963981 +0200
+++ linux/drivers/media/video/Makefile	2003-04-02 11:49:36.066600614 +0200
@@ -9,7 +9,7 @@
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o tuner.o video-buf.o tda9887.o
+	tda7432.o tda9875.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
@@ -29,5 +29,8 @@
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o video-buf.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134/
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
+
+obj-$(CONFIG_VIDEO_TUNER) += tuner.o tda9887.o
+obj-$(CONFIG_VIDEO_BUF)   += video-buf.o

-- 
Michael Moore for president!
