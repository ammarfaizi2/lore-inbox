Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCJOJg>; Sat, 10 Mar 2001 09:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRCJOJ0>; Sat, 10 Mar 2001 09:09:26 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:36346 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S130038AbRCJOJH>;
	Sat, 10 Mar 2001 09:09:07 -0500
Date: Sat, 10 Mar 2001 01:56:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010309210913.F13320@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.33.0103100154310.2283-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Jamie Lokier wrote:
> Rik van Riel wrote:
> > > Just raise the priority whenever the task's in kernel mode.  Problem
> > > solved.
> >
> > Remember that a task schedules itself out at the timer interrupt,
> > in kernel/sched.c::schedule() ... which is kernel mode ;)
>
> Even nicer.  On x86 change this:
>
> reschedule:
> 	call SYMBOL_NAME(schedule)    # test
> 	jmp ret_from_sys_call
>
> to this:
>
> reschedule:
> 	orl $PF_HONOUR_LOW_PRIORITY,flags(%ebx)
> 	call SYMBOL_NAME(schedule)    # test
> 	andl $~PF_HONOUR_LOW_PRIORITY,flags(%ebx)
> 	jmp ret_from_sys_call

Wonderful !

I think we'll want to use this, since we can use it for:

1. SCHED_IDLE
2. load control, when the VM starts thrashing we can just
   suspend a few processes to make sure the system as a
   whole won't thrash to death
3. ... ?

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

