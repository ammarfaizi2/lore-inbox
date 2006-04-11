Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDKDuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDKDuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWDKDuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:50:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27908 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751217AbWDKDut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:50:49 -0400
Date: Tue, 11 Apr 2006 05:50:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: michael@mihu.de
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill drivers/media/common/saa7146_vv_ksyms.c
Message-ID: <20060411035047.GB3190@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the EXPORT_SYMBOL's from 
drivers/media/common/saa7146_vv_ksyms.c to the files with the actual 
functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/common/Makefile           |    2 +-
 drivers/media/common/saa7146_fops.c     |    4 ++++
 drivers/media/common/saa7146_hlp.c      |    1 +
 drivers/media/common/saa7146_video.c    |    2 ++
 drivers/media/common/saa7146_vv_ksyms.c |   12 ------------
 5 files changed, 8 insertions(+), 13 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/media/common/Makefile.old	2006-04-11 03:40:29.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/common/Makefile	2006-04-11 03:40:39.000000000 +0200
@@ -1,5 +1,5 @@
 saa7146-objs    := saa7146_i2c.o saa7146_core.o
-saa7146_vv-objs := saa7146_vv_ksyms.o saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o
+saa7146_vv-objs := saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o
 ir-common-objs  := ir-functions.o ir-keymaps.o
 
 obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o
--- linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_video.c.old	2006-04-11 03:40:53.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_video.c	2006-04-11 03:41:33.000000000 +0200
@@ -318,6 +318,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_start_preview);
 
 int saa7146_stop_preview(struct saa7146_fh *fh)
 {
@@ -352,6 +353,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_stop_preview);
 
 static int s_fmt(struct saa7146_fh *fh, struct v4l2_format *f)
 {
--- linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_hlp.c.old	2006-04-11 03:41:41.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_hlp.c	2006-04-11 03:41:59.000000000 +0200
@@ -641,6 +641,7 @@
 	vv->current_hps_source = source;
 	vv->current_hps_sync = sync;
 }
+EXPORT_SYMBOL_GPL(saa7146_set_hps_source_and_sync);
 
 int saa7146_enable_overlay(struct saa7146_fh *fh)
 {
--- linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_fops.c.old	2006-04-11 03:42:09.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_fops.c	2006-04-11 03:44:57.000000000 +0200
@@ -501,6 +501,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_vv_init);
 
 int saa7146_vv_release(struct saa7146_dev* dev)
 {
@@ -515,6 +516,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_vv_release);
 
 int saa7146_register_device(struct video_device **vid, struct saa7146_dev* dev,
 			    char *name, int type)
@@ -553,6 +555,7 @@
 	*vid = vfd;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_register_device);
 
 int saa7146_unregister_device(struct video_device **vid, struct saa7146_dev* dev)
 {
@@ -571,6 +574,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(saa7146_unregister_device);
 
 static int __init saa7146_vv_init_module(void)
 {
--- linux-2.6.17-rc1-mm2-full/drivers/media/common/saa7146_vv_ksyms.c	2006-03-20 06:53:29.000000000 +0100
+++ /dev/null	2006-02-12 01:05:26.000000000 +0100
@@ -1,12 +0,0 @@
-#include <linux/module.h>
-#include <media/saa7146_vv.h>
-
-EXPORT_SYMBOL_GPL(saa7146_start_preview);
-EXPORT_SYMBOL_GPL(saa7146_stop_preview);
-
-EXPORT_SYMBOL_GPL(saa7146_set_hps_source_and_sync);
-EXPORT_SYMBOL_GPL(saa7146_register_device);
-EXPORT_SYMBOL_GPL(saa7146_unregister_device);
-
-EXPORT_SYMBOL_GPL(saa7146_vv_init);
-EXPORT_SYMBOL_GPL(saa7146_vv_release);

