Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVGAU7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVGAU7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVGAU6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:58:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:51937 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262757AbVGAUtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:39 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] PCI: Increase the number of PCI bus resources
In-Reply-To: <11202509113838@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:31 -0700
Message-Id: <11202509114020@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Increase the number of PCI bus resources

This patch increases the number of resource pointers in the
pci_bus structure. This is needed to store >4 resource ranges
for host bridges and transparent PCI bridges. With this change,
all PCI buses will have more resource pointers, but most PCI
buses will only use the first 3 or 4, the remaining being NULL.
The PCI core already deals with this correctly.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a03fa955576af50df80bec9127b46ef57e0877c0
tree dc13df100ead9efae7b370b435b58bca4736ae39
parent 26f674ae0e37190bf61c988e52911e4372fdb5f5
author rajesh.shah@intel.com <rajesh.shah@intel.com> Thu, 02 Jun 2005 15:41:48 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:49 -0700

 include/linux/pci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -586,7 +586,7 @@ struct pci_dev {
 #define PCI_NUM_RESOURCES 11
 
 #ifndef PCI_BUS_NUM_RESOURCES
-#define PCI_BUS_NUM_RESOURCES 4
+#define PCI_BUS_NUM_RESOURCES 8
 #endif
   
 #define PCI_REGION_FLAG_MASK 0x0fU	/* These bits of resource flags tell us the PCI region flags */

