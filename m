Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317925AbSGKW3P>; Thu, 11 Jul 2002 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317926AbSGKW3O>; Thu, 11 Jul 2002 18:29:14 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:19721 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317925AbSGKW3M>; Thu, 11 Jul 2002 18:29:12 -0400
Message-ID: <3D2E0799.612340BF@opersys.com>
Date: Thu, 11 Jul 2002 18:32:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: mbs <mbs@mc.com>, dank@kegel.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as  
 small as possible)
References: <3D2DB5F3.3C0EF4A2@kegel.com> <3D2DD734.5A3CA6EB@mvista.com> <200207111916.PAA08197@mc.com> <3D2DE9B2.70A21F7E@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


george anzinger wrote:
> First blush is HELL YES!  The issue is accounting.  When you
> ask how long a program ran, you are looking at the
> accounting that happens on a tick.  This is where one of two
> counters gets bumped (one for system, the other for user,
> depending on what was interrupted).  This information could,
> of course, be gathered every system call/ exit and every
> context switch, BUT, there are FAR more system calls and
> context switches than 1/HZ ticks.  Thus collecting
> accounting info this way adds overhead as the system load
> increases, a VERY BAD thing IMHO.

In addition to syscall entries/exits and sched changes, you then
also need to keep track of interrupt and trap entries/exits in
order to have the complete picture. Even then, determining exactly
when you're going to return to user-space can be tricky. Your
statement is indeed accurate, exact accounting's cost increases
linearly with the number of events that occur.

Having exact accounting all the time is certainly not necessary,
but it is indeed sometimes useful. *shameless self-promotion*,
That's yet another reason why I think LTT's inclusion in the
mailing kernel would be helpful. In addition to the rest of
the capabilities it provides, it provides exact accounting for
whoever really needs it on the spot.

If you are looking for better accounting using clock ticks, then
have a look at McCanne and Torek's paper "A Randomized Sampling
Clock for CPU Utilization Estimation and Code Profiling"
presented at Usenix in '93. As the title implies, they vary
the clock to obtain random samples and therefore obtain very
accurate results about system accounting. The use of hardware
counters to obtain samples is also viable, although it's much
more arch dependent than random clock ticks.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
