Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJHUO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJHUO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUJHUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:14:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17571 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264377AbUJHUNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:13:07 -0400
Date: Fri, 08 Oct 2004 13:13:34 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       paulus@samba.org, anton@samba.org
Subject: [PATCH 2.6] pmac_pci.c replace pci_find_device with pci_get_device
Message-ID: <77970000.1097266414@w-hlinder.beaverton.ibm.com>
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
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pmac_pci.c linux-2.6.9-rc3-mm3patch/arch/ppc64/kernel/pmac_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pmac_pci.c	2004-10-07 15:54:29.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/ppc64/kernel/pmac_pci.c	2004-10-08 10:42:47.000000000 -0700
@@ -669,7 +669,7 @@ void __init pmac_pcibios_fixup(void)
 {
 	struct pci_dev *dev = NULL;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	for_each_pci_dev(dev)
 		pci_read_irq_line(dev);
 
 	pci_fix_bus_sysdata();

