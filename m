Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUKUQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUKUQQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUKUPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:42:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48648 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261647AbUKUPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:27 -0500
Date: Sun, 21 Nov 2004 16:36:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] neofb.c: make some code static
Message-ID: <20041121153624.GU2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/neofb.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/neofb.c.old	2004-11-21 14:54:11.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/neofb.c	2004-11-21 14:55:53.000000000 +0100
@@ -405,21 +405,21 @@
  */
 static int paletteEnabled = 0;
 
-inline void VGAenablePalette(void)
+static inline void VGAenablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x00);
 	paletteEnabled = 1;
 }
 
-inline void VGAdisablePalette(void)
+static inline void VGAdisablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x20);
 	paletteEnabled = 0;
 }
 
-inline void VGAwATTR(u8 index, u8 value)
+static inline void VGAwATTR(u8 index, u8 value)
 {
 	if (paletteEnabled)
 		index &= ~0x20;
@@ -430,7 +430,7 @@
 	vga_wattr(NULL, index, value);
 }
 
-void vgaHWProtect(int on)
+static void vgaHWProtect(int on)
 {
 	unsigned char tmp;
 
@@ -1320,7 +1320,7 @@
 /*
  *    (Un)Blank the display.
  */
-int neofb_blank(int blank_mode, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank.
@@ -2236,7 +2236,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init neofb_setup(char *options)
+static int __init neofb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2265,7 +2265,7 @@
 	return 0;
 }
 
-int __init neofb_init(void)
+static int __init neofb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;

