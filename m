Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUJHWyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUJHWyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJHWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:54:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56704 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266181AbUJHWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:52:55 -0400
Date: Fri, 08 Oct 2004 15:53:08 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, uclinux-v850@lsi.nec.co.jp
Subject: [RFT 2.6] ret_mb_a_pci.c replace pci_find_device with pci_get_device
Message-ID: <87080000.1097275988@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a v850 system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/v850/kernel/rte_mb_a_pci.c linux-2.6.9-rc3-mm3patch/arch/v850/kernel/rte_mb_a_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/v850/kernel/rte_mb_a_pci.c	2004-09-29 20:04:23.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/v850/kernel/rte_mb_a_pci.c	2004-10-08 15:39:44.793464832 -0700
@@ -254,7 +254,7 @@ static void __devinit pcibios_assign_res
 	struct pci_dev *dev = NULL;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		unsigned di_num;
 		unsigned class = dev->class >> 8;
 

