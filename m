Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVDBAIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVDBAIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVDBAF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:05:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:33756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262910AbVDAXsP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:15 -0500
Cc: eike-hotplug@sf-tec.de
Subject: [PATCH] PCI Hotplug: only call ibmphp_remove_resource() if argument is not NULL
In-Reply-To: <1112399271636@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:51 -0800
Message-Id: <11123992711809@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.10, 2005/03/17 13:54:51-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: only call ibmphp_remove_resource() if argument is not NULL

If we call ibmphp_remove_resource() with a NULL argument it will write
a warning. We can avoid this here because we already look if the argument
will be NULL before (and we ignore the return code anyway).

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/ibmphp_pci.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-04-01 15:36:56 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-04-01 15:36:56 -08:00
@@ -1317,10 +1317,11 @@
 					err ("cannot find corresponding PFMEM resource to remove\n");
 					return -EIO;
 				}
-				if (pfmem)
+				if (pfmem) {
 					debug ("pfmem->start = %x\n", pfmem->start);
 
-				ibmphp_remove_resource (pfmem);
+					ibmphp_remove_resource(pfmem);
+				}
 			} else {
 				/* regular memory */
 				debug ("start address of mem is %x\n", start_address);
@@ -1328,10 +1329,11 @@
 					err ("cannot find corresponding MEM resource to remove\n");
 					return -EIO;
 				}
-				if (mem)
+				if (mem) {
 					debug ("mem->start = %x\n", mem->start);
 
-				ibmphp_remove_resource (mem);
+					ibmphp_remove_resource(mem);
+				}
 			}
 			if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 				/* takes up another dword */
@@ -1427,20 +1429,22 @@
 					err ("cannot find corresponding PFMEM resource to remove\n");
 					return -EINVAL;
 				}
-				if (pfmem)
+				if (pfmem) {
 					debug ("pfmem->start = %x\n", pfmem->start);
 
-				ibmphp_remove_resource (pfmem);
+					ibmphp_remove_resource(pfmem);
+				}
 			} else {
 				/* regular memory */
 				if (ibmphp_find_resource (bus, start_address, &mem, MEM) < 0) {
 					err ("cannot find corresponding MEM resource to remove\n");
 					return -EINVAL;
 				}
-				if (mem)
+				if (mem) {
 					debug ("mem->start = %x\n", mem->start);
 
-				ibmphp_remove_resource (mem);
+					ibmphp_remove_resource(mem);
+				}
 			}
 			if (tmp_address & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 				/* takes up another dword */

