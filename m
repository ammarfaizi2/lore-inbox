Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269955AbUJHSBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269955AbUJHSBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270076AbUJHRxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:53:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55275 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S270052AbUJHRjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:39:47 -0400
Date: Fri, 08 Oct 2004 10:40:19 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, paulus@samba.org, anton@samba.org
Subject: [PATCH 2.6] pSeries_iommu.c replace pci_find_device with pci_get_device
Message-ID: <70740000.1097257219@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a PPC64 system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/iSeries_pci.c linux-2.6.9-rc3-mm3patch/arch/ppc64/kernel/iSeries_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/iSeries_pci.c	2004-09-29 20:05:52.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/ppc64/kernel/iSeries_pci.c	2004-10-08 10:20:56.576395832 -0700
@@ -216,8 +216,7 @@ void __init iSeries_pci_final_fixup(void
 	mf_displaySrc(0xC9000100);
 
 	printk("pcibios_final_fixup\n");
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev))
-			!= NULL) {
+	for_each_pci_dev(pdev) {
 		node = find_Device_Node(pdev->bus->number, pdev->devfn);
 		printk("pci dev %p (%x.%x), node %p\n", pdev,
 		       pdev->bus->number, pdev->devfn, node);

