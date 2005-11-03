Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVKCAZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVKCAZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVKCAZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:25:12 -0500
Received: from fmr19.intel.com ([134.134.136.18]:50639 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030199AbVKCAYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:24:46 -0500
Subject: [patch 2/4] apci: use pin stored in pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
References: <20051103001540.365407000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:24:35 -0800
Message-Id: <1130977475.8321.40.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:24:36.0630 (UTC) FILETIME=[F8ADDB60:01C5E00C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the stored value of the Interrupt Pin, rather than try to read
it again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/acpi/pci_irq.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.13/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.13.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.13/drivers/acpi/pci_irq.c
@@ -361,8 +361,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
 			/* PC card has the same IRQ as its cardbridge */
-			pci_read_config_byte(bridge, PCI_INTERRUPT_PIN,
-					     &bridge_pin);
+			bridge_pin = bridge->pin;
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "No interrupt pin configured for device %s\n",
@@ -412,7 +411,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	if (!dev)
 		return_VALUE(-EINVAL);
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No interrupt pin configured for device %s\n",
@@ -503,7 +502,7 @@ void acpi_pci_irq_disable(struct pci_dev
 	if (!dev || !dev->bus)
 		return_VOID;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return_VOID;
 	pin--;

--
