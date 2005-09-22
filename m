Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVIVHtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVIVHtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIVHtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:64434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751442AbVIVHsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:53 -0400
Date: Thu, 22 Sep 2005 00:48:11 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       penberg@cs.helsinki.fi
Subject: [patch 06/18] PCI: convert kcalloc to kzalloc
Message-ID: <20050922074811.GG15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-kzalloc.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/hotplug/sgi_hotplug.c |    6 +++---
 drivers/pci/pci-sysfs.c           |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- scsi-2.6.orig/drivers/pci/hotplug/sgi_hotplug.c	2005-09-20 05:59:55.000000000 -0700
+++ scsi-2.6/drivers/pci/hotplug/sgi_hotplug.c	2005-09-21 17:29:30.000000000 -0700
@@ -159,7 +159,7 @@
 
 	pcibus_info = SN_PCIBUS_BUSSOFT_INFO(pci_bus);
 
-	slot = kcalloc(1, sizeof(*slot), GFP_KERNEL);
+	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return -ENOMEM;
 	bss_hotplug_slot->private = slot;
@@ -491,7 +491,7 @@
 		if (sn_pci_slot_valid(pci_bus, device) != 1)
 			continue;
 
-		bss_hotplug_slot = kcalloc(1, sizeof(*bss_hotplug_slot),
+		bss_hotplug_slot = kzalloc(sizeof(*bss_hotplug_slot),
 					   GFP_KERNEL);
 		if (!bss_hotplug_slot) {
 			rc = -ENOMEM;
@@ -499,7 +499,7 @@
 		}
 
 		bss_hotplug_slot->info =
-			kcalloc(1, sizeof(struct hotplug_slot_info),
+			kzalloc(sizeof(struct hotplug_slot_info),
 				GFP_KERNEL);
 		if (!bss_hotplug_slot->info) {
 			rc = -ENOMEM;
--- scsi-2.6.orig/drivers/pci/pci-sysfs.c	2005-09-20 05:59:55.000000000 -0700
+++ scsi-2.6/drivers/pci/pci-sysfs.c	2005-09-21 17:29:30.000000000 -0700
@@ -360,7 +360,7 @@
 			continue;
 
 		/* allocate attribute structure, piggyback attribute name */
-		res_attr = kcalloc(1, sizeof(*res_attr) + 10, GFP_ATOMIC);
+		res_attr = kzalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
 		if (res_attr) {
 			char *res_attr_name = (char *)(res_attr + 1);
 

--
