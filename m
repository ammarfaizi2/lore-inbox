Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUDAEcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDAEcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:32:01 -0500
Received: from ozlabs.org ([203.10.76.45]:62103 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262208AbUDAEb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:31:59 -0500
Date: Thu, 1 Apr 2004 14:29:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Bugfix for PPC64 hugepage support
Message-ID: <20040401042947.GA12992@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Due to a misunderstanding of pmd_offset() the PPC64 hugepage code could
end up looking at bogus pages as if they were PMD pages.

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-03-09 10:50:44.000000000 +1100
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-01 12:53:54.920618632 +1000
@@ -190,6 +190,9 @@
 	BUG_ON(!in_hugepage_area(mm->context, addr));
 
 	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
 	pmd = pmd_offset(pgd, addr);
 
 	/* We shouldn't find a (normal) PTE page pointer here */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
