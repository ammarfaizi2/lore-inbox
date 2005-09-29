Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVI2TdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVI2TdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVI2TdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:22 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:55453 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964806AbVI2TdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:06 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] i386: little pgtable.h consolidation vs 2/3level
Date: Thu, 29 Sep 2005 20:42:28 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050929184227.12866.7605.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Join together some common functions (pmd_page{,_kernel}) over 2level and
3level pages.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/pgtable-2level.h |    5 -----
 include/asm-i386/pgtable-3level.h |    5 -----
 include/asm-i386/pgtable.h        |    5 +++++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/asm-i386/pgtable-2level.h b/include/asm-i386/pgtable-2level.h
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -26,11 +26,6 @@
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-#define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-
-#define pmd_page_kernel(pmd) \
-((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
-
 /*
  * All present user pages are user-executable:
  */
diff --git a/include/asm-i386/pgtable-3level.h b/include/asm-i386/pgtable-3level.h
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -74,11 +74,6 @@ static inline void set_pte(pte_t *ptep, 
  */
 static inline void pud_clear (pud_t * pud) { }
 
-#define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-
-#define pmd_page_kernel(pmd) \
-((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
-
 #define pud_page(pud) \
 ((struct page *) __va(pud_val(pud) & PAGE_MASK))
 
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -368,6 +368,11 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
 
+#define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
+
+#define pmd_page_kernel(pmd) \
+((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+
 /*
  * Helper function that returns the kernel pagetable entry controlling
  * the virtual address 'address'. NULL means no pagetable entry present.

