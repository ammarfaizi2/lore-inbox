Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWF0UO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWF0UO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWF0UO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:14:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52355 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161267AbWF0UOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:14:54 -0400
Message-Id: <20060627201241.754037000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Bob Breuer <breuerr@mc.net>
Subject: [PATCH 11/25] SPARC32: Fix iommu_flush_iotlb end address
Content-Disposition: inline; filename=sparc32-fix-iommu_flush_iotlb-end-address.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

Fix the calculation of the end address when flushing iotlb entries to
ram.  This bug has been a cause of esp dma errors, and it affects
HyperSPARC systems much worse than SuperSPARC systems.

Signed-off-by: Bob Breuer <breuerr@mc.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/sparc/mm/iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.1.orig/arch/sparc/mm/iommu.c
+++ linux-2.6.17.1/arch/sparc/mm/iommu.c
@@ -144,8 +144,9 @@ static void iommu_flush_iotlb(iopte_t *i
 	unsigned long start;
 	unsigned long end;
 
-	start = (unsigned long)iopte & PAGE_MASK;
+	start = (unsigned long)iopte;
 	end = PAGE_ALIGN(start + niopte*sizeof(iopte_t));
+	start &= PAGE_MASK;
 	if (viking_mxcc_present) {
 		while(start < end) {
 			viking_mxcc_flush_page(start);

--
