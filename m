Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUGTTGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUGTTGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUGTSls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:41:48 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:29974
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266141AbUGTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:10 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8tu015434@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 481] M68k bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add `volatile' to some bitops parameters, as this is required by the
cpumask code in 2.6.8-rc1.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/include/asm-m68k/bitops.h	2004-06-21 20:20:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/bitops.h	2004-07-12 12:00:36.000000000 +0200
@@ -52,14 +52,14 @@
 
 #define __set_bit(nr,vaddr) set_bit(nr,vaddr)
 
-static inline void __constant_set_bit(int nr, unsigned long *vaddr)
+static inline void __constant_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	__asm__ __volatile__ ("bset %1,%0"
 			: "+m" (*p) : "di" (nr & 7));
 }
 
-static inline void __generic_set_bit(int nr, unsigned long *vaddr)
+static inline void __generic_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfset %1{%0:#1}"
 			: : "d" (nr^31), "o" (*vaddr) : "memory");
@@ -106,14 +106,14 @@
    __generic_clear_bit(nr, vaddr))
 #define __clear_bit(nr,vaddr) clear_bit(nr,vaddr)
 
-static inline void __constant_clear_bit(int nr, unsigned long *vaddr)
+static inline void __constant_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	__asm__ __volatile__ ("bclr %1,%0"
 			: "+m" (*p) : "di" (nr & 7));
 }
 
-static inline void __generic_clear_bit(int nr, unsigned long *vaddr)
+static inline void __generic_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfclr %1{%0:#1}"
 			: : "d" (nr^31), "o" (*vaddr) : "memory");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
