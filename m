Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUJHUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUJHUtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJHUtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:49:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42489 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264991AbUJHUqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:46:19 -0400
Date: Fri, 08 Oct 2004 13:46:51 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6] fixups-dreamcast.c replace pci_find_device with pci_get_device
Message-ID: <80460000.1097268411@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device and pci_dev_put.
If someone with a Dreamcast system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/sh/drivers/pci/fixups-dreamcast.c linux-2.6.9-rc3-mm3patch/arch/sh/drivers/pci/fixups-dreamcast.c
--- linux-2.6.9-rc3-mm3cln/arch/sh/drivers/pci/fixups-dreamcast.c	2004-09-29 20:05:41.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/sh/drivers/pci/fixups-dreamcast.c	2004-10-08 13:34:31.097720208 -0700
@@ -62,7 +62,7 @@ void __init pcibios_fixup_irqs(void)
 {
 	struct pci_dev *dev = 0;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/*
 		 * The interrupt routing semantics here are quite trivial.
 		 *


