Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWIRN2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWIRN2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWIRN2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:28:30 -0400
Received: from server6.greatnet.de ([83.133.96.26]:5515 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751541AbWIRN23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:28:29 -0400
Message-ID: <450E9F0B.9080502@nachtwindheim.de>
Date: Mon, 18 Sep 2006 15:28:43 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] microtek usb scanner: Scsi_Cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Converts obsolete typedef'd Scsi_Cmnd into struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc7-git2/drivers/usb/image/microtek.c	2006-09-15 14:05:38.000000000 +0200
+++ devel/drivers/usb/image/microtek.c	2006-09-18 15:21:14.000000000 +0200
@@ -225,7 +225,7 @@
 }
 
 
-static inline void mts_show_command(Scsi_Cmnd *srb)
+static inline void mts_show_command(struct scsi_cmnd *srb)
 {
 	char *what = NULL;
 
@@ -309,7 +309,7 @@
 
 #else
 
-static inline void mts_show_command(Scsi_Cmnd * dummy)
+static inline void mts_show_command(struct scsi_cmnd * dummy)
 {
 }
 
@@ -338,7 +338,7 @@
 	return 0;
 }
 
-static int mts_scsi_abort (Scsi_Cmnd *srb)
+static int mts_scsi_abort(struct scsi_cmnd *srb)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
 
@@ -349,7 +349,7 @@
 	return FAILED;
 }
 
-static int mts_scsi_host_reset (Scsi_Cmnd *srb)
+static int mts_scsi_host_reset(struct scsi_cmnd *srb)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
 	int result, rc;
@@ -366,8 +366,8 @@
 	return result ? FAILED : SUCCESS;
 }
 
-static
-int mts_scsi_queuecommand (Scsi_Cmnd *srb, mts_scsi_cmnd_callback callback );
+static int
+mts_scsi_queuecommand(struct scsi_cmnd *srb, mts_scsi_cmnd_callback callback);
 
 static void mts_transfer_cleanup( struct urb *transfer );
 static void mts_do_sg(struct urb * transfer, struct pt_regs *regs);
@@ -537,7 +537,7 @@
 #define MTS_DIRECTION_IS_IN(x) ((mts_direction[x>>3] >> (x & 7)) & 1)
 
 static void
-mts_build_transfer_context( Scsi_Cmnd *srb, struct mts_desc* desc )
+mts_build_transfer_context(struct scsi_cmnd *srb, struct mts_desc* desc)
 {
 	int pipe;
 	struct scatterlist * sg;
@@ -588,8 +588,8 @@
 }
 
 
-static
-int mts_scsi_queuecommand( Scsi_Cmnd *srb, mts_scsi_cmnd_callback callback )
+static int
+mts_scsi_queuecommand(struct scsi_cmnd *srb, mts_scsi_cmnd_callback callback)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
 	int err = 0;
--- linux-2.6.18-rc7-git2/drivers/usb/image/microtek.h	2006-06-18 03:49:35.000000000 +0200
+++ devel/drivers/usb/image/microtek.h	2006-09-18 15:11:12.000000000 +0200
@@ -8,14 +8,14 @@
  *
  */
 
-typedef void (*mts_scsi_cmnd_callback)(Scsi_Cmnd *);
+typedef void (*mts_scsi_cmnd_callback)(struct scsi_cmnd *);
 
 
 struct mts_transfer_context
 {
 	struct mts_desc* instance;
 	mts_scsi_cmnd_callback final_callback;
-	Scsi_Cmnd *srb;
+	struct scsi_cmnd *srb;
 	
 	void* data;
 	unsigned data_length;


