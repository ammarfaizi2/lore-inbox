Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273015AbTHKUTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273052AbTHKUTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:19:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22409 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S273015AbTHKUTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:19:19 -0400
Date: Mon, 11 Aug 2003 22:11:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [BUG] 2.6.0-test3 and cciss driver (or blk_queue_hardsect_size)
Message-ID: <20030811221118.B1246@electric-eye.fr.zoreil.com>
References: <F341E03C8ED6D311805E00902761278C0C35E6DF@xfc04.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F341E03C8ED6D311805E00902761278C0C35E6DF@xfc04.fc.hp.com>; from erik.habbinga@hp.com on Mon, Aug 11, 2003 at 03:28:51PM -0400
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

HABBINGA,ERIK (HP-Loveland,ex1) <erik.habbinga@hp.com> :
> I'm wondering if anyone else is having problems with 2.6.0-test3 and the
> cciss driver, or with the function blk_queue_hardsect_size.  I was able to
> successfully boot 2.6.0-test2 in previous weeks, but trying 2.6.0-test3
> today gave me:


Jens, does the following patch make sense ?

hba[i]->queue went from 'struct request_queue queue' to
'struct request_queue *queue' and it now needs to be explicitly set.


 drivers/block/cciss.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/block/cciss.c~oops-cciss drivers/block/cciss.c
--- linux-2.6.0-test3/drivers/block/cciss.c~oops-cciss	Mon Aug 11 21:53:11 2003
+++ linux-2.6.0-test3-fr/drivers/block/cciss.c	Mon Aug 11 22:00:55 2003
@@ -2537,6 +2537,7 @@ err_all:
 	cciss_procinit(i);
 
         q->queuedata = hba[i];
+	hba[i]->queue = q;
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
 
 	/* This is a hardware imposed limit. */

_
