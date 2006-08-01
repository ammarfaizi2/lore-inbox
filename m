Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWHADoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWHADoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWHADoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:44:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:53705 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751560AbWHADo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:44:28 -0400
Date: Tue, 01 Aug 2006 05:44:26 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com
Subject: [PATCH] [2/2] x86_64: Fix CONFIG_IOMMU_DEBUG
Message-ID: <44cece1a.KkKj/fk+AWDz3lCu%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Muli Ben-Yehuda <muli@il.ibm.com>

If CONFIG_IOMMU_DEBUG is set force_iommu defaults to 1. In the case
where no HW IOMMU is present in the machine and we end up using nommu,
leaving force_iommu set to 1 causes dma_alloc_coherent to do the wrong
thing. Therefore, if we end up using nommu, make sure force_iommu is
0.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-nommu.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/pci-nommu.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-nommu.c
+++ linux/arch/x86_64/kernel/pci-nommu.c
@@ -92,5 +92,7 @@ void __init no_iommu_init(void)
 {
 	if (dma_ops)
 		return;
+
+	force_iommu = 0; /* no HW IOMMU */
 	dma_ops = &nommu_dma_ops;
 }
