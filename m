Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWDSG5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWDSG5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWDSG5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:57:14 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:7591 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750824AbWDSG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:57:13 -0400
Date: Tue, 18 Apr 2006 23:57:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
Message-ID: <20060419065709.GA8075@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
on my system which has no VIA southbridge (but I do have a VIA IEEE
1394 device).

This should address that.  I also changed "Via IRQ" to "VIA IRQ"
(initially I read Via as a capitalized via (by way/means of).


Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 827550d..59a9e21 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -642,13 +642,15 @@ static void quirk_via_irq(struct pci_dev
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
+		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
