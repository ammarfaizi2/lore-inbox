Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131332AbRCHLoC>; Thu, 8 Mar 2001 06:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRCHLnw>; Thu, 8 Mar 2001 06:43:52 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:39918 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131332AbRCHLnn>; Thu, 8 Mar 2001 06:43:43 -0500
Message-ID: <3AA76FF5.987E8F2F@uow.edu.au>
Date: Thu, 08 Mar 2001 22:41:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Zdenek Kabelac <kabi@i.am>
CC: ludovic <ludovic.fernandez@sun.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <3AA6A97A.1EDE6A0B@sun.com> <3AA76A53.CEC1B234@i.am>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zdenek Kabelac wrote:
> 
> > Since the linux kernel is not preemptive, the problem is a little
> > bit more complicated; A low priority kernel thread won't lose the
> > CPU while holding a lock except if it wants to. That simplifies the
> > locking problem you mention but the idea of background low priority
> > threads that run when the machine is really idle is also not this
> > simple.
> 
> You seem to have a sence for black humor right :) ?
> As this is purely a complete nonsence
> - you were talking about M$Win3.11 right ?
> (are you really the employ of Sun ??)

awww..  Don't say that.  Ludovic is a nice guy.

Look.  Suppose you have a SCHED_IDLE task which does this,
in the kernel:

down(&sem1);
down(&sem2);		/* This sleeps */

Now, a SCHED_OTHER task does this, in user space:

	for ( ; ; )
		;

We're dead.  The SCHED_IDLE task will never be scheduled,
and hence will never release sem1.  The solution to this
problem is well known but, as Ludovic says, "not simple".

-
