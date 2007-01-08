Return-Path: <linux-kernel-owner+w=401wt.eu-S1751466AbXAHL5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbXAHL5c (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXAHL5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:57:32 -0500
Received: from [81.2.110.250] ([81.2.110.250]:60695 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751466AbXAHL5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:57:31 -0500
Date: Mon, 8 Jan 2007 12:07:25 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: Remove jmicron fixup
Message-ID: <20070108120725.5a9d63fa@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AHCI set up is handled properly along with the other bits in the
JMICRON quirk. Remove the code whacking it in ahci.c as its un-needed and
also blindly fiddles with bits it doesn't own.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/ahci.c linux-2.6.20-rc3-mm1/drivers/ata/ahci.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/ahci.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/ahci.c	2007-01-05 14:02:58.000000000 +0000
@@ -1659,13 +1659,9 @@
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	/* JMicron-specific fixup: make sure we're in AHCI mode */
-	/* This is protected from races with ata_jmicron by the pci probe
-	   locking */
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON) {
-		/* AHCI enable, AHCI on function 0 */
-		pci_write_config_byte(pdev, 0x41, 0xa1);
-		/* Function 1 is the PATA controller */
+		/* Function 1 is the PATA controller except on the 368, where
+		   we are not AHCI anyway */
 		if (PCI_FUNC(pdev->devfn))
 			return -ENODEV;
 	}
