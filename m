Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTH2O6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTH2O4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:56:34 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:52545 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261300AbTH2Ovw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:51:52 -0400
Date: Fri, 29 Aug 2003 16:50:58 +0200
Message-Id: <200308291450.h7TEow4Y005883@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k mm cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Kill superfluous includes and obsolete commented-out code in mm code.

--- linux-2.4.23-pre1/arch/m68k/mm/memory.c	Mon Apr  7 13:10:05 2003
+++ linux-m68k-2.4.23-pre1/arch/m68k/mm/memory.c	Tue Jul  1 21:29:03 2003
@@ -19,76 +19,10 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/traps.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#ifdef CONFIG_AMIGA
-#include <asm/amigahw.h>
-#endif
 
 struct pgtable_cache_struct quicklists;
 
-void __bad_pte(pmd_t *pmd)
-{
-	printk("Bad pmd in pte_alloc: %08lx\n", pmd_val(*pmd));
-	pmd_set(pmd, BAD_PAGETABLE);
-}
-
-void __bad_pmd(pgd_t *pgd)
-{
-	printk("Bad pgd in pmd_alloc: %08lx\n", pgd_val(*pgd));
-	pgd_set(pgd, (pmd_t *)BAD_PAGETABLE);
-}
-
-#if 0
-pte_t *get_pte_slow(pmd_t *pmd, unsigned long offset)
-{
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	if (pmd_none(*pmd)) {
-		if (pte) {
-			clear_page(pte);
-			__flush_page_to_ram((unsigned long)pte);
-			flush_tlb_kernel_page((unsigned long)pte);
-			nocache_page((unsigned long)pte);
-			pmd_set(pmd, pte);
-			return pte + offset;
-		}
-		pmd_set(pmd, BAD_PAGETABLE);
-		return NULL;
-	}
-	free_page((unsigned long)pte);
-	if (pmd_bad(*pmd)) {
-		__bad_pte(pmd);
-		return NULL;
-	}
-	return (pte_t *)__pmd_page(*pmd) + offset;
-}
-#endif
-
-#if 0
-pmd_t *get_pmd_slow(pgd_t *pgd, unsigned long offset)
-{
-	pmd_t *pmd;
-
-	pmd = get_pointer_table();
-	if (pgd_none(*pgd)) {
-		if (pmd) {
-			pgd_set(pgd, pmd);
-			return pmd + offset;
-		}
-		pgd_set(pgd, (pmd_t *)BAD_PAGETABLE);
-		return NULL;
-	}
-	free_pointer_table(pmd);
-	if (pgd_bad(*pgd)) {
-		__bad_pmd(pgd);
-		return NULL;
-	}
-	return (pmd_t *)__pgd_page(*pgd) + offset;
-}
-#endif
-
 /* ++andreas: {get,free}_pointer_table rewritten to use unused fields from
    struct page instead of separately kmalloced struct.  Stolen from
    arch/sparc/mm/srmmu.c ... */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
