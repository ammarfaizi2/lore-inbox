Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSJaQVW>; Thu, 31 Oct 2002 11:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSJaQVV>; Thu, 31 Oct 2002 11:21:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22150 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262812AbSJaQVN>; Thu, 31 Oct 2002 11:21:13 -0500
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <20021031154112.GB27801@bjl1.asuk.net>
References: <20021031005259.GA25651@bjl1.asuk.net>
	<Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com> 
	<20021031154112.GB27801@bjl1.asuk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 16:45:58 +0000
Message-Id: <1036082758.8575.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 15:41, Jamie Lokier wrote:
> 	- network accept()
> 	- read/write/exception on sockets and pipes
> 	- timers
> 	- aio
> 	- futexes
> 	- dnotify events 
> 
> See how epoll only helps with the first two?  And this is the very
> application space that epoll could _almost_ be perfect for.
>
> ps. Alan, you mentioned something about futexes being suitable.
> Was that a vague notion, or do you have a clear idea in mind?
> 
> (A nice way to collect events from a _set_ of futexes might be just the thing.)

The futexes do all the high performance stuff you actually need. One way
to do it is to do user space signal delivery setting futexes off but
that means user space switches and is just wrong. Setting a list of
futexes instead of signal delivery in kernel space is fast. Letting the
user pick what futexes get set allows you to do neat stuff like trees of
wakeup without having to handle t kernel side.

What is hard is multiple futex waits and livelock for that. I think it
can be done properly but I've not sat down and designed it all out - I
wonder what Rusty thinks.

Alan

