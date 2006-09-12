Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWILS3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWILS3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWILS3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:29:44 -0400
Received: from server6.greatnet.de ([83.133.96.26]:18320 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030340AbWILS3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:29:42 -0400
Message-ID: <4506FC9E.5030503@nachtwindheim.de>
Date: Tue, 12 Sep 2006 20:29:50 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] gvp11: Scsi_Cmnd to struct scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes the obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/gvp11.c devel/drivers/scsi/gvp11.c
--- linux-2.6/drivers/scsi/gvp11.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/gvp11.c	2006-09-12 19:56:49.000000000 +0200
@@ -47,7 +47,7 @@
     gvp11_xfer_mask = ints[1];
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned short cntr = GVP11_DMAC_INT_ENABLE;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -142,7 +142,7 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		      int status)
 {
     /* stop DMA */
@@ -341,7 +341,7 @@
     return num_gvp11;
 }
 
-static int gvp11_bus_reset(Scsi_Cmnd *cmd)
+static int gvp11_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 
diff -ruN linux-2.6/drivers/scsi/gvp11.h devel/drivers/scsi/gvp11.h
--- linux-2.6/drivers/scsi/gvp11.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/gvp11.h	2006-09-12 19:56:49.000000000 +0200
@@ -14,9 +14,9 @@
 int gvp11_detect(struct scsi_host_template *);
 int gvp11_release(struct Scsi_Host *);
 const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
+int wd33c93_queuecommand(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
+int wd33c93_abort(struct scsi_cmnd *);
+int wd33c93_reset(struct scsi_cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2


