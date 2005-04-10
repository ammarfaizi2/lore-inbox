Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVDJSvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDJSvh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVDJSvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:51:21 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:40244 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261575AbVDJSpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=L2G2zgLErALCNu7zA4Z+8lnNDVJQSnUibp91b21cqPBzy2EsyBNz21+Bz2JdC54ekps6sJpGy9pdkykjqxBsMnbsl/dAV4sDSyNh9KuO5zZXZ98Ekyx/Nfl3pB9mErDXt3NW4j6ahXiW84wopTogtpbtrwdYwijI4/9L5cTCuZ8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 06/07] scsi: Delete scsi_{add|delete}_timer() from scsi_mid_low_api.txt
Message-ID: <20050410184215.11E583D9@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:36 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_scsi_timer_update_api_doc.patch

	As scsi_{add|delete}_timer() got unexported, remove them from
	the API doc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_mid_low_api.txt |   41 -----------------------------------------
 1 files changed, 41 deletions(-)

Index: scsi-reqfn-export/Documentation/scsi/scsi_mid_low_api.txt
===================================================================
--- scsi-reqfn-export.orig/Documentation/scsi/scsi_mid_low_api.txt	2005-04-11 03:42:09.000000000 +0900
+++ scsi-reqfn-export/Documentation/scsi/scsi_mid_low_api.txt	2005-04-11 03:42:13.000000000 +0900
@@ -373,13 +373,11 @@ Summary:
    scsi_activate_tcq - turn on tag command queueing
    scsi_add_device - creates new scsi device (lu) instance
    scsi_add_host - perform sysfs registration and SCSI bus scan.
-   scsi_add_timer - (re-)start timer on a SCSI command.
    scsi_adjust_queue_depth - change the queue depth on a SCSI device
    scsi_assign_lock - replace default host_lock with given lock
    scsi_bios_ptable - return copy of block device's partition table
    scsi_block_requests - prevent further commands being queued to given host
    scsi_deactivate_tcq - turn off tag command queueing
-   scsi_delete_timer - cancel timer on a SCSI command.
    scsi_host_alloc - return a new scsi_host instance whose refcount==1
    scsi_host_get - increments Scsi_Host instance's refcount
    scsi_host_put - decrements Scsi_Host instance's refcount (free if 0)
@@ -461,27 +459,6 @@ int scsi_add_host(struct Scsi_Host *shos
 
 
 /**
- * scsi_add_timer - (re-)start timer on a SCSI command.
- * @scmd:    pointer to scsi command instance
- * @timeout: duration of timeout in "jiffies"
- * @complete: pointer to function to call if timeout expires
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Notes: Each scsi command has its own timer, and as it is added
- *      to the queue, we set up the timer. When the command completes, 
- *      we cancel the timer. An LLD can use this function to change
- *      the existing timeout value.
- *
- *      Defined in: drivers/scsi/scsi_error.c
- **/
-void scsi_add_timer(struct scsi_cmnd *scmd, int timeout, 
-                    void (*complete)(struct scsi_cmnd *))
-
-
-/**
  * scsi_adjust_queue_depth - allow LLD to change queue depth on a SCSI device
  * @sdev:       pointer to SCSI device to change queue depth on
  * @tagged:     0 - no tagged queuing
@@ -569,24 +546,6 @@ void scsi_deactivate_tcq(struct scsi_dev
 
 
 /**
- * scsi_delete_timer - cancel timer on a SCSI command.
- * @scmd:    pointer to scsi command instance
- *
- *      Returns 1 if able to cancel timer else 0 (i.e. too late or already
- *      cancelled).
- *
- *      Might block: no [may in the future if it invokes del_timer_sync()]
- *
- *      Notes: All commands issued by upper levels already have a timeout
- *      associated with them. An LLD can use this function to cancel the
- *      timer.
- *
- *      Defined in: drivers/scsi/scsi_error.c
- **/
-int scsi_delete_timer(struct scsi_cmnd *scmd)
-
-
-/**
  * scsi_host_alloc - create a scsi host adapter instance and perform basic
  *                   initialization.
  * @sht:        pointer to scsi host template

