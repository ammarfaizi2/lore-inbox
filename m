Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVKTXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVKTXFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKTXFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:05:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27920 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932104AbVKTXFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:05:22 -0500
Date: Mon, 21 Nov 2005 00:05:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/pci/hotplug/cpqphp_ctrl.c: remove dead code
Message-ID: <20051120230521.GC16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted that we already did return -ENOMEM
if (!p_mem_node).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/hotplug/cpqphp_ctrl.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/pci/hotplug/cpqphp_ctrl.c.old	2005-11-20 22:43:44.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/pci/hotplug/cpqphp_ctrl.c	2005-11-20 22:44:58.000000000 +0100
@@ -2630,29 +2630,15 @@
 			hold_mem_node = NULL;
 		}
 
-		/* If we have prefetchable memory resources copy them and 
-		 * fill in the bridge's memory range registers.  Otherwise,
-		 * fill in the range registers with values that disable them. */
-		if (p_mem_node) {
-			memcpy(hold_p_mem_node, p_mem_node, sizeof(struct pci_resource));
-			p_mem_node->next = NULL;
-
-			/* set Pre Mem base and Limit registers */
-			temp_word = p_mem_node->base >> 16;
-			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
+		memcpy(hold_p_mem_node, p_mem_node, sizeof(struct pci_resource));
+		p_mem_node->next = NULL;
 
-			temp_word = (p_mem_node->base + p_mem_node->length - 1) >> 16;
-			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
-		} else {
-			temp_word = 0xFFFF;
-			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
-
-			temp_word = 0x0000;
-			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
+		/* set Pre Mem base and Limit registers */
+		temp_word = p_mem_node->base >> 16;
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
 
-			kfree(hold_p_mem_node);
-			hold_p_mem_node = NULL;
-		}
+		temp_word = (p_mem_node->base + p_mem_node->length - 1) >> 16;
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
 
 		/* Adjust this to compensate for extra adjustment in first loop */
 		irqs.barber_pole--;

