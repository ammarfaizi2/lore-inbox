Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUIAU1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUIAU1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267747AbUIAUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:20:40 -0400
Received: from baikonur.stro.at ([213.239.196.228]:53165 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267556AbUIAUPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:10 -0400
Subject: [patch 01/12]  list_for_each: 	arch-alpha-kernel-pci.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:06 +0200
Message-ID: <E1C2bVa-0006ME-VC@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi.

Change for loops with list_for_each().

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>




---

 linux-2.6.9-rc1-bk7-max/arch/alpha/kernel/pci.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff -puN arch/alpha/kernel/pci.c~list-for-each-arch_alpha_kernel_pci arch/alpha/kernel/pci.c
--- linux-2.6.9-rc1-bk7/arch/alpha/kernel/pci.c~list-for-each-arch_alpha_kernel_pci	2004-09-01 19:36:10.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/alpha/kernel/pci.c	2004-09-01 19:36:10.000000000 +0200
@@ -280,7 +280,6 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	/* Propagate hose info into the subordinate devices.  */
 
 	struct pci_controller *hose = bus->sysdata;
-	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
 	if (!dev) {
@@ -304,9 +303,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
  		pcibios_fixup_device_resources(dev, bus);
 	} 
 
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
-
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
@@ -403,11 +400,10 @@ pcibios_set_master(struct pci_dev *dev)
 static void __init
 pcibios_claim_one_bus(struct pci_bus *b)
 {
-	struct list_head *ld;
+	struct pci_dev *dev;
 	struct pci_bus *child_bus;
 
-	for (ld = b->devices.next; ld != &b->devices; ld = ld->next) {
-		struct pci_dev *dev = pci_dev_b(ld);
+	list_for_each_entry(dev, &b->devices, bus_list) {
 		int i;
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -426,12 +422,10 @@ pcibios_claim_one_bus(struct pci_bus *b)
 static void __init
 pcibios_claim_console_setup(void)
 {
-	struct list_head *lb;
+	struct pci_bus *b;
 
-	for(lb = pci_root_buses.next; lb != &pci_root_buses; lb = lb->next) {
-		struct pci_bus *b = pci_bus_b(lb);
+	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
-	}
 }
 
 void __init

_
