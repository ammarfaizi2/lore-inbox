Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWIYWRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWIYWRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWIYWRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:17:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24767 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751527AbWIYWRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:17:45 -0400
Subject: [PATCH] i2o: Switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markus.lidel@shadowconnect.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:42:25 +0100
Message-Id: <1159224145.11049.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safe ref-counted API for the bridge check

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/message/i2o/pci.c linux-2.6.18-mm1/drivers/message/i2o/pci.c
--- linux.vanilla-2.6.18-mm1/drivers/message/i2o/pci.c	2006-09-25 12:08:45.000000000 +0100
+++ linux-2.6.18-mm1/drivers/message/i2o/pci.c	2006-09-25 12:21:39.164397568 +0100
@@ -372,12 +372,13 @@
 		 * Expose the ship behind i960 for initialization, or it will
 		 * failed
 		 */
-		i960 =
-		    pci_find_slot(c->pdev->bus->number,
+		i960 = pci_get_slot(c->pdev->bus,
 				  PCI_DEVFN(PCI_SLOT(c->pdev->devfn), 0));
 
-		if (i960)
+		if (i960) {
 			pci_write_config_word(i960, 0x42, 0);
+			pci_dev_put(i960);
+		}
 
 		c->promise = 1;
 		c->limit_sectors = 1;

