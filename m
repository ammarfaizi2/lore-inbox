Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTFECIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTFECEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:04:08 -0400
Received: from granite.he.net ([216.218.226.66]:58118 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264396AbTFECCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787472909@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787473298@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.4, 2003/06/03 17:08:13-07:00, greg@kroah.com

[PATCH] ACPI PCI Hotplug: remove hand made pci_find_bus function


 drivers/hotplug/acpiphp_glue.c |   26 +-------------------------
 1 files changed, 1 insertion(+), 25 deletions(-)


diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Wed Jun  4 18:12:11 2003
+++ b/drivers/hotplug/acpiphp_glue.c	Wed Jun  4 18:12:11 2003
@@ -281,30 +281,6 @@
 	return AE_OK;
 }
 
-
-/* find pci_bus structure associated to specific bus number */
-static struct pci_bus *find_pci_bus(const struct list_head *list, int bus)
-{
-	const struct list_head *l;
-
-	list_for_each (l, list) {
-		struct pci_bus *b = pci_bus_b(l);
-		if (b->number == bus)
-			return b;
-
-		if (!list_empty(&b->children)) {
-			/* XXX recursive call */
-			b = find_pci_bus(&b->children, bus);
-
-			if (b)
-				return b;
-		}
-	}
-
-	return NULL;
-}
-
-
 /* decode ACPI 2.0 _HPP hot plug parameters */
 static void decode_hpp(struct acpiphp_bridge *bridge)
 {
@@ -409,7 +385,7 @@
 	bridge->seg = seg;
 	bridge->bus = bus;
 
-	bridge->pci_bus = find_pci_bus(&pci_root_buses, bus);
+	bridge->pci_bus = pci_find_bus(bus);
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 

