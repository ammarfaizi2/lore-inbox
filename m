Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUJHW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUJHW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUJHWzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:55:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8906 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266034AbUJHWym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:54:42 -0400
Date: Fri, 08 Oct 2004 15:55:12 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, ak@suse.de
Subject: [RFT 2.6] pci-gart.c replace pci_find_device with pci_get_device
Message-ID: <87680000.1097276112@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a x86-64 system could test it I would appreciate it.
Thanks.

This should be the last of the /arch fixes for this work.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/x86_64/kernel/pci-gart.c linux-2.6.9-rc3-mm3patch3/arch/x86_64/kernel/pci-gart.c
--- linux-2.6.9-rc3-mm3cln/arch/x86_64/kernel/pci-gart.c	2004-09-29 20:04:32.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch3/arch/x86_64/kernel/pci-gart.c	2004-10-08 15:42:18.000000000 -0700
@@ -81,7 +81,7 @@ static u32 gart_unmapped_entry; 
 
 #define for_all_nb(dev) \
 	dev = NULL;	\
-	while ((dev = pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
+	while ((dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
 	     if (dev->bus->number == 0 && 				     \
 		    (PCI_SLOT(dev->devfn) >= 24) && (PCI_SLOT(dev->devfn) <= 31))
 


