Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRCOKO6>; Thu, 15 Mar 2001 05:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131660AbRCOKOt>; Thu, 15 Mar 2001 05:14:49 -0500
Received: from aeon.tvd.be ([195.162.196.20]:40807 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131662AbRCOKOf>;
	Thu, 15 Mar 2001 05:14:35 -0500
Date: Thu, 15 Mar 2001 11:13:47 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev init sequence
Message-ID: <Pine.LNX.4.05.10103151104580.23611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another patch from FISPET (The Fbdev Initialization Sequence Policy Enforcement
Team :-).

The following frame buffer devices do not use resource management yet:

  - radeonfb (ATI Radeon): resource management calls are commented out (why?
    Got no response from Ani)
  - pmag-ba-fb (PMAG-BA TurboChannel framebuffer card): no resource management
  - pmagb-b-fb (PMAGB-B TurboChannel framebuffer card): no resource management
  - maxinefb (DECstation 5000/xx onboard framebuffer): no resource management

Thus their initialization calls must be moved to the section marked with the
comment:

        /*
         * Chipset specific drivers that don't use resource management (yet)
         */

--- linux-2.4.2-ac20/drivers/video/fbmem.c	Tue Mar 13 14:28:34 2001
+++ fispet-2.4.2-ac20/drivers/video/fbmem.c	Thu Mar 15 11:11:55 2001
@@ -178,9 +178,6 @@
 #ifdef CONFIG_FB_RIVA
 	{ "riva", rivafb_init, rivafb_setup },
 #endif
-#ifdef CONFIG_FB_RADEON
-	{ "radeon", radeonfb_init, radeonfb_setup },
-#endif
 #ifdef CONFIG_FB_CONTROL
 	{ "controlfb", control_init, control_setup },
 #endif
@@ -270,6 +267,18 @@
 #ifdef CONFIG_FB_HIT
 	{ "hitfb", hitfb_init, NULL },
 #endif
+#ifdef CONFIG_FB_RADEON
+	{ "radeon", radeonfb_init, radeonfb_setup },
+#endif
+#ifdef CONFIG_FB_PMAG_BA
+	{ "pmagbafb", pmagbafb_init, pmagbafb_setup },
+#endif
+#ifdef CONFIG_FB_PMAGB_B
+	{ "pmagbbfb", pmagbbfb_init, pmagbbfb_setup },
+#endif
+#ifdef CONFIG_FB_MAXINE
+	{ "maxinefb", maxinefb_init, maxinefb_setup },
+#endif
 
 	/*
 	 * Generic drivers that don't use resource management (yet)
@@ -287,16 +296,6 @@
 	{ "resolver", NULL, resolver_video_setup },
 #endif
 
-#ifdef CONFIG_FB_PMAG_BA
-       { "pmagbafb", pmagbafb_init, pmagbafb_setup },
-#endif
-#ifdef CONFIG_FB_PMAGB_B
-        { "pmagbbfb", pmagbbfb_init, pmagbbfb_setup },
-#endif
-
-#ifdef CONFIG_FB_MAXINE
-        { "maxinefb", maxinefb_init, maxinefb_setup },
-#endif
 
 
 #ifdef CONFIG_FB_VIRTUAL

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

