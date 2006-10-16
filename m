Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWJPP00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWJPP00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWJPP00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:26:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4753 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422632AbWJPP0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:26:22 -0400
Subject: [PATCH] ide: complete switch to pci_get
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:53:11 +0100
Message-Id: <1161013992.24237.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reverse get function allows the final piece of the switching for the
old IDE layer

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/ide/setup-pci.c linux-2.6.19-rc1-mm1/drivers/ide/setup-pci.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/ide/setup-pci.c	2006-10-13 15:09:30.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/ide/setup-pci.c	2006-10-13 17:19:44.000000000 +0100
@@ -844,11 +844,11 @@
 
 	pre_init = 0;
 	if (!scan_direction) {
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 			ide_scan_pcidev(dev);
 		}
 	} else {
-		while ((dev = pci_find_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		while ((dev = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 			ide_scan_pcidev(dev);
 		}
 	}

