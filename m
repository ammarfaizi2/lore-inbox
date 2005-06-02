Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFBWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFBWgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFBWd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:33:57 -0400
Received: from fmr19.intel.com ([134.134.136.18]:221 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261446AbVFBWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:33:14 -0400
Message-Id: <20050602224326.656154000@csdlinux-1>
References: <20050602224147.177031000@csdlinux-1>
Date: Thu, 02 Jun 2005 15:41:48 -0700
From: rajesh.shah@intel.com
To: gregkh@suse.de, ink@jurassic.park.msu.ru, ak@suse.de, len.brown@intel.com,
       akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 1/2] Increase the number of PCI bus resources
Content-Disposition: inline; filename=inc-pci-bus-resources
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases the number of resource pointers in the
pci_bus structure. This is needed to store >4 resource ranges
for host bridges and transparent PCI bridges. With this change,
all PCI buses will have more resource pointers, but most PCI
buses will only use the first 3 or 4, the remaining being NULL.
The PCI core already deals with this correctly.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

Index: linux-2.6.12-rc5/include/linux/pci.h
===================================================================
--- linux-2.6.12-rc5.orig/include/linux/pci.h
+++ linux-2.6.12-rc5/include/linux/pci.h
@@ -586,7 +586,7 @@ struct pci_dev {
 #define PCI_NUM_RESOURCES 11
 
 #ifndef PCI_BUS_NUM_RESOURCES
-#define PCI_BUS_NUM_RESOURCES 4
+#define PCI_BUS_NUM_RESOURCES 8
 #endif
   
 #define PCI_REGION_FLAG_MASK 0x0fU	/* These bits of resource flags tell us the PCI region flags */

--
