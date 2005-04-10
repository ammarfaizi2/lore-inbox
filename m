Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVDJStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDJStt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDJStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:49:04 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:32810 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261571AbVDJSph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=lTkxE85P89+MO0dNihfNpSKLfF6MgOipBPhChZycjK7veEBcJsYX4KzsrbU3U7P0T7nNTxECPqUvkyrahRVN6gfUn5cvE/tP+y/TU8Fzhwy1Am4KdIWYOVNRIqrMwfNG8Ea7NMYcp9r/i2vROuulKFOuTssqrCYP/7UU+b4IpSM=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/07] scsi: remove unnecessary scsi_delete_timer() call in scsi_reset_provider()
Message-ID: <20050410184214.8FFBC5B6@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:26 +0900 (KST)
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
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-11 03:42:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-11 03:42:12.000000000 +0900
@@ -1843,7 +1843,6 @@ scsi_reset_provider(struct scsi_device *
 		rtn = FAILED;
 	}
 
-	scsi_delete_timer(scmd);
 	scsi_next_command(scmd);
 	return rtn;
 }

