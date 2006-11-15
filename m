Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWKOQQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWKOQQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030638AbWKOQQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:16:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14012 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030633AbWKOQQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:16:13 -0500
Date: Wed, 15 Nov 2006 16:17:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_hpt366
Message-ID: <20061115161713.06a7972c@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More enablebits

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_hpt366.c linux-2.6.19-rc5-mm2/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_hpt366.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_hpt366.c	2006-11-15 13:51:13.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.5"
+#define DRV_VERSION	"0.5.1"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -222,9 +222,17 @@
 
 static int hpt36x_pre_reset(struct ata_port *ap)
 {
+	static const struct pci_bits hpt36x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
+
 	u8 ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
+	if (!pci_test_config_bits(pdev, &hpt36x_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	pci_read_config_byte(pdev, 0x5A, &ata66);
 	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
