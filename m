Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313724AbSD1GD5>; Sun, 28 Apr 2002 02:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313882AbSD1GD5>; Sun, 28 Apr 2002 02:03:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57335 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S313724AbSD1GD4>;
	Sun, 28 Apr 2002 02:03:56 -0400
Message-ID: <3CCB9080.EA1E0DB0@mvista.com>
Date: Sat, 27 Apr 2002 23:02:40 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <E171Ym8-0000iP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > I remain unconvinced. Firstly the timer changes do not have to
> > > occur at schedule rate unless your implementaiton is incredibly naiive.
> >
> > OK, I'll bite, how do you stop a task at the end of its slice if you
> > don't set up a timer event for that time?
> 
> At high scheduling rate you task switch more often than you hit the timer,
> so you want to handle it in a lazy manner most of the time. Ie so long as
> the timer goes off before the time slice expire why frob it

So then we test for this condition (avoiding races, of course) and if
so, what?  We will have a timer interrupt prior to the slice end, and
will have to make this decision all over again.  However, the real rub
is that we have to keep track of elapsed time and account for that (i.e.
shorten the remaining slice) not only in the timer interrupt, but each
context switch.  We are still doing more work each schedule and making
it "smaller" just puts off the inevitable, i.e. at some level of
scheduling activity we will accumulate more time in this accounting code
than in the current "flat" or constant overhead way of doing things.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
