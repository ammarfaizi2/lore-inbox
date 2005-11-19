Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKSV0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKSV0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKSV0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:26:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38335 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750703AbVKSV0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:26:00 -0500
Subject: PATCH: AMD pata fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 21:58:14 +0000
Message-Id: <1132437495.19692.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to send you the pata file versions before I did the last fix
(forgot to rsync them back off a build box). This corrects the obvious
problem for the AMD driver and fixes drive detection.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.14-mm2/drivers/scsi/pata_amd.c linux-2.6.14-mm2/drivers/scsi/pata_amd.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_amd.c	2005-11-19 17:28:03.000000000 +0000
+++ linux-2.6.14-mm2/drivers/scsi/pata_amd.c	2005-11-19 17:34:37.000000000 +0000
@@ -148,8 +148,8 @@
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	static struct pci_bits amd_enable_bits[] = {
-		{ 0x40, 0x02, 0x02 },
-		{ 0x40, 0x01, 0x01 }
+		{ 0x40, 1, 0x02, 0x02 },
+		{ 0x40, 1, 0x01, 0x01 }
 	};
 
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->hard_port_no])) {

