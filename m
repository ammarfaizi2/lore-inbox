Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBYReq>; Sun, 25 Feb 2001 12:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbRBYReg>; Sun, 25 Feb 2001 12:34:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45836 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129436AbRBYRea>;
	Sun, 25 Feb 2001 12:34:30 -0500
Date: Sun, 25 Feb 2001 18:34:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010225183401.D7830@suse.de>
In-Reply-To: <20010222145642.D17276@suse.de> <Pine.LNX.4.10.10102221052000.8403-100000@penguin.transmeta.com> <20010222223811.A29372@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010222223811.A29372@athlon.random>; from andrea@suse.de on Thu, Feb 22, 2001 at 10:38:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22 2001, Andrea Arcangeli wrote:
> On Thu, Feb 22, 2001 at 10:59:20AM -0800, Linus Torvalds wrote:
> > I'd prefer for this check to be a per-queue one.
> 
> I'm running this in my tree since a few weeks, however I never had the courage
> to post it publically because I didn't benchmarked it carefully yet and I
> prefer to finish another thing first. This is actually based on the code I had
> in my blkdev tree after I merged last time with Jens the 512K I/O requests and
> elevator fixes. I think it won't generate bad numbers and it was running fine
> on a 32way SMP (though I didn't stressed the I/O subsystem much there) but
> please don't include until somebody benchmarks it carefully with dbench and
> tiotest.  (it still applys cleanly against 2.4.2)

Thinking about this a bit, I have to agree with you and Linus. It
is possible to find pathetic cases where the per-queue limit suffers
compared to the global one, but in reality I don't think it's worth
it. And the per-queue limits saves us the atomic updates since it's
done under the io_request_lock (or queue later, still fine) so that's
a win too.

I have had rw wait queues before, was removed when I did the request
stealing which is now gone again. I'm not even sure it's worth it
now, Marcelo and I discussed it last week and I did some tests that
showed nothing remarkable. But it's mainly for free, so we might
as well do it.

Any reason why you don't have a lower wake-up limit for the queue?
Do you mind if I do some testing with this patch and fold it in,
possibly?

-- 
Jens Axboe

