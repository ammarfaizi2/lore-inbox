Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWEITPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEITPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWEITPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:15:07 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:22609 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750798AbWEITPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:15:06 -0400
Date: Tue, 9 May 2006 12:14:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: masouds@masoud.ir, jeff@garzik.org, gregkh@suse.de
Subject: [PATCH] VIA quirk fixup, additional PCI IDs
Message-ID: <20060509191455.GA27503@taniwha.stupidest.org>
References: <20060430162820.GA18666@masoud.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060430162820.GA18666@masoud.ir>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier commit (75cf7456dd87335f574dcd53c4ae616a2ad71a11) changed
an overly-zealous PCI quirk to only poke those VIA devices that need
it.  However, some PCI devices were not included in what I hope is now
the full list.

This should I hope correct this.

Thanks to Masoud Sharbiani <masouds@masoud.ir> for pointing this out
and testing the fix.


Signed-of-By: Chris Wedgwood <cw@f00f.org>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 19e2b17..0d36d50 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -634,6 +634,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  * non-x86 architectures (yes Via exists on PPC among other places),
  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
+ *
+ * Some of the on-chip devices are actually '586 devices' so they are
+ * listed here.
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
@@ -648,6 +651,10 @@ static void quirk_via_irq(struct pci_dev
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
