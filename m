Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUGTSiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUGTSiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUGTSiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:38:13 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:30778 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266126AbUGTSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:03 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0CG015389@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 464] m68k sparse void return
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Don't return anything in functions returning void (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/mac/macints.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/mac/macints.c	2004-07-10 21:06:54.000000000 +0200
@@ -545,7 +545,8 @@
 #endif
 
 	if (irq < VIA1_SOURCE_BASE) {
-		return cpu_free_irq(irq, dev_id);
+		cpu_free_irq(irq, dev_id);
+		return;
 	}
 
 	if (irq >= NUM_MAC_SOURCES) {
--- linux-2.6.8-rc2/arch/m68k/mm/kmap.c	2004-04-28 16:08:20.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/mm/kmap.c	2004-07-10 21:06:54.000000000 +0200
@@ -45,7 +45,7 @@
 
 static inline void free_io_area(void *addr)
 {
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
+	vfree((void *)(PAGE_MASK & (unsigned long)addr));
 }
 
 #else

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
