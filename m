Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVDBAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVDBAki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVDBAKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:10:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:39644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262950AbVDAXsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:17 -0500
Cc: eike-hotplug@sf-tec.de
Subject: [PATCH] PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c
In-Reply-To: <11123992702271@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:51 -0800
Message-Id: <1112399271636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.9, 2005/03/17 13:54:33-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c

This patch removes some code duplication where if and else have the
same code at the beginning and the end of the branch.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/ibmphp_pci.c |   36 ++++++++++--------------------------
 1 files changed, 10 insertions(+), 26 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-04-01 15:37:11 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-04-01 15:37:11 -08:00
@@ -1308,9 +1308,9 @@
 			/* ????????? DO WE NEED TO WRITE ANYTHING INTO THE PCI CONFIG SPACE BACK ?????????? */
 		} else {
 			/* This is Memory */
+			start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 			if (start_address & PCI_BASE_ADDRESS_MEM_PREFETCH) {
 				/* pfmem */
-				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				debug ("start address of pfmem is %x\n", start_address);
 
 				if (ibmphp_find_resource (bus, start_address, &pfmem, PFMEM) < 0) {
@@ -1321,15 +1321,8 @@
 					debug ("pfmem->start = %x\n", pfmem->start);
 
 				ibmphp_remove_resource (pfmem);
-
-				if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					count += 1;
-				}
-
 			} else {
 				/* regular memory */
-				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				debug ("start address of mem is %x\n", start_address);
 				if (ibmphp_find_resource (bus, start_address, &mem, MEM) < 0) {
 					err ("cannot find corresponding MEM resource to remove\n");
@@ -1339,11 +1332,10 @@
 					debug ("mem->start = %x\n", mem->start);
 
 				ibmphp_remove_resource (mem);
-
-				if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					count += 1;
-				}
+			}
+			if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+				/* takes up another dword */
+				count += 1;
 			}
 		}	/* end of mem */
 	}	/* end of for */
@@ -1428,9 +1420,9 @@
 			/* ????????? DO WE NEED TO WRITE ANYTHING INTO THE PCI CONFIG SPACE BACK ?????????? */
 		} else {
 			/* This is Memory */
+			start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 			if (start_address & PCI_BASE_ADDRESS_MEM_PREFETCH) {
 				/* pfmem */
-				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				if (ibmphp_find_resource (bus, start_address, &pfmem, PFMEM) < 0) {
 					err ("cannot find corresponding PFMEM resource to remove\n");
 					return -EINVAL;
@@ -1439,15 +1431,8 @@
 					debug ("pfmem->start = %x\n", pfmem->start);
 
 				ibmphp_remove_resource (pfmem);
-
-				if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					count += 1;
-				}
-
 			} else {
 				/* regular memory */
-				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				if (ibmphp_find_resource (bus, start_address, &mem, MEM) < 0) {
 					err ("cannot find corresponding MEM resource to remove\n");
 					return -EINVAL;
@@ -1456,11 +1441,10 @@
 					debug ("mem->start = %x\n", mem->start);
 
 				ibmphp_remove_resource (mem);
-
-				if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					count += 1;
-				}
+			}
+			if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+				/* takes up another dword */
+				count += 1;
 			}
 		}	/* end of mem */
 	}	/* end of for */

