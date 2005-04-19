Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVDSXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVDSXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVDSXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:16:37 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:53100 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261747AbVDSXPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:15:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=B6RC5NJq7H6rpcaGlPwCQmp53exUSwdES3D24miPmyaVcfnsrDlT7n0+luXqv0H05kBPYBsTYsQ0mRylhFNoK1IFN1QG8J7efFY3T/OFOcQDTWzv1BiEY1wxb1HXmTb1L7/UALYBlX0se6jyQlrkoOCJoZPvpAUSlRjeIgxVG9A=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419231435.D85F89C0@htj.dyndns.org>
In-Reply-To: <20050419231435.D85F89C0@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/05] scsi: remove REQ_SPECIAL in scsi_init_io()
Message-ID: <20050419231435.EB64B601@htj.dyndns.org>
Date: Wed, 20 Apr 2005 08:15:49 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_REQ_SPECIAL_semantic_scsi_init_io.patch

	scsi_init_io() used to set REQ_SPECIAL when it fails sg
	allocation before requeueing the request by returning
	BLKPREP_DEFER.  REQ_SPECIAL is being updated to mean special
	requests.  So, remove REQ_SPECIAL setting.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-20 08:13:33.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-20 08:13:34.000000000 +0900
@@ -935,10 +935,8 @@ static int scsi_init_io(struct scsi_cmnd
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

