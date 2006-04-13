Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWDML54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWDML54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWDML5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:57:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28430 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964891AbWDML5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:57:54 -0400
Date: Thu, 13 Apr 2006 13:57:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/em28xx/: possible cleanups
Message-ID: <20060413115753.GB8171@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global functions static:
  - em28xx-core.c: em28xx_accumulator_set()
  - em28xx-core.c: em28xx_capture_area_set()
  - em28xx-core.c: em28xx_scaler_set()
  - em28xx-core.c: em28xx_isocIrq()
- remove the following unused EXPORT_SYMBOL's:
  - em28xx-cards.c: em28xx_boards
  - em28xx-cards.c: em28xx_bcount
  - em28xx-cards.c: em28xx_id_table

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/em28xx/em28xx-cards.c |    4 ----
 drivers/media/video/em28xx/em28xx-core.c  |   10 +++++-----
 drivers/media/video/em28xx/em28xx.h       |    6 ------
 3 files changed, 5 insertions(+), 15 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx.h.old	2006-04-13 12:27:42.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx.h	2006-04-13 12:29:28.000000000 +0200
@@ -319,13 +319,7 @@
 int em28xx_colorlevels_set_default(struct em28xx *dev);
 int em28xx_capture_start(struct em28xx *dev, int start);
 int em28xx_outfmt_set_yuv422(struct em28xx *dev);
-int em28xx_accumulator_set(struct em28xx *dev, u8 xmin, u8 xmax, u8 ymin,
-			   u8 ymax);
-int em28xx_capture_area_set(struct em28xx *dev, u8 hstart, u8 vstart,
-			    u16 width, u16 height);
-int em28xx_scaler_set(struct em28xx *dev, u16 h, u16 v);
 int em28xx_resolution_set(struct em28xx *dev);
-void em28xx_isocIrq(struct urb *urb, struct pt_regs *regs);
 int em28xx_init_isoc(struct em28xx *dev);
 void em28xx_uninit_isoc(struct em28xx *dev);
 int em28xx_set_alternate(struct em28xx *dev);
--- linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-core.c.old	2006-04-13 12:27:59.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-core.c	2006-04-13 12:29:36.000000000 +0200
@@ -317,8 +317,8 @@
 	return em28xx_write_regs(dev, VINCTRL_REG, "\x11", 1);
 }
 
-int em28xx_accumulator_set(struct em28xx *dev, u8 xmin, u8 xmax, u8 ymin,
-				  u8 ymax)
+static int em28xx_accumulator_set(struct em28xx *dev, u8 xmin, u8 xmax,
+				  u8 ymin, u8 ymax)
 {
 	em28xx_coredbg("em28xx Scale: (%d,%d)-(%d,%d)\n", xmin, ymin, xmax, ymax);
 
@@ -328,7 +328,7 @@
 	return em28xx_write_regs(dev, YMAX_REG, &ymax, 1);
 }
 
-int em28xx_capture_area_set(struct em28xx *dev, u8 hstart, u8 vstart,
+static int em28xx_capture_area_set(struct em28xx *dev, u8 hstart, u8 vstart,
 				   u16 width, u16 height)
 {
 	u8 cwidth = width;
@@ -345,7 +345,7 @@
 	return em28xx_write_regs(dev, OFLOW_REG, &overflow, 1);
 }
 
-int em28xx_scaler_set(struct em28xx *dev, u16 h, u16 v)
+static int em28xx_scaler_set(struct em28xx *dev, u16 h, u16 v)
 {
 	u8 mode;
 	/* the em2800 scaler only supports scaling down to 50% */
@@ -534,7 +534,7 @@
  * em28xx_isoIrq()
  * handles the incoming isoc urbs and fills the frames from our inqueue
  */
-void em28xx_isocIrq(struct urb *urb, struct pt_regs *regs)
+static void em28xx_isocIrq(struct urb *urb, struct pt_regs *regs)
 {
 	struct em28xx *dev = urb->context;
 	int i, status;
--- linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-cards.c.old	2006-04-13 12:27:08.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/video/em28xx/em28xx-cards.c	2006-04-13 12:27:15.000000000 +0200
@@ -326,8 +326,4 @@
 	}
 }
 
-EXPORT_SYMBOL(em28xx_boards);
-EXPORT_SYMBOL(em28xx_bcount);
-EXPORT_SYMBOL(em28xx_id_table);
-
 MODULE_DEVICE_TABLE (usb, em28xx_id_table);

