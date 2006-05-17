Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWEQWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWEQWOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWEQWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:13:29 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17536 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751265AbWEQWMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:51 -0400
Message-Id: <20060517221411.300987000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:16 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wedgwood <cw@f00f.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/22] [PATCH] VIA quirk fixup, additional PCI IDs
Content-Disposition: inline; filename=PCI-VIA-quirk-fixup-additional-PCI-IDs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

An earlier commit (75cf7456dd87335f574dcd53c4ae616a2ad71a11) changed an
overly-zealous PCI quirk to only poke those VIA devices that need it.
However, some PCI devices were not included in what I hope is now the full
list.  Consequently we're failing to run the quirk on all machines which need
it, causing IRQ routing failures.

This should I hope correct this.

Thanks to Masoud Sharbiani <masouds@masoud.ir> for pointing this out
and testing the fix.

Signed-off-by: Chris Wedgwood <cw@f00f.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/pci/quirks.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.16.16.orig/drivers/pci/quirks.c
+++ linux-2.6.16.16/drivers/pci/quirks.c
@@ -631,6 +631,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  * non-x86 architectures (yes Via exists on PPC among other places),
  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
+ *
+ * Some of the on-chip devices are actually '586 devices' so they are
+ * listed here.
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
@@ -645,6 +648,10 @@ static void quirk_via_irq(struct pci_dev
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

--
