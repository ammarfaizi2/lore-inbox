Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRDRKWZ>; Wed, 18 Apr 2001 06:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133072AbRDRKWQ>; Wed, 18 Apr 2001 06:22:16 -0400
Received: from aeon.tvd.be ([195.162.196.20]:62676 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S133071AbRDRKV6>;
	Wed, 18 Apr 2001 06:21:58 -0400
Date: Wed, 18 Apr 2001 12:20:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev init order violation
Message-ID: <Pine.LNX.4.05.10104181219110.2647-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Epson 1355 frame buffer device doesn't use resource management (yet), so it
must be initialized later.

--- linux-2.4.4-pre4/drivers/video/fbmem.c.orig	Wed Apr 18 11:40:40 2001
+++ linux-2.4.4-pre4/drivers/video/fbmem.c	Wed Apr 18 12:17:57 2001
@@ -202,9 +202,6 @@
 #ifdef CONFIG_FB_SIS
 	{ "sisfb", sisfb_init, sisfb_setup },
 #endif
-#ifdef CONFIG_FB_E1355
-	{ "e1355fb", e1355fb_init, e1355fb_setup },
-#endif
 
 	/*
 	 * Generic drivers that are used as fallbacks
@@ -269,6 +266,9 @@
 #endif
 #ifdef CONFIG_FB_HIT
 	{ "hitfb", hitfb_init, NULL },
+#endif
+#ifdef CONFIG_FB_E1355
+	{ "e1355fb", e1355fb_init, e1355fb_setup },
 #endif
 #ifdef CONFIG_FB_DC
 	{ "dcfb", dcfb_init, NULL },

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

