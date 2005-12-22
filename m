Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVLVExK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVLVExK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVLVEwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:52:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38608 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965100AbVLVEwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:52:00 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 35/36] m68k: NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQp-0004uA-PY@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135012281 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/mac/iop.c             |    4 ++--
 drivers/macintosh/adb-iop.c     |    2 +-
 drivers/macintosh/via-macii.c   |    4 ++--
 drivers/macintosh/via-maciisi.c |    4 ++--
 drivers/macintosh/via-pmu68k.c  |    4 ++--
 drivers/net/hplance.c           |    2 +-
 drivers/net/sun3lance.c         |    2 +-
 drivers/scsi/wd33c93.c          |    4 ++--
 include/asm-m68k/floppy.h       |    2 +-
 include/asm-m68k/sun3xflop.h    |    4 ++--
 10 files changed, 16 insertions(+), 16 deletions(-)

37cfae2a15e5ec5cf884b8b03798e9c1a1f89996
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index d889ba8..9179a37 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -293,8 +293,8 @@ void __init iop_init(void)
 	}
 
 	for (i = 0 ; i < NUM_IOP_CHAN ; i++) {
-		iop_send_queue[IOP_NUM_SCC][i] = 0;
-		iop_send_queue[IOP_NUM_ISM][i] = 0;
+		iop_send_queue[IOP_NUM_SCC][i] = NULL;
+		iop_send_queue[IOP_NUM_ISM][i] = NULL;
 		iop_listeners[IOP_NUM_SCC][i].devname = NULL;
 		iop_listeners[IOP_NUM_SCC][i].handler = NULL;
 		iop_listeners[IOP_NUM_ISM][i].devname = NULL;
diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 71aeb91..d56d400 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -239,7 +239,7 @@ static int adb_iop_write(struct adb_requ
 
 	local_irq_save(flags);
 
-	req->next = 0;
+	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	req->reply_len = 0;
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index e9a159a..2a2ffe0 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -260,7 +260,7 @@ static int macii_write(struct adb_reques
 		return -EINVAL;
 	}
 	
-	req->next = 0;
+	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	req->reply_len = 0;
@@ -295,7 +295,7 @@ static void macii_poll(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (via[IFR] & SR_INT) macii_interrupt(0, 0, 0);
+	if (via[IFR] & SR_INT) macii_interrupt(0, NULL, NULL);
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/macintosh/via-maciisi.c b/drivers/macintosh/via-maciisi.c
index ad271e7..0129fcc 100644
--- a/drivers/macintosh/via-maciisi.c
+++ b/drivers/macintosh/via-maciisi.c
@@ -326,7 +326,7 @@ maciisi_write(struct adb_request* req)
 		req->complete = 1;
 		return -EINVAL;
 	}
-	req->next = 0;
+	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	req->reply_len = 0;
@@ -421,7 +421,7 @@ maciisi_poll(void)
 
 	local_irq_save(flags);
 	if (via[IFR] & SR_INT) {
-		maciisi_interrupt(0, 0, 0);
+		maciisi_interrupt(0, NULL, NULL);
 	}
 	else /* avoid calling this function too quickly in a loop */
 		udelay(ADB_DELAY);
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index 6f80d76..f08e52f 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -493,7 +493,7 @@ pmu_queue_request(struct adb_request *re
 		return -EINVAL;
 	}
 
-	req->next = 0;
+	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	local_irq_save(flags);
@@ -717,7 +717,7 @@ pmu_handle_data(unsigned char *data, int
 				printk(KERN_ERR "PMU: extra ADB reply\n");
 				return;
 			}
-			req_awaiting_reply = 0;
+			req_awaiting_reply = NULL;
 			if (len <= 2)
 				req->reply_len = 0;
 			else {
diff --git a/drivers/net/hplance.c b/drivers/net/hplance.c
index 08703d6..d841063 100644
--- a/drivers/net/hplance.c
+++ b/drivers/net/hplance.c
@@ -150,7 +150,7 @@ static void __init hplance_init(struct n
         lp->lance.name = (char*)d->name;                /* discards const, shut up gcc */
         lp->lance.base = va;
         lp->lance.init_block = (struct lance_init_block *)(va + HPLANCE_MEMOFF); /* CPU addr */
-        lp->lance.lance_init_block = 0;                 /* LANCE addr of same RAM */
+        lp->lance.lance_init_block = NULL;              /* LANCE addr of same RAM */
         lp->lance.busmaster_regval = LE_C3_BSWP;        /* we're bigendian */
         lp->lance.irq = d->ipl;
         lp->lance.writerap = hplance_writerap;
diff --git a/drivers/net/sun3lance.c b/drivers/net/sun3lance.c
index 5c8fcd4..01bdb23 100644
--- a/drivers/net/sun3lance.c
+++ b/drivers/net/sun3lance.c
@@ -389,7 +389,7 @@ static int __init lance_probe( struct ne
 	dev->stop = &lance_close;
 	dev->get_stats = &lance_get_stats;
 	dev->set_multicast_list = &set_multicast_list;
-	dev->set_mac_address = 0;
+	dev->set_mac_address = NULL;
 //	KLUDGE -- REMOVE ME
 	set_bit(__LINK_STATE_PRESENT, &dev->state);
 
diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index fd63add..fb53eea 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -465,7 +465,7 @@ wd33c93_execute(struct Scsi_Host *instan
 	 */
 
 	cmd = (struct scsi_cmnd *) hostdata->input_Q;
-	prev = 0;
+	prev = NULL;
 	while (cmd) {
 		if (!(hostdata->busy[cmd->device->id] & (1 << cmd->device->lun)))
 			break;
@@ -1569,7 +1569,7 @@ wd33c93_abort(struct scsi_cmnd * cmd)
  */
 
 	tmp = (struct scsi_cmnd *) hostdata->input_Q;
-	prev = 0;
+	prev = NULL;
 	while (tmp) {
 		if (tmp == cmd) {
 			if (prev)
diff --git a/include/asm-m68k/floppy.h b/include/asm-m68k/floppy.h
index c6e708d..63a05ed 100644
--- a/include/asm-m68k/floppy.h
+++ b/include/asm-m68k/floppy.h
@@ -46,7 +46,7 @@ asmlinkage irqreturn_t floppy_hardint(in
 
 static int virtual_dma_count=0;
 static int virtual_dma_residue=0;
-static char *virtual_dma_addr=0;
+static char *virtual_dma_addr=NULL;
 static int virtual_dma_mode=0;
 static int doing_pdma=0;
 
diff --git a/include/asm-m68k/sun3xflop.h b/include/asm-m68k/sun3xflop.h
index fda1ecc..98a9f79 100644
--- a/include/asm-m68k/sun3xflop.h
+++ b/include/asm-m68k/sun3xflop.h
@@ -208,7 +208,7 @@ static int sun3xflop_request_irq(void)
 
 	if(!once) {
 		once = 1;
-		error = request_irq(FLOPPY_IRQ, sun3xflop_hardint, SA_INTERRUPT, "floppy", 0);
+		error = request_irq(FLOPPY_IRQ, sun3xflop_hardint, SA_INTERRUPT, "floppy", NULL);
 		return ((error == 0) ? 0 : -1);
 	} else return 0;
 }
@@ -238,7 +238,7 @@ static int sun3xflop_init(void)
 	*sun3x_fdc.fcr_r = 0;
 
 	/* Success... */
-	floppy_set_flags(0, 1, FD_BROKEN_DCL); // I don't know how to detect this.
+	floppy_set_flags(NULL, 1, FD_BROKEN_DCL); // I don't know how to detect this.
 	allowed_drive_mask = 0x01;
 	return (int) SUN3X_FDC;
 }
-- 
0.99.9.GIT

