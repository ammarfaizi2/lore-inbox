Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUJTE0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUJTE0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270157AbUJSXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:36:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:10378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270131AbUJSWqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225734848@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <1098225734438@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.17, 2004/10/06 11:54:36-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-alpha-kernel-pci.c

Change for loops with list_for_each().

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/alpha/kernel/pci.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)


diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	2004-10-19 15:26:19 -07:00
+++ b/arch/alpha/kernel/pci.c	2004-10-19 15:26:19 -07:00
@@ -280,7 +280,6 @@
 	/* Propagate hose info into the subordinate devices.  */
 
 	struct pci_controller *hose = bus->sysdata;
-	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
 	if (!dev) {
@@ -304,9 +303,7 @@
  		pcibios_fixup_device_resources(dev, bus);
 	} 
 
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
-
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
@@ -403,11 +400,10 @@
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
@@ -426,12 +422,10 @@
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

