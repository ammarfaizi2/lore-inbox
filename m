Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUHCTug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUHCTug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCTug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:50:36 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:23455 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266820AbUHCTuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:50:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] idt77252.c: add missing pci_enable_device()
Date: Tue, 3 Aug 2004 13:50:21 -0600
User-Agent: KMail/1.6.2
Cc: ecd@atecom.com, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031350.21349.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci_enable_device().  In the past, drivers often worked without
this, but it is now required in order to route PCI interrupts correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/atm/idt77252.c 1.24 vs edited =====
--- 1.24/drivers/atm/idt77252.c	2004-07-12 02:01:05 -06:00
+++ edited/drivers/atm/idt77252.c	2004-07-30 13:45:42 -06:00
@@ -3684,6 +3684,11 @@
 	int i;
 
 
+	if (pci_enable_device(pcidev)) {
+		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
+		return -ENODEV;
+	}
+
 	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
 		printk("idt77252-%d: can't read PCI_REVISION_ID\n", index);
 		return -ENODEV;
