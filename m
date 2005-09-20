Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVITStQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVITStQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVITSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:41 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:14272 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965073AbVITSsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:20 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/7] i386: little pgtable.h consolidation vs 2/3level
Date: Tue, 20 Sep 2005 20:45:32 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184531.14557.8668.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
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

