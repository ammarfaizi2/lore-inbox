Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWHGW4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWHGW4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHGW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:17 -0400
Received: from xenotime.net ([66.160.160.81]:25009 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750831AbWHGW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:16 -0400
Date: Mon, 7 Aug 2006 15:54:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jejb <james.bottomley@steeleye.com>,
       michaelc@cs.wisc.edu
Subject: [PATCH -mm 4/5] scsi-target: printk format warnings
Message-Id: <20060807155432.a7462087.rdunlap@xenotime.net>
In-Reply-To: <20060807155208.666d7ea3.rdunlap@xenotime.net>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807155044.a8eee456.rdunlap@xenotime.net>
	<20060807155208.666d7ea3.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
drivers/scsi/scsi_tgt_lib.c:96: warning: long unsigned int format, different type arg (arg 6)
drivers/scsi/scsi_tgt_lib.c:293: warning: long unsigned int format, different type arg (arg 5)
drivers/scsi/scsi_tgt_lib.c:305: warning: long unsigned int format, different type arg (arg 5)
drivers/scsi/scsi_tgt_lib.c:344: warning: long unsigned int format, different type arg (arg 7)
drivers/scsi/scsi_tgt_lib.c:553: warning: long unsigned int format, different type arg (arg 8

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/scsi_tgt_lib.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2618-rc3mm2.orig/drivers/scsi/scsi_tgt_lib.c
+++ linux-2618-rc3mm2/drivers/scsi/scsi_tgt_lib.c
@@ -93,7 +93,7 @@ static void scsi_tgt_cmd_destroy(void *d
 	struct scsi_tgt_queuedata *qdata = cmd->request->q->queuedata;
 	unsigned long flags;
 
-	dprintk("cmd %p %d %lu\n", cmd, cmd->sc_data_direction,
+	dprintk("cmd %p %d %u\n", cmd, cmd->sc_data_direction,
 		rq_data_dir(cmd->request));
 
 	spin_lock_irqsave(&qdata->cmd_hash_lock, flags);
@@ -290,7 +290,7 @@ static void scsi_tgt_cmd_done(struct scs
 {
 	struct scsi_tgt_cmd *tcmd = cmd->request->end_io_data;
 
-	dprintk("cmd %p %lu\n", cmd, rq_data_dir(cmd->request));
+	dprintk("cmd %p %u\n", cmd, rq_data_dir(cmd->request));
 
 	scsi_tgt_uspace_send_status(cmd, GFP_ATOMIC);
 	INIT_WORK(&tcmd->work, scsi_tgt_cmd_destroy, cmd);
@@ -302,7 +302,7 @@ static int __scsi_tgt_transfer_response(
 	struct Scsi_Host *shost = scsi_tgt_cmd_to_host(cmd);
 	int err;
 
-	dprintk("cmd %p %lu\n", cmd, rq_data_dir(cmd->request));
+	dprintk("cmd %p %u\n", cmd, rq_data_dir(cmd->request));
 
 	err = shost->hostt->transfer_response(cmd, scsi_tgt_cmd_done);
 	switch (err) {
@@ -341,7 +341,7 @@ static int scsi_tgt_init_cmd(struct scsi
 
 	cmd->request_bufflen = rq->data_len;
 
-	dprintk("cmd %p addr %p cnt %d %lu\n", cmd, tcmd->buffer, cmd->use_sg,
+	dprintk("cmd %p addr %p cnt %d %u\n", cmd, tcmd->buffer, cmd->use_sg,
 		rq_data_dir(rq));
 	count = blk_rq_map_sg(rq->q, rq, cmd->request_buffer);
 	if (likely(count <= cmd->use_sg)) {
@@ -550,7 +550,7 @@ int scsi_tgt_kspace_exec(int host_no, u3
 	}
 	cmd = rq->special;
 
-	dprintk("cmd %p result %d len %d bufflen %u %lu %x\n", cmd,
+	dprintk("cmd %p result %d len %d bufflen %u %u %x\n", cmd,
 		result, len, cmd->request_bufflen, rq_data_dir(rq), cmd->cmnd[0]);
 
 	if (result == TASK_ABORTED) {


---
