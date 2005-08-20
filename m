Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbVHTTCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbVHTTCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbVHTTCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:02:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16395 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932785AbVHTTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:02:53 -0400
Date: Sat, 20 Aug 2005 21:02:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] drivers/ide/: possible cleanups
Message-ID: <20050820190251.GZ3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- pci/cy82c693.c: make a needlessly global function static
- remove the following unneeded EXPORT_SYMBOL's:
  - ide-taskfile.c: do_rw_taskfile
  - ide-iops.c: default_hwif_iops
  - ide-iops.c: default_hwif_transport
  - ide-iops.c: wait_for_ready

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-iops.c     |    6 ------
 drivers/ide/ide-taskfile.c |    2 --
 drivers/ide/pci/cy82c693.c |    2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/ide/ide-taskfile.c.old	2005-02-05 02:57:03.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/ide/ide-taskfile.c	2005-02-05 02:57:12.000000000 +0100
@@ -161,8 +161,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(do_rw_taskfile);
-
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */

--- linux-2.6.12-rc2-mm3-full/drivers/ide/pci/cy82c693.c.old	2005-04-17 21:11:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ide/pci/cy82c693.c	2005-04-17 21:11:30.000000000 +0200
@@ -469,7 +469,7 @@
 
 static __initdata ide_hwif_t *primary;
 
-void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
+static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	if (PCI_FUNC(hwif->pci_dev->devfn) == 1)
 		primary = hwif;
--- linux-2.6.12-rc2-mm3-full/drivers/ide/ide-iops.c.old	2005-04-17 21:12:44.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ide/ide-iops.c	2005-04-17 21:12:54.000000000 +0200
@@ -104,8 +104,6 @@
 	hwif->INSL	= ide_insl;
 }
 
-EXPORT_SYMBOL(default_hwif_iops);
-
 /*
  *	MMIO operations, typically used for SATA controllers
  */
@@ -329,8 +327,6 @@
 	hwif->atapi_output_bytes	= atapi_output_bytes;
 }
 
-EXPORT_SYMBOL(default_hwif_transport);
-
 /*
  * Beginning of Taskfile OPCODE Library and feature sets.
  */
@@ -525,8 +525,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(wait_for_ready);
-
 /*
  * This routine busy-waits for the drive status to be not "busy".
  * It then checks the status for all of the "good" bits and none

