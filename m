Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVJ0Tb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVJ0Tb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVJ0Tb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:31:27 -0400
Received: from fmr17.intel.com ([134.134.136.16]:1235 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932211AbVJ0Tb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:31:26 -0400
Subject: [patch 3/3] pci: use stored value of pin from pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
References: <20051027192603.488616000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Oct 2005 12:30:16 -0700
Message-Id: <1130441416.5996.26.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 27 Oct 2005 19:30:17.0586 (UTC) FILETIME=[DC971520:01C5DB2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (patch-interrupt-pin-pci)
Use the stored value of the interrupt pin rather than try to read
the config again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -567,7 +567,7 @@ pci_get_interrupt_pin(struct pci_dev *de
 {
 	u8 pin;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return -1;
 	pin--;

--
