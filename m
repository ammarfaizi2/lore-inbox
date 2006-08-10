Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWHJUET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWHJUET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWHJTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932321AbWHJTge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:34 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [76/145] x86_64: Calgary IOMMU: break out of pci_find_device_reverse if dev not found
Message-Id: <20060810193632.A60CC13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:32 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -844,6 +844,8 @@ error:
 		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
 					      PCI_DEVICE_ID_IBM_CALGARY,
 					      dev);
+		if (!dev)
+			break;
 		if (!translate_phb(dev)) {
 			pci_dev_put(dev);
 			continue;
