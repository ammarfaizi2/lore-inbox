Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSLJXGL>; Tue, 10 Dec 2002 18:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbSLJXGL>; Tue, 10 Dec 2002 18:06:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:53750 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266852AbSLJXGH>;
	Tue, 10 Dec 2002 18:06:07 -0500
Message-ID: <3DF674BC.53DA7603@mvista.com>
Date: Tue, 10 Dec 2002 15:11:56 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Mikael Starvik <mikael.starvik@axis.com>,
       "'Daniel Jacobowitz'" <dan@debian.org>,
       "'Jim Houston'" <jim.houston@ccur.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'David S. Miller'" <davem@redhat.com>, "'ak@muc.de'" <ak@muc.de>,
       "'davidm@hpl.hp.com'" <davidm@hpl.hp.com>,
       "'schwidefsky@de.ibm.com'" <schwidefsky@de.ibm.com>,
       "'ralf@gnu.org'" <ralf@gnu.org>,
       "'willy@debian.org'" <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE4E9@mailse01.axis.se>
		<Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com> <15861.12698.361774.252071@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
> Linus Torvalds writes:
> 
> > Note that I've not committed the patch to my tree at all, and as far as I
> > am concerned this is in somebody elses court (ie somebody that cares about
> > restarting). I don't have any strong feelings either way about how
> > restarting should work - and I'd like to have somebody take it up and
> > testing it as well as having architecture maintainers largely sign off on
> > this approach.
> 
> There is a simpler way to solve the nanosleep problem which doesn't
> involve any more restart magic than we have been using for years.
> That is to define a new sys_new_nanosleep system call which takes one
> argument which is a pointer to the time to sleep.  If the sleep gets
> interrupted by a pending signal, the kernel sys_new_nanosleep will
> write back the remaining time (overwriting the requested time) and
> return -ERESTARTNOHAND.  The glibc nanosleep() then looks like this:
> 
> int nanosleep(const struct timespec *req, struct timespec *rem)
> {
>         *rem = *req;
>         return new_nanosleep(rem);
> }
> 
> Any reason why this can't work?
> 
> (BTW this is Rusty's idea. :)
> 
This all started because the standard says nano_sleep should
wake up delta time from when it went to sleep.  To this one
would need to save the absolute time, not the time
remaining.  In other words, while ptrace or what ever are
doing there thing, time IS passing.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
