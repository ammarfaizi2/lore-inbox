Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTH2OwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTH2Oup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:50:45 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:27667 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261288AbTH2Oui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:50:38 -0400
Date: Fri, 29 Aug 2003 16:49:45 +0200
Message-Id: <200308291449.h7TEnjX7005827@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
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

--- linux-2.4.23-pre1/drivers/video/fbcmap.c.orig	Mon Mar  5 09:29:30 2001
+++ linux-2.4.23-pre1/drivers/video/fbcmap.c	Mon Mar 17 17:39:59 2003
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
