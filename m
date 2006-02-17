Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWBQECF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWBQECF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 23:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBQECF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 23:02:05 -0500
Received: from ozlabs.org ([203.10.76.45]:46221 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932074AbWBQECE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 23:02:04 -0500
Date: Fri, 17 Feb 2006 14:54:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: Fix accidentally-working typo in __pud_free_tlb
Message-ID: <20060217035411.GB21696@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Paulus, please apply.

One of the parameters to the __pud_free_tlb() macro for powerpc is
incorrect (see patch) .  We get away with it by accident, because the
one place the macro is called, the second parameter is a variable
named "pud".

Nonetheless, this should be fixed for 2.6.16.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-powerpc/pgalloc.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgalloc.h	2006-01-16 13:02:29.000000000 +1100
+++ working-2.6/include/asm-powerpc/pgalloc.h	2006-02-17 14:48:13.000000000 +1100
@@ -146,7 +146,7 @@ extern void pgtable_free_tlb(struct mmu_
 	pgtable_free_tlb(tlb, pgtable_free_cache(pmd, \
 		PMD_CACHE_NUM, PMD_TABLE_SIZE-1))
 #ifndef CONFIG_PPC_64K_PAGES
-#define __pud_free_tlb(tlb, pmd)	\
+#define __pud_free_tlb(tlb, pud)	\
 	pgtable_free_tlb(tlb, pgtable_free_cache(pud, \
 		PUD_CACHE_NUM, PUD_TABLE_SIZE-1))
 #endif /* CONFIG_PPC_64K_PAGES */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
