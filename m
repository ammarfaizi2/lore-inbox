Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCaJPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCaJPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:14:25 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:35155 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261225AbVCaJIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=FNT3M4e9gGxFiEvGmQcYbJvJ7uKCkLrNQ85K3K3c1SQa7yJmruu9WhGCGR5nyLUNyQ1CPL40Ty5WbV/nthCiLe9pWQ+DCdTyuCTsMmBu3P7dC9kqlkMpc5TL4DToeAiKTIW6bovGpQAAVkloBHhe763MqSO4dYwb9vM9Wy0/Y28=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/13] scsi: don't turn on REQ_SPECIAL on sgtable allocation failure.
Message-ID: <20050331090647.C0E52845@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:00 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_no_REQ_SPECIAL_on_sgtable_allocation_failure.patch

	Don't turn on REQ_SPECIAL on sgtable allocation failure.  This
	was the last place where REQ_SPECIAL is turned on for normal
	requests.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:19.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:20.000000000 +0900
@@ -940,10 +940,8 @@ static int scsi_init_io(struct scsi_cmnd
 	 * if sg table allocation fails, requeue request later.
 	 */
 	sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);
-	if (unlikely(!sgpnt)) {
-		req->flags |= REQ_SPECIAL;
+	if (unlikely(!sgpnt))
 		return BLKPREP_DEFER;
-	}
 
 	cmd->request_buffer = (char *) sgpnt;
 	cmd->request_bufflen = req->nr_sectors << 9;

