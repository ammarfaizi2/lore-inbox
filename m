Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265261AbSJWWMn>; Wed, 23 Oct 2002 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSJWWMm>; Wed, 23 Oct 2002 18:12:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14332 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265261AbSJWWMl>;
	Wed, 23 Oct 2002 18:12:41 -0400
Message-ID: <3DB72027.E59FA802@mvista.com>
Date: Wed, 23 Oct 2002 15:18:15 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@ccur.com
CC: jim.houston@attbi.com, linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] alternate Posix timer patch
References: <200210230838.g9N8cac00490@linux.local> <3DB6ED10.A81B0429@mvista.com> <3DB6FD0A.74BB3AD0@ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> george anzinger wrote:
> >
> > Jim Houston wrote:
> > I have also looked at the timer index stuff and made a few
> > changes.  If it get it working today, I will include it
> > also.  My changes mostly revolved around not caring about
> > reusing a timer id.  Would you care to comment on why you
> > think reuse is bad?
> >
> > With out this feature the code is much simpler and does not
> > keep around dead trees.
> >
> > -g
> 
> Hi George,
> 
> I assume the rationale is that not reusing the same id immediately helps
> catch errors in user code.  Since the id space is global, there
> is more chance that one process may be manipulating another processes
> timer.  Reusing the same id makes this sort of problem harder to
> catch.

Actually the timer itself has an owner field so if the id is
reused by a different process, the timer will belong to that
process and attempting to use the id from the prior process
will fail.  If the same process gets the same id there could
be a problem of this sort, but, then why would a process
release and then ask for another if that is not what it
wanted to do.
> 
> The main reason I changed this in my patch is to avoid the CONFIG
> limit on the number of timers.  Since I don't have the fixed array,
> I need a way to safely translate a user-space id into a kernel pointer.

I think this is independent of the reuse of the timer id.  I
like your id indexing except for the extra code and memory
required by the delayed reuse.

-g
> 
> Jim Houston Concurrent Computer Corp.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
