Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVAKXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVAKXYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAKXWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:22:21 -0500
Received: from coderock.org ([193.77.147.115]:15045 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262899AbVAKXRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:17:52 -0500
Subject: [patch 3/3] Replace pci_find_device with pci_dev_present
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       domen@coderock.org, hannal@us.ibm.com, janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:17:43 +0100
Message-Id: <20050111231743.A07031F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




The dev returned from pci_find_device was not used so it can be replaced
with pci_dev_present. Has been compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/pci/alim15x3.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/ide/pci/alim15x3.c~pci_dev_present-drivers_ide_pci_alim15x3 drivers/ide/pci/alim15x3.c
--- kj/drivers/ide/pci/alim15x3.c~pci_dev_present-drivers_ide_pci_alim15x3	2005-01-10 18:00:15.000000000 +0100
+++ kj-domen/drivers/ide/pci/alim15x3.c	2005-01-10 18:00:15.000000000 +0100
@@ -876,9 +876,14 @@ static ide_pci_device_t ali15x3_chipset 
  
 static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	static struct pci_device_id ati_rs100[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100) },
+		{ },
+	};
+
 	ide_pci_device_t *d = &ali15x3_chipset;
 
-	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100, NULL))
+	if(pci_dev_present(ati_rs100))
 		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
 #if defined(CONFIG_SPARC64)
_
