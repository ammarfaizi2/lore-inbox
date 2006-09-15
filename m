Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWIONpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWIONpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWIONpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:45:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30148 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751445AbWIONpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:45:25 -0400
Subject: [PATCH] cs46xx OSS : switch to pci_get_device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:08:43 +0100
Message-Id: <1158329323.29932.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly trivial change in this case

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/sound/oss/cs46xx.c linux-2.6.18-rc6-mm1/sound/oss/cs46xx.c
--- linux.vanilla-2.6.18-rc6-mm1/sound/oss/cs46xx.c	2006-09-11 17:00:27.000000000 +0100
+++ linux-2.6.18-rc6-mm1/sound/oss/cs46xx.c	2006-09-14 17:30:26.000000000 +0100
@@ -2982,7 +2982,7 @@
 	
 	card->active+=change;
 	
-	acpi_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	acpi_dev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
 	if (acpi_dev == NULL)
 		return;		/* Not a thinkpad thats for sure */
 
@@ -3008,6 +3008,7 @@
 				change,card->active));
 		outw(control&~0x2000, port+0x10);
 	}
+	pci_dev_put(acpi_dev);
 }
 
 	

