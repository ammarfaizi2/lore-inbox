Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132837AbRDPCgY>; Sun, 15 Apr 2001 22:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132839AbRDPCgF>; Sun, 15 Apr 2001 22:36:05 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:26376 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S132837AbRDPCgC>;
	Sun, 15 Apr 2001 22:36:02 -0400
Message-ID: <3ADA60C6.1593A2BF@candelatech.com>
Date: Sun, 15 Apr 2001 20:02:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: george anzinger <george@mvista.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3AD77540.42BF138E@mvista.com> <20010414011035.D2290@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> george anzinger wrote:
> > Horst von Brand wrote:
> > >
> > > Ben Greear <greearb@candelatech.com> said:
> > >
> > > [...]
> > >
> > > > Wouldn't a heap be a good data structure for a list of timers?  Insertion
> > > > is log(n) and finding the one with the least time is O(1), ie pop off the
> > > > front....  It can be implemented in an array which should help cache
> > > > coherency and all those other things they talked about in school :)
> > >
> > > Insertion and deleting the first are both O(log N). Plus the array is fixed
> > > size (bad idea) and the jumping around in the array thrashes the caches.
> > > --
> > And your solution is?
> 
> Note that jumping around the array thrashes no more cache than
> traversing a tree (it touches the same number of elements).  I prefer
> heap-ordered trees though because fixed size is always a bad idea.

With a tree, you will be allocating and de-allocating for every
insert/delete right?  That seems like a reasonable performance
hit that an array-based approach might not have... 

On cache-coherency issues, wouldn't it be more likely to have a cache hit when you are
accessing one contigious (ie the array) piece of memory?  A 4-k page
will hold a lot of indexes!!

To get around the fixed size thing..could have
the array grow itself when needed (and probably never shrink again).
This would suck if you did it often, but I'm assuming that it would
quickly grow to needed size and then stabalize...

> 
> Insertion is O(1) if entries can be predicted to be near
> enough some place in the list, be that the beginning, the end, or some
> marked places in the middle.
> 
> By the way, the current timer implementation only appears to be O(1) if
> you ignore the overhead of having to do a check on every tick, and the
> extra processing on table rollover.  For random timer usage patterns,
> that overhead adds up to O(log n), the same as a heap.
> 
> However for skewed usage patterns (likely in the kernel), the current
> table method avoids the O(log n) sorting overhead because long-delay
> timers are often removed before percolating down to the smallest tables.
> It is possible to produce a general purpose heap which also has this
> property.
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
