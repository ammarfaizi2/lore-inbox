Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271720AbTGRNtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271723AbTGRNtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:49:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9349
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271720AbTGRNsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:48:55 -0400
Date: Fri, 18 Jul 2003 15:03:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181403.h6IE3GQ3017646@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix visws pci (visws specific code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Andrey Panin)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/i386/pci/visws.c linux-2.6.0-test1-ac2/arch/i386/pci/visws.c
--- linux-2.6.0-test1/arch/i386/pci/visws.c	2003-07-10 21:12:50.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/i386/pci/visws.c	2003-07-15 17:23:53.000000000 +0100
@@ -17,7 +17,7 @@
 
 int broken_hp_bios_irq9;
 
-extern struct pci_ops pci_direct_conf1;
+extern struct pci_raw_ops pci_direct_conf1;
 
 static int pci_visws_enable_irq(struct pci_dev *dev) { return 0; }
 
@@ -101,8 +101,9 @@
 	printk(KERN_INFO "PCI: Lithium bridge A bus: %u, "
 		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);
 
-	pci_scan_bus(pci_bus0, &pci_direct_conf1, NULL);
-	pci_scan_bus(pci_bus1, &pci_direct_conf1, NULL);
+	raw_pci_ops = &pci_direct_conf1;
+	pci_scan_bus(pci_bus0, &pci_root_ops, NULL);
+	pci_scan_bus(pci_bus1, &pci_root_ops, NULL);
 	pci_fixup_irqs(visws_swizzle, visws_map_irq);
 	pcibios_resource_survey();
 	return 0;
