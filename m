Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVAKJEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVAKJEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVAKJEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:04:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262622AbVAKJEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:04:24 -0500
Date: Tue, 11 Jan 2005 10:04:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Badness in cfq_account_completion at drivers/block/cfq-iosched.c:916
Message-ID: <20050111090421.GG4551@suse.de>
References: <20050111052355.14035.qmail@web52604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111052355.14035.qmail@web52604.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11 2005, Srihari Vijayaraghavan wrote:
> I see zillion of these error messages in vanilla
> 2.6.10:
> Jan 11 16:10:13 linux kernel:  [<c0220ee0>]
> scsi_end_request+0xa9/0xd6

[snip]

Does this fix it?

===== drivers/block/cfq-iosched.c 1.17 vs edited =====
--- 1.17/drivers/block/cfq-iosched.c	2004-12-24 09:12:58 +01:00
+++ edited/drivers/block/cfq-iosched.c	2005-01-11 10:03:17 +01:00
@@ -622,8 +622,10 @@
 			cfq_sort_rr_list(cfqq, 0);
 		}
 
-		crq->accounted = 0;
-		cfqq->cfqd->rq_in_driver--;
+		if (crq->accounted) {
+			crq->accounted = 0;
+			cfqq->cfqd->rq_in_driver--;
+		}
 	}
 	list_add(&rq->queuelist, &q->queue_head);
 }

-- 
Jens Axboe

