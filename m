Return-Path: <linux-kernel-owner+w=401wt.eu-S965010AbWLMPzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWLMPzy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLMPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:55:54 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4539 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012AbWLMPzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:55:53 -0500
X-Greylist: delayed 4202 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 10:55:53 EST
Date: Wed, 13 Dec 2006 14:45:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Add support for Korenix 16C950-based PCI cards
Message-ID: <20061213144546.GA23951@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

This patch adds initial support to 8250-pci for the Korenix Jetcard PCI
serial cards.  The JC12xx cards are standard RS232-based serial cards
utilising the Oxford 16C950 device.

The JC14xx are RS422/RS485-based cards, but in order for these to be
supported natively, we will need additional tweaks to the 8250 layers
so we can specify some values for the 950's registers.  Hence, these
two entries are commented out.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

 drivers/serial/8250_pci.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 4d0ff8f..89c3f2c 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -2239,6 +2239,30 @@ static struct pci_device_id serial_pci_t
 		pbn_b0_bt_1_460800 },
 
 	/*
+	 * Korenix Jetcard F0/F1 cards (JC1204, JC1208, JC1404, JC1408).
+	 * Cards are identified by their subsystem vendor IDs, which
+	 * (in hex) match the model number.
+	 *
+	 * Note that JC140x are RS422/485 cards which require ox950
+	 * ACR = 0x10, and as such are not currently fully supported.
+	 */
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+		0x1204, 0x0004, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+		0x1208, 0x0004, 0, 0,
+		pbn_b0_4_921600 },
+/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+		0x1402, 0x0002, 0, 0,
+		pbn_b0_2_921600 }, */
+/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
+		0x1404, 0x0004, 0, 0,
+		pbn_b0_4_921600 }, */
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
+		0x1208, 0x0004, 0, 0,
+		pbn_b0_4_921600 },
+
+	/*
 	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
 	 */
 	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4,

