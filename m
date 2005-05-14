Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVENArs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVENArs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVENArW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:47:22 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:31423 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262655AbVENAqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:46:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=E6BJ+5j/c7fFTFB1EaXUs6xFJUuAEIY/EDc3VXU2Jb00ww5T7695Elcv0EM+3HeINKXtq3AU9jDsBm2TEKUBHe5lypMUb5sY+fYk4Y5V/xTUmfC9SIMBACtDPwsL6Xhvys0Ioj0nXZSVhWtUUnMJGs2PBXhKpYSLlXxwkvD+c2U=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050514004601.783910E3@htj.dyndns.org>
In-Reply-To: <20050514004601.783910E3@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/03] scsi: remove spurious if tests from scsi_eh_{times_out|done}
Message-ID: <20050514004601.E140FAC9@htj.dyndns.org>
Date: Sat, 14 May 2005 09:46:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_scsi_timer_eh_timer_remove_spurious_if.patch

	'if' tests which check if eh_action isn't NULL in both
	functions are always true.  Remove the redundant if's as it
	can give wrong impressions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-05-14 09:45:59.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-05-14 09:45:59.000000000 +0900
@@ -434,8 +434,7 @@ static void scsi_eh_times_out(struct scs
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
 					  scmd));
 
-	if (scmd->device->host->eh_action)
-		up(scmd->device->host->eh_action);
+	up(scmd->device->host->eh_action);
 }
 
 /**
@@ -457,8 +456,7 @@ static void scsi_eh_done(struct scsi_cmn
 		SCSI_LOG_ERROR_RECOVERY(3, printk("%s scmd: %p result: %x\n",
 					   __FUNCTION__, scmd, scmd->result));
 
-		if (scmd->device->host->eh_action)
-			up(scmd->device->host->eh_action);
+		up(scmd->device->host->eh_action);
 	}
 }
 

