Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKXBq>; Mon, 11 Dec 2000 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQLKXBh>; Mon, 11 Dec 2000 18:01:37 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:56840 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129314AbQLKXBZ>;
	Mon, 11 Dec 2000 18:01:25 -0500
Date: Mon, 11 Dec 2000 14:31:03 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2.X patches for fbcon
Message-ID: <Pine.LNX.4.21.0012111416050.296-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows you select different modes on a Mac. The functionality
was there but not taken advantage of. This is needed because the resolution 
can be 834x628 on a Mac and the screen is really screwed up with more than
8 bit in that case.

--- fbmem.c.orig	Mon Dec 11 14:18:44 2000
+++ fbmem.c	Mon Dec 11 14:19:08 2000
@@ -92,6 +92,8 @@
 extern void hpfb_setup(char *options, int *ints);
 extern void sbusfb_init(void);
 extern void sbusfb_setup(char *options, int *ints);
+extern void platinum_init(void);
+extern void platinum_setup(char *options, int *ints);
 extern void valkyriefb_init(void);
 extern void valkyriefb_setup(char *options, int *ints);
 extern void control_init(void);
@@ -183,6 +185,9 @@
 #ifdef CONFIG_FB_HP300
 	{ "hpfb", hpfb_init, hpfb_setup },
 #endif 
+#ifdef CONFIG_FB_PLATINUM
+        { "platinumfb", platinum_init, platinum_setup },
+#endif
 #ifdef CONFIG_FB_VALKYRIE
 	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
 #endif
------------------------------------------------------------------------------

This patch forces 1024x768-60 modes on PowerBook Lombard and
Mainstreet. No need to pass vmode:14 anymore.


--- atyfb.c	Mon Dec 11 14:28:19 2000
+++ atyfb.c.orig	Wed Oct  4 22:22:28 2000
@@ -2796,7 +2796,7 @@
      * works on iMacs as well as the G3 powerbooks. - paulus
      */
     if (default_vmode == VMODE_CHOOSE) {
-	if ((Gx == LG_CHIP_ID)||(Gx == LI_CHIP_ID)||(Gx == LP_CHIP_ID))
+	if (Gx == LG_CHIP_ID)
 	    /* G3 PowerBook with 1024x768 LCD */
 	    default_vmode = VMODE_1024_768_60;
 	else if (Gx == LN_CHIP_ID)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
