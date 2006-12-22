Return-Path: <linux-kernel-owner+w=401wt.eu-S1752886AbWLVVuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbWLVVuM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbWLVVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:50:11 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:55883 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbWLVVuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:50:10 -0500
Date: Fri, 22 Dec 2006 13:51:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] pci/probe: fix macro that confuses kernel-doc
Message-Id: <20061222135124.26122c95.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Don't have macros between a function's kernel-doc block and
the function definition.  This is not valid for kernel-doc.

Warning(/var/linsrc/linux-2.6.20-rc1-git8//drivers/pci/probe.c:653): No description found for parameter 'IORESOURCE_PCI_FIXED'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/pci/probe.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.20-rc1-git8.orig/drivers/pci/probe.c
+++ linux-2.6.20-rc1-git8/drivers/pci/probe.c
@@ -639,6 +639,8 @@ static void pci_read_irq(struct pci_dev 
 	dev->irq = irq;
 }
 
+#define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
+
 /**
  * pci_setup_device - fill in class and map information of a device
  * @dev: the device structure to fill
@@ -649,9 +651,6 @@ static void pci_read_irq(struct pci_dev 
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
  */
-
-#define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
-
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;


---
