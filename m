Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314068AbSDKOCm>; Thu, 11 Apr 2002 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSDKOCl>; Thu, 11 Apr 2002 10:02:41 -0400
Received: from imladris.infradead.org ([194.205.184.45]:62478 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314068AbSDKOCk>; Thu, 11 Apr 2002 10:02:40 -0400
Date: Thu, 11 Apr 2002 15:02:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Message-ID: <20020411150219.A10486@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zlatko Calusic <zlatko.calusic@iskon.hr>,
	linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
	Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 01:06:59PM +0200, Zlatko Calusic wrote:
> I had to make some changes, as kernel internals have changed since the
> time patch was originally written. Alan has also included this patch
> in his 2.4.x-ac kernel series, but it is not working well.

Oh, it's also in 2.4.19-pre6 and works pretty well..

> First problem is that somehow, misteriously, ios_in_flight variable
> drops to value of -1 when disks are idle. Of course, this skews lots
> of other numbers and iostat reports garbage. I tried to find the cause
> of this behaviour, but failed (looks like we have a request fired on
> each disk, whose start is never accounted but completion is?!). So I
> resolved it this way
> 
> if (hd->ios_in_flight)
>                --hd->ios_in_flight;
> 
> which works well, but I would still love to know how number of I/Os
> can drop below zero. :)

I'm unable to reproduce it here - I only have idle partition though..

> Second problem/nuisance is that blk_partition_remap() destroys
> partition information from the bio->bi_dev before the request is
> queued. That's why -ac kernel doesn't report per-partition
> information.

Bullocks.  2.4 doesn't even have blk_partition_remap, but the individual
drivers do the partition remapping themselves.  I wouldn't have submitted
sard for 2.4 inclusion if there would be such a bug.

	Christoph

