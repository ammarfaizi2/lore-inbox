Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDGKST>; Sun, 7 Apr 2002 06:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDGKSS>; Sun, 7 Apr 2002 06:18:18 -0400
Received: from mail.sonytel.be ([193.74.243.200]:51188 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S313027AbSDGKSR>;
	Sun, 7 Apr 2002 06:18:17 -0400
Date: Sun, 7 Apr 2002 12:17:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0204071215220.2567-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Linus Torvalds wrote:
> <rmk@flint.arm.linux.org.uk> (02/03/13 1.388.3.5)
> 	Update ARM related video drivers:
> 	 - cyber2000fb
> 	 - sa1100fb
> 	Add new ARM video drivers:
> 	 - anakinfb
> 	 - clps711xfb

Please either add resource management code to anakinfb and clps711xfb, or apply
the patch below.

--- linux-2.5.8-pre2/drivers/video/fbmem.c.orig	Sun Apr  7 10:54:24 2002
+++ linux-2.5.8-pre2/drivers/video/fbmem.c	Sun Apr  7 12:15:21 2002
@@ -157,12 +157,6 @@
 #ifdef CONFIG_FB_AMIGA
 	{ "amifb", amifb_init, amifb_setup },
 #endif
-#ifdef CONFIG_FB_ANAKIN
-	{ "anakinfb", anakinfb_init, NULL },
-#endif
-#ifdef CONFIG_FB_CLPS711X
-	{ "clps711xfb", clps711xfb_init, NULL },
-#endif
 #ifdef CONFIG_FB_CYBER
 	{ "cyber", cyberfb_init, cyberfb_setup },
 #endif
@@ -293,6 +287,12 @@
 #endif
 #ifdef CONFIG_FB_VOODOO1
 	{ "sst", sstfb_init, sstfb_setup },
+#endif
+#ifdef CONFIG_FB_ANAKIN
+	{ "anakinfb", anakinfb_init, NULL },
+#endif
+#ifdef CONFIG_FB_CLPS711X
+	{ "clps711xfb", clps711xfb_init, NULL },
 #endif
 	/*
 	 * Generic drivers that don't use resource management (yet)

Gr{oetje,eeting}s,

			      Geert (fbdev init order watchdog^H^H^Hpenguin)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

