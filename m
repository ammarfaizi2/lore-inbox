Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSKHCm3>; Thu, 7 Nov 2002 21:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266719AbSKHCm3>; Thu, 7 Nov 2002 21:42:29 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:23539 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266716AbSKHCm3>;
	Thu, 7 Nov 2002 21:42:29 -0500
Date: Thu, 7 Nov 2002 21:49:05 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@digeo.com>
Cc: MdkDev <mdkdev@starman.ee>, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108024905.GA10246@www.kroptech.com>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com> <3DCB1D09.EE25507D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCB1D09.EE25507D@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 06:10:17PM -0800, Andrew Morton wrote:
> Your bandwidth there fell from 12 megs/sec to around 8.  That is
> reasonable, I think.  It's just that the read-vs-write balance is
> wrong for you.

Agreed. I only thought this was a problem because you said it should
work. ;)

> Try changing drivers/block/deadline-iosched.c:fifo_batch to 16.

Works! A 12x burn succeeded with a parallell dd *and* and make -j20.
Overall disk throughput suffered by a couple MB/s but there was a solid
2 MB/s left for the recorder.

> And the application isn't performing enough caching, perhaps.

Perhaps, but it was a steady downward spiral, and with a read 
throughput far lower than needed I think the application would have
had to cache the entire image in order to survive.

> The VM could be fairly easily changed to defer writeback if there is
> read activity happening on the same spindle.  Been thinking about
> that (and its relative, early flush) a bit.  But that write has
> to go to disk sometime.

Sounds interesting. It seems that this is the sort of behavior is
precisely what some workloads need and precisely the opposite of
what others need. Such is the life of a vm hacker, I suppose. :/

--Adam

