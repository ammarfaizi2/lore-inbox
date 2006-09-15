Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWIOOFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWIOOFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIOOFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:05:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8106 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751482AbWIOOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:05:55 -0400
Subject: [PATCH] s2io: Switch to pci_get_device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: raghavendra.koushik@neterion.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:22:51 +0100
Message-Id: <1158330171.29932.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We want the pci devices ref counted against hotplug.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/net/s2io.c linux-2.6.18-rc6-mm1/drivers/net/s2io.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/net/s2io.c	2006-09-11 17:00:15.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/net/s2io.c	2006-09-14 16:46:11.000000000 +0100
@@ -855,9 +855,10 @@
 static int s2io_on_nec_bridge(struct pci_dev *s2io_pdev)
 {
 	struct pci_dev *tdev = NULL;
-	while ((tdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, tdev)) != NULL) {
-		if ((tdev->vendor == NEC_VENID) && (tdev->device == NEC_DEVID)){
+	while ((tdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tdev)) != NULL) {
+		if (tdev->vendor == NEC_VENID && tdev->device == NEC_DEVID) {
 			if (tdev->bus == s2io_pdev->bus->parent)
+				pci_dev_put(tdev);
 				return 1;
 		}
 	}

