Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWILVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWILVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWILVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:49:24 -0400
Received: from server6.greatnet.de ([83.133.96.26]:31663 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030286AbWILVtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:49:23 -0400
Message-ID: <45072B6D.7080201@nachtwindheim.de>
Date: Tue, 12 Sep 2006 23:49:33 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wd33c93-dependend drivers: Scsi_Cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/a2091.c devel/drivers/scsi/a2091.c
--- linux-2.6/drivers/scsi/a2091.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a2091.c	2006-09-12 23:32:47.000000000 +0200
@@ -40,7 +40,7 @@
     return IRQ_HANDLED;
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -115,7 +115,7 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt, 
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		      int status)
 {
     /* disable SCSI interrupts */
@@ -217,7 +217,7 @@
     return num_a2091;
 }
 
-static int a2091_bus_reset(Scsi_Cmnd *cmd)
+static int a2091_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 
diff -ruN linux-2.6/drivers/scsi/a3000.c devel/drivers/scsi/a3000.c
--- linux-2.6/drivers/scsi/a3000.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a3000.c	2006-09-12 23:33:42.000000000 +0200
@@ -44,7 +44,7 @@
 	return IRQ_NONE;
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -110,8 +110,8 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
-		      int status)
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
+		     int status)
 {
     /* disable SCSI interrupts */
     unsigned short cntr = CNTR_PDMD;
@@ -205,7 +205,7 @@
     return 0;
 }
 
-static int a3000_bus_reset(Scsi_Cmnd *cmd)
+static int a3000_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 	
diff -ruN linux-2.6/drivers/scsi/gvp11.c devel/drivers/scsi/gvp11.c
--- linux-2.6/drivers/scsi/gvp11.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/gvp11.c	2006-09-12 23:36:09.000000000 +0200
@@ -47,7 +47,7 @@
     gvp11_xfer_mask = ints[1];
 }
 
-static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
+static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
     unsigned short cntr = GVP11_DMAC_INT_ENABLE;
     unsigned long addr = virt_to_bus(cmd->SCp.ptr);
@@ -142,8 +142,8 @@
     return 0;
 }
 
-static void dma_stop (struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
-		      int status)
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
+		     int status)
 {
     /* stop DMA */
     DMA(instance)->SP_DMA = 1;
@@ -341,7 +341,7 @@
     return num_gvp11;
 }
 
-static int gvp11_bus_reset(Scsi_Cmnd *cmd)
+static int gvp11_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 
diff -ruN linux-2.6/drivers/scsi/mvme147.c devel/drivers/scsi/mvme147.c
--- linux-2.6/drivers/scsi/mvme147.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/mvme147.c	2006-09-12 23:37:05.000000000 +0200
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
 
diff -ruN linux-2.6/drivers/scsi/sgiwd93.c devel/drivers/scsi/sgiwd93.c
--- linux-2.6/drivers/scsi/sgiwd93.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/sgiwd93.c	2006-09-12 23:41:24.000000000 +0200
@@ -97,7 +97,7 @@
 }
 
 static inline
-void fill_hpc_entries(struct hpc_chunk *hcp, Scsi_Cmnd *cmd, int datainp)
+void fill_hpc_entries(struct hpc_chunk *hcp, struct scsi_cmnd *cmd, int datainp)
 {
 	unsigned long len = cmd->SCp.this_residual;
 	void *addr = cmd->SCp.ptr;
@@ -129,7 +129,7 @@
 	hcp->desc.cntinfo = HPCDMA_EOX;
 }
 
-static int dma_setup(Scsi_Cmnd *cmd, int datainp)
+static int dma_setup(struct scsi_cmnd *cmd, int datainp)
 {
 	struct ip22_hostdata *hdata = HDATA(cmd->device->host);
 	struct hpc3_scsiregs *hregs =
@@ -163,7 +163,7 @@
 	return 0;
 }
 
-static void dma_stop(struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
+static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 		     int status)
 {
 	struct ip22_hostdata *hdata = HDATA(instance);
@@ -305,7 +305,7 @@
 	return 1;
 }
 
-static int sgiwd93_bus_reset(Scsi_Cmnd *cmd)
+static int sgiwd93_bus_reset(struct scsi_cmnd *cmd)
 {
 	/* FIXME perform bus-specific reset */
 


