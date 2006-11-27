Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758381AbWK0QjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbWK0QjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758382AbWK0QjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:39:25 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16849 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758380AbWK0QjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:39:24 -0500
Date: Mon, 27 Nov 2006 16:37:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_marvell: merge Mandriva patches
Message-ID: <20061127163752.7acbc377@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct and complete the Marvell PATA cable detection logic.

From: Arnaud Patard <apatard@mandriva.com>
Signed-off-by: Arnaud Patard <apatard@mandriva.com>
Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_marvell.c linux-2.6.19-rc6-mm1/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_marvell.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_marvell.c	2006-11-24 14:31:46.000000000 +0000
@@ -57,11 +57,11 @@
 	switch(ap->port_no)
 	{
 	case 0:
-		/* Might be backward, docs unclear */
 		if (inb(ap->ioaddr.bmdma_addr + 1) & 1)
-			ap->cbl = ATA_CBL_PATA80;
-		else
 			ap->cbl = ATA_CBL_PATA40;
+		else
+			ap->cbl = ATA_CBL_PATA80;
+		break;
 
 	case 1: /* Legacy SATA port */
 		ap->cbl = ATA_CBL_SATA;
