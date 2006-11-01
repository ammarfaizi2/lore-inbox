Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946514AbWKAFkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946514AbWKAFkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946510AbWKAFjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:39:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45457 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946512AbWKAFjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:39:08 -0500
Message-Id: <20061101053923.029626000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 24/61] SPARC64: Fix memory corruption in pci_4u_free_consistent().
Content-Disposition: inline; filename=sparc64-fix-memory-corruption-in-pci_4u_free_consistent.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

The second argument to free_npages() was being incorrectly
calculated, which would thus access far past the end of the
arena->map[] bitmap.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/sparc64/kernel/pci_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/arch/sparc64/kernel/pci_iommu.c
+++ linux-2.6.18.1/arch/sparc64/kernel/pci_iommu.c
@@ -281,7 +281,7 @@ static void pci_4u_free_consistent(struc
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	free_npages(iommu, dvma, npages);
+	free_npages(iommu, dvma - iommu->page_table_map_base, npages);
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 

--
