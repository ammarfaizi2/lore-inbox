Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVCFTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVCFTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVCFTA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 14:00:56 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:51436 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261476AbVCFTAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 14:00:51 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sun, 6 Mar 2005 20:00:46 +0100
To: vernux@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-mm1] acpiphp_ibm: add failure handling for memory allocation
Message-ID: <20050306190046.GA6992@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds failure handling for kmalloc in the ACPI PCI Hot Plug IBM
Extension driver.

Signed-off-by: <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/pci/hotplug/acpiphp_ibm.c linux-2.6.11-pi/drivers/pci/hotplug/acpiphp_ibm.c
--- linux-2.6.11-orig/drivers/pci/hotplug/acpiphp_ibm.c	2005-03-05 03:38:06.000000000 +0100
+++ linux-2.6.11-pi/drivers/pci/hotplug/acpiphp_ibm.c	2005-03-06 19:35:06.000000000 +0100
@@ -163,6 +163,11 @@ static union apci_descriptor *ibm_slot_f
 ibm_slot_done:
 	if (ret) {
 		ret = kmalloc(sizeof(union apci_descriptor), GFP_KERNEL);
+		if (!ret) {
+			err("%s:  Memory allocation failed.\n", __FUNCTION__);
+			kfree(table);
+			return -ENOMEM;
+		}
 		memcpy(ret, des, sizeof(union apci_descriptor));
 	}
 	kfree(table);
