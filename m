Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVKVFTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVKVFTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKVFTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:19:40 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:38080 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932281AbVKVFTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:19:22 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/5] Initialise pci_dev->irq correctly
Message-Id: <E1EeQYg-00055v-SX@localhost.localdomain>
Date: Tue, 22 Nov 2005 00:19:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the Interrupt Pin is 0, initialise the device's irq to NO_IRQ instead of
leaving it unset.

Signed-off-by: Matthew Wlcox <matthew@wil.cx>

---

 drivers/pci/probe.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

applies-to: 3175f6d926ef8ff55ee1fd96364d5b3ed430fb38
4ec4e15bcdd7401cf1fb19ef1cd4f64eb064a4c7
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fce2cb2..652095c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -571,9 +571,12 @@ static void pci_read_irq(struct pci_dev 
 	unsigned char irq;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
-	if (irq)
+	if (irq) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	dev->irq = irq;
+		dev->irq = irq;
+	} else {
+		dev->irq = NO_IRQ;
+	}
 }
 
 /**
---
0.99.8.GIT
