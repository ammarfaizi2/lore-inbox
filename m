Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWIOOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWIOOEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWIOOEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:04:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7082 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751474AbWIOOEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:04:44 -0400
Subject: [PATCH] gt96100: move to pci_get_device API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, source@mvista.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:27:06 +0100
Message-Id: <1158330426.29932.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/net/gt96100eth.c linux-2.6.18-rc6-mm1/drivers/net/gt96100eth.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/net/gt96100eth.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/net/gt96100eth.c	2006-09-14 16:45:30.000000000 +0100
@@ -613,9 +613,9 @@
 	/*
 	 * Stupid probe because this really isn't a PCI device
 	 */
-	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
-	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
 		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
 		return -ENODEV;
@@ -630,6 +630,8 @@
 
 	for (i=0; i < NUM_INTERFACES; i++)
 		retval |= gt96100_probe1(pci, i);
+		
+	pci_dev_put(pci);
 
 	return retval;
 }

