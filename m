Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUAAUFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUAAUE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:04:57 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:35667 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264591AbUAAUB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:56 -0500
Date: Thu, 1 Jan 2004 21:01:54 +0100
Message-Id: <200401012001.i01K1srR031751@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 351] M68k math emu C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k math emulator: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/math-emu/fp_arith.c	Sun Apr  6 10:28:29 2003
+++ linux-m68k-2.6.0/arch/m68k/math-emu/fp_arith.c	Sun Oct 19 20:06:26 2003
@@ -19,12 +19,13 @@
 
 const struct fp_ext fp_QNaN =
 {
-	0, 0, 0x7fff, { ~0 }
+	.exp = 0x7fff,
+	.mant = { .m64 = ~0 }
 };
 
 const struct fp_ext fp_Inf =
 {
-	0, 0, 0x7fff, { 0 }
+	.exp = 0x7fff,
 };
 
 /* let's start with the easy ones */
--- linux-2.6.0/arch/m68k/math-emu/fp_log.c	Tue Jul 29 18:18:35 2003
+++ linux-m68k-2.6.0/arch/m68k/math-emu/fp_log.c	Sun Oct 19 20:06:41 2003
@@ -19,7 +19,7 @@
 
 static const struct fp_ext fp_one =
 {
-	0, 0, 0x3fff, { 0 }
+	.exp = 0x3fff,
 };
 
 extern struct fp_ext *fp_fadd(struct fp_ext *dest, const struct fp_ext *src);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
