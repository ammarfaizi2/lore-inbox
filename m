Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbVKDA4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbVKDA4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbVKDAzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:55:42 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:38804
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161035AbVKDAzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:55:14 -0500
Date: Thu, 3 Nov 2005 18:55:14 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 40/42]: ppc64: IOMMU: don't ioremap null pointers
Message-ID: <20051104005514.GA27179@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

240-ioremap-null-ptr-test.patch

Under highly unusual circumstances, a buggy driver will ask a null ptr to be
ioremapped, an operation that curently suceeds but leads to later trouble.
Instead, refuse to remap the null pointer.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-git3/arch/powerpc/mm/pgtable_64.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/mm/pgtable_64.c	2005-11-02 14:59:56.507624778 -0600
+++ linux-2.6.14-git3/arch/powerpc/mm/pgtable_64.c	2005-11-02 15:01:04.284115774 -0600
@@ -185,7 +185,7 @@
 	pa = addr & PAGE_MASK;
 	size = PAGE_ALIGN(addr + size) - pa;
 
-	if (size == 0)
+	if ((size == 0) || (pa == 0))
 		return NULL;
 
 	if (mem_init_done) {
