Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUDOFoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 01:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUDOFoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 01:44:11 -0400
Received: from ozlabs.org ([203.10.76.45]:44500 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263641AbUDOFoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 01:44:07 -0400
Date: Thu, 15 Apr 2004 13:54:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: PPC64 hugepage cleanup
Message-ID: <20040415035446.GA25560@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  This is a small cleanup to the PPC64 hugepage
code.  It removes an unhelpful function, removing some studlyCaps in
the process.  It was originally this way to match the normal page
path, but that has all been rewritten since.

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-14 15:04:28.512784264 +1000
@@ -609,15 +609,6 @@
 	}
 }
 
-static inline unsigned long computeHugeHptePP(unsigned int hugepte)
-{
-	unsigned long flags = 0x2;
-
-	if (! (hugepte & _HUGEPAGE_RW))
-		flags |= 0x1;
-	return flags;
-}
-
 int hash_huge_page(struct mm_struct *mm, unsigned long access,
 		   unsigned long ea, unsigned long vsid, int local)
 {
@@ -671,7 +662,7 @@
 	old_pte = *ptep;
 	new_pte = old_pte;
 
-	hpteflags = computeHugeHptePP(hugepte_val(new_pte));
+	hpteflags = 0x2 | (! (hugepte_val(new_pte) & _HUGEPAGE_RW));
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(hugepte_val(old_pte) & _HUGEPAGE_HASHPTE)) {



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
