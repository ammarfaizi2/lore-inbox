Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUIAU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUIAU1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUIAUV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:21:28 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42689 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267605AbUIAUPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:35 -0400
Subject: [patch 06/12]  list_for_each: 	arch-ppc64-kernel-pci.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:34 +0200
Message-ID: <E1C2bW2-0006Pm-Og@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pci.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff -puN arch/ppc64/kernel/pci.c~list-for-each-arch_ppc64_kernel_pci arch/ppc64/kernel/pci.c
--- linux-2.6.9-rc1-bk7/arch/ppc64/kernel/pci.c~list-for-each-arch_ppc64_kernel_pci	2004-09-01 19:38:07.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pci.c	2004-09-01 19:38:07.000000000 +0200
@@ -229,11 +229,10 @@ pci_alloc_pci_controller(enum phb_types 
 
 static void __init pcibios_claim_one_bus(struct pci_bus *b)
 {
-	struct list_head *ld;
+	struct pci_dev *dev;
 	struct pci_bus *child_bus;
 
-	for (ld = b->devices.next; ld != &b->devices; ld = ld->next) {
-		struct pci_dev *dev = pci_dev_b(ld);
+	list_for_each_entry(dev, &b->devices, bus_list) {
 		int i;
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -252,12 +251,10 @@ static void __init pcibios_claim_one_bus
 #ifndef CONFIG_PPC_ISERIES
 static void __init pcibios_claim_of_setup(void)
 {
-	struct list_head *lb;
+	struct pci_bus *b;
 
-	for (lb = pci_root_buses.next; lb != &pci_root_buses; lb = lb->next) {
-		struct pci_bus *b = pci_bus_b(lb);
+	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
-	}
 }
 #endif
 

_
