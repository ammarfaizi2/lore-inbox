Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWJRRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWJRRWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWJRRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:22:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58256 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422715AbWJRRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:22:11 -0400
Subject: [PATCH] x86: resend - remove last two pci_find offenders in the
	core code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:24:45 +0100
Message-Id: <1161192285.9363.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as I believe the discussion about them established they were
correct.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/arch/i386/pci/irq.c linux-2.6.19-rc2-mm1/arch/i386/pci/irq.c
--- linux.vanilla-2.6.19-rc2-mm1/arch/i386/pci/irq.c	2006-10-18 13:50:03.000000000 +0100
+++ linux-2.6.19-rc2-mm1/arch/i386/pci/irq.c	2006-10-18 13:54:08.000000000 +0100
@@ -758,7 +758,7 @@
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for %04x:%04x\n",
 	    rt->rtr_vendor, rt->rtr_device);
 
-	pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
+	pirq_router_dev = pci_get_bus_and_slot(rt->rtr_bus, rt->rtr_devfn);
 	if (!pirq_router_dev) {
 		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
 			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
@@ -778,6 +778,8 @@
 		pirq_router_dev->vendor,
 		pirq_router_dev->device,
 		pci_name(pirq_router_dev));
+		
+	/* The device remains referenced for the kernel lifetime */
 }
 
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/arch/x86_64/kernel/pci-calgary.c linux-2.6.19-rc2-mm1/arch/x86_64/kernel/pci-calgary.c
--- linux.vanilla-2.6.19-rc2-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-18 13:51:02.000000000 +0100
+++ linux-2.6.19-rc2-mm1/arch/x86_64/kernel/pci-calgary.c	2006-10-18 13:54:28.000000000 +0100
@@ -879,7 +879,7 @@
 
 error:
 	do {
-		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
+		dev = pci_get_device_reverse(PCI_VENDOR_ID_IBM,
 					      PCI_DEVICE_ID_IBM_CALGARY,
 					      dev);
 		if (!dev)

