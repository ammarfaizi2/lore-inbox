Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281934AbRKUSLh>; Wed, 21 Nov 2001 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281927AbRKUSL1>; Wed, 21 Nov 2001 13:11:27 -0500
Received: from [213.97.45.174] ([213.97.45.174]:22022 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S281395AbRKUSLT>;
	Wed, 21 Nov 2001 13:11:19 -0500
Date: Wed, 21 Nov 2001 19:10:43 +0100 (CET)
From: Pau Aliagas <pau@newtral.com>
X-X-Sender: <pau@pau.intranet.ct>
To: Dave McCracken <dmccr@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Jeff Long <jeffwlong@hotmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] Re: Zombies with 2.4.15pre5 (exit.c)
In-Reply-To: <41490000.1006272492@baldur>
Message-ID: <Pine.LNX.4.33.0111211908210.1844-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Dave McCracken wrote:

> > Running 2.4.15pre5 (UP) on i386, running UML 2.4.14-2.
> > UML processes create threads on the host system that don't
> > die.  Threads are stuck at do_exit( ), so I backed out the
> > patch to kernel/exit.c @ 539 (in 2.4.15pre5 patch):
> > 
> >   p->state = TASK_DEAD;
> > 
> > and things work fine.  I do not see zombies with anything
> > other than UML processes/native threads.
> 
> The intent of the original patch was to make the task unfindable to other
> waiters, which fixed a race condition in sys_wait4().  My assumption was
> that the task was about to be cleaned up in release_task().  What I missed
> was that there are a couple of code paths that don't release the task, but
> assume it'll be cleaned up later.
> 
> The patch below should fix the problem.

It doesn't for me.
I'll try OGAWA Hirofumi's patch -posted to the list- and let you know.

Pau



