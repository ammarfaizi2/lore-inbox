Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUIAU1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUIAU1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUIAUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:21:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:937 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267648AbUIAUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:29 -0400
Subject: [patch 05/12]  list_for_each: 	arch-ppc64-kernel-pSeries_pci.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:28 +0200
Message-ID: <E1C2bVx-0006P4-8g@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pSeries_pci.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/kernel/pSeries_pci.c~list-for-each-arch_ppc64_kernel_pSeries_pci arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.9-rc1-bk7/arch/ppc64/kernel/pSeries_pci.c~list-for-each-arch_ppc64_kernel_pSeries_pci	2004-09-01 19:38:07.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pSeries_pci.c	2004-09-01 19:38:07.000000000 +0200
@@ -585,7 +585,7 @@ EXPORT_SYMBOL(pcibios_fixup_device_resou
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
-	struct list_head *ln;
+	struct pci_dev *dev;
 
 	/* XXX or bus->parent? */
 	struct pci_dev *dev = bus->self;
@@ -627,8 +627,7 @@ void __devinit pcibios_fixup_bus(struct 
 	if (!pci_probe_only)
 		return;
 
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}

_
