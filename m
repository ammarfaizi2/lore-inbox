Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbTE1Kv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbTE1Kv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:51:57 -0400
Received: from dyn-ctb-210-9-245-51.webone.com.au ([210.9.245.51]:6405 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264669AbTE1Kvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:51:50 -0400
Message-ID: <3ED4976D.1030809@cyberone.com.au>
Date: Wed, 28 May 2003 21:03:09 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@digeo.com>
CC: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>,
       m.c.p@wolk-project.de, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <20030528032315.679e77b0.akpm@digeo.com> <20030528102529.GQ845@suse.de> <200305282048.58032.kernel@kolivas.org>
In-Reply-To: <200305282048.58032.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Wed, 28 May 2003 20:25, Jens Axboe wrote:
>
>>On Wed, May 28 2003, Andrew Morton wrote:
>>
>>>Then this (totally unlikely, don't bother):
>>>
>>>diff -puN drivers/block/ll_rw_blk.c~3 drivers/block/ll_rw_blk.c
>>>--- 24/drivers/block/ll_rw_blk.c~3	2003-05-28 03:21:15.000000000 -0700
>>>+++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:21:39.000000000 -0700
>>>@@ -829,8 +829,7 @@ void blkdev_release_request(struct reque
>>> 	 */
>>> 	if (q) {
>>> 		list_add(&req->queue, &q->rq[rw].free);
>>>-		if (++q->rq[rw].count >= q->batch_requests &&
>>>-				waitqueue_active(&q->wait_for_requests[rw]))
>>>+		if (++q->rq[rw].count >= q->batch_requests)
>>> 			wake_up(&q->wait_for_requests[rw]);
>>> 	}
>>> }
>>>
>>Well it's the only one left :). But you are right, try one of them at
>>the time, establishing the effect of each of them.
>>
>
>THIS IS IT! The last one. No pauses writing a 2Gb file now unless I do a read 
>midstream.
>
>
OK, I can't see how this would make a difference, but there
is similar (batch_requests) code in the mm tree, so it would
be nice if someone would work out what is going on.


