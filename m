Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272527AbTGZOlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272517AbTGZOhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:37:10 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:18011 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272522AbTGZOcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:45 -0400
Date: Sat, 26 Jul 2003 16:51:44 +0200
Message-Id: <200307261451.h6QEpiES002358@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Macfb compile fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macfb compile fixes

--- linux-2.6.x/drivers/video/macfb.c	Mon May  5 10:32:15 2003
+++ linux-m68k-2.6.x/drivers/video/macfb.c	Sun Jun  8 11:24:51 2003
@@ -233,11 +233,11 @@
 		
 		/* Loop until we get to the register we want */
 		for (i = 0; i < regno; i++) {
-			nubus_writeb(info->cmap[i].red >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.red[i] >> 8, &dafb_cmap_regs->lut);
 			nop();
-			nubus_writeb(info->cmap[i].green >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.green[i] >> 8, &dafb_cmap_regs->lut);
 			nop();
-			nubus_writeb(info->cmap[i].blue >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.blue[i] >> 8, &dafb_cmap_regs->lut);
 			nop();
 		}
 	}
@@ -528,10 +528,10 @@
 	 *  != 0 for invalid regno.
 	 */
 	
-	if (regno >= info->cmap.len)
+	if (regno >= fb_info->cmap.len)
 		return 1;
 
-	switch (info->var.bits_per_pixel) {
+	switch (fb_info->var.bits_per_pixel) {
 	case 1:
 		/* We shouldn't get here */
 		break;
@@ -539,21 +539,21 @@
 	case 4:
 	case 8:
 		if (macfb_setpalette)
-			macfb_setpalette(regno, red, green, blue, info);
+			macfb_setpalette(regno, red, green, blue, fb_info);
 		else
 			return 1;
 		break;
 	case 16:
-		if (info->var.red.offset == 10) {
+		if (fb_info->var.red.offset == 10) {
 			/* 1:5:5:5 */
-			((u32*) (info->pseudo_palette))[regno] =
+			((u32*) (fb_info->pseudo_palette))[regno] =
 					((red   & 0xf800) >>  1) |
 					((green & 0xf800) >>  6) |
 					((blue  & 0xf800) >> 11) |
 					((transp != 0) << 15);
 		} else {
 			/* 0:5:6:5 */
-			((u32*) (info->pseudo_palette))[regno] =
+			((u32*) (fb_info->pseudo_palette))[regno] =
 					((red   & 0xf800)      ) |
 					((green & 0xfc00) >>  5) |
 					((blue  & 0xf800) >> 11);
@@ -565,19 +565,19 @@
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		((u32 *)(info->pseudo_palette))[regno] =
-			(red   << info->var.red.offset)   |
-			(green << info->var.green.offset) |
-			(blue  << info->var.blue.offset);
+		((u32 *)(fb_info->pseudo_palette))[regno] =
+			(red   << fb_info->var.red.offset)   |
+			(green << fb_info->var.green.offset) |
+			(blue  << fb_info->var.blue.offset);
 		break;
 	case 32:
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		((u32 *)(info->pseudo_palette))[regno] =
-			(red   << info->var.red.offset)   |
-			(green << info->var.green.offset) |
-			(blue  << info->var.blue.offset);
+		((u32 *)(fb_info->pseudo_palette))[regno] =
+			(red   << fb_info->var.red.offset)   |
+			(green << fb_info->var.green.offset) |
+			(blue  << fb_info->var.blue.offset);
 		break;
     }
     return 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
