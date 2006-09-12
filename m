Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWILS1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWILS1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWILS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:27:49 -0400
Received: from server6.greatnet.de ([83.133.96.26]:14992 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030342AbWILS1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:27:47 -0400
Message-ID: <4506FC28.20401@nachtwindheim.de>
Date: Tue, 12 Sep 2006 20:27:52 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] a3000: Scsi_Cmnd to struct scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd .
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/a3000.c devel/drivers/scsi/a3000.c
--- linux-2.6/drivers/scsi/a3000.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a3000.c	2006-09-12 19:40:36.000000000 +0200
@@ -44,7 +44,7 @@
 	return IRQ_NONE;
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -110,7 +110,7 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		      int status)
 {
     /* disable SCSI interrupts */
@@ -205,7 +205,7 @@
     return 0;
 }
 
-static int a3000_bus_reset(Scsi_Cmnd *cmd)
+static int a3000_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 	
diff -ruN linux-2.6/drivers/scsi/a3000.h devel/drivers/scsi/a3000.h
--- linux-2.6/drivers/scsi/a3000.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a3000.h	2006-09-12 19:39:46.000000000 +0200
@@ -14,9 +14,9 @@
 int a3000_detect(struct scsi_host_template *);
 int a3000_release(struct Scsi_Host *);
 const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
+int wd33c93_queuecommand(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
+int wd33c93_abort(struct scsi_cmnd *);
+int wd33c93_reset(struct scsi_cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2


