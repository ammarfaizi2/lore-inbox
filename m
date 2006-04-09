Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDITxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDITxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWDITxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:53:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750807AbWDITxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:53:34 -0400
Date: Sun, 9 Apr 2006 21:53:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [2.6 patch] remove the obsolete IDEPCI_FLAG_FORCE_PDC
Message-ID: <20060409195333.GL8454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the obsolete IDEPCI_FLAG_FORCE_PDC.

Noted by Sergei Shtylylov <sshtylyov@ru.mvista.com>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---

This patch was already sent on:
- 7 Apr 2006

 drivers/ide/pci/pdc202xx_old.c |    2 --
 drivers/ide/setup-pci.c        |   13 -------------
 include/linux/ide.h            |    1 -
 3 files changed, 16 deletions(-)

--- linux-2.6.17-rc1-mm1-full/include/linux/ide.h.old	2006-04-07 00:51:49.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/include/linux/ide.h	2006-04-07 00:52:03.000000000 +0200
@@ -1221,7 +1221,6 @@
 enum {
 	/* Uses ISA control ports not PCI ones. */
 	IDEPCI_FLAG_ISA_PORTS		= (1 << 0),
-	IDEPCI_FLAG_FORCE_PDC		= (1 << 1),
 };
 
 typedef struct ide_pci_device_s {
--- linux-2.6.17-rc1-mm1-full/drivers/ide/pci/pdc202xx_old.c.old	2006-04-07 00:52:13.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/ide/pci/pdc202xx_old.c	2006-04-07 00:52:19.000000000 +0200
@@ -798,7 +798,6 @@
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 2 */
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
@@ -819,7 +818,6 @@
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 4 */
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
--- linux-2.6.17-rc1-mm1-full/drivers/ide/setup-pci.c.old	2006-04-07 00:52:27.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/ide/setup-pci.c	2006-04-07 00:54:28.000000000 +0200
@@ -580,7 +580,6 @@
 	int port;
 	int at_least_one_hwif_enabled = 0;
 	ide_hwif_t *hwif, *mate = NULL;
-	static int secondpdc = 0;
 	u8 tmp;
 
 	index->all = 0xf0f0;
@@ -592,21 +591,9 @@
 	for (port = 0; port <= 1; ++port) {
 		ide_pci_enablebit_t *e = &(d->enablebits[port]);
 	
-		/* 
-		 * If this is a Promise FakeRaid controller,
-		 * the 2nd controller will be marked as 
-		 * disabled while it is actually there and enabled
-		 * by the bios for raid purposes. 
-		 * Skip the normal "is it enabled" test for those.
-		 */
-		if ((d->flags & IDEPCI_FLAG_FORCE_PDC) &&
-		    (secondpdc++==1) && (port==1))
-			goto controller_ok;
-			
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
 		    (tmp & e->mask) != e->val))
 			continue;	/* port not enabled */
-controller_ok:
 
 		if (d->channels	<= port)
 			break;

