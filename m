Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311105AbSCHUsO>; Fri, 8 Mar 2002 15:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311108AbSCHUsD>; Fri, 8 Mar 2002 15:48:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8181 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311105AbSCHUrr>;
	Fri, 8 Mar 2002 15:47:47 -0500
Message-ID: <3C89234B.F9F1BDD1@mvista.com>
Date: Fri, 08 Mar 2002 12:47:07 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Mar 2002, Hubertus Franke wrote:
> >
> > Could you also comment on the functionality that has been discussed.
> 
> First off, I have to say that I really like the current patch by Rusty.
> The hashing approach is very clean, and it all seems quite good. As to
> specific points:
> 
> > (I) the fairness issues that have been raised.
> >     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR
> >     or you don't care about fairness and starvation
> 
> I don't think fairness and starvation is that big of a deal for
> semaphores, usually being unfair in these things tends to just improve
> performance through better cache locality with no real downside. That
> said, I think the option should be open (which it does seem to be).
> 
> For rwlocks, my personal preference is the fifo-fair-preference (unlike
> semaphore fairness, I have actually seen loads where read- vs
> write-preference really is unacceptable). This might be a point where we
> give users the choice.
> 
> I do think we should make the lock bigger - I worry that atomic_t simply
> won't be enough for things like fair rwlocks, which might want a
> "cmpxchg8b" on x86.
> 
> So I would suggest making the size (and thus alignment check) of locks at
> least 8 bytes (and preferably 16). That makes it slightly harder to put
> locks on the stack, but gcc does support stack alignment, even if the code
> sucks right now.
> 
I think this is needed if we want to address the "task dies while
holding a lock" issue.  In this case we need to know who holds the lock.

-g

>                 Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
