Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWCMVVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWCMVVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWCMVVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:21:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932449AbWCMVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:21:19 -0500
Date: Mon, 13 Mar 2006 22:21:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC: -mm patch] remove drivers/scsi/constants.c:scsi_print_req_sense()
Message-ID: <20060313212118.GK13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm3:
>...
>  git-scsi-misc.patch
>...
>  git trees
>...


This function is no longer used anywhere.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/constants.c |   10 ----------
 include/scsi/scsi_dbg.h  |    1 -
 2 files changed, 11 deletions(-)

--- linux-2.6.16-rc6-mm1-full/include/scsi/scsi_dbg.h.old	2006-03-13 21:15:08.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/include/scsi/scsi_dbg.h	2006-03-13 21:15:17.000000000 +0100
@@ -9,7 +9,6 @@
 extern void scsi_print_sense_hdr(const char *, struct scsi_sense_hdr *);
 extern void __scsi_print_command(unsigned char *);
 extern void scsi_print_sense(const char *, struct scsi_cmnd *);
-extern void scsi_print_req_sense(const char *, struct scsi_request *);
 extern void __scsi_print_sense(const char *name,
 			       const unsigned char *sense_buffer,
 			       int sense_len);
--- linux-2.6.16-rc6-mm1-full/drivers/scsi/constants.c.old	2006-03-13 21:15:41.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/scsi/constants.c	2006-03-13 21:39:51.000000000 +0100
@@ -1259,16 +1259,6 @@
 }
 EXPORT_SYMBOL(scsi_print_sense);
 
-void scsi_print_req_sense(const char *devclass, struct scsi_request *sreq)
-{
-	const char *name = devclass;
-
-	if (sreq->sr_request->rq_disk)
-		name = sreq->sr_request->rq_disk->disk_name;
-	__scsi_print_sense(name, sreq->sr_sense_buffer, SCSI_SENSE_BUFFERSIZE);
-}
-EXPORT_SYMBOL(scsi_print_req_sense);
-
 void scsi_print_command(struct scsi_cmnd *cmd)
 {
 	/* Assume appended output (i.e. not at start of line) */

