Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJ1XrK>; Mon, 28 Oct 2002 18:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSJ1XrK>; Mon, 28 Oct 2002 18:47:10 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19097 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261206AbSJ1XrJ>; Mon, 28 Oct 2002 18:47:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 16:02:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021028234434.GB18415@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210281556020.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > sys_epoll, by plugging directly in the existing kernel architecture,
> > supports sockets and pipes. It does not support and there're not even
> > plans to support other devices like tty, where poll() and select() works
> > flawlessy. Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
> > can mix sys_epoll handling with other methods like poll() and the AIO's
> > POLL function when it'll be ready. For example, for devices that sys_epoll
> > intentionally does not support, you can use a method like :
>
> :( I was hoping sys_epoll would be scalable without increasing the
> number of system calls per event.
>
> Is it too much work to support all kinds of fd?  It would be rather a
> good thing IMHO.
>
> I'm thinking that a typical generic event handling library (like in a
> typical home grown server) takes a set of fds and event handling
> callbacks.  sys_epoll is obviously not so trivial to use in place of a
> poll() loop, because the library needs to fstat() each fd that is
> registered to decide if epoll will return events for that fd.
>
> For that to work, it's important that you can determine, through
> fstat(), whether sys_epoll will actually return events for the fd, or
> whether a sigqueue event is needed to trigger the epoll read.
>
> So, is it exactly _all_ sockets and pipes, and nothing else?
>
> Btw, is the set of fd types supported by epoll the same as the set of
> fd types supported by SIGIO?  That would be convenient - and logical.

Jamie, doing that is not a real problem. The fact is that sys_epoll aimed
to solve issues where scalability on huge number of fds is involved. By
covering sockets ( network connections ) and pipes ( cgi execution ) you
have a pretty wide scalability addressing. Usually you know from where and
fd born, so you're typically able to handle it correctly. Those reasons,
togheter with the fact that I did not want to introduce revolutions in the
kernel, drove me to limit the sys_epoll coverage to sockets and pipes.



- Davide



