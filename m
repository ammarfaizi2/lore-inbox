Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDMXLW>; Fri, 13 Apr 2001 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRDMXLC>; Fri, 13 Apr 2001 19:11:02 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:5906 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132327AbRDMXKv>;
	Fri, 13 Apr 2001 19:10:51 -0400
Date: Sat, 14 Apr 2001 01:10:35 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: george anzinger <george@mvista.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010414011035.D2290@pcep-jamie.cern.ch>
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3AD77540.42BF138E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD77540.42BF138E@mvista.com>; from george@mvista.com on Fri, Apr 13, 2001 at 02:53:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> Horst von Brand wrote:
> > 
> > Ben Greear <greearb@candelatech.com> said:
> > 
> > [...]
> > 
> > > Wouldn't a heap be a good data structure for a list of timers?  Insertion
> > > is log(n) and finding the one with the least time is O(1), ie pop off the
> > > front....  It can be implemented in an array which should help cache
> > > coherency and all those other things they talked about in school :)
> > 
> > Insertion and deleting the first are both O(log N). Plus the array is fixed
> > size (bad idea) and the jumping around in the array thrashes the caches.
> > --
> And your solution is?

Note that jumping around the array thrashes no more cache than
traversing a tree (it touches the same number of elements).  I prefer
heap-ordered trees though because fixed size is always a bad idea.

Insertion is O(1) if entries can be predicted to be near
enough some place in the list, be that the beginning, the end, or some
marked places in the middle.

By the way, the current timer implementation only appears to be O(1) if
you ignore the overhead of having to do a check on every tick, and the
extra processing on table rollover.  For random timer usage patterns,
that overhead adds up to O(log n), the same as a heap.

However for skewed usage patterns (likely in the kernel), the current
table method avoids the O(log n) sorting overhead because long-delay
timers are often removed before percolating down to the smallest tables.
It is possible to produce a general purpose heap which also has this
property.

-- Jamie
