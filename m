Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJHUSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJHUSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUJHUSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:18:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45006 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264443AbUJHUQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:16:48 -0400
Date: Fri, 08 Oct 2004 13:17:19 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       paulus@samba.org, anton@samba.org
Subject: [PATCH 2.6] u3_iommu.c replace pci_find_device with pci_get_device
Message-ID: <78680000.1097266639@w-hlinder.beaverton.ibm.com>
In-Reply-To: <73910000.1097257899@w-hlinder.beaverton.ibm.com>
References: <70860000.1097257256@w-hlinder.beaverton.ibm.com> <73910000.1097257899@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device and pci_dev_put.
If someone with a PPC64 system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/u3_iommu.c linux-2.6.9-rc3-mm3patch2/arch/ppc64/kernel/u3_iommu.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/u3_iommu.c	2004-09-29 20:05:52.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/ppc64/kernel/u3_iommu.c	2004-10-08 13:10:06.883314632 -0700
@@ -290,7 +290,7 @@ void iommu_setup_u3(void)
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/* We must use pci_device_to_OF_node() to make sure that
 		 * we get the real "final" pointer to the device in the
 		 * pci_dev sysdata and not the temporary PHB one


