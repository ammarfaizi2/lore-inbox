Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWG1Rc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWG1Rc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWG1Rc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:32:58 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:64237 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1161191AbWG1Rc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:32:58 -0400
Date: Sat, 29 Jul 2006 01:32:45 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi" <linux-scsi@vger.kernel.org>
Cc: "James.Bottomley" <James.Bottomley@SteelEye.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>, "jeff" <jeff@garzik.org>
Subject: [PATCH 2/4] stex: add new device ids
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBfkNsjUHQHh2w000002b6@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Jul 2006 17:34:56.0640 (UTC) FILETIME=[24920800:01C6B26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add new device ids

Signed-off-by: Ed Lin <ed.lin@promise.com>
---
 stex.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)
diff -urN a/drivers/scsi/stex.c b/drivers/scsi/stex.c
--- a/drivers/scsi/stex.c	2006-07-28 05:48:26.000000000 -0400
+++ b/drivers/scsi/stex.c	2006-07-28 05:52:48.000000000 -0400
@@ -118,6 +118,9 @@
 	ST_MAX_TARGET_NUM			= (ST_MAX_ARRAY_SUPPORTED+1),
 	ST_MAX_LUN_PER_TARGET			= 16,
 
+	st_shasta				= 0,
+	st_vsc					= 1,
+
 	PASSTHRU_REQ_TYPE			= 0x00000001,
 	PASSTHRU_REQ_NO_WAKEUP			= 0x00000100,
 	ST_INTERNAL_TIMEOUT			= 30,
@@ -275,6 +278,8 @@
 
 	unsigned int mu_status;
 	int out_req_cnt;
+
+	unsigned int cardtype;
 };
 
 static const char console_inq_page[] =
@@ -1043,6 +1048,8 @@
 		(struct status_msg *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
 	hba->mu_status = MU_STATE_STARTING;
 
+	hba->cardtype = (unsigned int) id->driver_data;
+
 	/* firmware uses id/lun pair for a logical drive, but lun would be
 	   always 0 if CONFIG_SCSI_MULTI_LUN not configured, so we use
 	   channel to map lun here */
@@ -1163,12 +1170,14 @@
 }
 
 static struct pci_device_id stex_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8350, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0xf350, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x4301, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x4302, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8301, PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8302, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x105a, 0x8350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0xc350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0xf350, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x4301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x4302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x8301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x105a, 0x8302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_shasta },
+	{ 0x1725, 0x7250, PCI_ANY_ID, PCI_ANY_ID, 0, 0, st_vsc },
 	{ }	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, stex_pci_tbl);

