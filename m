Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVAJRfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVAJRfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAJRez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:34:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:28807 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262363AbVAJRVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:07 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776551683@kroah.com>
Date: Mon, 10 Jan 2005 09:20:56 -0800
Message-Id: <11053776561347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.45, 2005/01/07 10:33:06-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Remove unneeded kmalloc casts from ibmphp_pci.c

this patch removes some unneeded casts from ibmphp_pci.c that cast the result
of kmalloc to some pointer type. It also uses "sizeof(*result)" instead of
"sizeof(type_of_result)".

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_pci.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:59:03 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:59:03 -08:00
@@ -164,7 +164,7 @@
 						cleanup_count = 6;
 						goto error;
 					}
-					newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+					newfunc = kmalloc(sizeof(*newfunc), GFP_KERNEL);
 					if (!newfunc) {
 						err ("out of system memory\n");
 						return -ENOMEM;
@@ -203,7 +203,7 @@
 					flag = FALSE;
 					for (i = 0; i < 32; i++) {
 						if (func->devices[i]) {
-							newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+							newfunc = kmalloc(sizeof(*newfunc), GFP_KERNEL);
 							if (!newfunc) {
 								err ("out of system memory\n");
 								return -ENOMEM;
@@ -232,7 +232,7 @@
 						}
 					}
 
-					newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+					newfunc = kmalloc(sizeof(*newfunc), GFP_KERNEL);
 					if (!newfunc) {
 						err ("out of system memory\n");
 						return -ENOMEM;
@@ -279,7 +279,7 @@
 					for (i = 0; i < 32; i++) {
 						if (func->devices[i]) {
 							debug ("inside for loop, device is %x\n", i);
-							newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+							newfunc = kmalloc(sizeof(*newfunc), GFP_KERNEL);
 							if (!newfunc) {
 								err (" out of system memory\n");
 								return -ENOMEM;
@@ -459,7 +459,7 @@
 					ibmphp_add_resource (pfmem[count]);
 					func->pfmem[count] = pfmem[count];
 				} else {
-					mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+					mem_tmp = kmalloc(sizeof(*mem_tmp), GFP_KERNEL);
 					if (!mem_tmp) {
 						err ("out of system memory\n");
 						kfree (pfmem[count]);
@@ -724,7 +724,7 @@
 					ibmphp_add_resource (bus_pfmem[count]);
 					func->pfmem[count] = bus_pfmem[count];
 				} else {
-					mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+					mem_tmp = kmalloc(sizeof(*mem_tmp), GFP_KERNEL);
 					if (!mem_tmp) {
 						err ("out of system memory\n");
 						retval = -ENOMEM;
@@ -836,7 +836,7 @@
 		flag_io = TRUE;
 	} else {
 		debug ("it wants %x IO behind the bridge\n", amount_needed->io);
-		io = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+		io = kmalloc(sizeof(*io), GFP_KERNEL);
 		
 		if (!io) {
 			err ("out of system memory\n");
@@ -860,7 +860,7 @@
 		flag_mem = TRUE;
 	} else {
 		debug ("it wants %x memory behind the bridge\n", amount_needed->mem);
-		mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+		mem = kmalloc(sizeof(*mem), GFP_KERNEL);
 		if (!mem) {
 			err ("out of system memory\n");
 			retval = -ENOMEM;
@@ -883,7 +883,7 @@
 		flag_pfmem = TRUE;
 	} else {
 		debug ("it wants %x pfmemory behind the bridge\n", amount_needed->pfmem);
-		pfmem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+		pfmem = kmalloc(sizeof(*pfmem), GFP_KERNEL);
 		if (!pfmem) {
 			err ("out of system memory\n");
 			retval = -ENOMEM;
@@ -899,7 +899,7 @@
 			ibmphp_add_resource (pfmem);
 			flag_pfmem = TRUE;
 		} else {
-			mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+			mem_tmp = kmalloc(sizeof(*mem_tmp), GFP_KERNEL);
 			if (!mem_tmp) {
 				err ("out of system memory\n");
 				retval = -ENOMEM;
@@ -931,7 +931,7 @@
 		 */
 		bus = ibmphp_find_res_bus (sec_number);
 		if (!bus) {
-			bus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
+			bus = kmalloc(sizeof(*bus), GFP_KERNEL);
 			if (!bus) {
 				err ("out of system memory\n");
 				retval = -ENOMEM;
@@ -1107,7 +1107,7 @@
 	};
 	struct res_needed *amount;
 
-	amount = kmalloc (sizeof (struct res_needed), GFP_KERNEL);
+	amount = kmalloc(sizeof(*amount), GFP_KERNEL);
 	if (amount == NULL)
 		return NULL;
 	memset (amount, 0, sizeof (struct res_needed));
@@ -1680,7 +1680,7 @@
 		list_add (&bus->bus_list, &cur_bus->bus_list);
 	}
 	if (io) {
-		io_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
+		io_range = kmalloc(sizeof(*io_range), GFP_KERNEL);
 		if (!io_range) {
 			err ("out of system memory\n");
 			return -ENOMEM;
@@ -1693,7 +1693,7 @@
 		bus->rangeIO = io_range;
 	}
 	if (mem) {
-		mem_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
+		mem_range = kmalloc(sizeof(*mem_range), GFP_KERNEL);
 		if (!mem_range) {
 			err ("out of system memory\n");
 			return -ENOMEM;
@@ -1706,7 +1706,7 @@
 		bus->rangeMem = mem_range;
 	}
 	if (pfmem) {
-		pfmem_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
+		pfmem_range = kmalloc(sizeof(*pfmem_range), GFP_KERNEL);
 		if (!pfmem_range) {	
 			err ("out of system memory\n");
 			return -ENOMEM;

