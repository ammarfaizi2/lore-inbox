Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbUKLXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUKLXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUKLXeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:34:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31459 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262673AbUKLXWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:36 -0500
X-Fake: the user-agent is fake
Subject: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <20041112232057.GA16964@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017152930@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2000.10.1, 2004/10/20 15:35:44-07:00, greg@kroah.com

PCI: use pci_dev_present() in irq.c check

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/irq.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2004-11-12 15:14:50 -08:00
+++ b/arch/i386/pci/irq.c	2004-11-12 15:14:50 -08:00
@@ -452,21 +452,17 @@
 
 #endif
 
-
 static __init int intel_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	struct pci_dev *dev1, *dev2;
+	static struct pci_device_id pirq_440gx[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_0) },
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_2) },
+		{ },
+	};
 
 	/* 440GX has a proprietary PIRQ router -- don't use it */
-	dev1 = pci_get_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_82443GX_0, NULL);
-	dev2 = pci_get_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_82443GX_2, NULL);
-	if ((dev1 != NULL) || (dev2 != NULL)) {
-		pci_dev_put(dev1);
-		pci_dev_put(dev2);
+	if (pci_dev_present(pirq_440gx))
 		return 0;
-	}
 
 	switch(device)
 	{

