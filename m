Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbTHaOFu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTHaOFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:05:50 -0400
Received: from havoc.gtf.org ([63.247.75.124]:15016 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262065AbTHaOFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:05:44 -0400
Date: Sun, 31 Aug 2003 10:05:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@parcelfarce.linux.theplanet.co.uk
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [bk patches] 2.4.x quick fixes
Message-ID: <20030831140543.GA4819@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4

This will update the following files:

 arch/i386/kernel/pci-irq.c |    1 +
 drivers/pci/pci.c          |    2 +-
 include/linux/pci.h        |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/31 1.1106)
   [BK] ignore auto-generated files lib/{crc32table.h,gen_crc32table}

<jgarzik@redhat.com> (03/08/31 1.1105)
   [PCI] fix export of pdev_set_mwi/pci_generic_prep_mwi
   
   Missed in recent PCI MWI change.

<jgarzik@redhat.com> (03/08/31 1.1104)
   [ia32] add PCI id for VIA irq router
   
   Noticed by Sebastian Reichelt.


diff -Nru a/arch/i386/kernel/pci-irq.c b/arch/i386/kernel/pci-irq.c
--- a/arch/i386/kernel/pci-irq.c	Sun Aug 31 09:57:19 2003
+++ b/arch/i386/kernel/pci-irq.c	Sun Aug 31 09:57:19 2003
@@ -610,6 +610,7 @@
 		case PCI_DEVICE_ID_VIA_82C586_0:
 		case PCI_DEVICE_ID_VIA_82C596:
 		case PCI_DEVICE_ID_VIA_82C686:
+		case PCI_DEVICE_ID_VIA_8231:
 		/* FIXME: add new ones for 8233/5 */
 			r->name = "VIA";
 			r->get = pirq_via_get;
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sun Aug 31 09:57:19 2003
+++ b/drivers/pci/pci.c	Sun Aug 31 09:57:19 2003
@@ -2151,7 +2151,7 @@
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
-EXPORT_SYMBOL(pdev_set_mwi);
+EXPORT_SYMBOL(pci_generic_prep_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sun Aug 31 09:57:19 2003
+++ b/include/linux/pci.h	Sun Aug 31 09:57:19 2003
@@ -628,7 +628,7 @@
 #define HAVE_PCI_SET_MWI
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
-int pdev_set_mwi(struct pci_dev *dev);
+int pci_generic_prep_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
