Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbTDBOxT>; Wed, 2 Apr 2003 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbTDBOxT>; Wed, 2 Apr 2003 09:53:19 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:34576 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S263022AbTDBOwt>; Wed, 2 Apr 2003 09:52:49 -0500
Date: Wed, 2 Apr 2003 09:04:05 -0600
From: Art Haas <ahaas@airmail.net>
To: James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/video files
Message-ID: <20030402150405.GB22242@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are a set of patches converting various files in drivers/video to
use C99 initializers. pm2fb.c and retz3fb.c do not compile as they
haven't been converted to the new framebuffer code, but the patches
converting the existing files are included here regardless. The patches
are against the current BK.

Art Haas

===== drivers/video/pm2fb.c 1.17 vs edited =====
--- 1.17/drivers/video/pm2fb.c	Sun Feb 16 12:36:47 2003
+++ edited/drivers/video/pm2fb.c	Tue Apr  1 19:30:16 2003
@@ -1434,24 +1434,24 @@
 }
 
 static struct display_switch pm2_cfb8 = {
-	.setup =	fbcon_cfb8_setup,
-	.bmove =	pm2fb_pp_bmove,
+	.setup		= fbcon_cfb8_setup,
+	.bmove		= pm2fb_pp_bmove,
 #ifdef __alpha__
 	/* Not sure why, but this works and the other does not. */
 	/* Also, perhaps we need a separate routine to wait for the
 	   blitter to stop before doing this? */
 	/* In addition, maybe we need to do this for 16 and 32 bit depths? */
-	.clear =	fbcon_cfb8_clear,
+	.clear		= fbcon_cfb8_clear,
 #else
-	.clear =	pm2fb_clear8,
+	.clear		= pm2fb_clear8,
 #endif
-	.putc =		fbcon_cfb8_putc,
-	.putcs =	fbcon_cfb8_putcs,
-	.revc =		fbcon_cfb8_revc,
-	.cursor =	pm2fb_cursor,
-	.set_font =	pm2fb_set_font,
-	.clear_margins =pm2fb_clear_margins8,
-	fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16) };
+	.putc		= fbcon_cfb8_putc,
+	.putcs		= fbcon_cfb8_putcs,
+	.revc		= fbcon_cfb8_revc,
+	.cursor		= pm2fb_cursor,
+	.set_font	= pm2fb_set_font,
+	.clear_margins	= pm2fb_clear_margins8,
+	.fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16) };
 #endif /* FBCON_HAS_CFB8 */
 
 #ifdef FBCON_HAS_CFB16
===== drivers/video/retz3fb.c 1.18 vs edited =====
--- 1.18/drivers/video/retz3fb.c	Tue Feb 25 13:05:23 2003
+++ edited/drivers/video/retz3fb.c	Wed Feb 26 18:19:05 2003
@@ -1589,13 +1589,13 @@
 
 
 static struct display_switch fbcon_retz3_8 = {
-    setup:		fbcon_cfb8_setup,
-    bmove:		retz3_8_bmove,
-    clear:		retz3_8_clear,
-    putc:		retz3_putc,
-    putcs:		retz3_putcs,
-    revc:		retz3_revc,
-    clear_margins:	retz3_clear_margins,
-    fontwidthmask:	FONTWIDTH(8)
+	.setup		= fbcon_cfb8_setup,
+	.bmove		= retz3_8_bmove,
+	.clear		= retz3_8_clear,
+	.putc		= retz3_putc,
+	.putcs		= retz3_putcs,
+	.revc		= retz3_revc,
+	.clear_margins	= retz3_clear_margins,
+	.fontwidthmask	= FONTWIDTH(8)
 };
 #endif
===== drivers/video/sis/sis_main.h 1.9 vs edited =====
--- 1.9/drivers/video/sis/sis_main.h	Fri Mar  7 13:19:02 2003
+++ edited/drivers/video/sis/sis_main.h	Mon Mar 24 11:49:23 2003
@@ -286,43 +286,43 @@
 static int    video_type = FB_TYPE_PACKED_PIXELS;
 
 static struct fb_var_screeninfo default_var = {
-	xres:           0,
-	yres:           0,
-	xres_virtual:   0,
-	yres_virtual:   0,
-	xoffset:        0,
-	yoffset:        0,
-	bits_per_pixel: 0,
-	grayscale:      0,
-	red:            {0, 8, 0},
-	green:          {0, 8, 0},
-	blue:           {0, 8, 0},
-	transp:         {0, 0, 0},
-	nonstd:         0,
-	activate:       FB_ACTIVATE_NOW,
-	height:         -1,
-	width:          -1,
-	accel_flags:    0,
-	pixclock:       0,
-	left_margin:    0,
-	right_margin:   0,
-	upper_margin:   0,
-	lower_margin:   0,
-	hsync_len:      0,
-	vsync_len:      0,
-	sync:           0,
-	vmode:          FB_VMODE_NONINTERLACED,
+	.xres		= 0,
+	.yres		= 0,
+	.xres_virtual	= 0,
+	.yres_virtual	= 0,
+	.xoffset	= 0,
+	.yoffset	= 0,
+	.bits_per_pixel	= 0,
+	.grayscale	= 0,
+	.red		= {0, 8, 0},
+	.green		= {0, 8, 0},
+	.blue		= {0, 8, 0},
+	.transp		= {0, 0, 0},
+	.nonstd		= 0,
+	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.accel_flags	= 0,
+	.pixclock	= 0,
+	.left_margin	= 0,
+	.right_margin	= 0,
+	.upper_margin	= 0,
+	.lower_margin	= 0,
+	.hsync_len	= 0,
+	.vsync_len	= 0,
+	.sync		= 0,
+	.vmode		= FB_VMODE_NONINTERLACED,
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)	
-	reserved:       {0, 0, 0, 0, 0, 0}
+	.reserved	= {0, 0, 0, 0, 0, 0}
 #endif	
 };
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 static struct fb_fix_screeninfo sisfb_fix = {
-	id:		"SiS",
-	type:		FB_TYPE_PACKED_PIXELS,
-	xpanstep:	1,
-	ypanstep:	1,
+	.id		= "SiS",
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.xpanstep	= 1,
+	.ypanstep	= 1,
 };
 static char myid[20];
 static u32 pseudo_palette[17];
===== drivers/video/radeonfb.c 1.20 vs edited =====
--- 1.20/drivers/video/radeonfb.c	Tue Jan 28 14:28:57 2003
+++ edited/drivers/video/radeonfb.c	Wed Apr  2 07:02:45 2003
@@ -3111,10 +3111,10 @@
 
 
 static struct pci_driver radeonfb_driver = {
-	name:		"radeonfb",
-	id_table:	radeonfb_pci_table,
-	probe:		radeonfb_pci_register,
-	remove:		__devexit_p(radeonfb_pci_unregister),
+	.name		= "radeonfb",
+	.id_table	= radeonfb_pci_table,
+	.probe		= radeonfb_pci_register,
+	.remove		= __devexit_p(radeonfb_pci_unregister),
 };
 
 
===== drivers/video/tridentfb.c 1.6 vs edited =====
--- 1.6/drivers/video/tridentfb.c	Mon Mar  3 21:41:18 2003
+++ edited/drivers/video/tridentfb.c	Wed Apr  2 07:03:26 2003
@@ -1204,10 +1204,10 @@
 MODULE_DEVICE_TABLE(pci,trident_devices); 
 
 static struct pci_driver tridentfb_pci_driver = {
-	name:"tridentfb",
-	id_table:trident_devices,
-	probe:trident_pci_probe,
-	remove:__devexit_p(trident_pci_remove)
+	.name		= "tridentfb",
+	.id_table	= trident_devices,
+	.probe		= trident_pci_probe,
+	.remove		= __devexit_p(trident_pci_remove)
 };
 
 int __init tridentfb_init(void)
===== drivers/video/riva/fbdev.c 1.40 vs edited =====
--- 1.40/drivers/video/riva/fbdev.c	Fri Feb 28 12:40:11 2003
+++ edited/drivers/video/riva/fbdev.c	Wed Apr  2 07:02:04 2003
@@ -297,34 +297,34 @@
 #endif
 
 static struct fb_fix_screeninfo rivafb_fix = {
-	id:		"nVidia",
-	type:		FB_TYPE_PACKED_PIXELS,
-	xpanstep:	1,
-	ypanstep:	1,
+	.id		= "nVidia",
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.xpanstep	= 1,
+	.ypanstep	= 1,
 };
 
 static struct fb_var_screeninfo rivafb_default_var = {
-	xres:		640,
-	yres:		480,
-	xres_virtual:	640,
-	yres_virtual:	480,
-	bits_per_pixel:	8,
-	red:		{0, 8, 0},
-	green:		{0, 8, 0},
-	blue:		{0, 8, 0},
-	transp:		{0, 0, 0},
-	activate:	FB_ACTIVATE_NOW,
-	height:		-1,
-	width:		-1,
-	accel_flags:	FB_ACCELF_TEXT,
-	pixclock:	39721,
-	left_margin:	40,
-	right_margin:	24,
-	upper_margin:	32,
-	lower_margin:	11,
-	hsync_len:	96,
-	vsync_len:	2,
-	vmode:		FB_VMODE_NONINTERLACED
+	.xres		= 640,
+	.yres		= 480,
+	.xres_virtual	= 640,
+	.yres_virtual	= 480,
+	.bits_per_pixel	= 8,
+	.red		= {0, 8, 0},
+	.green		= {0, 8, 0},
+	.blue		= {0, 8, 0},
+	.transp		= {0, 0, 0},
+	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.accel_flags	= FB_ACCELF_TEXT,
+	.pixclock	= 39721,
+	.left_margin	= 40,
+	.right_margin	= 24,
+	.upper_margin	= 32,
+	.lower_margin	= 11,
+	.hsync_len	= 96,
+	.vsync_len	= 2,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 /* from GGI */
@@ -1984,10 +1984,10 @@
 #endif /* !MODULE */
 
 static struct pci_driver rivafb_driver = {
-	name:		"rivafb",
-	id_table:	rivafb_pci_tbl,
-	probe:		rivafb_probe,
-	remove:		__exit_p(rivafb_remove),
+	.name		= "rivafb",
+	.id_table	= rivafb_pci_tbl,
+	.probe		= rivafb_probe,
+	.remove		= __exit_p(rivafb_remove),
 };
 
 
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
