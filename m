Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVDSOmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDSOmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDSOcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:32:22 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:41361 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261562AbVDSObQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:31:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Jyo2GkFwd5lYLYQpzspSGddretZcSkqgqKU0d3qvOtt7fHWwoHrpRUlwOuDYvH71H5mXx4fQxS5vkHBCFxr/iKbGkofmj2uRGew1yECYpWEn5L9ntGbrf9QmqSK7OKm6Oyudh8RQG/b5jYHYqJgiV6Ocl4mElNOGFLRhMFc2+Og=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419143100.E231523D@htj.dyndns.org>
In-Reply-To: <20050419143100.E231523D@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/04] scsi: remove spurious if tests from scsi_eh_{times_out|done}
Message-ID: <20050419143100.3724D346@htj.dyndns.org>
Date: Tue, 19 Apr 2005 23:31:11 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_timer_eh_timer_remove_spurious_if.patch

	If tests which check if eh_action isn't NULL in both functions
	are always true.  Remove the if's.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-19 23:30:57.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-19 23:30:58.000000000 +0900
@@ -436,8 +436,7 @@ static void scsi_eh_times_out(unsigned l
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
 					  scmd));
 
-	if (scmd->device->host->eh_action)
-		up(scmd->device->host->eh_action);
+	up(scmd->device->host->eh_action);
 }
 
 /**
@@ -461,8 +460,7 @@ static void scsi_eh_done(struct scsi_cmn
 		SCSI_LOG_ERROR_RECOVERY(3, printk("%s scmd: %p result: %x\n",
 					   __FUNCTION__, scmd, scmd->result));
 
-		if (scmd->device->host->eh_action)
-			up(scmd->device->host->eh_action);
+		up(scmd->device->host->eh_action);
 	}
 }
 

