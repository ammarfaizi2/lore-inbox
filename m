Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUEKMqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUEKMqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUEKMqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:46:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264670AbUEKMqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:46:18 -0400
Date: Tue, 11 May 2004 14:46:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
Message-ID: <20040511124614.GI1906@suse.de>
References: <20040511114936.GI4828@tpkurt.garloff.de> <20040511122037.GG1906@suse.de> <1084279242.2688.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084279242.2688.12.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11 2004, Arjan van de Ven wrote:
> On Tue, 2004-05-11 at 14:20, Jens Axboe wrote:
> > On Tue, May 11 2004, Kurt Garloff wrote:
> > > Hi,
> > block/scsi_ioctl.c should likely receive similar treatment then.
> 
> how about sticking these in a shared header between the 2 files ?

yep would be best, ala

===== drivers/block/scsi_ioctl.c 1.42 vs edited =====
--- 1.42/drivers/block/scsi_ioctl.c	Tue Apr 27 15:20:34 2004
+++ edited/drivers/block/scsi_ioctl.c	Tue May 11 14:43:51 2004
@@ -209,11 +209,6 @@
 	return 0;
 }
 
-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
-#define START_STOP_TIMEOUT		(60 * HZ)
-#define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
-#define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )
 #define OMAX_SB_LEN 16          /* For backward compatibility */
 
 static int sg_scsi_ioctl(request_queue_t *q, struct gendisk *bd_disk,
===== drivers/scsi/scsi_ioctl.c 1.24 vs edited =====
--- 1.24/drivers/scsi/scsi_ioctl.c	Mon Aug 25 15:37:40 2003
+++ edited/drivers/scsi/scsi_ioctl.c	Tue May 11 14:45:09 2004
@@ -27,11 +27,6 @@
 
 #define NORMAL_RETRIES			5
 #define IOCTL_NORMAL_TIMEOUT			(10 * HZ)
-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
-#define START_STOP_TIMEOUT		(60 * HZ)
-#define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
-#define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )  /* ZIP-250 on parallel port takes as long! */
 
 #define MAX_BUF PAGE_SIZE
 
===== include/scsi/scsi.h 1.20 vs edited =====
--- 1.20/include/scsi/scsi.h	Wed Feb 25 12:37:46 2004
+++ edited/include/scsi/scsi.h	Tue May 11 14:45:25 2004
@@ -362,6 +362,14 @@
 #define SCSI_2          3
 #define SCSI_3          4
 
+/*
+ * default timeouts
+ */
+#define FORMAT_UNIT_TIMEOUT		(12 * 60 * 60 * HZ)
+#define START_STOP_TIMEOUT		(60 * HZ)
+#define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
+#define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )
 
 /*
  * Here are some scsi specific ioctl commands which are sometimes useful.


-- 
Jens Axboe

