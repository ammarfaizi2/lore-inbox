Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291633AbSBHQps>; Fri, 8 Feb 2002 11:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291637AbSBHQpk>; Fri, 8 Feb 2002 11:45:40 -0500
Received: from mail.sonytel.be ([193.74.243.200]:22967 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291633AbSBHQpY>;
	Fri, 8 Feb 2002 11:45:24 -0500
Date: Fri, 8 Feb 2002 17:43:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jani Monoses <jani@astechnix.ro>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Tridentfb and resource management
Message-ID: <Pine.GSO.4.21.0202081741140.19681-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jani and Marcelo,

Since Tridentfb uses resource management, its initialization must be done
before the initialization of the generic drivers (vesafb and offb).

--- linux-2.4.18-pre9/drivers/video/fbmem.c.orig	Fri Feb  8 09:39:18 2002
+++ linux-2.4.18-pre9/drivers/video/fbmem.c	Fri Feb  8 17:40:30 2002
@@ -207,6 +207,9 @@
 #ifdef CONFIG_FB_SIS
 	{ "sisfb", sisfb_init, sisfb_setup },
 #endif
+#ifdef CONFIG_FB_TRIDENT
+	{ "trident", tridentfb_init, tridentfb_setup },
+#endif
 
 	/*
 	 * Generic drivers that are used as fallbacks
@@ -229,9 +232,6 @@
 
 #ifdef CONFIG_FB_3DFX
 	{ "tdfx", tdfxfb_init, tdfxfb_setup },
-#endif
-#ifdef CONFIG_FB_TRIDENT
-	{ "trident", tridentfb_init, tridentfb_setup },
 #endif
 #ifdef CONFIG_FB_SGIVW
 	{ "sgivw", sgivwfb_init, sgivwfb_setup },

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

