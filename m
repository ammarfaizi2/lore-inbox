Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUGWOLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUGWOLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 10:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUGWOLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 10:11:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42932 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267739AbUGWOLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 10:11:05 -0400
Date: Fri, 23 Jul 2004 16:10:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: maximilian attems <janitor@sternwelten.at>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [patch-kj] remove faulty __init's from drivers/video/fbmem.c (fwd)
Message-ID: <Pine.GSO.4.58.0407231609260.9186@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


He's right, please apply! Patch applies cleanly against 2.6.8-rc2.

Domen, thanks a lot!

---------- Forwarded message ----------
Date: Fri, 23 Jul 2004 11:42:52 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org, geert@linux-m68k.org
Subject: [patch-kj] remove faulty __init's from drivers/video/fbmem.c



Hi.

These four are called from fb_show_logo, which is exported symbol,
called by fbcon_switch.

Compile tested.

	Domen

patch is against 2.6.7-bk20, please tell if you need against newer.

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems



---

 linux-2.6.7-bk20-max/drivers/video/fbmem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/video/fbmem.c~faulty-inits-fbmem drivers/video/fbmem.c
--- linux-2.6.7-bk20/drivers/video/fbmem.c~faulty-inits-fbmem	2004-07-11 14:40:42.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/video/fbmem.c	2004-07-11 14:40:42.000000000 +0200
@@ -563,7 +563,7 @@ static inline unsigned safe_shift(unsign
 	return n < 0 ? d >> -n : d << n;
 }

-static void __init fb_set_logocmap(struct fb_info *info,
+static void fb_set_logocmap(struct fb_info *info,
 				   const struct linux_logo *logo)
 {
 	struct fb_cmap palette_cmap;
@@ -597,7 +597,7 @@ static void __init fb_set_logocmap(struc
 	}
 }

-static void  __init fb_set_logo_truepalette(struct fb_info *info,
+static void  fb_set_logo_truepalette(struct fb_info *info,
 					    const struct linux_logo *logo,
 					    u32 *palette)
 {
@@ -627,7 +627,7 @@ static void  __init fb_set_logo_truepale
 	}
 }

-static void __init fb_set_logo_directpalette(struct fb_info *info,
+static void fb_set_logo_directpalette(struct fb_info *info,
 					     const struct linux_logo *logo,
 					     u32 *palette)
 {
@@ -642,7 +642,7 @@ static void __init fb_set_logo_directpal
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }

-static void __init fb_set_logo(struct fb_info *info,
+static void fb_set_logo(struct fb_info *info,
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
