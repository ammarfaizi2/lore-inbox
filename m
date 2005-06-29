Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVF2Arz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVF2Arz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVF2Arv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:47:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59854 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262338AbVF2AAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:00:10 -0400
Date: Tue, 28 Jun 2005 19:00:06 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 11/13]: PCI Err: RPA-PHP janitoring
Message-ID: <20050629000006.GA6468@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-11-rpaphp-janitor.patch

Remove dead code.

Signed-off-by: Linas Vepstas <linas@linas.org>

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-11-rpaphp-janitor.patch"

--- linux-2.6.12-git10/drivers/pci/hotplug/rpaphp.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/rpaphp.h	2005-06-22 15:28:29.000000000 -0500
@@ -113,7 +113,6 @@ extern int rpaphp_enable_pci_slot(struct
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
-extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
--- linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_pci.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_pci.c	2005-06-22 15:28:29.000000000 -0500
@@ -503,36 +503,3 @@ exit:
 	return retval;
 }
 
-struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev)
-{
-	struct list_head	*tmp, *n;
-	struct slot		*slot;
-
-	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		struct pci_bus *bus;
-		struct list_head *ln;
-
-		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-		if (slot->bridge == NULL) {
-			if (slot->dev_type == PCI_DEV) {
-				printk(KERN_WARNING "PCI slot missing bridge %s %s \n", 
-				                    slot->name, slot->location);
-			}
-			continue;
-		}
-
-		bus = slot->bridge->subordinate;
-		if (!bus) {
-			continue;  /* should never happen? */
-		}
-		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-                                struct pci_dev *pdev = pci_dev_b(ln);
-				if (pdev == dev)
-					return slot->hotplug_slot;
-		}
-	}
-
-	return NULL;
-}
-
-EXPORT_SYMBOL_GPL(rpaphp_find_hotplug_slot);

--Kj7319i9nmIyA2yE--
