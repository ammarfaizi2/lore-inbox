Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTFOTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFOTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:00:14 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:43806 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262709AbTFOS7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:53 -0400
Date: Sun, 15 Jun 2003 21:10:32 +0200
Message-Id: <200306151910.h5FJAWWG008604@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fb_cmap and transparency
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a colormap contains no transparency information, fb_set_cmap() calls
fb_setcolreg() with trans = 0. This causes all CLUT entries to be fully
transparent on hardware that does have transparency information in the CLUT
registers.

The following patch solves this problem by changing the default transparency
from 0 (full transparent) to 0xffff (full opaque).

--- linux-2.4.x/drivers/video/fbcmap.c.orig	Mon Mar  5 09:29:30 2001
+++ linux-2.4.x/drivers/video/fbcmap.c	Mon Mar 17 17:39:59 2003
@@ -271,7 +271,7 @@
 	    hred = *red;
 	    hgreen = *green;
 	    hblue = *blue;
-	    htransp = transp ? *transp : 0;
+	    htransp = transp ? *transp : 0xffff;
 	} else {
 	    get_user(hred, red);
 	    get_user(hgreen, green);
@@ -279,7 +279,7 @@
 	    if (transp)
 		get_user(htransp, transp);
 	    else
-		htransp = 0;
+		htransp = 0xffff;
 	}
 	red++;
 	green++;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
