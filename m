Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWKOPE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWKOPE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWKOPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:04:57 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18841
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030539AbWKOPE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:04:57 -0500
Message-Id: <455B3AF2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 15:06:10 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <patches@x86-64.org>
Subject: [PATCH] x86-64: adjust pmd_bad()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make pmd_bad() symmetrical to pgd_bad() and pud_bad(). At once,
simplify them all.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/include/asm-x86_64/pgtable.h	2006-11-08 09:25:39.000000000 +0100
+++ 2.6.19-rc5-x86_64-pmd_bad/include/asm-x86_64/pgtable.h	2006-11-14 14:33:20.000000000 +0100
@@ -221,20 +221,19 @@ static inline pte_t ptep_get_and_clear_f
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
-static inline unsigned long pgd_bad(pgd_t pgd) 
-{ 
-       unsigned long val = pgd_val(pgd);
-       val &= ~PTE_MASK; 
-       val &= ~(_PAGE_USER | _PAGE_DIRTY); 
-       return val & ~(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED);      
-} 
+static inline unsigned long pgd_bad(pgd_t pgd)
+{
+	return pgd_val(pgd) & ~(PTE_MASK | _KERNPG_TABLE | _PAGE_USER);
+}
 
 static inline unsigned long pud_bad(pud_t pud)
 {
-       unsigned long val = pud_val(pud);
-       val &= ~PTE_MASK;
-       val &= ~(_PAGE_USER | _PAGE_DIRTY);
-       return val & ~(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED);
+	return pud_val(pud) & ~(PTE_MASK | _KERNPG_TABLE | _PAGE_USER);
+}
+
+static inline unsigned long pmd_bad(pmd_t pmd)
+{
+	return pmd_val(pmd) & ~(PTE_MASK | _KERNPG_TABLE | _PAGE_USER);
 }
 
 #define pte_none(x)	(!pte_val(x))
@@ -347,7 +346,6 @@ static inline int pmd_large(pmd_t pte) {
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PTE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE )
 #define pfn_pmd(nr,prot) (__pmd(((nr) << PAGE_SHIFT) | pgprot_val(prot)))
 #define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 


