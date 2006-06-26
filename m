Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWFZPRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWFZPRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFZPRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:17:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60681 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932482AbWFZPRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:17:21 -0400
Date: Mon, 26 Jun 2006 17:17:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Erich Chen <erich@areca.com.tw>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/arcmsr/: cleanups
Message-ID: <20060626151719.GS23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- arcmsr_attr.c: #if 0 the unused arcmsr_free_sysfs_attr()
- arcmsr_hba.c: make the needlessly global arcmsr_iop_reset() static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/arcmsr/arcmsr_attr.c |    2 ++
 drivers/scsi/arcmsr/arcmsr_hba.c  |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17-mm2-full/drivers/scsi/arcmsr/arcmsr_attr.c.old	2006-06-26 01:43:40.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/scsi/arcmsr/arcmsr_attr.c	2006-06-26 01:44:00.000000000 +0200
@@ -171,12 +171,14 @@
 							&arcmsr_sysfs_message_transfer_attr);
 }
 
+#if 0
 void
 arcmsr_free_sysfs_attr(struct AdapterControlBlock *acb) {
 	struct Scsi_Host *host = acb->host;
 
 	sysfs_remove_bin_file(&host->shost_gendev.kobj, &arcmsr_sysfs_message_transfer_attr);
 }
+#endif  /*  0  */
 
 static ssize_t
 arcmsr_attr_host_driver_version(struct class_device *cdev, char *buf) {
--- linux-2.6.17-mm2-full/drivers/scsi/arcmsr/arcmsr_hba.c.old	2006-06-26 01:44:09.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/scsi/arcmsr/arcmsr_hba.c	2006-06-26 01:44:19.000000000 +0200
@@ -1357,7 +1357,7 @@
 	acb->acb_flags |= ACB_F_IOP_INITED;
 }
 
-void arcmsr_iop_reset(struct AdapterControlBlock *acb)
+static void arcmsr_iop_reset(struct AdapterControlBlock *acb)
 {
 	struct MessageUnit __iomem *reg = acb->pmu;
 	struct CommandControlBlock *ccb;

