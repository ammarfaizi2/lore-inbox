Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbSLEUCi>; Thu, 5 Dec 2002 15:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbSLEUCi>; Thu, 5 Dec 2002 15:02:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23291 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267430AbSLEUCg>;
	Thu, 5 Dec 2002 15:02:36 -0500
Message-ID: <3DEFB284.A209E75C@mvista.com>
Date: Thu, 05 Dec 2002 12:09:40 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH ] POSIX clocks & timers take 15 (NOT HIGH RES)
References: <Pine.LNX.4.44.0212050904390.27298-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Ok, finally starting to look at merging this, however:
> 
> This must go (we already have a timespec, there's no way it should be
> here in <asm/signal.h>):
> 
>         +#ifndef _STRUCT_TIMESPEC
>         +#define _STRUCT_TIMESPEC
>         +struct timespec {
>         +       time_t  tv_sec;         /* seconds */
>         +       long    tv_nsec;        /* nanoseconds */
>         +};
>         +#endif /* _STRUCT_TIMESPEC */

OK.
> 
> and you have things like
> 
>         +       if ((flags & TIMER_ABSTIME) &&
>         +           (clock->clock_get != do_posix_clock_monotonic_gettime)) {
>         +       }else{
>         +       }

A hang over from the high res code, I will remove the empty
else.
> 
> and
> 
>         +if (!p) {
>         +printk("in sub_remove for id=%d called with null pointer.\n", id);
>         +return(0);
>         +}

That is in there!?  I will check into and fix it.
> 
> and obviously the "nanosleep()" thing and the CLOCK_NANOSLEEP_ENTRY()
> stuff has been discussed in the unrelated thread (ie it doesn't work for
> alpha or other architectures).

Right!  I am merging this now.

I think something went into bk5 yesterday that will require
an update.  I will update to 2.5.50-bk5 with the above fixes
and sent it ... soon.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
