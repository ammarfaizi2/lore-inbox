Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136633AbRASBYO>; Thu, 18 Jan 2001 20:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136636AbRASBYF>; Thu, 18 Jan 2001 20:24:05 -0500
Received: from gateway.sequent.com ([192.148.1.10]:42923 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S136633AbRASBXv>; Thu, 18 Jan 2001 20:23:51 -0500
Date: Thu, 18 Jan 2001 17:23:44 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Andi Kleen <ak@suse.de>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010118172344.I8637@w-mikek.des.sequent.com>
In-Reply-To: <20010119012616.D32087@athlon.random> <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca> <20010119020852.A6973@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010119020852.A6973@gruyere.muc.suse.de>; from ak@suse.de on Fri, Jan 19, 2001 at 02:08:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:08:52AM +0100, Andi Kleen wrote:
> On Thu, Jan 18, 2001 at 08:00:16PM -0500, Mark Hahn wrote:
> > > >                            microseconds/yield
> > > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > > ------------   ---------         --------     ---------------
> > > > 16               18.740            4.603         1.455
> > > 
> > > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> > 
> > isn't the normal case (as in "The Right Case to optimize") 
> > where there are close to zero runnable tasks?  what realistic/sane
> > scenarios have very large numbers of spinning threads?  all server
> > situations I can think of do not.  not volanomark -loopback, surely!
> 
> I think the main point of Mike's patch is decreasing locking and cache line
> bouncing overhead of multi cpu scheduling, not optimizing lots of runnable tasks.
> 
> 
> -Andi

Andi is correct.  Although the results I posted may seem to indicate
we are concentrating on high thread counts, this is really secondary
to reducing lock contention within the scheduler.  A co-worker down
the hall just ran pgbench (a postgresql db) benchmark and saw
contention on the runqueue lock at 57%.  Now, I know nothing about this
benchmark, but it will be interesting to see what happens after
applying my patch.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
