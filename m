Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSKRSaW>; Mon, 18 Nov 2002 13:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSKRSaW>; Mon, 18 Nov 2002 13:30:22 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17030 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263491AbSKRSaS>; Mon, 18 Nov 2002 13:30:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 10:37:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021118175115.GA12968@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211181034290.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Mark Mielke wrote:

> On Mon, Nov 18, 2002 at 08:05:32AM -0800, Davide Libenzi wrote:
> > 1) epoll's event structure extension
> > I received quite a few request to extend the event structure to have space
> > for an opaque user data object. The eventpoll event structure will turn to
> > be :
> > struct epollfd {
> > 	int fd;
> > 	unsigned short int events, revents;
> > 	unsigned long obj;
> > };
>
> As long as people most people make use of 'obj', this
> will be a good thing.
>
> I would be tempted to go the read(), read64() route on this. It makes
> everything a mess, but it probably means a more efficient
> implementation.

At that point I prefer to have it directly a 64bit int.



> > 2) epoll bits in glibc
> > I was talking to Ulrich Drepper about adding epoll bits inside glibc. His
> > first objection was to store epoll bits inside poll.h, that IMHO is wrong
> > because epoll semantics are completely different from poll(). My idea of
> > the <sys/epoll.h> include file would be this :
> > ...
> > But he does not like epoll to include <bits/poll.h> and he  would like
> > epoll to redefine POLLIN, POLLOUT, ... to EPOLLIN, EPOLLOUT, ...
> > In my opinion it is right for epoll to include <bits/poll.h> because those
> > are bits that f_op->poll() returns, and renaming those bits inside another
> > include file will require more maintainance. If the kernel will be
> > extended to support more POLL* bits, they will have to go only inside
> > <bits/poll.h> w/out having another file to be updated IMHO.
>
> If you can guarantee that epoll will always be compatible with poll() in
> terms of objects that can be watched, and events that can be watched, I
> would lean towards your preference. If this guarantee cannot be made, I
> would lean toward Ulrich's preference.

epoll does hook f_op->poll() and hence uses the asm/poll.h bits.




- Davide


