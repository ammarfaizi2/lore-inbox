Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbUKYErC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUKYErC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 23:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUKYErC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 23:47:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16648 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262964AbUKYEq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 23:46:57 -0500
Date: Wed, 24 Nov 2004 19:46:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI 53c700.c: make NCR_700_intr static (fwd)
Message-ID: <20041124184649.GF19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply or comment of it's incorrect.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date: Mon, 15 Nov 2004 02:47:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org
Subject: [2.6 patch] SCSI 53c700.c: make NCR_700_intr static

NCR_700_intr is EXPORT_SYMBOL'e but has no external users.

Is the patch below correct or is future external usage planned?


diffstat output:
 drivers/scsi/53c700.c |    4 ++--
 drivers/scsi/53c700.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/53c700.h.old	2004-11-13 16:05:17.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/53c700.h	2004-11-13 16:19:50.000000000 +0100
@@ -63,7 +63,6 @@
 		struct NCR_700_Host_Parameters *, struct device *,
 		unsigned long, u8);
 int NCR_700_release(struct Scsi_Host *host);
-irqreturn_t NCR_700_intr(int, void *, struct pt_regs *);
 
 
 enum NCR_700_Host_State {
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/53c700.c.old	2004-11-13 16:19:58.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/53c700.c	2004-11-13 16:22:42.000000000 +0100
@@ -167,6 +167,7 @@
 #include "53c700_d.h"
 
 
+STATIC irqreturn_t NCR_700_intr(int irq, void *dev_id, struct pt_regs *regs);
 STATIC int NCR_700_queuecommand(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
 STATIC int NCR_700_abort(struct scsi_cmnd * SCpnt);
 STATIC int NCR_700_bus_reset(struct scsi_cmnd * SCpnt);
@@ -1486,7 +1487,7 @@
 	return 1;
 }
 
-irqreturn_t
+STATIC irqreturn_t
 NCR_700_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct Scsi_Host *host = (struct Scsi_Host *)dev_id;
@@ -2148,7 +2149,6 @@
 
 EXPORT_SYMBOL(NCR_700_detect);
 EXPORT_SYMBOL(NCR_700_release);
-EXPORT_SYMBOL(NCR_700_intr);
 
 static struct spi_function_template NCR_700_transport_functions =  {
 	.set_period	= NCR_700_set_period,


----- End forwarded message -----

