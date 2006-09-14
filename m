Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWINMef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWINMef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWINMef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:34:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30126 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751292AbWINMee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:34:34 -0400
Subject: [PATCH] v4l: Extend bttv and saa7134 to check for both AGP and PCI
	PCI failure case
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mchehab@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Sep 2006 13:58:14 +0100
Message-Id: <1158238694.21860.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We could go and work out if the target object is AGP or PCI but the
corner case of an Athlon 64 era box with PCI video is sufficiently
unusual it doesn't seem worth the extra work, at least until other cases
if any pop up.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c linux-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/bt8xx/bttv-cards.c	2006-09-13 11:57:33.000000000 +0100
@@ -4991,7 +4991,7 @@
 	int pcipci_fail = 0;
 	struct pci_dev *dev = NULL;
 
-	if (pci_pci_problems & PCIPCI_FAIL)
+	if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL)) 	/* should check if target is AGP */
 		pcipci_fail = 1;
 	if (pci_pci_problems & (PCIPCI_TRITON|PCIPCI_NATOMA|PCIPCI_VIAETBF))
 		triton1 = 1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c linux-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/saa7134/saa7134-core.c	2006-09-11 17:20:16.000000000 +0100
@@ -843,7 +843,7 @@
 			latency = 0x0A;
 		}
 #endif
-		if (pci_pci_problems & PCIPCI_FAIL) {
+		if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL)) {
 			printk(KERN_INFO "%s: quirk: this driver and your "
 					"chipset may not work together"
 					" in overlay mode.\n",dev->name);

