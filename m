Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269933AbUJGXcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269933AbUJGXcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbUJGX36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:29:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28333 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269920AbUJGXZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:25:30 -0400
Date: Thu, 07 Oct 2004 16:26:05 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][9/12] pplus.c replace pci_find_device with pci_get_device
Message-ID: <33930000.1097191565@w-hlinder.beaverton.ibm.com>
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

diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/pplus.c linux-2.6.9-rc3-mm3patch2/arch/ppc/platforms/pplus.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/pplus.c	2004-09-29 20:05:41.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/ppc/platforms/pplus.c	2004-10-07 16:17:53.406339280 -0700
@@ -359,7 +359,7 @@ void __init pplus_pib_init(void)
 	 * Perform specific configuration for the Via Tech or
 	 * or Winbond PCI-ISA-Bridge part.
 	 */
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_1, dev))) {
 		/*
 		 * PPCBUG does not set the enable bits
@@ -371,7 +371,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, 0x40, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_2,
 				   dev)) && (dev->devfn = 0x5a)) {
 		/* Force correct USB interrupt */
@@ -379,7 +379,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_83C553, dev))) {
 		/* Clear PCI Interrupt Routing Control Register. */
 		short_reg = 0x0000;
@@ -389,7 +389,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, 0x43, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_82C105, dev))) {
 		/*
 		 * Disable LEGIRQ mode so PCI INTS are routed

