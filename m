Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266132AbUGTSka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUGTSka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUGTSj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:39:58 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:4936
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266132AbUGTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:06 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0sc015374@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 461] M68k ifpsp060
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

68060 Integer Support Package: Fix _060_real_lock_page(): test %d0 before
actually using it (from Roman Zippel)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/ifpsp060/iskeleton.S	2004-06-21 20:20:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/ifpsp060/iskeleton.S	2004-07-04 22:03:48.000000000 +0200
@@ -204,11 +204,12 @@
 _060_real_lock_page:
 	move.l	%d2,-(%sp)
 	| load sfc/dfc
-	moveq	#5,%d0
 	tst.b	%d0
 	jne	1f
 	moveq	#1,%d0
-1:	movec.l	%dfc,%d2
+	jra	2f
+1:	moveq	#5,%d0
+2:	movec.l	%dfc,%d2
 	movec.l	%d0,%dfc
 	movec.l	%d0,%sfc
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
