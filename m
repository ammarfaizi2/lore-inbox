Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTBRCdx>; Mon, 17 Feb 2003 21:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBRCdx>; Mon, 17 Feb 2003 21:33:53 -0500
Received: from fmr01.intel.com ([192.55.52.18]:54465 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267553AbTBRCdw>;
	Mon, 17 Feb 2003 21:33:52 -0500
Subject: [PATCH] PCI code cleanup
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1045535218.1018.0.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 18 Feb 2003 10:26:58 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,
The patch clean up some old-style usage of list_head. Pls apply if you
like it. Thanks
-- 
Yours truly,
Louis Zhuang
--
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection


===== drivers/pci/probe.c 1.26 vs edited =====
-- 1.26/drivers/pci/probe.c	Mon Jan 13 11:44:26 2003
+++ edited/drivers/pci/probe.c	Tue Feb 18 09:28:40 2003
@@ -533,7 +533,7 @@
 {
 	const struct list_head *l;
 
-	for(l=list->next; l != list; l = l->next) {
+	list_for_each(l, list) {
 		const struct pci_bus *b = pci_bus_b(l);
 		if (b->number == nr || pci_bus_exists(&b->children, nr))
 			return 1;
===== drivers/pci/setup-bus.c 1.12 vs edited =====
-- 1.12/drivers/pci/setup-bus.c	Sun Dec 22 07:46:25 2002
+++ edited/drivers/pci/setup-bus.c	Tue Feb 18 09:33:33 2003
@@ -45,7 +45,7 @@
 	int idx, found_vga = 0;
 
 	head.next = NULL;
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+	list_for_each(ln, &bus->devices) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		u16 class = dev->class >> 8;
 
@@ -208,7 +208,7 @@
 	if (!(b_res->flags & IORESOURCE_IO))
 		return;
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+	list_for_each(ln, &bus->devices) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		int i;
 		
@@ -261,7 +261,7 @@
 	max_order = 0;
 	size = 0;
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+	list_for_each(ln, &bus->devices) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		int i;
 		
@@ -325,8 +325,9 @@
 	struct list_head *ln;
 	unsigned long mask, type;
 
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
+	list_for_each(ln, &bus->children) {
 		pci_bus_size_bridges(pci_bus_b(ln));
+	}
 
 	/* The root bus? */
 	if (!bus->self)
@@ -361,7 +362,7 @@
 			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
 		}
 	}
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
+	list_for_each(ln, &bus->children) {
 		struct pci_bus *b = pci_bus_b(ln);
 
 		pci_bus_assign_resources(b);


