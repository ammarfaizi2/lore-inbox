Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVGBViJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVGBViJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVGBViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:38:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12225 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261281AbVGBVhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:37:24 -0400
Subject: Re: If ACPI doesn't find an irq listed, don't accept 0 as a valid
	PCI irq.
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, torvalds@osdl.org
In-Reply-To: <200507021908.j62J8m4D009707@hera.kernel.org>
References: <200507021908.j62J8m4D009707@hera.kernel.org>
Content-Type: multipart/mixed; boundary="=-ALojQjjxiCuGMWSpHajY"
Date: Sat, 02 Jul 2005 22:36:25 +0100
Message-Id: <1120340186.9275.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ALojQjjxiCuGMWSpHajY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-07-02 at 12:08 -0700, Linux Kernel Mailing List wrote:
> If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
> 
> That zero just means that nothing else found any irq information
> either.

> -               if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> +               if (dev->irq > 0 && (dev->irq <= 0xF)) {

Zero _is_ a valid IRQ number. You're undoing the fix which was made as
part of cset 1.1803.119.54 (attached).

-- 
dwmw2

--=-ALojQjjxiCuGMWSpHajY
Content-Disposition: inline
Content-Description: Attached message - [ACPI] acpi_pci_irq_enable() now
	returns 0 on success.
Content-Type: message/rfc822

Return-path: <bk-commits-head-owner@vger.kernel.org>
Envelope-to: dwmw2@baythorne.infradead.org
Delivery-date: Thu, 02 Dec 2004 02:02:33 +0000
Received: from [2002:cde9:da46::1] (helo=canuck.infradead.org) by
	baythorne.infradead.org with esmtps (Exim 4.42 #1 (Red Hat Linux)) id
	1CZgIi-0005jl-74 for dwmw2@baythorne.infradead.org; Thu, 02 Dec 2004
	02:02:33 +0000
Received: from vger.kernel.org ([12.107.209.244]) by canuck.infradead.org
	with esmtp (Exim 4.42 #1 (Red Hat Linux)) id 1CZgK4-0000nW-50 for
	dwmw2@lists.infradead.org; Wed, 01 Dec 2004 21:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S261545AbULBCDx (ORCPT <rfc822;dwmw2@lists.infradead.org>); Wed, 1 Dec 2004
	21:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULBCDx
	(ORCPT <rfc822;bk-commits-head-outgoing>); Wed, 1 Dec 2004 21:03:53 -0500
Received: from hera.kernel.org ([63.209.29.2]:11481 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261545AbULBCDn (ORCPT
	<rfc822;bk-commits-head@vger.kernel.org>); Wed, 1 Dec 2004 21:03:43 -0500
Received: from hera.kernel.org (localhost [127.0.0.1]) by hera.kernel.org
	(8.12.11/8.12.8) with ESMTP id iB223gZ5008974 for
	<bk-commits-head@vger.kernel.org>; Wed, 1 Dec 2004 18:03:42 -0800
Received: (from dwmw2@localhost) by hera.kernel.org
	(8.12.11/8.12.11/Submit) id iB223VGb008939 for
	bk-commits-head@vger.kernel.org; Wed, 1 Dec 2004 18:03:31 -0800
Message-Id: <200412020203.iB223VGb008939@hera.kernel.org>
Subject: [ACPI] acpi_pci_irq_enable() now returns 0 on success.
Date: Tue, 09 Nov 2004 08:08:42 +0000
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: bk-commits-head@vger.kernel.org
X-BK-Repository: hera.kernel.org:/home/dwmw2/BK/linus-2.5
X-BK-ChangeSetKey: len.brown@intel.com|ChangeSet|20041109080842|44022
Sender: bk-commits-head-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: bk-commits-head@vger.kernel.org
X-Evolution-Source: imap://dwmw2@pentafluge.infradead.org/
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

ChangeSet 1.1803.119.54, 2004/11/09 03:08:42-05:00, len.brown@intel.com

	[ACPI] acpi_pci_irq_enable() now returns 0 on success.
	This bubbles all the way up to pci_enable_device().
	This allows IRQ0 to be used as a legal PCI device IRQ.
	
	The ES7000 uses an interrupt source override to assign pin20 to IRQ0.
	Then platform_rename_gsi assigns pin0 a high-numbered IRQ -- available
	for PCI devices.  But IRQ0 needs to be a legal PCI IRQ in the lookup code
	to make it as far as the re-name code. 
	
	Signed-off-by: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
	Signed-off-by: Len Brown <len.brown@intel.com>



 pci_irq.c  |   41 ++++++++++++++++++++++++++++-------------
 pci_link.c |   15 ++++++++++-----
 2 files changed, 38 insertions(+), 18 deletions(-)


diff -Nru a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c	2004-12-01 18:03:42 -08:00
+++ b/drivers/acpi/pci_irq.c	2004-12-01 18:03:42 -08:00
@@ -227,6 +227,11 @@
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 
+/*
+ * acpi_pci_irq_lookup
+ * success: return IRQ >= 0
+ * failure: return -1
+ */
 static int
 acpi_pci_irq_lookup (
 	struct pci_bus		*bus,
@@ -249,14 +254,14 @@
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 	
 	if (entry->link.handle) {
 		irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, edge_level, active_high_low);
-		if (!irq) {
+		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
-			return_VALUE(0);
+			return_VALUE(-1);
 		}
 	} else {
 		irq = entry->link.index;
@@ -269,6 +274,11 @@
 	return_VALUE(irq);
 }
 
+/*
+ * acpi_pci_irq_derive
+ * success: return IRQ >= 0
+ * failure: return < 0
+ */
 static int
 acpi_pci_irq_derive (
 	struct pci_dev		*dev,
@@ -277,7 +287,7 @@
 	int			*active_high_low)
 {
 	struct pci_dev		*bridge = dev;
-	int			irq = 0;
+	int			irq = -1;
 	u8			bridge_pin = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
@@ -289,7 +299,7 @@
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (!irq && bridge->bus->self) {
+	while (irq < 0 && bridge->bus->self) {
 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge = bridge->bus->self;
 
@@ -299,7 +309,7 @@
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 					"No interrupt pin configured for device %s\n", pci_name(bridge)));
-				return_VALUE(0);
+				return_VALUE(-1);
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin --;
@@ -310,9 +320,9 @@
 			pin, edge_level, active_high_low);
 	}
 
-	if (!irq) {
+	if (irq < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to derive IRQ for device %s\n", pci_name(dev)));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
@@ -321,6 +331,11 @@
 	return_VALUE(irq);
 }
 
+/*
+ * acpi_pci_irq_enable
+ * success: return 0
+ * failure: return < 0
+ */
 
 int
 acpi_pci_irq_enable (
@@ -358,20 +373,20 @@
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (!irq)
+	if (irq < 0)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (!irq) {
+	if (irq < 0) {
 		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq && (dev->irq <= 0xF)) {
+		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
-			return_VALUE(dev->irq);
+			return_VALUE(0);
 		}
 		else {
 			printk("\n");
@@ -388,5 +403,5 @@
 		(active_high_low == ACPI_ACTIVE_LOW) ? "low" : "high",
 		dev->irq);
 
-	return_VALUE(dev->irq);
+	return_VALUE(0);
 }
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-12-01 18:03:42 -08:00
+++ b/drivers/acpi/pci_link.c	2004-12-01 18:03:42 -08:00
@@ -577,6 +577,11 @@
 	return_VALUE(0);
 }
 
+/*
+ * acpi_pci_link_get_irq
+ * success: return IRQ >= 0
+ * failure: return -1
+ */
 
 int
 acpi_pci_link_get_irq (
@@ -594,27 +599,27 @@
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *) acpi_driver_data(device);
 	if (!link) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n", index));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (acpi_pci_link_allocate(link))
-		return_VALUE(0);
+		return_VALUE(-1);
 	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (edge_level) *edge_level = link->irq.edge_level;
-
To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-ALojQjjxiCuGMWSpHajY--

