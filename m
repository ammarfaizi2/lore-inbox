Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131113AbQLQUDp>; Sun, 17 Dec 2000 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131211AbQLQUDf>; Sun, 17 Dec 2000 15:03:35 -0500
Received: from web.sajt.cz ([212.71.160.9]:3081 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S131113AbQLQUDS>;
	Sun, 17 Dec 2000 15:03:18 -0500
Date: Sun, 17 Dec 2000 20:29:47 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, ajapted@netspace.net.au
Subject: [PATCH] mdacon.c cleanup in 2.2.19
Message-ID: <Pine.LNX.4.21.0012172022070.25444-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch is removing few ifdefs.
Both MODULE_PARM and __initfunc are removed by preprocessor if compiled
as module.

Pavel Rabel

--- drivers/video/mdacon.c.old	Sun Dec 17 18:53:18 2000
+++ drivers/video/mdacon.c	Sun Dec 17 18:54:55 2000
@@ -75,14 +75,10 @@
 
 static struct vc_data	*mda_display_fg = NULL;
 
-#ifdef MODULE_PARM
 MODULE_PARM(mda_first_vc, "1-255i");
 MODULE_PARM(mda_last_vc,  "1-255i");
-#endif
-
 
-/* MDA register values
- */
+/* MDA register values */
 
 #define MDA_CURSOR_BLINKING	0x00
 #define MDA_CURSOR_OFF		0x20
@@ -200,11 +196,7 @@
 }
 #endif
 
-#ifdef MODULE
-static int mda_detect(void)
-#else
 __initfunc(static int mda_detect(void))
-#endif
 {
 	int count=0;
 	u16 *p, p_save;
@@ -287,11 +279,7 @@
 	return 1;
 }
 
-#ifdef MODULE
-static void mda_initialize(void)
-#else
 __initfunc(static void mda_initialize(void))
-#endif
 {
 	write_mda_b(97, 0x00);		/* horizontal total */
 	write_mda_b(80, 0x01);		/* horizontal displayed */
@@ -316,11 +304,7 @@
 	outb_p(0x00, mda_gfx_port);
 }
 
-#ifdef MODULE
-static const char *mdacon_startup(void)
-#else
 __initfunc(static const char *mdacon_startup(void))
-#endif
 {
 	mda_num_columns = 80;
 	mda_num_lines   = 25;
@@ -606,11 +590,7 @@
 	mdacon_invert_region,	/* con_invert_region */
 };
 
-#ifdef MODULE
-void mda_console_init(void)
-#else
 __initfunc(void mda_console_init(void))
-#endif
 {
 	if (mda_first_vc > mda_last_vc)
 		return;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
