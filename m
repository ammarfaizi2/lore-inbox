Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVCCVOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVCCVOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCCVO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:14:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41737 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262582AbVCCVB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:01:26 -0500
Date: Thu, 3 Mar 2005 22:01:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/: more cleanups
Message-ID: <20050303210119.GK4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains cleanups including the following:
- make needlessly global code static
- remove the needlessly #ifdef MODULE from several module_exit
- remove or #if 0 the following unused global functions:
  - fbmon.c: fb_create_modedb
  - fbmon.c: fb_get_monitor_limits
  - nvidia/nv_i2c.c: nvidia_delete_i2c_busses
  - nvidia/nv_setup.c: NVEnablePalette
  - nvidia/nv_setup.c: NVReadDacMask
- remove the following unneeded EXPORT_SYMBOL's:
  - fbmon.c: fb_create_modedb
  - fbmon.c: fb_get_monitor_limits
  - hgafb.c: hgafb_setup

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/aty/aty128fb.c        |   13 +---
 drivers/video/aty/atyfb.h           |    1 
 drivers/video/aty/atyfb_base.c      |   14 ++---
 drivers/video/aty/mach64_ct.c       |    7 +-
 drivers/video/aty/mach64_cursor.c   |    2 
 drivers/video/aty/radeon_base.c     |   46 ++++++++---------
 drivers/video/aty/radeon_pm.c       |    4 -
 drivers/video/aty/radeonfb.h        |    1 
 drivers/video/backlight/backlight.c |    2 
 drivers/video/backlight/lcd.c       |    2 
 drivers/video/cyber2000fb.c         |    6 +-
 drivers/video/fbmon.c               |   14 -----
 drivers/video/geode/gx1fb_core.c    |    4 -
 drivers/video/hgafb.c               |   14 +----
 drivers/video/i810/i810_main.c      |    2 
 drivers/video/imsttfb.c             |    7 +-
 drivers/video/intelfb/intelfbdrv.c  |   73 ++++++++++++----------------
 drivers/video/neofb.c               |   16 +++---
 drivers/video/nvidia/nv_accel.c     |    4 -
 drivers/video/nvidia/nv_i2c.c       |    2 
 drivers/video/nvidia/nv_of.c        |    1 
 drivers/video/nvidia/nv_proto.h     |    5 -
 drivers/video/nvidia/nv_setup.c     |    4 +
 drivers/video/nvidia/nvidia.c       |    4 -
 drivers/video/pm2fb.c               |   58 +++++++---------------
 drivers/video/radeonfb.c            |   44 +++++++---------
 drivers/video/riva/fbdev.c          |    8 +--
 drivers/video/sis/init.c            |    4 -
 drivers/video/sis/init.h            |    3 -
 drivers/video/sis/init301.c         |    9 +--
 drivers/video/sis/init301.h         |    3 -
 drivers/video/sis/sis_main.c        |    5 +
 drivers/video/tdfxfb.c              |   51 ++++++++-----------
 drivers/video/vesafb.c              |   12 ----
 drivers/video/vfb.c                 |   12 +---
 include/linux/fb.h                  |    2 
 36 files changed, 193 insertions(+), 266 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/aty128fb.c.old	2005-03-01 02:17:46.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/aty128fb.c	2005-03-01 02:59:50.000000000 +0100
@@ -425,11 +425,6 @@
 
 #define round_div(n, d) ((n+(d/2))/d)
 
-    /*
-     *  Interface used by the world
-     */
-int aty128fb_init(void);
-
 static int aty128fb_check_var(struct fb_var_screeninfo *var,
 			      struct fb_info *info);
 static int aty128fb_set_par(struct fb_info *info);
@@ -1648,7 +1643,8 @@
 	return 0;
 }
 
-int __init aty128fb_setup(char *options)
+#ifndef MODULE
+static int __init aty128fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1701,6 +1697,7 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
 
 /*
@@ -2432,7 +2429,7 @@
 }
 
 
-int __init aty128fb_init(void)
+static int __init aty128fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -2452,7 +2449,6 @@
 
 module_init(aty128fb_init);
 
-#ifdef MODULE
 module_exit(aty128fb_exit);
 
 MODULE_AUTHOR("(c)1999-2003 Brad Douglas <brad@neruo.com>");
@@ -2464,5 +2460,4 @@
 module_param_named(nomtrr, mtrr, invbool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
 #endif
-#endif
 
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/atyfb_base.c.old	2005-03-01 02:18:33.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/atyfb_base.c	2005-03-01 02:59:45.000000000 +0100
@@ -265,7 +265,7 @@
      *  Interface used by the world
      */
 
-struct fb_var_screeninfo default_var = {
+static struct fb_var_screeninfo default_var = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	640, 480, 640, 480, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -2990,7 +2990,7 @@
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
-void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
 	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
@@ -3589,7 +3589,8 @@
 
 #endif /* CONFIG_PCI */
 
-int __init atyfb_setup(char *options)
+#ifndef MODULE
+static int __init atyfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -3657,8 +3658,9 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-int __init atyfb_init(void)
+static int __init atyfb_init(void)
 {
 #ifndef MODULE
     char *option = NULL;
@@ -3677,7 +3679,7 @@
     return 0;
 }
 
-void __exit atyfb_exit(void)
+static void __exit atyfb_exit(void)
 {
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
@@ -3685,9 +3687,7 @@
 }
 
 module_init(atyfb_init);
-#ifdef MODULE
 module_exit(atyfb_exit);
-#endif
 
 MODULE_DESCRIPTION("FBDev driver for ATI Mach64 cards");
 MODULE_LICENSE("GPL");
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/mach64_ct.c.old	2005-03-01 02:20:29.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/mach64_ct.c	2005-03-01 02:21:26.000000000 +0100
@@ -359,7 +359,8 @@
 #endif
 }
 
-void __init aty_get_pll_ct(const struct fb_info *info, union aty_pll *pll)
+static void __init aty_get_pll_ct(const struct fb_info *info,
+				  union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 tmp, clock;
@@ -382,7 +383,9 @@
 	}
 }
 
-int __init aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll) {
+staticint __init aty_init_pll_ct(const struct fb_info *info,
+				 union aty_pll *pll)
+{
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
 	u32 q, i, memcntl, trp;
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/atyfb.h.old	2005-03-01 02:21:41.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/atyfb.h	2005-03-01 02:21:51.000000000 +0100
@@ -334,7 +334,6 @@
      */
 
 extern int aty_init_cursor(struct fb_info *info);
-extern int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
     /*
      *  Hardware acceleration
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/mach64_cursor.c.old	2005-03-01 02:21:59.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/mach64_cursor.c	2005-03-01 02:22:10.000000000 +0100
@@ -71,7 +71,7 @@
 	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
 };
 
-int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u16 xoff, yoff;
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeonfb.h.old	2005-03-01 02:24:25.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeonfb.h	2005-03-01 02:24:32.000000000 +0100
@@ -647,7 +647,6 @@
 
 /* Other functions */
 extern int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch);
-extern void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save);
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
 			       int reg_only);
 
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeon_base.c.old	2005-03-01 02:24:41.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeon_base.c	2005-03-01 03:00:55.000000000 +0100
@@ -1139,7 +1139,8 @@
 }
 
 
-void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
+static void radeon_save_state (struct radeonfb_info *rinfo,
+			       struct radeon_regs *save)
 {
 	/* CRTC regs */
 	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
@@ -2486,27 +2487,8 @@
 #endif /* CONFIG_PM */
 };
 
-int __init radeonfb_setup (char *options);
-
-int __init radeonfb_init (void)
-{
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("radeonfb", &option))
-		return -ENODEV;
-	radeonfb_setup(option);
-#endif
-	return pci_module_init (&radeonfb_driver);
-}
-
-
-void __exit radeonfb_exit (void)
-{
-	pci_unregister_driver (&radeonfb_driver);
-}
-
-int __init radeonfb_setup (char *options)
+static int __init radeonfb_setup (char *options)
 {
 	char *this_opt;
 
@@ -2540,12 +2522,28 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-module_init(radeonfb_init);
+static int __init radeonfb_init (void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
-#ifdef MODULE
-module_exit(radeonfb_exit);
+	if (fb_get_options("radeonfb", &option))
+		return -ENODEV;
+	radeonfb_setup(option);
 #endif
+	return pci_module_init (&radeonfb_driver);
+}
+
+
+static void __exit radeonfb_exit (void)
+{
+	pci_unregister_driver (&radeonfb_driver);
+}
+
+module_init(radeonfb_init);
+module_exit(radeonfb_exit);
 
 MODULE_AUTHOR("Ani Joshi");
 MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
--- linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeon_pm.c.old	2005-03-01 02:31:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/aty/radeon_pm.c	2005-03-01 02:31:44.000000000 +0100
@@ -27,7 +27,7 @@
 
 #include "ati_ids.h"
 
-void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
+static void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
 
@@ -229,7 +229,7 @@
 	radeon_msleep(16);
 }
 
-void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
+static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
 
--- linux-2.6.11-rc4-mm1-full/drivers/video/backlight/backlight.c.old	2005-03-01 02:32:07.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/backlight/backlight.c	2005-03-01 02:32:25.000000000 +0100
@@ -111,7 +111,7 @@
 	kfree(bd);
 }
 
-struct class backlight_class = {
+static struct class backlight_class = {
 	.name = "backlight",
 	.release = backlight_class_release,
 };
--- linux-2.6.11-rc4-mm1-full/drivers/video/backlight/lcd.c.old	2005-03-01 02:33:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/backlight/lcd.c	2005-03-01 02:33:50.000000000 +0100
@@ -111,7 +111,7 @@
 	kfree(ld);
 }
 
-struct class lcd_class = {
+static struct class lcd_class = {
 	.name = "lcd",
 	.release = lcd_class_release,
 };
--- linux-2.6.11-rc4-mm1-full/drivers/video/cyber2000fb.c.old	2005-03-01 02:38:27.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/cyber2000fb.c	2005-03-01 03:01:44.000000000 +0100
@@ -1306,7 +1306,8 @@
  * Parse Cyber2000fb options.  Usage:
  *  video=cyber2000:font:fontname
  */
-int
+#ifndef MODULE
+static int
 cyber2000fb_setup(char *options)
 {
 	char *opt;
@@ -1328,6 +1329,7 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
 /*
  * The CyberPro chips can be placed on many different bus types.
@@ -1717,7 +1719,7 @@
  *
  * Tony: "module_init" is now required
  */
-int __init cyber2000fb_init(void)
+static int __init cyber2000fb_init(void)
 {
 	int ret = -1, err;
 
--- linux-2.6.11-rc4-mm1-full/include/linux/fb.h.old	2005-03-01 02:39:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/fb.h	2005-03-01 02:41:40.000000000 +0100
@@ -857,10 +857,8 @@
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
-extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
 extern void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs);
 extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
-extern struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 
 /* drivers/video/modedb.c */
--- linux-2.6.11-rc4-mm1-full/drivers/video/fbmon.c.old	2005-03-01 02:40:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/fbmon.c	2005-03-01 02:41:54.000000000 +0100
@@ -517,7 +517,7 @@
  * This function builds a mode database using the contents of the EDID
  * data
  */
-struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
@@ -592,7 +592,7 @@
 		kfree(modedb);
 }
 
-int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 {
 	int i, retval = 1;
 	unsigned char *block;
@@ -1180,17 +1180,9 @@
 {
 	specs = NULL;
 }
-struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
-{
-	return NULL;
-}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
-int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
-{
-	return 1;
-}
 int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
@@ -1264,6 +1256,4 @@
 
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
-EXPORT_SYMBOL(fb_create_modedb);
 EXPORT_SYMBOL(fb_destroy_modedb);
-EXPORT_SYMBOL(fb_get_monitor_limits);
--- linux-2.6.11-rc4-mm1-full/drivers/video/geode/gx1fb_core.c.old	2005-03-01 02:42:05.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/geode/gx1fb_core.c	2005-03-01 02:42:31.000000000 +0100
@@ -264,9 +264,9 @@
 }
 
 
-struct fb_info *gx1fb_info;
+static struct fb_info *gx1fb_info;
 
-int __init gx1fb_init(void)
+static int __init gx1fb_init(void)
 {
 	struct fb_info *info;
         struct geodefb_par *par;
--- linux-2.6.11-rc4-mm1-full/drivers/video/hgafb.c.old	2005-03-01 02:42:43.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/hgafb.c	2005-03-01 02:43:41.000000000 +0100
@@ -412,7 +412,8 @@
  *	A zero is returned on success and %-EINVAL for failure.
  */
 
-int hgafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+static int hgafb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
 		if (var->yoffset < 0 || 
@@ -548,7 +549,7 @@
 	 *  Initialization
 	 */
 
-int __init hgafb_init(void)
+static int __init hgafb_init(void)
 {
 	if (fb_get_options("hgafb", NULL))
 		return -ENODEV;
@@ -587,15 +588,6 @@
 	return 0;
 }
 
-	/*
-	 *  Setup
-	 */
-
-int __init hgafb_setup(char *options)
-{
-	return 0;
-}
-
 #ifdef MODULE
 static void __exit hgafb_exit(void)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/video/i810/i810_main.c.old	2005-03-01 02:44:55.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/i810/i810_main.c	2005-03-01 02:45:32.000000000 +0100
@@ -1997,7 +1997,7 @@
 
 #ifdef MODULE
 
-int __init i810fb_init(void)
+static int __init i810fb_init(void)
 {
 	hsync1 *= 1000;
 	hsync2 *= 1000;
--- linux-2.6.11-rc4-mm1-full/drivers/video/imsttfb.c.old	2005-03-01 02:45:44.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/imsttfb.c	2005-03-01 03:02:22.000000000 +0100
@@ -1547,7 +1547,7 @@
 }
 
 #ifndef MODULE
-int __init 
+static int __init 
 imsttfb_setup(char *options)
 {
 	char *this_opt;
@@ -1601,7 +1601,7 @@
 
 #endif /* MODULE */
 
-int __init imsttfb_init(void)
+static int __init imsttfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1619,9 +1619,8 @@
 	pci_unregister_driver(&imsttfb_pci_driver);
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
+
 module_init(imsttfb_init);
 module_exit(imsttfb_exit);
 
--- linux-2.6.11-rc4-mm1-full/drivers/video/intelfb/intelfbdrv.c.old	2005-03-01 02:46:20.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/intelfb/intelfbdrv.c	2005-03-01 03:04:13.000000000 +0100
@@ -227,42 +227,6 @@
 module_param(mode, charp, S_IRUGO);
 MODULE_PARM_DESC(mode,
 		 "Initial video mode \"<xres>x<yres>[-<depth>][@<refresh>]\"");
-/***************************************************************
- *                     modules entry points                    *
- ***************************************************************/
-
-/* module load/unload entry points */
-int __init
-intelfb_init(void)
-{
-#ifndef MODULE
-	char *option = NULL;
-#endif
-
-	DBG_MSG("intelfb_init\n");
-
-	INF_MSG("Framebuffer driver for "
-		"Intel(R) " SUPPORTED_CHIPSETS " chipsets\n");
-	INF_MSG("Version " INTELFB_VERSION "\n");
-
-	if (idonly)
-		return -ENODEV;
-
-#ifndef MODULE
-	if (fb_get_options("intelfb", &option))
-		return -ENODEV;
-	intelfb_setup(option);
-#endif
-
-	return pci_module_init(&intelfb_driver);
-}
-
-static void __exit
-intelfb_exit(void)
-{
-	DBG_MSG("intelfb_exit\n");
-	pci_unregister_driver(&intelfb_driver);
-}
 
 #ifndef MODULE
 #define OPT_EQUAL(opt, name) (!strncmp(opt, name, strlen(name)))
@@ -322,7 +286,7 @@
 	return 1;
 }
 
-int __init
+static int __init
 intelfb_setup(char *options)
 {
 	char *this_opt;
@@ -374,12 +338,41 @@
 
 #endif
 
-module_init(intelfb_init);
+static int __init
+intelfb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
+#endif
 
-#ifdef MODULE
-module_exit(intelfb_exit);
+	DBG_MSG("intelfb_init\n");
+
+	INF_MSG("Framebuffer driver for "
+		"Intel(R) " SUPPORTED_CHIPSETS " chipsets\n");
+	INF_MSG("Version " INTELFB_VERSION "\n");
+
+	if (idonly)
+		return -ENODEV;
+
+#ifndef MODULE
+	if (fb_get_options("intelfb", &option))
+		return -ENODEV;
+	intelfb_setup(option);
 #endif
 
+	return pci_module_init(&intelfb_driver);
+}
+
+static void __exit
+intelfb_exit(void)
+{
+	DBG_MSG("intelfb_exit\n");
+	pci_unregister_driver(&intelfb_driver);
+}
+
+module_init(intelfb_init);
+module_exit(intelfb_exit);
+
 /***************************************************************
  *                     mtrr support functions                  *
  ***************************************************************/
--- linux-2.6.11-rc4-mm1-full/drivers/video/neofb.c.old	2005-03-01 02:48:12.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/neofb.c	2005-03-01 03:04:44.000000000 +0100
@@ -400,21 +400,21 @@
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
@@ -425,7 +425,7 @@
 	vga_wattr(NULL, index, value);
 }
 
-void vgaHWProtect(int on)
+static void vgaHWProtect(int on)
 {
 	unsigned char tmp;
 
@@ -1315,7 +1315,7 @@
 /*
  *    (Un)Blank the display.
  */
-int neofb_blank(int blank_mode, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank.
@@ -2230,7 +2230,8 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init neofb_setup(char *options)
+#ifndef MODULE
+static int __init neofb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2258,8 +2259,9 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-int __init neofb_init(void)
+static int __init neofb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_accel.c.old	2005-03-01 02:49:39.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_accel.c	2005-03-01 02:51:05.000000000 +0100
@@ -55,7 +55,7 @@
 	}
 }
 
-void NVDmaKickoff(struct nvidia_par *par)
+static void NVDmaKickoff(struct nvidia_par *par)
 {
 	if (par->dmaCurrent != par->dmaPut) {
 		par->dmaPut = par->dmaCurrent;
@@ -63,7 +63,7 @@
 	}
 }
 
-void NVDmaWait(struct nvidia_par *par, int size)
+static void NVDmaWait(struct nvidia_par *par, int size)
 {
 	int dmaGet;
 	int count = 1000000000, cnt;
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_proto.h.old	2005-03-01 02:52:06.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_proto.h	2005-03-01 02:54:17.000000000 +0100
@@ -15,10 +15,7 @@
 u8 NVReadAttr(struct nvidia_par *par, u8 index);
 void NVWriteMiscOut(struct nvidia_par *par, u8 value);
 u8 NVReadMiscOut(struct nvidia_par *par);
-void NVEnablePalette(struct nvidia_par *par);
-void NVDisablePalette(struct nvidia_par *par);
 void NVWriteDacMask(struct nvidia_par *par, u8 value);
-u8 NVReadDacMask(struct nvidia_par *par);
 void NVWriteDacReadAddr(struct nvidia_par *par, u8 value);
 void NVWriteDacWriteAddr(struct nvidia_par *par, u8 value);
 void NVWriteDacData(struct nvidia_par *par, u8 value);
@@ -36,12 +33,10 @@
 /* in nvidia-i2c.c */
 #if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
 void nvidia_create_i2c_busses(struct nvidia_par *par);
-void nvidia_delete_i2c_busses(struct nvidia_par *par);
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn,
 			       u8 ** out_edid);
 #else
 #define nvidia_create_i2c_busses(...)
-#define nvidia_delete_i2c_busses(...)
 #define nvidia_probe_i2c_connector(p, c, edid) \
 do {                                           \
 	*(edid) = NULL;                        \
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_i2c.c.old	2005-03-01 02:52:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_i2c.c	2005-03-01 02:52:50.000000000 +0100
@@ -143,6 +143,7 @@
 	nvidia_setup_i2c_bus(&par->chan[2], "BUS3");
 }
 
+#if 0
 void nvidia_delete_i2c_busses(struct nvidia_par *par)
 {
 	if (par->chan[0].par)
@@ -158,6 +159,7 @@
 	par->chan[2].par = NULL;
 
 }
+#endif  /*  0  */
 
 static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_of.c.old	2005-03-01 02:52:58.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_of.c	2005-03-01 02:53:01.000000000 +0100
@@ -28,7 +28,6 @@
 #include "nv_proto.h"
 
 void nvidia_create_i2c_busses(struct nvidia_par *par) {}
-void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
 
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
 {
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_setup.c.old	2005-03-01 02:53:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nv_setup.c	2005-03-01 02:54:32.000000000 +0100
@@ -108,6 +108,7 @@
 {
 	return (VGA_RD08(par->PVIO, VGA_MIS_R));
 }
+#if 0
 void NVEnablePalette(struct nvidia_par *par)
 {
 	volatile u8 tmp;
@@ -124,14 +125,17 @@
 	VGA_WR08(par->PCIO, VGA_ATT_IW, 0x20);
 	par->paletteEnabled = 0;
 }
+#endif  /*  0  */
 void NVWriteDacMask(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_MSK, value);
 }
+#if 0
 u8 NVReadDacMask(struct nvidia_par *par)
 {
 	return (VGA_RD08(par->PDIO, VGA_PEL_MSK));
 }
+#endif  /*  0  */
 void NVWriteDacReadAddr(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_IR, value);
--- linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nvidia.c.old	2005-03-01 02:54:44.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/nvidia/nvidia.c	2005-03-01 03:05:14.000000000 +0100
@@ -1613,7 +1613,7 @@
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-int __init nvidiafb_setup(char *options)
+static int __init nvidiafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1666,7 +1666,7 @@
  *
  * ------------------------------------------------------------------------- */
 
-int __devinit nvidiafb_init(void)
+static int __devinit nvidiafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
--- linux-2.6.11-rc4-mm1-full/drivers/video/pm2fb.c.old	2005-03-01 02:55:43.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/pm2fb.c	2005-03-01 03:06:14.000000000 +0100
@@ -1243,47 +1243,13 @@
 MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
 
 
-/*
- *  Initialization
- */
-
-int __init pm2fb_setup(char *options);
-
-int __init pm2fb_init(void)
-{
-#ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("pm2fb", &option))
-		return -ENODEV;
-	pm2fb_setup(option);
-#endif
-
-	return pci_module_init(&pm2fb_driver);
-}
-
-#ifdef MODULE
-/*
- *  Cleanup
- */
-
-static void __exit pm2fb_exit(void)
-{
-	pci_unregister_driver(&pm2fb_driver);
-}
-#endif
-
-/*
- *  Setup
- */
-
 #ifndef MODULE
 /**
  * Parse user speficied options.
  *
  * This is, comma-separated options following `video=pm2fb:'.
  */
-int __init pm2fb_setup(char *options)
+static int __init pm2fb_setup(char *options)
 {
 	char* this_opt;
 
@@ -1306,13 +1272,29 @@
 #endif
 
 
-/* ------------------------------------------------------------------------- */
+static int __init pm2fb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
-/* ------------------------------------------------------------------------- */
+	if (fb_get_options("pm2fb", &option))
+		return -ENODEV;
+	pm2fb_setup(option);
+#endif
 
+	return pci_module_init(&pm2fb_driver);
+}
 
+#ifdef MODULE
+/*
+ *  Cleanup
+ */
 
-module_init(pm2fb_init);
+static void __exit pm2fb_exit(void)
+{
+	pci_unregister_driver(&pm2fb_driver);
+}
+#endif
 
 #ifdef MODULE
 module_exit(pm2fb_exit);
--- linux-2.6.11-rc4-mm1-full/drivers/video/radeonfb.c.old	2005-03-01 02:56:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/radeonfb.c	2005-03-01 03:07:31.000000000 +0100
@@ -3109,28 +3109,8 @@
 	.remove		= __devexit_p(radeonfb_pci_unregister),
 };
 
-int __init radeonfb_old_setup (char *options);
-
-int __init radeonfb_old_init (void)
-{
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("radeonfb_old", &option))
-		return -ENODEV;
-	radeonfb_old_setup(option);
-#endif
-	return pci_module_init (&radeonfb_driver);
-}
-
-
-void __exit radeonfb_old_exit (void)
-{
-	pci_unregister_driver (&radeonfb_driver);
-}
-
-
-int __init radeonfb_old_setup (char *options)
+static int __init radeonfb_old_setup (char *options)
 {
         char *this_opt;
 
@@ -3156,12 +3136,28 @@
 
 	return 0;
 }
+#endif  /*  MODULE  */
 
-module_init(radeonfb_old_init);
+static int __init radeonfb_old_init (void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
-#ifdef MODULE
-module_exit(radeonfb_old_exit);
+	if (fb_get_options("radeonfb_old", &option))
+		return -ENODEV;
+	radeonfb_old_setup(option);
 #endif
+	return pci_module_init (&radeonfb_driver);
+}
+
+
+static void __exit radeonfb_old_exit (void)
+{
+	pci_unregister_driver (&radeonfb_driver);
+}
+
+module_init(radeonfb_old_init);
+module_exit(radeonfb_old_exit);
 
 
 MODULE_AUTHOR("Ani Joshi");
--- linux-2.6.11-rc4-mm1-full/drivers/video/riva/fbdev.c.old	2005-03-01 02:57:25.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/riva/fbdev.c	2005-03-01 02:58:25.000000000 +0100
@@ -906,7 +906,7 @@
 }
 
 /* acceleration routines */
-inline void wait_for_idle(struct riva_par *par)
+static inline void wait_for_idle(struct riva_par *par)
 {
 	while (par->riva.Busy(&par->riva));
 }
@@ -923,7 +923,7 @@
 
 }
 
-void riva_setup_accel(struct fb_info *info)
+static void riva_setup_accel(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 
@@ -2139,7 +2139,7 @@
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-int __init rivafb_setup(char *options)
+static int __init rivafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2189,7 +2189,7 @@
  *
  * ------------------------------------------------------------------------- */
 
-int __devinit rivafb_init(void)
+static int __devinit rivafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
--- linux-2.6.11-rc4-mm1-full/drivers/video/sis/init.h.old	2005-03-01 03:13:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/sis/init.h	2005-03-01 03:15:04.000000000 +0100
@@ -2394,11 +2394,9 @@
 void	SiS_DisplayOn(SiS_Private *SiS_Pr);
 void	SiS_DisplayOff(SiS_Private *SiS_Pr);
 void	SiSRegInit(SiS_Private *SiS_Pr, SISIOADDRESS BaseAddr);
-void	SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN SiSDetermineROMLayout661(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SetEnableDstn(SiS_Private *SiS_Pr, int enable);
 void	SiS_SetEnableFstn(SiS_Private *SiS_Pr, int enable);
-void	SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SearchModeID(SiS_Private *SiS_Pr, USHORT *ModeNo, USHORT *ModeIdIndex);
 UCHAR	SiS_GetModePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
 USHORT	SiS_GetColorDepth(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex);
@@ -2444,7 +2442,6 @@
 extern void     SiS_SetYPbPr(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void 	SiS_SetTVMode(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex, PSIS_HW_INFO HwInfo);
 extern void     SiS_UnLockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-extern void     SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 extern void     SiS_DisableBridge(SiS_Private *, PSIS_HW_INFO);
 extern BOOLEAN  SiS_SetCRT2Group(SiS_Private *, PSIS_HW_INFO, USHORT);
 extern USHORT   SiS_GetRatePtr(SiS_Private *SiS_Pr, USHORT ModeNo, USHORT ModeIdIndex,
--- linux-2.6.11-rc4-mm1-full/drivers/video/sis/init.c.old	2005-03-01 03:13:31.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/sis/init.c	2005-03-01 03:13:53.000000000 +0100
@@ -1384,7 +1384,7 @@
 /*             HELPER: SetLVDSetc            */
 /*********************************************/
 
-void
+static void
 SiSSetLVDSetc(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    USHORT temp;
@@ -1625,7 +1625,7 @@
 /*             HELPER: GetVBType             */
 /*********************************************/
 
-void
+static void
 SiS_GetVBType(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT flag=0, rev=0, nolcd=0, p4_0f, p4_25, p4_27;
--- linux-2.6.11-rc4-mm1-full/drivers/video/sis/init301.h.old	2005-03-01 03:14:13.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/sis/init301.h	2005-03-01 03:15:40.000000000 +0100
@@ -310,7 +310,6 @@
                 USHORT RefreshRateTableIndex, PSIS_HW_INFO HwInfo);
 USHORT	SiS_GetResInfo(SiS_Private *SiS_Pr,USHORT ModeNo,USHORT ModeIdIndex);
 void	SiS_DisableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
-void	SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 BOOLEAN	SiS_SetCRT2Group(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo, USHORT ModeNo);
 void	SiS_SiS30xBLOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
 void	SiS_SiS30xBLOff(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
@@ -319,8 +318,6 @@
 USHORT 	SiS_GetCH700x(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
 USHORT 	SiS_GetCH701x(SiS_Private *SiS_Pr, USHORT tempax);
-void   	SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
-USHORT 	SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempax);
 void   	SiS_SetCH70xxANDOR(SiS_Private *SiS_Pr, USHORT tempax,USHORT tempbh);
 #ifdef SIS315H
 static void   	SiS_Chrontel701xOn(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo);
--- linux-2.6.11-rc4-mm1-full/drivers/video/sis/init301.c.old	2005-03-01 03:14:27.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/sis/init301.c	2005-03-01 03:16:14.000000000 +0100
@@ -86,6 +86,7 @@
 #define SiS_I2CDELAYSHORT  150
 
 static USHORT SiS_GetBIOSLCDResInfo(SiS_Private *SiS_Pr);
+static void SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx);
 
 /*********************************************/
 /*         HELPER: Lock/Unlock CRT2          */
@@ -100,7 +101,7 @@
       SiS_SetRegOR(SiS_Pr->SiS_Part1Port,0x24,0x01);
 }
 
-void
+static void
 SiS_LockCRT2(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
    if(HwInfo->jChipType >= SIS_315H)
@@ -4236,7 +4237,7 @@
  * from outside the context of a mode switch!
  * MUST call getVBType before calling this
  */
-void
+static void
 SiS_EnableBridge(SiS_Private *SiS_Pr, PSIS_HW_INFO HwInfo)
 {
   USHORT temp=0,tempah;
@@ -9219,7 +9220,7 @@
   SiS_SetChReg(SiS_Pr, tempbx, 0);
 }
 
-void
+static void
 SiS_SetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
@@ -9323,7 +9324,7 @@
 
 /* Read from Chrontel 70xx */
 /* Parameter is [Register no (S7-S0)] */
-USHORT
+static USHORT
 SiS_GetCH70xx(SiS_Private *SiS_Pr, USHORT tempbx)
 {
   if(SiS_Pr->SiS_IF_DEF_CH70xx == 1)
--- linux-2.6.11-rc4-mm1-full/drivers/video/sis/sis_main.c.old	2005-03-01 03:20:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/sis/sis_main.c	2005-03-01 03:21:07.000000000 +0100
@@ -4762,7 +4762,8 @@
 #endif
 
 
-int __devinit sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit sisfb_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
 {
 	struct sisfb_chip_info 	*chipinfo = &sisfb_chip_info[ent->driver_data];
 	struct sis_video_info 	*ivideo = NULL;
@@ -5940,7 +5941,7 @@
 #endif
 #endif
 
-int __init sisfb_init_module(void)
+static int __init sisfb_init_module(void)
 {
 	sisfb_setdefaultparms();
 
--- linux-2.6.11-rc4-mm1-full/drivers/video/tdfxfb.c.old	2005-03-01 03:21:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/tdfxfb.c	2005-03-01 03:22:40.000000000 +0100
@@ -154,9 +154,6 @@
 /*
  *  Frame buffer device API
  */
-int tdfxfb_init(void);
-void tdfxfb_setup(char *options);
-
 static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb); 
 static int tdfxfb_set_par(struct fb_info *info); 
 static int tdfxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue, 
@@ -1292,6 +1289,28 @@
 	return -ENXIO;
 }
 
+#ifndef MODULE
+void tdfxfb_setup(char *options)
+{ 
+	char* this_opt;
+
+	if (!options || !*options)
+		return;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {	
+		if (!*this_opt)
+			continue;
+		if(!strcmp(this_opt, "nopan")) {
+			nopan = 1;
+		} else if(!strcmp(this_opt, "nowrap")) {
+			nowrap = 1;
+		} else {
+			mode_option = this_opt;
+		}
+	} 
+}
+#endif
+
 /**
  *      tdfxfb_remove - Device removal
  *
@@ -1321,7 +1340,7 @@
 	framebuffer_release(info);
 }
 
-int __init tdfxfb_init(void)
+static int __init tdfxfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1345,27 +1364,3 @@
  
 module_init(tdfxfb_init);
 module_exit(tdfxfb_exit);
-
-
-#ifndef MODULE
-void tdfxfb_setup(char *options)
-{ 
-	char* this_opt;
-
-	if (!options || !*options)
-		return;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {	
-		if (!*this_opt)
-			continue;
-		if(!strcmp(this_opt, "nopan")) {
-			nopan = 1;
-		} else if(!strcmp(this_opt, "nowrap")) {
-			nowrap = 1;
-		} else {
-			mode_option = this_opt;
-		}
-	} 
-}
-#endif
-
--- linux-2.6.11-rc4-mm1-full/drivers/video/vesafb.c.old	2005-03-01 03:22:51.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/vesafb.c	2005-03-01 03:42:05.000000000 +0100
@@ -185,7 +185,7 @@
 	.fb_cursor	= soft_cursor,
 };
 
-int __init vesafb_setup(char *options)
+static int __init vesafb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -434,7 +434,7 @@
 	.name	= "vesafb",
 };
 
-int __init vesafb_init(void)
+static int __init vesafb_init(void)
 {
 	int ret;
 	char *option = NULL;
@@ -453,12 +453,4 @@
 }
 module_init(vesafb_init);
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
-
 MODULE_LICENSE("GPL");
--- linux-2.6.11-rc4-mm1-full/drivers/video/vfb.c.old	2005-03-01 03:42:21.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/video/vfb.c	2005-03-01 03:43:51.000000000 +0100
@@ -72,12 +72,6 @@
 static int vfb_enable __initdata = 0;	/* disabled by default */
 module_param(vfb_enable, bool, 0);
 
-    /*
-     *  Interface used by the world
-     */
-int vfb_init(void);
-int vfb_setup(char *);
-
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info);
 static int vfb_set_par(struct fb_info *info);
@@ -379,7 +373,8 @@
 	return -EINVAL;
 }
 
-int __init vfb_setup(char *options)
+#ifndef MODULE
+static int __init vfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -396,6 +391,7 @@
 	}
 	return 1;
 }
+#endif  /*  MODULE  */
 
     /*
      *  Initialisation
@@ -492,7 +488,7 @@
 	}
 };
 
-int __init vfb_init(void)
+static int __init vfb_init(void)
 {
 	int ret = 0;
 

