Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVASFAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVASFAD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVASE6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:58:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261579AbVASE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:57:30 -0500
Date: Wed, 19 Jan 2005 05:57:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] bttv: make some code static
Message-ID: <20050119045726.GN1841@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some bttv code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 drivers/media/video/bttv-cards.c  |    5 +++--
 drivers/media/video/bttv-driver.c |    6 +++---
 drivers/media/video/bttvp.h       |    5 -----
 3 files changed, 6 insertions(+), 10 deletions(-)

This patch was already sent on:
- 9 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h.old	2004-11-07 16:34:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h	2004-11-07 16:47:42.000000000 +0100
@@ -240,11 +221,6 @@
 extern void bttv_gpio_tracking(struct bttv *btv, char *comment);
 extern int init_bttv_i2c(struct bttv *btv);
 extern int fini_bttv_i2c(struct bttv *btv);
-extern int pvr_boot(struct bttv *btv);
-
-extern int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg);
-extern void bttv_reinit_bt848(struct bttv *btv);
-extern void bttv_field_count(struct bttv *btv);
 
 #define vprintk  if (bttv_verbose) printk
 #define dprintk  if (bttv_debug >= 1) printk
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c.old	2004-11-07 16:34:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c	2004-11-07 17:14:25.000000000 +0100
@@ -84,12 +84,13 @@
 static int tea5757_write(struct bttv *btv, int value);
 static void identify_by_eeprom(struct bttv *btv,
 			       unsigned char eeprom_data[256]);
+static int __devinit pvr_boot(struct bttv *btv);
 
 /* config variables */
 static unsigned int triton1=0;
 static unsigned int vsfx=0;
 static unsigned int latency = UNSET;
-unsigned int no_overlay=-1;
+static unsigned int no_overlay=-1;
 
 static unsigned int card[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int pll[BTTV_MAX]    = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
@@ -2979,7 +2959,7 @@
 
 extern int mod_firmware_load(const char *fn, char **fp);
 
-int __devinit pvr_boot(struct bttv *btv)
+static int __devinit pvr_boot(struct bttv *btv)
 {
 	u32 microlen;
 	u8 *micro;
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c.old	2004-11-07 16:40:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c	2004-11-07 16:41:55.000000000 +0100
@@ -1071,7 +1071,7 @@
 	init_irqreg(btv);
 }
 
-void bttv_reinit_bt848(struct bttv *btv)
+static void bttv_reinit_bt848(struct bttv *btv)
 {
 	unsigned long flags;
 
@@ -1275,7 +1275,7 @@
 	       btv->c.nr,outbits,data & outbits, data & ~outbits, comment);
 }
 
-void bttv_field_count(struct bttv *btv)
+static void bttv_field_count(struct bttv *btv)
 {
 	int need_count = 0;
 
@@ -1475,7 +1475,7 @@
 	"SMICROCODE", "GVBIFMT", "SVBIFMT" };
 #define V4L1_IOCTLS ARRAY_SIZE(v4l1_ioctls)
 
-int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
+static int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
 {
 	switch (cmd) {
         case BTTV_VERSION:

