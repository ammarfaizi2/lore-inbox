Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSLJWun>; Tue, 10 Dec 2002 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSLJWun>; Tue, 10 Dec 2002 17:50:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52211 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266983AbSLJWul>;
	Tue, 10 Dec 2002 17:50:41 -0500
Message-ID: <3DF6716D.81E06446@mvista.com>
Date: Tue, 10 Dec 2002 14:57:49 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>
CC: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <200212101514.PAA15602@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> [ repost - first attempt failed to get out ]
> 
> > > Is the "don't reuse an ID for some time" requirement still there?
> >
> > I don't see the need for the "don't reuse an ID for some
> > time" thing and it looked like what Jim had messed up the
> > book keeping AND it also looked like it failed to actually
> > work.  All of this convinced me that the added complexity
> > was just not worth it.
> 
> A thought: any algorithm that fails to "reuse an ID for some time"
> can be converted into one that does by tweaking the algorithn to
> return an ID with fewer bits and putting a counter (bumped on each
> fresh allocation of that ID) in the remaining bits.  Or, one can go
> stateless and achieve an "almost never reuse an ID for some time" by
> instead inserting a freshly generated pseudo-random number in the
> unused ID bits.
> 
With out going into a lot of detail, since I don't think I
need such an animal, one would need to keep the actual id
somewhere (either the node or in what it pointed to).

Perhaps a less costly way would be to keep a sequence
number, say the number of items allocated so far and
inserting that.  I think one would want to make sure this is
not a power of 2, but this may not be needed as the first
freeing would generate an indexing of the number WRT to the
id.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
