Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUJBRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUJBRME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUJBRJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:09:24 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:42283
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S267409AbUJBRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:05:27 -0400
Date: Sat, 2 Oct 2004 19:05:24 +0200
Message-Id: <200410021705.i92H5Ova021802@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 162] fbdev monochrome lines
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fbdev: Clear the underline attribute when erasing the logo space on monochrome
screens. This removes the bogus horizontal lines next to the logo.
(from Petr Stehlik and Antonino A. Daplas)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.28-pre3/drivers/video/fbcon.c	26 Aug 2003 03:13:09 -0000	1.1.1.2.2.6
+++ linux-m68k-2.4.28-pre3/drivers/video/fbcon.c	12 Aug 2004 11:59:22 -0000
@@ -660,9 +660,8 @@
     
     if (logo) {
     	/* Need to make room for the logo */
-	int cnt;
-	int step;
-    
+	int cnt, step, erase_char;
+
     	logo_lines = (LOGO_H + fontheight(p) - 1) / fontheight(p);
     	q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
     	step = logo_lines * old_cols;
@@ -692,8 +691,10 @@
     		conp->vc_pos += logo_lines * conp->vc_size_row;
     	    }
     	}
-    	scr_memsetw((unsigned short *)conp->vc_origin,
-		    conp->vc_video_erase_char, 
+	erase_char = conp->vc_video_erase_char;
+	if (! conp->vc_can_do_color)
+	    erase_char &= ~0x400; /* disable underline */
+	scr_memsetw((unsigned short *)conp->vc_origin, erase_char,
 		    conp->vc_size_row * logo_lines);
     }
     

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
