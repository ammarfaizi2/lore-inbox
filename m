Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSKRRhP>; Mon, 18 Nov 2002 12:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSKRRhP>; Mon, 18 Nov 2002 12:37:15 -0500
Received: from findaloan-online.cc ([216.209.85.42]:3596 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S263986AbSKRRhN>;
	Mon, 18 Nov 2002 12:37:13 -0500
Date: Mon, 18 Nov 2002 12:51:15 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021118175115.GA12968@mark.mielke.cc>
References: <Pine.LNX.4.44.0211180753090.979-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211180753090.979-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 08:05:32AM -0800, Davide Libenzi wrote:
> 1) epoll's event structure extension
> I received quite a few request to extend the event structure to have space
> for an opaque user data object. The eventpoll event structure will turn to
> be :
> struct epollfd {
> 	int fd;
> 	unsigned short int events, revents;
> 	unsigned long obj;
> };

As long as people most people make use of 'obj', this
will be a good thing.

I would be tempted to go the read(), read64() route on this. It makes
everything a mess, but it probably means a more efficient
implementation.

> 2) epoll bits in glibc
> I was talking to Ulrich Drepper about adding epoll bits inside glibc. His
> first objection was to store epoll bits inside poll.h, that IMHO is wrong
> because epoll semantics are completely different from poll(). My idea of
> the <sys/epoll.h> include file would be this :
> ...
> But he does not like epoll to include <bits/poll.h> and he  would like
> epoll to redefine POLLIN, POLLOUT, ... to EPOLLIN, EPOLLOUT, ...
> In my opinion it is right for epoll to include <bits/poll.h> because those
> are bits that f_op->poll() returns, and renaming those bits inside another
> include file will require more maintainance. If the kernel will be
> extended to support more POLL* bits, they will have to go only inside
> <bits/poll.h> w/out having another file to be updated IMHO.

If you can guarantee that epoll will always be compatible with poll() in
terms of objects that can be watched, and events that can be watched, I
would lean towards your preference. If this guarantee cannot be made, I
would lean toward Ulrich's preference.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

