Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVATPit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVATPit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVATPit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:38:49 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18852 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262162AbVATPaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:16 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:27:45 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv IR input driver update
Message-ID: <20050120152745.GA13041@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables IR support for one AverMedia card and
drops a obsolete function.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/common/ir-common.c  |    3 ++-
 drivers/media/video/ir-kbd-gpio.c |    4 ++--
 drivers/media/video/ir-kbd-i2c.c  |   14 ++------------
 3 files changed, 6 insertions(+), 15 deletions(-)

Index: linux-2004-12-16/drivers/media/video/ir-kbd-gpio.c
===================================================================
--- linux-2004-12-16.orig/drivers/media/video/ir-kbd-gpio.c	2004-12-17 12:09:03.000000000 +0100
+++ linux-2004-12-16/drivers/media/video/ir-kbd-gpio.c	2004-12-17 12:28:00.761810330 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-kbd-gpio.c,v 1.10 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: ir-kbd-gpio.c,v 1.11 2004/10/25 11:26:36 kraxel Exp $
  *
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
@@ -366,7 +366,7 @@ static int ir_probe(struct device *dev)
 		break;
 
 	case BTTV_AVDVBT_761:
-	/* case BTTV_AVDVBT_771: */
+	case BTTV_AVDVBT_771:
 		ir_codes         = ir_codes_avermedia_dvbt;
 		ir->mask_keycode = 0x0f00c0;
 		ir->mask_keydown = 0x000020;
Index: linux-2004-12-16/drivers/media/video/ir-kbd-i2c.c
===================================================================
--- linux-2004-12-16.orig/drivers/media/video/ir-kbd-i2c.c	2004-12-17 12:06:32.000000000 +0100
+++ linux-2004-12-16/drivers/media/video/ir-kbd-i2c.c	2004-12-17 12:28:00.762810142 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-kbd-i2c.c,v 1.8 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: ir-kbd-i2c.c,v 1.10 2004/12/09 12:51:35 kraxel Exp $
  *
  * keyboard input driver for i2c IR remote controls
  *
@@ -155,16 +155,6 @@ module_param(debug, int, 0644);    /* de
 
 /* ----------------------------------------------------------------------- */
 
-static inline int reverse(int data, int bits)
-{
-	int i,c;
-
-	for (c=0,i=0; i<bits; i++) {
-		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
-	}
-	return c;
-}
-
 static int get_key_haup(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
 	unsigned char buf[3];
@@ -443,7 +433,7 @@ static int ir_probe(struct i2c_adapter *
 	*/
 
 	static const int probe_bttv[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
-	static const int probe_saa7134[] = { 0x7a, -1};
+	static const int probe_saa7134[] = { 0x7a, -1 };
 	const int *probe = NULL;
 	struct i2c_client c; char buf; int i,rc;
 
Index: linux-2004-12-16/drivers/media/common/ir-common.c
===================================================================
--- linux-2004-12-16.orig/drivers/media/common/ir-common.c	2004-12-17 12:08:49.000000000 +0100
+++ linux-2004-12-16/drivers/media/common/ir-common.c	2004-12-17 12:28:11.383812920 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.c,v 1.5 2004/11/07 13:17:15 kraxel Exp $
+ * $Id: ir-common.c,v 1.6 2004/12/10 12:33:39 kraxel Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -22,6 +22,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 
 #include <media/ir-common.h>
 

-- 
#define printk(args...) fprintf(stderr, ## args)
