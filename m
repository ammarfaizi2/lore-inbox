Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUGTTGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUGTTGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUGTSl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:41:56 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:5437
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266142AbUGTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:10 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8eI015444@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 485] M68k pgalloc fixup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix build after <asm/pgalloc.h> surgery in 2.6.8-rc1:
  - Add missing include on machines with a standard m68k MMU
  - Convert __pte_free_tlb() to a macro (like it is on most other archs) on
    Sun-3, to avoid include hell

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/include/asm-m68k/motorola_pgalloc.h	2003-05-05 10:32:45.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/motorola_pgalloc.h	2004-07-18 22:48:35.000000000 +0200
@@ -2,6 +2,7 @@
 #define _MOTOROLA_PGALLOC_H
 
 #include <asm/tlb.h>
+#include <asm/tlbflush.h>
 
 extern pmd_t *get_pointer_table(void);
 extern int free_pointer_table(pmd_t *);
--- linux-2.6.8-rc2/include/asm-m68k/sun3_pgalloc.h	2004-07-15 21:38:16.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/sun3_pgalloc.h	2004-07-18 22:53:30.000000000 +0200
@@ -31,10 +31,7 @@
         __free_page(page);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *page)
-{
-	tlb_remove_page(tlb, page);
-}
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
