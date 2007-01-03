Return-Path: <linux-kernel-owner+w=401wt.eu-S932173AbXACXJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXACXJ5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXACXJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:09:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1041 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932173AbXACXJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:09:33 -0500
Date: Thu, 4 Jan 2007 00:09:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ata/: make 4 functions static
Message-ID: <20070103230936.GR20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following needlessly global functions static:
- libata-core.c: ata_qc_complete_internal()
- libata-scsi.c: ata_scsi_qc_new()
- libata-scsi.c: ata_dump_status()
- libata-scsi.c: ata_to_sense_error()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-scsi.c |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.20-rc2-mm1/drivers/ata/libata-core.c.old	2007-01-03 23:06:04.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/ata/libata-core.c	2007-01-03 23:06:12.000000000 +0100
@@ -1160,7 +1160,7 @@
 		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
 }
 
-void ata_qc_complete_internal(struct ata_queued_cmd *qc)
+static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
 	struct completion *waiting = qc->private_data;
 
--- linux-2.6.20-rc2-mm1/drivers/ata/libata-scsi.c.old	2007-01-03 23:06:35.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/ata/libata-scsi.c	2007-01-03 23:07:52.000000000 +0100
@@ -397,9 +397,9 @@
  *	RETURNS:
  *	Command allocated, or %NULL if none available.
  */
-struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
-				       struct scsi_cmnd *cmd,
-				       void (*done)(struct scsi_cmnd *))
+static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
+					      struct scsi_cmnd *cmd,
+					      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_queued_cmd *qc;
 
@@ -435,7 +435,7 @@
  *	LOCKING:
  *	inherited from caller
  */
-void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 {
 	u8 stat = tf->command, err = tf->feature;
 
@@ -610,8 +610,8 @@
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
-			u8 *ascq, int verbose)
+static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
+			       u8 *asc, u8 *ascq, int verbose)
 {
 	int i;
 

