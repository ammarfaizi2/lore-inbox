Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUDPE6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDPE6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:58:21 -0400
Received: from ozlabs.org ([203.10.76.45]:29081 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262236AbUDPE6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:58:20 -0400
Date: Fri, 16 Apr 2004 14:56:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Yet another ppc64 hugepage cleanup
Message-ID: <20040416045626.GC26707@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Trivial cleanup to flush_hash_hugepage() in the ppc64 hugepage code.

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-16 13:59:29.979920272 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-16 13:59:43.664834064 +1000
@@ -736,7 +736,7 @@
 static void flush_hash_hugepage(mm_context_t context, unsigned long ea,
 				hugepte_t pte, int local)
 {
-	unsigned long vsid, vpn, va, hash, secondary, slot;
+	unsigned long vsid, vpn, va, hash, slot;
 
 	BUG_ON(hugepte_bad(pte));
 	BUG_ON(!in_hugepage_area(context, ea));
@@ -746,8 +746,7 @@
 	va = (vsid << 28) | (ea & 0x0fffffff);
 	vpn = va >> LARGE_PAGE_SHIFT;
 	hash = hpt_hash(vpn, 1);
-	secondary = !!(hugepte_val(pte) & _HUGEPAGE_SECONDARY);
-	if (secondary)
+	if (hugepte_val(pte) & _HUGEPAGE_SECONDARY)
 		hash = ~hash;
 	slot = (hash & htab_data.htab_hash_mask) * HPTES_PER_GROUP;
 	slot += (hugepte_val(pte) & _HUGEPAGE_GROUP_IX) >> 5;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
