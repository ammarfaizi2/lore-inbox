Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWATTIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWATTIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWATTFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:27856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751162AbWATTE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:59 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: remove remove_bus_device()
In-Reply-To: <11377838793011@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:40 -0800
Message-Id: <11377838804160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: remove remove_bus_device()

The function rpaphp_eeh_remove_bus_device() is a dupe of
eeh_remove_bus_device(). Remove it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5091bcbccd26ae37caea6330a1f267427422f18f
tree fd401066a0ad4976668d7b507e485c870e9e2cac
parent 2a291fc8e77fad35c129ae5b11bbe13d835c01c1
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:24:27 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpaphp_pci.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index b93d9c9..1f5e73b 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -116,30 +116,12 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 
-static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
-{
-	eeh_remove_device(dev);
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		struct pci_bus *bus = dev->subordinate;
-		struct list_head *ln;
-		if (!bus)
-			return; 
-		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-			struct pci_dev *pdev = pci_dev_b(ln);
-			if (pdev)
-				rpaphp_eeh_remove_bus_device(pdev);
-		}
-
-	}
-	return;
-}
-
 int rpaphp_unconfig_pci_adapter(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
 
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		rpaphp_eeh_remove_bus_device(dev);
+		eeh_remove_bus_device(dev);
 		pci_remove_bus_device(dev);
 	}
 	return 0;

