Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSJ3AAq>; Tue, 29 Oct 2002 19:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSJ3AAq>; Tue, 29 Oct 2002 19:00:46 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42649 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262409AbSJ3AAo>; Tue, 29 Oct 2002 19:00:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 16:16:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029112045.GA19970@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210291609470.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > IMHO sys_epoll is going to be a replacement for rt-signals, because it
> > scales better, it collapses events and does not have the overflowing queue
> > problem.
>
> Scalability is also solved by the signal-per-fd patch, as you know.
> The main advantage of epoll is that it's lighter weight than rt-signals.
>
> (IMHO signal-per-fd really ought to be included in 2.6 _anyway_, regardless
> of any better mechanism for reading events.)

It scales pretty good, yes. You have to be carefull to build your kernel
with a huge queue to avoid SIGIO, that makes you pay somthing. Also does
not support pipes.


> > The sys_epoll interface was coded to use the existing infrastructure w/out
> > adding any legacy code added to suite the implementation. Basically,
> > besides the few lines added to fs/pipe.c to support pipes ( rt-signal did
> > not support them ), the hook lays inside sk_wake_async().
>
> I agree that was the way to do it for 2.4 and earlier - you have to
> work with a range of kernels, and minimum impact.
>
> But now in 2.5 it's appropriate to implement whatever's _right_.

Yes Jamie, you can add sys_epoll support for other devices but IMHO the
only devices where you're going to have scalability problems due huge
number of handled fds are 1) sockets 2) pipes. I feel that devices that do
not go over 100-500 can be easily handled with the fully supportive
poll(). The fact that you can drop a sys_epoll fd inside a poll() set,
garanties you 1) scalability due the stocking of sockets+pipes inside the
sys_epoll fd 2) compatibility with the full set of devices. This w/out
screwing up much the kernel code. What do you think ?



- Davide


