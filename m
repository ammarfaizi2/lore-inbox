Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVKSVeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVKSVeY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVKSVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:34:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:1982 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750839AbVKSVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:34:24 -0500
Subject: PATCH: Fix opti pci enable bits as with the AMD bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 22:06:28 +0000
Message-Id: <1132437988.19692.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.14-mm2/drivers/scsi/pata_opti.c linux-2.6.14-mm2/drivers/scsi/pata_opti.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_opti.c	2005-11-19 17:28:03.000000000 +0000
+++ linux-2.6.14-mm2/drivers/scsi/pata_opti.c	2005-11-19 17:34:54.000000000 +0000
@@ -52,8 +52,8 @@
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	static const struct pci_bits opti_enable_bits[] = {
-		{ 0x45, 0x80, 0x00 },
-		{ 0x45, 0x08, 0x00 }
+		{ 0x45, 1, 0x80, 0x00 },
+		{ 0x45, 1, 0x08, 0x00 }
 	};
 
 	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->hard_port_no])) {

