Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUD1Tdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUD1Tdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUD1Tdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:33:43 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:18670 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264955AbUD1QvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:51:03 -0400
Date: Wed, 28 Apr 2004 18:50:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/6): zfcp host adapter.
Message-ID: <20040428165051.GF2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

zfcp host adapter change:
 - Fix addressing exception due to uninitialized host_scribble pointer.

diffstat:
 drivers/s390/scsi/zfcp_scsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Wed Apr 28 17:51:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Wed Apr 28 17:51:40 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.60 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.61 $"
 
 #include <linux/blkdev.h>
 
@@ -345,7 +345,7 @@
 
 	/* reset the status for this request */
 	scpnt->result = 0;
-	/* save address of mid layer call back function */
+	scpnt->host_scribble = NULL;
 	scpnt->scsi_done = done;
 
 	/*
