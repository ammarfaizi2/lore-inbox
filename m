Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270154AbUJSXb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270154AbUJSXb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270135AbUJSX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:26:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:17802 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270160AbUJSWqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:39 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257322647@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257322457@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.2, 2004/10/06 11:17:47-07:00, greg@kroah.com

[PATCH] PCI: remove pci_find_subsys() calls from acpi code.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/acpi/processor.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -Nru a/drivers/acpi/processor.c b/drivers/acpi/processor.c
--- a/drivers/acpi/processor.c	2004-10-19 15:27:47 -07:00
+++ b/drivers/acpi/processor.c	2004-10-19 15:27:47 -07:00
@@ -213,11 +213,13 @@
 		 * each IDE controller's DMA status to make sure we catch all
 		 * DMA activity.
 		 */
-		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 		           PCI_DEVICE_ID_INTEL_82371AB, 
                            PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (dev)
+		if (dev) {
 			errata.piix4.bmisx = pci_resource_start(dev, 4);
+			pci_dev_put(dev);
+		}
 
 		/* 
 		 * Type-F DMA
@@ -228,7 +230,7 @@
 		 * disable C3 support if this is enabled, as some legacy 
 		 * devices won't operate well if fast DMA is disabled.
 		 */
-		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
+		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL, 
 			PCI_DEVICE_ID_INTEL_82371AB_0, 
 			PCI_ANY_ID, PCI_ANY_ID, NULL);
 		if (dev) {
@@ -236,6 +238,7 @@
 			pci_read_config_byte(dev, 0x77, &value2);
 			if ((value1 & 0x80) || (value2 & 0x80))
 				errata.piix4.fdma = 1;
+			pci_dev_put(dev);
 		}
 
 		break;
@@ -267,10 +270,12 @@
 	/*
 	 * PIIX4
 	 */
-	dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
+	dev = pci_get_subsys(PCI_VENDOR_ID_INTEL, 
 		PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID, PCI_ANY_ID, NULL);
-	if (dev)
+	if (dev) {
 		result = acpi_processor_errata_piix4(dev);
+		pci_dev_put(dev);
+	}
 
 	return_VALUE(result);
 }

