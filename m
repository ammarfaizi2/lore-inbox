Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJHWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJHWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJHWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:36:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22762 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266096AbUJHWgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:36:24 -0400
Date: Fri, 08 Oct 2004 15:36:12 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, davem@davemloft.net, ecd@skynet.be,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Subject: [RFT 2.6] isa.c replace pci_find_device with pci_get_device
Message-ID: <84880000.1097274972@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a Sparc64 system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/isa.c linux-2.6.9-rc3-mm3patch/arch/sparc64/kernel/isa.c
--- linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/isa.c	2004-09-29 20:04:25.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/sparc64/kernel/isa.c	2004-10-08 15:22:19.000000000 -0700
@@ -262,7 +262,7 @@ void __init isa_init(void)
 	device = PCI_DEVICE_ID_AL_M1533;
 
 	pdev = NULL;
-	while ((pdev = pci_find_device(vendor, device, pdev)) != NULL) {
+	while ((pdev = pci_get_device(vendor, device, pdev)) != NULL) {
 		struct pcidev_cookie *pdev_cookie;
 		struct pci_pbm_info *pbm;
 		struct sparc_isa_bridge *isa_br;

