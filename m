Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269914AbUJGXME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269914AbUJGXME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269924AbUJGXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:11:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23546 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269914AbUJGXJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:09:31 -0400
Date: Thu, 07 Oct 2004 16:10:06 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][8/12] pmac_pci.c replace pci_find_device with pci_get_device
Message-ID: <31870000.1097190606@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a PPC system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/pmac_pci.c linux-2.6.9-rc3-mm3patch/arch/ppc/platforms/pmac_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/pmac_pci.c	2004-10-07 15:54:30.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/ppc/platforms/pmac_pci.c	2004-10-07 16:01:41.000000000 -0700
@@ -889,7 +889,7 @@ pcibios_fixup_OF_interrupts(void)
 	 * should find the device node and apply the interrupt
 	 * obtained from the OF device-tree
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		struct device_node *node;
 		node = pci_device_to_OF_node(dev);
 		/* this is the node, see if it has interrupts */
@@ -989,7 +989,7 @@ pmac_pcibios_after_init(void)
 	 *
 	 * -- BenH
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		if ((dev->class >> 16) == PCI_BASE_CLASS_STORAGE)
 			pci_enable_device(dev);
 	}

