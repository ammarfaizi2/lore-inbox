Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSJ3FfP>; Wed, 30 Oct 2002 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSJ3FfP>; Wed, 30 Oct 2002 00:35:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19840 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263986AbSJ3FfO>; Wed, 30 Oct 2002 00:35:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 21:51:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021030002644.GB22170@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210292145300.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Jamie Lokier wrote:

> > 1) "issuing a command to an IDE disk" == "using read/write until EAGAIN"
> > 2) "adding yourself on the IDE disk wait queue" == "calling sys_epoll_wait()"
>
> That is quite a good analogy.  epoll is like a waitqueue - which is
> also like a futex.  To use a waitqueue properly you have do these
> things in the order shown:
>
> 	1. Set the task state to stopped.
> 	2. Register yourself on the waitqueue.
> 	3. Check the condition.
> 	4. If condition is not met, schedule.
>
> With epoll it is very similar.  To wait for a condition on a file
> descriptor, such as readability, you must do these things in the order
> shown:
>
> 	1. Register your interest using epoll_ctl.
> 	2. Check the condition by actually calling read().
> 	3. If the condition is not met (i.e. read() returned EAGAIN),
> 	   call epoll_wait (i.e. equivalent to schedule).
>
> With epoll, you can optimise by registering interest just once.  In
> other words, steps 2 and 3 may be repeated without repeating step 1.
>
> And if you are concerned about starvation -- that is, one of your file
> descriptors always has new data so others don't get a chance to be
> serviced -- don't be.  You don't have to completely read one fd until
> you see EGAIN.  All that matters is that until you see the EAGAIN,
> your user space data structure should have a flag that says the fd is
> still readable, so another epoll event is not expected or required for
> that fd.

I would say more about this. I did not understand the interface until I
read this one :-)
Hanna, is it possible for you to make Jamie description to fit the epoll.2
man page ?
If you can do that I'll send you the source of the man page ...



- Davide



