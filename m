Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbREVNka>; Tue, 22 May 2001 09:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbREVNkT>; Tue, 22 May 2001 09:40:19 -0400
Received: from ns.caldera.de ([212.34.180.1]:6824 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261706AbREVNkQ>;
	Tue, 22 May 2001 09:40:16 -0400
Date: Tue, 22 May 2001 15:39:27 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: gibbs@freebsd.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: aic7xxx patches?
Message-ID: <20010522153926.A26867@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin, Alan, linux-kernel,

I do not know who is the right contact for AIC7xxx patches, so I am just
ccing everone ;)

This patch just exports the PCI id table from aic7xxx so autoprobing and
hotplugging can find it.

Whoever maintains aic7xxx, please consider applying :)

Ciao, Marcus

Index: drivers/scsi/aic7xxx/aic7xxx_linux_pci.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c,v
retrieving revision 1.7
diff -u -r1.7 aic7xxx_linux_pci.c
--- drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	2001/05/03 13:16:24	1.7
+++ drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	2001/05/22 13:26:28
@@ -42,9 +42,13 @@
 static int	ahc_linux_pci_dev_probe(struct pci_dev *pdev,
 					const struct pci_device_id *ent);
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+#include <linux/module.h>
+
 static void	ahc_linux_pci_dev_remove(struct pci_dev *pdev);
 
-/* We do our own ID filtering.  So, grab all SCSI storage class devices. */
+/* We do our own ID filtering.  So we grab all Adaptec SCSI storage class
+ * devices here.
+ */
 static struct pci_device_id ahc_linux_pci_id_table[] = {
 	{
 		0x9004, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -56,6 +60,7 @@
 	},
 	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci,ahc_linux_pci_id_table);
 
 struct pci_driver aic7xxx_pci_driver = {
 	name:		"aic7xxx",
