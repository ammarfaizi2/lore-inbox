Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUKUQmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUKUQmF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUKUPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:39:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38152 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261333AbUKUPgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:09 -0500
Date: Sun, 21 Nov 2004 16:36:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] cirrusfb.c: make some code static
Message-ID: <20041121153603.GO2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some nedlessly global code static.


diffstat output:
 drivers/video/cirrusfb.c |   70 ++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 34 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/cirrusfb.c.old	2004-11-21 03:07:59.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/cirrusfb.c	2004-11-21 03:13:04.000000000 +0100
@@ -515,23 +515,25 @@
 
 
 /*--- Interface used by the world ------------------------------------------*/
-int cirrusfb_init (void);
-int cirrusfb_setup (char *options);
+static int cirrusfb_init (void);
+#ifndef MODULE
+static int cirrusfb_setup (char *options);
+#endif
 
-int cirrusfb_open (struct fb_info *info, int user);
-int cirrusfb_release (struct fb_info *info, int user);
-int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-			unsigned blue, unsigned transp,
-			struct fb_info *info);
-int cirrusfb_check_var (struct fb_var_screeninfo *var,
-			struct fb_info *info);
-int cirrusfb_set_par (struct fb_info *info);
-int cirrusfb_pan_display (struct fb_var_screeninfo *var,
-			  struct fb_info *info);
-int cirrusfb_blank (int blank_mode, struct fb_info *info);
-void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region);
-void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image);
+static int cirrusfb_open (struct fb_info *info, int user);
+static int cirrusfb_release (struct fb_info *info, int user);
+static int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			       unsigned blue, unsigned transp,
+			       struct fb_info *info);
+static int cirrusfb_check_var (struct fb_var_screeninfo *var,
+			       struct fb_info *info);
+static int cirrusfb_set_par (struct fb_info *info);
+static int cirrusfb_pan_display (struct fb_var_screeninfo *var,
+				 struct fb_info *info);
+static int cirrusfb_blank (int blank_mode, struct fb_info *info);
+static void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region);
+static void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+static void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* function table of the above functions */
 static struct fb_ops cirrusfb_ops = {
@@ -600,7 +602,7 @@
 static int opencount = 0;
 
 /*--- Open /dev/fbx ---------------------------------------------------------*/
-int cirrusfb_open (struct fb_info *info, int user)
+static int cirrusfb_open (struct fb_info *info, int user)
 {
 	if (opencount++ == 0)
 		switch_monitor (info->par, 1);
@@ -608,7 +610,7 @@
 }
 
 /*--- Close /dev/fbx --------------------------------------------------------*/
-int cirrusfb_release (struct fb_info *info, int user)
+static int cirrusfb_release (struct fb_info *info, int user)
 {
 	if (--opencount == 0)
 		switch_monitor (info->par, 0);
@@ -660,8 +662,8 @@
 	return mclk;
 }
 
-int cirrusfb_check_var(struct fb_var_screeninfo *var,
-		       struct fb_info *info)
+static int cirrusfb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	int nom, den;		/* translyting from pixels->bytes */
@@ -1573,15 +1575,15 @@
 
 /* for some reason incomprehensible to me, cirrusfb requires that you write
  * the registers twice for the settings to take..grr. -dte */
-int cirrusfb_set_par (struct fb_info *info)
+static int cirrusfb_set_par (struct fb_info *info)
 {
 	cirrusfb_set_par_foo (info);
 	return cirrusfb_set_par_foo (info);
 }
 
-int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-			unsigned blue, unsigned transp,
-			struct fb_info *info)
+static int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			       unsigned blue, unsigned transp,
+			       struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 
@@ -1632,8 +1634,8 @@
 
 	performs display panning - provided hardware permits this
 **************************************************************************/
-int cirrusfb_pan_display (struct fb_var_screeninfo *var,
-			  struct fb_info *info)
+static int cirrusfb_pan_display (struct fb_var_screeninfo *var,
+				 struct fb_info *info)
 {
 	int xoffset = 0;
 	int yoffset = 0;
@@ -1702,7 +1704,7 @@
 }
 
 
-int cirrusfb_blank (int blank_mode, struct fb_info *info)
+static int cirrusfb_blank (int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank. If blank == NULL
@@ -2036,7 +2038,7 @@
 	return;
 }
 
-void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region)
+static void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	struct fb_fillrect modded;
@@ -2086,7 +2088,7 @@
 }
 
 
-void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	struct fb_copyarea modded;
@@ -2121,7 +2123,7 @@
 	cirrusfb_prim_copyarea(cinfo, &modded);
 }
 
-void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct cirrusfb_info *cinfo = info->par;
 
@@ -2459,7 +2461,7 @@
 	return ret;
 }
 
-void __devexit cirrusfb_pci_unregister (struct pci_dev *pdev)
+static void __devexit cirrusfb_pci_unregister (struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	DPRINTK ("ENTER\n");
@@ -2605,7 +2607,7 @@
 };
 #endif /* CONFIG_ZORRO */
 
-int __init cirrusfb_init(void)
+static int __init cirrusfb_init(void)
 {
 	int error = 0;
 
@@ -2629,7 +2631,7 @@
 
 
 #ifndef MODULE
-int __init cirrusfb_setup(char *options) {
+static int __init cirrusfb_setup(char *options) {
 	char *this_opt, s[32];
 	int i;
 
@@ -2664,7 +2666,7 @@
 MODULE_DESCRIPTION("Accelerated FBDev driver for Cirrus Logic chips");
 MODULE_LICENSE("GPL");
 
-void __exit cirrusfb_exit (void)
+static void __exit cirrusfb_exit (void)
 {
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&cirrusfb_pci_driver);

