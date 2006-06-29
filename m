Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbWF2Vg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWF2Vg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWF2Vgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:55 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:30432 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932766AbWF2Vgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:47 -0400
Message-Id: <200606292136.k5TLaTGc010802@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       ak@suse.de
Subject: [PATCH 3/9] UML - Remove pte_mkexec
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi is making pte_mkexec go away, and UML had one of the last uses.

This removes the use and the definition.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/skas/mmu.c	2006-06-26 14:49:53.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/kernel/skas/mmu.c	2006-06-28 13:07:26.000000000 -0400
@@ -61,8 +61,10 @@ static int init_stub_pte(struct mm_struc
 #endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
-	*pte = pte_mkexec(*pte);
-	*pte = pte_wrprotect(*pte);
+	/* This is wrong for the code page, but it doesn't matter since the
+	 * stub is mapped by hand with the correct permissions.
+	 */
+	*pte = pte_mkwrite(*pte);
 	return(0);
 
  out_pmd:
Index: linux-2.6.16-rc-mm/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.16-rc-mm.orig/include/asm-um/pgtable.h	2006-01-03 17:39:53.000000000 -0500
+++ linux-2.6.16-rc-mm/include/asm-um/pgtable.h	2006-06-26 14:54:42.000000000 -0400
@@ -274,12 +274,6 @@ static inline pte_t pte_mkread(pte_t pte
 	return(pte_mknewprot(pte)); 
 }
 
-static inline pte_t pte_mkexec(pte_t pte)
-{ 
-	pte_set_bits(pte, _PAGE_USER);
-	return(pte_mknewprot(pte)); 
-}
-
 static inline pte_t pte_mkdirty(pte_t pte)
 { 
 	pte_set_bits(pte, _PAGE_DIRTY);

