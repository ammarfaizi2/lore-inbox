Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVDKDqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDKDqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVDKDqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:46:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:2631 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbVDKDpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:45:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=pa0GnMa4csdUIJUgqyjodC7qSpbx934t52zE7XSYpy7B7ys5f/qKXGHwYilVmN8uz64KIH2ma7QKMfMkPFU52aUZnKewsST0CspFA1ACuHiZgLcDXpt+j0nn754n8Yap6RGUmkcenw0m6MQOY7+Gfu4NaU1ueJk/yMukgjXky/8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050411034451.B75F3870@htj.dyndns.org>
In-Reply-To: <20050411034451.B75F3870@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: replace REQ_SPECIAL with REQ_SOFTBARRIER in scsi_init_io()
Message-ID: <20050411034451.81FB61F1@htj.dyndns.org>
Date: Mon, 11 Apr 2005 12:45:42 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_REQ_SPECIAL_semantic_scsi_init_io.patch

	scsi_init_io() used to set REQ_SPECIAL when it fails sg
	allocation before requeueing the request by returning
	BLKPREP_DEFER.  REQ_SPECIAL is being updated to mean special
	requests and we need to set REQ_SOFTBARRIER for half-prepp'ed
	requests.  So, replace REQ_SPECIAL with REQ_SOFTBARRIER.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-11 12:27:07.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-11 12:27:07.000000000 +0900
@@ -936,7 +936,7 @@ static int scsi_init_io(struct scsi_cmnd
 	 */
 	sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);
 	if (unlikely(!sgpnt)) {
-		req->flags |= REQ_SPECIAL;
+		req->flags |= REQ_SOFTBARRIER;
 		return BLKPREP_DEFER;
 	}
 

