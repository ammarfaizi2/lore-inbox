Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318890AbSICRuo>; Tue, 3 Sep 2002 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSICRuo>; Tue, 3 Sep 2002 13:50:44 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:33929 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318890AbSICRun>; Tue, 3 Sep 2002 13:50:43 -0400
Date: Tue, 3 Sep 2002 19:55:09 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031844430.30462-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209031858090.10770-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Ingo Molnar wrote:

> On Tue, 3 Sep 2002, Tobias Ringstrom wrote:
> 
> > [...] It's a deadline driven semi realtime process.
> 
> > [...] I see three simple ways to solve the problem without changing the
> > scheduler.  Either run the process with nice -20, use SCHED_RR, or use a
> > dedicated server with no other processes (such as crond, httpd, etc).  
> > The first two might be OK, but you need root privilegies to run renice
> > and to change the scheduler policy.  The third one is not an option for
> > all users, and definately not for the video playback case.
> 
> do you see the conflict between your two statements?

Certainly, it's very hard for the kernel to do the right thing.  Perhaps 
the only viable solution is for the user to solve the problem.

Would it really be so unfair go give the user a way to state that a
process is interactive?  The kernel obviously make mistakes.  The system
is not fair for users anyway.  If a user wants to compete with other
users, he can create more processes to get more CPU.

I'm really concerned about the video decompression/playback situation,
which is quite similar, and can easily take >50% CPU.  It also very
inconvenient to have to have superuser support to get good frame rate
stability.  A way to define a process as interactive is one way to solve
that problem.  Another solution is to let ordinary users use negative nice
values, as you mention below.

> but, i have a spare plan for this, mentioned previously: to enable
> unprivileged processes to lower their priority to -5 if they want to.
> Could you please test your game server, does it feel interactive enough at
> -5?

It helps a little, but the problem is still very visible.

> (allowing -10 might be too much of a stretch.)

Why?  If it's using more than 50% CPU, the prio will be the same as a 
zero-niced interactive process.

The minimum user nice value might be a good candidate for a new rlimit...

/Tobias

