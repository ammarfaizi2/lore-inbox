Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDSOdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDSOdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDSOc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:32:58 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:59587 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261572AbVDSOb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=aKEmqnTRU9JDvTCnk0Y7VyZ4z2AamDAMrmF1DeQ5Lp2vFFhHkaxHOO4U8Mxtv97I4wtmmxGJ8XADznfZ3fxVXRnHtWykyXTIVrbfk317ZfntU2fGYY6/IV6WShfggiwlKz+aFkXhyR419Ho0XvHWC6DhlkHHgKzvPLnjnNsjtEw=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419143100.E231523D@htj.dyndns.org>
In-Reply-To: <20050419143100.E231523D@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary scsi_delete_timer() call in scsi_reset_provider()
Message-ID: <20050419143100.284C6D23@htj.dyndns.org>
Date: Tue, 19 Apr 2005 23:31:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_timer_remove_delete_timer_from_reset_provider.patch

	scsi_reset_provider() calls scsi_delete_timer() on exit which
	isn't necessary.  Remove it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |    1 -
 1 files changed, 1 deletion(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-19 23:30:58.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-19 23:30:58.000000000 +0900
@@ -1882,7 +1882,6 @@ scsi_reset_provider(struct scsi_device *
 		rtn = FAILED;
 	}
 
-	scsi_delete_timer(scmd);
 	scsi_next_command(scmd);
 	return rtn;
 }

