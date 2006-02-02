Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWBBVUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWBBVUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBBVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:20:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:59367 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751195AbWBBVUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:20:13 -0500
Date: Thu, 2 Feb 2006 16:20:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata: sata_mv MSI workaround
Message-ID: <20060202212011.GA18990@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_mv.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

Jeff Garzik:
      [libata sata_mv] do not enable PCI MSI by default

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index cd54244..6fddf17 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -510,6 +510,12 @@ static const struct mv_hw_ops mv6xxx_ops
 };
 
 /*
+ * module options
+ */
+static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
+
+
+/*
  * Functions
  */
 
@@ -2191,7 +2197,7 @@ static int mv_init_one(struct pci_dev *p
 	}
 
 	/* Enable interrupts */
-	if (pci_enable_msi(pdev) == 0) {
+	if (msi && pci_enable_msi(pdev) == 0) {
 		hpriv->hp_flags |= MV_HP_FLAG_MSI;
 	} else {
 		pci_intx(pdev, 1);
@@ -2246,5 +2252,8 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+module_param(msi, int, 0444);
+MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
+
 module_init(mv_init);
 module_exit(mv_exit);
