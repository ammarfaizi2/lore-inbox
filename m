Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318982AbSHSSwF>; Mon, 19 Aug 2002 14:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSHSSwE>; Mon, 19 Aug 2002 14:52:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40689 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318982AbSHSSwE>;
	Mon, 19 Aug 2002 14:52:04 -0400
Message-ID: <3D613F20.9E5E3B84@mvista.com>
Date: Mon, 19 Aug 2002 11:55:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
References: <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain> <61100000.1029781898@baldur.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> --On Monday, August 19, 2002 08:08:10 PM +0200 Ingo Molnar <mingo@elte.hu>
> wrote:
> 
> > the problem is that the tracing task wants to do a wait4() on all traced
> > children, and the only way to get that is to have the traced tasks in the
> > child list. Eg. strace -f traces a random number of tasks, and after the
> > PTRACE_CONTINUE call, the wait4 done by strace must be able to 'get
> > events' from pretty much any of the traced tasks. So unless the ptrace
> > interface is reworked in an incompatible way, i cannot see how this would
> > work. wait4 could perhaps somehow search the whole tasklist, but that
> > could be a pretty big pain even for something like strace.
> 
> It seems to me it would be worth adding list_heads in the task struct for
> ptraced tasks and ptraced siblings if it gets rid of the reparenting.
> 
That and then each time a SIGCHILD is sent, it is also sent
to the tracer, if there is one.  Some filtering may be
needed here as the real parent should not be disturbed by
trace ONLY things.  It has been done on other systems.  Not
super clean, but it does push Heisenberg out a ring or two. 
The current way its done, a child can not get the pid of its
father and thus would NEED to know it was being traced in
order to do anything that required such.  This is asking
Heisenberg to live somewhere more or less close by :)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
