Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271529AbRHPIt4>; Thu, 16 Aug 2001 04:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271527AbRHPItr>; Thu, 16 Aug 2001 04:49:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36105 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271534AbRHPItj>; Thu, 16 Aug 2001 04:49:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] alternative way of calculating inactive_target
Date: Thu, 16 Aug 2001 10:55:32 +0200
X-Mailer: KMail [version 1.3]
Cc: <linux-mm@kvack.org>
In-Reply-To: <200108160337.FAA11729@mailb.telia.com>
In-Reply-To: <200108160337.FAA11729@mailb.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816084939Z16265-1231+1158@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 16, 2001 05:33 am, Roger Larsson wrote:
> Hi,
> 
> 1. Two things in this file, first an unrelated issue (but included in the patch)
> global_target in free_shortage shouldn't it be freepages.low?
> Traditionally freepages.high has been when to stop freeing pages.
> 
> 2. I have wondered about how inactive_target is calculated.
> This is an alternative approach...
> 
> In this alternative approach I use two wrapping counters.
> (memory_clock & memory_clock_rubberband)
> 
> memory_clock is incremented only when allocating pages (and it
> is never decremented)

Yes, exactly, did you read my mind?  Page units are the natural quantum
of the time base for the whole mm.  When we clock all mm events according
to the (__alloc_page << order) timebase then lots of memory spikes are
magically transformed into smooth curves and it becomes immediately
obvious how much scanning we need to do at each instant.  Now, warning,
this is a major shift in viewpoint and I'll wager, unwelcome on this side
of the 2.5 split.  I'd be happy to work with you doing a skunkworks-type
proof-of-concept though.

> memory_clock_rubberband is calculated to be close to what
> memory_clock should have been for MEMORY_CLOCK_WINDOW seconds
> earlier, using current values and information about how long it was since it
> was updated the last time. This makes it possible to recalculate the target
> more often when pressure is high - and it simplifies kswapd too...

I'll supply a cute, efficient filter that does what you're doing with the
rubberband with a little stronger theoretical basis, as soon as I wake up
again.  Or you can look for my earlier "Early flush with bandwidth
estimation" post.  (Try to ignore the incorrect volatile handling please.)

BTW, you left out an interesting detail: any performance measurements
you've already done.

--
Daniel
