Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbRGKIy0>; Wed, 11 Jul 2001 04:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbRGKIyG>; Wed, 11 Jul 2001 04:54:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34053 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267236AbRGKIx4>;
	Wed, 11 Jul 2001 04:53:56 -0400
Date: Wed, 11 Jul 2001 10:53:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Dipankar Sarma <dipankar@sequent.com>
Cc: Mike Anderson <mike.anderson@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711105339.F17314@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010711142311.B9220@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11 2001, Dipankar Sarma wrote:
> >  I would like to know why the request_freelist is going empty? Having
> >  __get_request_wait being called alot would appear to be not optimal.
> 
> It is not unreasonable for request IOCB pools to go empty, the important
> issue is at what rate ? If a large portion of I/Os have to wait for
> request structures to be freed, we may not be able to utilize the available
> hardware bandwidth of the system optimally when we need, say, large
> # of IOs/Sec. On the other hand, having large number of request structures
> available may not necessarily give you large IOs/sec. The thing to look
> at would be - how well are we utilizing the queueing capablility
> of the hardware given a particular type of workload.

The queue lengths should always be long enough to keep the hw busy of
course. And in addition, the bigger the queues the bigger the chance of
skipping seeks due to reordering. But don't worry, I've scaled the queue
lengths so I'm pretty sure that they are always on the safe side in
size.

It's pretty easy to test for yourself if you want, just change
QUEUE_NR_REQUESTS in blkdev.h. It's currently 8192, the request slots
are scaled down from this value. 8k will give you twice the amount of
slots that you have RAM in mb, ie 2048 on a 1gig machine.

block: queued sectors max/low 683554kB/552482kB, 2048 slots per queue

-- 
Jens Axboe

