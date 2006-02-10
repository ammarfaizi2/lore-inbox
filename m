Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWBJLMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWBJLMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBJLMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:12:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5131 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750894AbWBJLMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:12:19 -0500
Date: Fri, 10 Feb 2006 12:12:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/libata-scsi.c: make some functions static
Message-ID: <20060210111217.GB19918@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlesly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Jan 2006

 drivers/scsi/libata-scsi.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/libata-scsi.c.old	2005-11-20 03:06:38.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/libata-scsi.c	2005-11-20 03:08:34.000000000 +0100
@@ -325,10 +325,10 @@
  *	RETURNS:
  *	Command allocated, or %NULL if none available.
  */
-struct ata_queued_cmd *ata_scsi_qc_new(struct ata_port *ap,
-				       struct ata_device *dev,
-				       struct scsi_cmnd *cmd,
-				       void (*done)(struct scsi_cmnd *))
+static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_port *ap,
+					      struct ata_device *dev,
+					      struct scsi_cmnd *cmd,
+					      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_queued_cmd *qc;
 
@@ -364,7 +364,7 @@
  *	LOCKING:
  *	inherited from caller
  */
-void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
 {
 	u8 stat = tf->command, err = tf->feature;
 
@@ -413,8 +413,8 @@
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
-			u8 *ascq)
+static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err,
+			       u8 *sk, u8 *asc, u8 *ascq)
 {
 	int i;
 
@@ -524,7 +524,7 @@
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
+static void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
@@ -600,7 +600,7 @@
  *	LOCKING:
  *	inherited from caller
  */
-void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+static void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;

