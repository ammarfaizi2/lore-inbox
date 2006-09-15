Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWIONuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWIONuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWIONuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:50:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45769 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751450AbWIONuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:50:54 -0400
Subject: [PATCH] piix: Use refcounted interface when searching for a 450NX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:14:38 +0100
Message-Id: <1158329678.29932.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple conversion

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-14 17:19:12.000000000 +0100
@@ -602,7 +602,7 @@
 	struct pci_dev *pdev = NULL;
 	u16 cfg;
 	u8 rev;
-	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
+	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
 	{
 		/* Look for 450NX PXB. Check for problem configurations
 		   A PCI quirk checks bit 6 already */

