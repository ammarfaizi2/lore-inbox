Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbQLITMK>; Sat, 9 Dec 2000 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbQLITMA>; Sat, 9 Dec 2000 14:12:00 -0500
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:13480 "EHLO
	styx.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S130195AbQLITLr>; Sat, 9 Dec 2000 14:11:47 -0500
Date: Sat, 9 Dec 2000 19:38:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Philipp Rumpf <prumpf@tux.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: PA-RISC fb fixes
Message-ID: <Pine.LNX.4.10.10012091931540.1555-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  - stifb doesn't use resource management (yet?), so it must be initialized
    later for consistency (as indicated by the comments in fbmem.c)
  - Remove superfluous NULL data

--- linux-2.4.0-test12-pre7/drivers/video/fbmem.c.orig	Sat Dec  9 14:18:21 2000
+++ linux-2.4.0-test12-pre7/drivers/video/fbmem.c	Sat Dec  9 19:29:07 2000
@@ -200,9 +200,6 @@
 	 * management!
 	 */
 
-#ifdef CONFIG_FB_STI
-	{ "stifb", stifb_init, stifb_setup },
-#endif
 #ifdef CONFIG_FB_OF
 	{ "offb", offb_init, NULL },
 #endif
@@ -264,6 +261,9 @@
 	 * Generic drivers that don't use resource management (yet)
 	 */
 
+#ifdef CONFIG_FB_STI
+	{ "stifb", stifb_init, stifb_setup },
+#endif
 #ifdef CONFIG_FB_VGA16
 	{ "vga16", vga16fb_init, vga16fb_setup },
 #endif 
--- linux-2.4.0-test12-pre7/drivers/video/stifb.c.orig	Sat Dec  9 14:18:21 2000
+++ linux-2.4.0-test12-pre7/drivers/video/stifb.c	Sat Dec  9 19:31:04 2000
@@ -146,7 +146,6 @@
 	set_par:	sti_set_par,
 	getcolreg:	sti_getcolreg,
 	setcolreg:	sti_setcolreg,
-	pan_display:	NULL,
 	blank:		sti_blank,
 	set_disp:	sti_set_disp
 };
@@ -218,13 +217,10 @@
 
 static struct fb_ops stifb_ops = {
 	owner:		THIS_MODULE,
-	fb_open:	NULL,
-	fb_release:	NULL,
 	fb_get_fix:	fbgen_get_fix,
 	fb_get_var:	fbgen_get_var,
 	fb_set_var:	fbgen_set_var,
 	fb_get_cmap:	fbgen_get_cmap,
 	fb_set_cmap:	fbgen_set_cmap,
 	fb_pan_display:	fbgen_pan_display,
-	fb_ioctl:	NULL
 };
--- linux-2.4.0-test12-pre7/drivers/video/sticon-bmode.c.orig	Sat Dec  9 14:18:21 2000
+++ linux-2.4.0-test12-pre7/drivers/video/sticon-bmode.c	Sat Dec  9 19:30:40 2000
@@ -440,9 +440,7 @@
 	con_set_palette:	sticon_set_palette,
 	con_scrolldelta:	sticon_scrolldelta,
 	con_set_origin: 	sticon_set_origin,
-	con_save_screen:	NULL,
 	con_build_attr:		sticon_build_attr,
-	con_invert_region:	NULL,
 	con_screen_pos:		sticon_screen_pos,
 	con_getxy:		sticon_getxy,
 };
--- linux-2.4.0-test12-pre7/drivers/video/sticon.c.orig	Sat Dec  9 14:18:21 2000
+++ linux-2.4.0-test12-pre7/drivers/video/sticon.c	Sat Dec  9 19:30:47 2000
@@ -208,9 +208,7 @@
 	con_set_palette:	sticon_set_palette,
 	con_scrolldelta:	sticon_scrolldelta,
 	con_set_origin: 	sticon_set_origin,
-	con_save_screen:	NULL,
 	con_build_attr:		sticon_build_attr,
-	con_invert_region:	NULL,
 	con_screen_pos:		sticon_screen_pos,
 	con_getxy:		sticon_getxy,
 };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
