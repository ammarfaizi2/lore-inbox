Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUHWTWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUHWTWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHWTVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:21:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267214AbUHWSgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:47 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860853494@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860852863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.11, 2004/08/04 08:37:35-04:00, dwmw2@shinybook.infradead.org

PCI quirks -- parisc. 

Remove pcibios_fixups[] from core code and declare the one fixup in
the same place it's implemented.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/parisc/kernel/pci.c |    9 ---------
 drivers/parisc/superio.c |    1 +
 2 files changed, 1 insertion(+), 9 deletions(-)


diff -Nru a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
--- a/arch/parisc/kernel/pci.c	2004-08-23 11:06:17 -07:00
+++ b/arch/parisc/kernel/pci.c	2004-08-23 11:06:17 -07:00
@@ -146,15 +146,6 @@
 	return str;
 }
 
-/* Used in drivers/pci/quirks.c */
-struct pci_fixup pcibios_fixups[] = { 
-#ifdef CONFIG_SUPERIO
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NS,	PCI_DEVICE_ID_NS_87415,	superio_fixup_pci },
-#endif
-	{ 0 }
-};
-
-
 /*
  * Called by pci_set_master() - a driver interface.
  *
diff -Nru a/drivers/parisc/superio.c b/drivers/parisc/superio.c
--- a/drivers/parisc/superio.c	2004-08-23 11:06:17 -07:00
+++ b/drivers/parisc/superio.c	2004-08-23 11:06:17 -07:00
@@ -480,6 +480,7 @@
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 	printk("PCI: Enabled native mode for NS87415 (pif=0x%x)\n", prog);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci);
 
 /* Because of a defect in Super I/O, all reads of the PCI DMA status 
  * registers, IDE status register and the IDE select register need to be 

