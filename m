Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVENAt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVENAt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVENArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:47:07 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:957 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262654AbVENAqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:46:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=jVDTh2k9z2diGUpqzif101meQ5QhkNMTXsB7Zb0llt7AoJrK0+LI2FZm8EJ7KcosPrNiksm4c11ozvSq0KhySntXhjiieGADyFKs/Nms4QnvfTaxfUOgtKx58dWfXuyEfU9FhjdGeA/1oMonye+V9mulDhpgirNYY9DM966z+Vc=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050514004601.783910E3@htj.dyndns.org>
In-Reply-To: <20050514004601.783910E3@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/03] scsi: remove unnecessary scsi_delete_timer() call in scsi_reset_provider()
Message-ID: <20050514004601.4404815C@htj.dyndns.org>
Date: Sat, 14 May 2005 09:46:13 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_timer_remove_delete_timer_from_reset_provider.patch

	scsi_reset_provider() calls scsi_delete_timer() on exit which
	isn't necessary.  Remove it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |    1 -
 1 files changed, 1 deletion(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-05-14 09:43:18.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-05-14 09:45:59.000000000 +0900
@@ -1870,7 +1870,6 @@ scsi_reset_provider(struct scsi_device *
 		rtn = FAILED;
 	}
 
-	scsi_delete_timer(scmd);
 	scsi_next_command(scmd);
 	return rtn;
 }

