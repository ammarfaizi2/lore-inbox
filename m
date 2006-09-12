Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWILSbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWILSbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWILSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:31:13 -0400
Received: from server6.greatnet.de ([83.133.96.26]:20112 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030309AbWILSbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:31:12 -0400
Message-ID: <4506FCEE.1070209@nachtwindheim.de>
Date: Tue, 12 Sep 2006 20:31:10 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mvme147: Scsi_Cmnd to struct scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/mvme147.c devel/drivers/scsi/mvme147.c
--- linux-2.6/drivers/scsi/mvme147.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/mvme147.c	2006-09-12 20:13:20.000000000 +0200
@@ -29,7 +29,7 @@
     return IRQ_HANDLED;
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned char flags = 0x01;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -57,7 +57,7 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		      int status)
 {
     m147_pcc->dma_cntrl = 0;
@@ -112,7 +112,7 @@
     return 0;
 }
 
-static int mvme147_bus_reset(Scsi_Cmnd *cmd)
+static int mvme147_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 
diff -ruN linux-2.6/drivers/scsi/mvme147.h devel/drivers/scsi/mvme147.h
--- linux-2.6/drivers/scsi/mvme147.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/mvme147.h	2006-09-12 20:10:18.000000000 +0200
@@ -13,9 +13,9 @@
 int mvme147_detect(struct scsi_host_template *);
 int mvme147_release(struct Scsi_Host *);
 const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
+int wd33c93_queuecommand(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
+int wd33c93_abort(struct scsi_cmnd *);
+int wd33c93_reset(struct scsi_cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2


