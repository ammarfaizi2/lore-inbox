Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJ1Xi0>; Mon, 28 Oct 2002 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJ1Xi0>; Mon, 28 Oct 2002 18:38:26 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:28071 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261512AbSJ1XiZ>;
	Mon, 28 Oct 2002 18:38:25 -0500
Date: Mon, 28 Oct 2002 23:44:34 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: bert hubert <ahu@ds9a.nl>, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021028234434.GB18415@bjl1.asuk.net>
References: <20021028220809.GB27798@outpost.ds9a.nl> <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> sys_epoll, by plugging directly in the existing kernel architecture,
> supports sockets and pipes. It does not support and there're not even
> plans to support other devices like tty, where poll() and select() works
> flawlessy. Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
> can mix sys_epoll handling with other methods like poll() and the AIO's
> POLL function when it'll be ready. For example, for devices that sys_epoll
> intentionally does not support, you can use a method like :

:( I was hoping sys_epoll would be scalable without increasing the
number of system calls per event.

Is it too much work to support all kinds of fd?  It would be rather a
good thing IMHO.

I'm thinking that a typical generic event handling library (like in a
typical home grown server) takes a set of fds and event handling
callbacks.  sys_epoll is obviously not so trivial to use in place of a
poll() loop, because the library needs to fstat() each fd that is
registered to decide if epoll will return events for that fd.

For that to work, it's important that you can determine, through
fstat(), whether sys_epoll will actually return events for the fd, or
whether a sigqueue event is needed to trigger the epoll read.

So, is it exactly _all_ sockets and pipes, and nothing else?

Btw, is the set of fd types supported by epoll the same as the set of
fd types supported by SIGIO?  That would be convenient - and logical.

thanks,
-- Jamie (who thinks a lot about fast web servers)
