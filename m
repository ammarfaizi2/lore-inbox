Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRISGTp>; Wed, 19 Sep 2001 02:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274008AbRISGT0>; Wed, 19 Sep 2001 02:19:26 -0400
Received: from mail.sonytel.be ([193.74.243.200]:1242 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S274007AbRISGTW>;
	Wed, 19 Sep 2001 02:19:22 -0400
Date: Wed, 19 Sep 2001 08:19:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev config fixes (ac edition)
Message-ID: <Pine.GSO.4.21.0109190816360.14079-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Alan,

Fix fbdev config glitches that were introduced recently:
  - Remove duplicate CONFIG_* section for DECstation
  - Remove duplicate initialization code for pmagbafb, pmagbbfb, and maxinefb
  - Sstfb doesn't use resource management, so move its initialization to the
    correct section (why do people never read comments in source code?)

diff -urN linux-2.4.9-ac10/drivers/video/Config.in geert-2.4.9-ac10/drivers/video/Config.in
--- linux-2.4.9-ac10/drivers/video/Config.in	Thu Sep 13 10:37:07 2001
+++ geert-2.4.9-ac10/drivers/video/Config.in	Tue Sep 18 21:17:39 2001
@@ -199,13 +199,6 @@
    if [ "$CONFIG_NINO" = "y" ]; then
       bool '  TMPTX3912/PR31700 frame buffer support' CONFIG_FB_TX3912
    fi
-   if [ "$CONFIG_DECSTATION" = "y" ]; then
-     if [ "$CONFIG_TC" = "y" ]; then
-       bool '  PMAG-BA TURBOchannel framebuffer support' CONFIG_FB_PMAG_BA
-       bool '  PMAGB-B TURBOchannel framebuffer spport' CONFIG_FB_PMAGB_B
-       bool '  Maxine (Personal DECstation) onboard framebuffer spport' CONFIG_FB_MAXINE
-     fi
-   fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       tristate '  Virtual Frame Buffer support (ONLY FOR TESTING!)' CONFIG_FB_VIRTUAL
    fi
diff -urN linux-2.4.9-ac10/drivers/video/fbmem.c geert-2.4.9-ac10/drivers/video/fbmem.c
--- linux-2.4.9-ac10/drivers/video/fbmem.c	Thu Sep 13 10:37:12 2001
+++ geert-2.4.9-ac10/drivers/video/fbmem.c	Tue Sep 18 21:25:47 2001
@@ -126,12 +126,6 @@
 extern int tx3912fb_init(void);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
-extern int pmagbafb_init(void);
-extern int pmagbafb_setup(char *);
-extern int pmagbbfb_init(void);
-extern int pmagbbfb_setup(char *options, int *ints);
-extern void maxinefb_init(void);
-extern void maxinefb_setup(char *options, int *ints);
 extern int e1355fb_init(void);
 extern int e1355fb_setup(char*);
 extern int pvr2fb_init(void);
@@ -214,9 +208,6 @@
 #if defined(CONFIG_FB_SIS) && (defined(CONFIG_FB_SIS_300) || defined(CONFIG_FB_SIS_315))
 	{ "sisfb", sisfb_init, sisfb_setup },
 #endif
-#ifdef CONFIG_FB_VOODOO1
-	{ "sstfb", sstfb_init, sstfb_setup },
-#endif
 
 	/*
 	 * Generic drivers that are used as fallbacks
@@ -303,6 +294,9 @@
 #ifdef CONFIG_FB_MAXINE
 	{ "maxinefb", maxinefb_init, NULL },
 #endif
+#ifdef CONFIG_FB_VOODOO1
+	{ "sstfb", sstfb_init, sstfb_setup },
+#endif
 
 	/*
 	 * Generic drivers that don't use resource management (yet)
@@ -319,19 +313,6 @@
 	/* Not a real frame buffer device... */
 	{ "resolver", NULL, resolver_video_setup },
 #endif
-
-#ifdef CONFIG_FB_PMAG_BA
-       { "pmagbafb", pmagbafb_init, pmagbafb_setup },
-#endif
-#ifdef CONFIG_FB_PMAGB_B
-        { "pmagbbfb", pmagbbfb_init, pmagbbfb_setup },
-#endif
-
-#ifdef CONFIG_FB_MAXINE
-        { "maxinefb", maxinefb_init, NULL },
-#endif
-
-
 
 
 #ifdef CONFIG_FB_VIRTUAL

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

