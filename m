Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264951AbSJ3Xht>; Wed, 30 Oct 2002 18:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJ3Xht>; Wed, 30 Oct 2002 18:37:49 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:25497 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264951AbSJ3Xhs>; Wed, 30 Oct 2002 18:37:48 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 15:53:45 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: John Gardiner Myers <jgmyers@netscape.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021030230159.GB25231@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210301547170.1405-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Jamie Lokier wrote:

> John Gardiner Myers wrote:
> > I am uncomfortable with the way the epoll code adds its own set of
> > notification hooks into the socket and pipe code.  Much better would be
> > to extend the existing set of notification hooks, like the aio poll code
> > does.
>
> Fwiw, I agree with the above (I'm having a think about it).
>
> I also agree with criticisms that epoll should test and send an event
> on registration, but only _if_ the test is cheap.  Nothing to do with
> correctness (I like the edge semantics as they are), but because
> delivering one event is so infinitesimally low impact with epoll that
> it's preferable to doing a single speculative read/write/whatever.
>
> Regarding the effectiveness of the optimisation, I'd guess that quite
> a lot of incoming connections do not come with initial data in the
> short scheduling time after a SYN (unless it's on a LAN).  I don't
> know this for sure though.

Ok Jamie, try to explain me which kind of improvement this first drop will
bring. And also, how such first drop would not bring a "confusion" for the
user, letting him think that he can go sleeping event w/out having first
received EAGAIN. Isn't it better to say "you wait for events after EAGAIN",
instead of "you wait for events after EAGAIN but after accept/connect".
The cost of the test will be basically the cost of a ->poll(), that is
exactly the same cost of the very first read()/write() that you would do
by following the current API rule.



- Davide


