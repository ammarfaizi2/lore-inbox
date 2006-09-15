Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWIOQuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWIOQuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIOQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:50:49 -0400
Received: from server6.greatnet.de ([83.133.96.26]:65481 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750754AbWIOQus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:50:48 -0400
Message-ID: <450AD9EF.9000404@nachtwindheim.de>
Date: Fri, 15 Sep 2006 18:50:55 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] scsi: seagate Scsi_Cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes the obsolete typedef'd Scsi_Cmnd to struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc7-git1/drivers/scsi/seagate.c	2006-09-15 18:29:07.000000000 +0200
+++ devel/drivers/scsi/seagate.c	2006-09-15 18:27:32.000000000 +0200
@@ -321,7 +321,7 @@
 static int hostno = -1;
 static void seagate_reconnect_intr (int, void *, struct pt_regs *);
 static irqreturn_t do_seagate_reconnect_intr (int, void *, struct pt_regs *);
-static int seagate_st0x_bus_reset(Scsi_Cmnd *);
+static int seagate_st0x_bus_reset(struct scsi_cmnd *);
 
 #ifdef FAST
 static int fast = 1;
@@ -585,8 +585,8 @@
 static unsigned char linked_target, linked_lun;
 #endif
 
-static void (*done_fn) (Scsi_Cmnd *) = NULL;
-static Scsi_Cmnd *SCint = NULL;
+static void (*done_fn) (struct scsi_cmnd *) = NULL;
+static struct scsi_cmnd *SCint = NULL;
 
 /*
  * These control whether or not disconnect / reconnect will be attempted,
@@ -633,7 +633,7 @@
 static void seagate_reconnect_intr (int irq, void *dev_id, struct pt_regs *regs)
 {
 	int temp;
-	Scsi_Cmnd *SCtmp;
+	struct scsi_cmnd *SCtmp;
 
 	DPRINTK (PHASE_RESELECT, "scsi%d : seagate_reconnect_intr() called\n", hostno);
 
@@ -675,10 +675,11 @@
 
 static int recursion_depth = 0;
 
-static int seagate_st0x_queue_command (Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
+static int seagate_st0x_queue_command(struct scsi_cmnd * SCpnt,
+				      void (*done) (struct scsi_cmnd *))
 {
 	int result, reconnect;
-	Scsi_Cmnd *SCtmp;
+	struct scsi_cmnd *SCtmp;
 
 	DANY ("seagate: que_command");
 	done_fn = done;
@@ -1609,7 +1610,7 @@
 	return retcode (st0x_aborted);
 }				/* end of internal_command */
 
-static int seagate_st0x_abort (Scsi_Cmnd * SCpnt)
+static int seagate_st0x_abort(struct scsi_cmnd * SCpnt)
 {
 	st0x_aborted = DID_ABORT;
 	return SUCCESS;
@@ -1624,7 +1625,7 @@
  * May be called with SCpnt = NULL
  */
 
-static int seagate_st0x_bus_reset(Scsi_Cmnd * SCpnt)
+static int seagate_st0x_bus_reset(struct scsi_cmnd * SCpnt)
 {
 	/* No timeouts - this command is going to fail because it was reset. */
 	DANY ("scsi%d: Reseting bus... ", hostno);


