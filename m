Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVAJRYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVAJRYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAJRYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:24:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30865 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262357AbVAJRVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:05 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776574186@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <11053776573462@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.5, 2004/12/16 15:59:38-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: ibmphp_core.c: useless casts

this patch removes some useless casts to and from (void *) as well as a cast
where a (struct pci_bus *) is cast to a (struct pci_bus *).

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_core.c |   42 ++++++++++++++++----------------------
 1 files changed, 18 insertions(+), 24 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2005-01-10 09:04:42 -08:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2005-01-10 09:04:42 -08:00
@@ -260,7 +260,7 @@
 			break;
 		}
 		if (rc == 0) {
-			pslot = (struct slot *) hotplug_slot->private;
+			pslot = hotplug_slot->private;
 			if (pslot)
 				rc = ibmphp_hpc_writeslot(pslot, cmd);
 			else
@@ -286,10 +286,9 @@
         
 	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
-			memcpy((void *) &myslot, (void *) pslot,
-						sizeof(struct slot));
+			memcpy(&myslot, pslot, sizeof(struct slot));
 			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
 						&(myslot.status));
 			if (!rc)
@@ -317,10 +316,9 @@
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
-			memcpy((void *) &myslot, (void *) pslot,
-						sizeof(struct slot));
+			memcpy(&myslot, pslot, sizeof(struct slot));
 			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
 						&(myslot.status));
 			if (!rc)
@@ -345,10 +343,9 @@
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
-			memcpy((void *) &myslot, (void *) pslot,
-						sizeof(struct slot));
+			memcpy(&myslot, pslot, sizeof(struct slot));
 			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
 						&(myslot.status));
 			if (!rc)
@@ -373,10 +370,9 @@
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
-			memcpy((void *) &myslot, (void *) pslot,
-						sizeof(struct slot));
+			memcpy(&myslot, pslot, sizeof(struct slot));
 			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
 						&(myslot.status));
 			if (!rc) {
@@ -406,7 +402,7 @@
 	ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
 			rc = 0;
 			mode = pslot->supported_bus_mode;
@@ -446,7 +442,7 @@
 	ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
 			rc = get_cur_bus_info(&pslot);
 			if (!rc) {
@@ -494,10 +490,9 @@
 		ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
-			memcpy((void *) &myslot, (void *) pslot,
-						sizeof(struct slot));
+			memcpy(&myslot, pslot, sizeof(struct slot));
 			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
 						&(myslot.status));
 
@@ -530,7 +525,7 @@
 	ibmphp_lock_operations();
 
 	if (hotplug_slot) {
-		pslot = (struct slot *) hotplug_slot->private;
+		pslot = hotplug_slot->private;
 		if (pslot) {
 			rc = 0;
 			snprintf(value, 100, "Bus %x", pslot->bus);
@@ -851,8 +846,7 @@
 	}
 	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		pci_read_config_byte(func->dev, PCI_SECONDARY_BUS, &bus);
-		child = (struct pci_bus *) pci_add_new_bus(func->dev->bus,
-							(func->dev), bus);
+		child = pci_add_new_bus(func->dev->bus, func->dev, bus);
 		pci_do_scan_bus(child);
 	}
 
@@ -1058,7 +1052,7 @@
 	ibmphp_lock_operations();
 
 	debug("ENABLING SLOT........\n");
-	slot_cur = (struct slot *) hs->private;
+	slot_cur = hs->private;
 
 	if ((rc = validate(slot_cur, ENABLE))) {
 		err("validate function failed\n");
@@ -1147,7 +1141,7 @@
 		goto error_power;
 	}
 
-	slot_cur->func = (struct pci_func *) kmalloc(sizeof(struct pci_func), GFP_KERNEL);
+	slot_cur->func = kmalloc(sizeof(struct pci_func), GFP_KERNEL);
 	if (!slot_cur->func) {
 		/* We cannot do update_slot_info here, since no memory for
 		 * kmalloc n.e.ways, and update_slot_info allocates some */
@@ -1258,7 +1252,7 @@
 
 	if (slot_cur->func == NULL) {
 		/* We need this for fncs's that were there on bootup */
-		slot_cur->func = (struct pci_func *) kmalloc(sizeof(struct pci_func), GFP_KERNEL);
+		slot_cur->func = kmalloc(sizeof(struct pci_func), GFP_KERNEL);
 		if (!slot_cur->func) {
 			err("out of system memory\n");
 			rc = -ENOMEM;

