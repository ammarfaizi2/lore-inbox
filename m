Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284876AbRLUWUx>; Fri, 21 Dec 2001 17:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286614AbRLUWUo>; Fri, 21 Dec 2001 17:20:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29956 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284876AbRLUWUd>;
	Fri, 21 Dec 2001 17:20:33 -0500
Date: Fri, 21 Dec 2001 23:19:51 +0100
From: Jens Axboe <axboe@kernel.org>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221231951.F2929@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221114352.A8661@earthlink.net> <20011221180156.C2929@suse.de> <20011221134709.A128@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221134709.A128@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, rwhron@earthlink.net wrote:
> On Fri, Dec 21, 2001 at 06:01:56PM +0100, Jens Axboe wrote:
> > Thanks -- could you also try and do sysrq-t back traces when it seems
> > stuck?
> > 
> > Does a non-highmem kernel run ok?
> > 
> > -- 
> > Jens Axboe
> 
> I recompiled with highmem turned off.  
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> 
> I run a scripty that executes dbench 32, then dbench 128.

Ok, please try something for me. In drivers/block/elevator.c, comment
out this block:

	if (q->last_merge) {
		__rq = list_entry_rq(q->last_merge);
		BUG_ON(__rq->flags & REQ_STARTED);

		if ((ret = elv_try_merge(__rq, bio))) {
			*req = __rq;
			return ret;
		}
	}

(just #if 0 the entire thing) -- the one inside elevator_linus_merge()

Loop back highmem issue is different, I'll take a look at that later.
I'll be pretty unresponsive over christmas, though.

-- 
Jens Axboe

