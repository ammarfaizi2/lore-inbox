Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUGTTGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUGTTGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUGTSlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:41:07 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:19228 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266136AbUGTSiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:09 -0400
Date: Tue, 20 Jul 2004 20:38:04 +0200
Message-Id: <200407201838.i6KIc4er015409@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 468] m68k sparse floating point
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Replace floating point by integer constants (found by sparse)
Affected drivers:
  - Amiga frame buffer
  - ATI Mach64 frame buffer

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/video/amifb.c	2004-04-28 15:49:02.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/amifb.c	2004-07-10 21:07:38.000000000 +0200
@@ -2351,7 +2351,7 @@
 	 */
 
 	{
-	u_long tmp = DIVUL(200E9, amiga_eclock);
+	u_long tmp = DIVUL(200000000000ULL, amiga_eclock);
 
 	pixclock[TAG_SHRES] = (tmp + 4) / 8;	/* SHRES:  35 ns / 28 MHz */
 	pixclock[TAG_HIRES] = (tmp + 2) / 4;	/* HIRES:  70 ns / 14 MHz */
--- linux-2.6.8-rc2/drivers/video/aty/mach64_gx.c	2004-04-27 20:30:51.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/aty/mach64_gx.c	2004-07-10 21:06:54.000000000 +0200
@@ -653,7 +653,7 @@
 
 		for (m = MIN_M; m <= MAX_M; m++) {
 			for (n = MIN_N; n <= MAX_N; n++) {
-				tempA = (14.31818 * 65536);
+				tempA = 938356;		/* 14.31818 * 65536 */
 				tempA *= (n + 8);	/* 43..256 */
 				tempB = twoToKth * 256;
 				tempB *= (m + 2);	/* 4..32 */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
