Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUIAU1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUIAU1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUIAUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:24:39 -0400
Received: from baikonur.stro.at ([213.239.196.228]:9927 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267700AbUIAUQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:16:08 -0400
Subject: [patch 12/12]  pci_dev_b to list_for_each_entry: 	drivers-pci-setup-bus.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:16:07 +0200
Message-ID: <E1C2bWZ-0006U2-Kq@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



list_for_each & pci_(dev|bus)_[bg] replaced by list_for_each_entry.


Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>




---

 linux-2.6.9-rc1-bk7-max/drivers/pci/setup-bus.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/pci/setup-bus.c~list-for-each-drivers_pci_setup-bus2 drivers/pci/setup-bus.c
--- linux-2.6.9-rc1-bk7/drivers/pci/setup-bus.c~list-for-each-drivers_pci_setup-bus2	2004-09-01 19:38:29.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/pci/setup-bus.c	2004-09-01 19:38:29.000000000 +0200
@@ -533,16 +533,16 @@ EXPORT_SYMBOL(pci_bus_assign_resources);
 void __init
 pci_assign_unassigned_resources(void)
 {
-	struct list_head *ln;
+	struct pci_bus *bus;
 
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
-	list_for_each(ln, &pci_root_buses) {
-		pci_bus_size_bridges(pci_bus_b(ln));
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		pci_bus_size_bridges(bus);
 	}
 	/* Depth last, allocate resources and update the hardware. */
-	list_for_each(ln, &pci_root_buses) {
-		pci_bus_assign_resources(pci_bus_b(ln));
-		pci_enable_bridges(pci_bus_b(ln));
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		pci_bus_assign_resources(bus);
+		pci_enable_bridges(bus);
 	}
 }

_
