Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUIAU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUIAU1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUIAUXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:23:38 -0400
Received: from baikonur.stro.at ([213.239.196.228]:35279 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267682AbUIAUP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:57 -0400
Subject: [patch 10/12]  list_for_each: 	arch-sparc64-kernel-pci_sabre.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:56 +0200
Message-ID: <E1C2bWO-0006Sc-LE@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each//

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/sparc64/kernel/pci_sabre.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN arch/sparc64/kernel/pci_sabre.c~list-for-each-arch_sparc64_kernel_pci_sabre arch/sparc64/kernel/pci_sabre.c
--- linux-2.6.9-rc1-bk7/arch/sparc64/kernel/pci_sabre.c~list-for-each-arch_sparc64_kernel_pci_sabre	2004-09-01 19:38:15.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/sparc64/kernel/pci_sabre.c	2004-09-01 19:38:15.000000000 +0200
@@ -1113,10 +1113,9 @@ static void __init sabre_base_address_up
 
 static void __init apb_init(struct pci_controller_info *p, struct pci_bus *sabre_bus)
 {
-	struct list_head *walk = &sabre_bus->devices;
+	struct pci_dev *pdev;
 
-	for (walk = walk->next; walk != &sabre_bus->devices; walk = walk->next) {
-		struct pci_dev *pdev = pci_dev_b(walk);
+	list_for_each_entry(pdev, &sabre_bus->devices, bus_list) {
 
 		if (pdev->vendor == PCI_VENDOR_ID_SUN &&
 		    pdev->device == PCI_DEVICE_ID_SUN_SIMBA) {
@@ -1178,10 +1177,9 @@ static struct pcidev_cookie *alloc_bridg
 static void __init sabre_scan_bus(struct pci_controller_info *p)
 {
 	static int once;
-	struct pci_bus *sabre_bus;
+	struct pci_bus *sabre_bus, *pbus;
 	struct pci_pbm_info *pbm;
 	struct pcidev_cookie *cookie;
-	struct list_head *walk;
 	int sabres_scanned;
 
 	/* The APB bridge speaks to the Sabre host PCI bridge
@@ -1217,9 +1215,7 @@ static void __init sabre_scan_bus(struct
 
 	sabres_scanned = 0;
 
-	walk = &sabre_bus->children;
-	for (walk = walk->next; walk != &sabre_bus->children; walk = walk->next) {
-		struct pci_bus *pbus = pci_bus_b(walk);
+	list_for_each_entry(pbus, &sabre_bus->children, node) {
 
 		if (pbus->number == p->pbm_A.pci_first_busno) {
 			pbm = &p->pbm_A;

_
