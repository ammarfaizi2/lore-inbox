Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVCKStw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVCKStw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCKSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:39:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261279AbVCKSQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:16:52 -0500
Date: Fri, 11 Mar 2005 19:16:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport kmap_{pte,port} on !ppc
Message-ID: <20050311181645.GL3723@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any modular usage of kmap_{pte,port} on !ppc in the 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Jan 2005

 arch/i386/mm/init.c  |    3 ---
 arch/mips/mm/init.c  |    3 ---
 arch/sparc/mm/init.c |    3 ---
 3 files changed, 9 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/mm/init.c.old	2005-01-20 23:45:08.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/mm/init.c	2005-01-20 23:45:20.000000000 +0100
@@ -252,9 +252,6 @@
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
-EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
-
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
--- linux-2.6.11-rc1-mm2-full/arch/sparc/mm/init.c.old	2005-01-20 23:45:27.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/sparc/mm/init.c	2005-01-20 23:45:32.000000000 +0100
@@ -59,9 +59,6 @@
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
-EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
-
 #define kmap_get_fixmap_pte(vaddr) \
 	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
--- linux-2.6.11-rc1-mm2-full/arch/mips/mm/init.c.old	2005-01-20 23:45:39.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/mips/mm/init.c	2005-01-20 23:45:46.000000000 +0100
@@ -83,9 +83,6 @@
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
-EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
-
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 

