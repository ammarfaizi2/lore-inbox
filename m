Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUI2XDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUI2XDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUI2XDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:03:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45734 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269120AbUI2XC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:02:26 -0400
Message-ID: <415B3EC5.5030606@engr.sgi.com>
Date: Wed, 29 Sep 2004 16:01:25 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc2 1/2] enhanced I/O accounting data collection
References: <20040928152123.GD2385@suse.de>
In-Reply-To: <20040928152123.GD2385@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right, Jens. In our earlier posting, we also included block
device read/write counters. The block read/write counts are not very
accurate but it fits our customers' needs since they used that
information sort of for performance analysis than for accounting
purpose.

Thus the block read/write counters were removed from our patch so
that we can concentrate on the accounting needs. This bwtime (block
wait time) should have been pulled together with block read/write
counters.

Regards,
  - jay


Jens Axboe wrote:
> Hi,
> 
> 
>>Index: linux/drivers/block/ll_rw_blk.c
>>===================================================================
>>--- linux.orig/drivers/block/ll_rw_blk.c	2004-09-12 22:31:31.000000000 -0700
>>+++ linux/drivers/block/ll_rw_blk.c	2004-09-27 12:37:04.374234677 -0700
>>@@ -1741,6 +1741,7 @@
>>{
>>	DEFINE_WAIT(wait);
>>	struct request *rq;
>>+	unsigned long start_wait = jiffies;
>>
>>	generic_unplug_device(q);
>>	do {
>>@@ -1769,6 +1770,7 @@
>>		finish_wait(&rl->wait[rw], &wait);
>>	} while (!rq);
>>
>>+	current->bwtime += (unsigned long) jiffies - start_wait;
>>	return rq;
>>}
> 
> 
> What is the purpose of this hunk alone as block io accounting? It
> doesn't make any sense to me - you are accounting the time a process
> spends sleeping on a congested queue, it has nothing to do with the
> bandwidth time it used. Which, btw, isn't so easy to account on queueing
> hardware.
> 
> Just curious on what you are trying to achieve here.
>  

