Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWEQWN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWEQWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWEQWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:13:27 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55939 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751236AbWEQWM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:57 -0400
Message-Id: <20060517221410.395051000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/22] [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
Content-Disposition: inline; filename=PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
on my system which has no VIA southbridge (but I do have a VIA IEEE
1394 device).

This should address that.  I also changed "Via IRQ" to "VIA IRQ"
(initially I read Via as a capitalized via (by way/means of).

Signed-off-by: Chris Wedgwood <cw@f00f.org>
Acked-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/pci/quirks.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.16.16.orig/drivers/pci/quirks.c
+++ linux-2.6.16.16/drivers/pci/quirks.c
@@ -639,13 +639,15 @@ static void quirk_via_irq(struct pci_dev
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

--
