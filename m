Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbSKSUrR>; Tue, 19 Nov 2002 15:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbSKSUrQ>; Tue, 19 Nov 2002 15:47:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:61828 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267217AbSKSUrO>; Tue, 19 Nov 2002 15:47:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 12:54:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021119205733.GE22001@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211191253100.1918-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Mark Mielke wrote:

> On Tue, Nov 19, 2002 at 11:51:40AM -0800, Davide Libenzi wrote:
> > On Tue, 19 Nov 2002, Grant Taylor wrote:
> > > If we're bound to poll small sets of epoll fds perhaps a bit of
> > > improvement in poll would be worthwhile.  I should go look at my
> > The current poll() with a number of fds you're talking about, scales
> > beautifully.
>
> For event loops that need minimal latency for high priority events
> (even at the cost of higher latency for low priority events), poll()
> of epoll fds may allow greater optimization opportunities, as the
> epoll fd set is dynamically adjusted without extra system code
> overhead.
>
> Example: Code that expects that at least one high priority event may
> be ready (for example, after dispatching events during the previous
> iteration) can choose to first only poll(0) the epoll fds responsible
> for the high priority event sets. Only if poll(0) returns no high
> priority epoll fds, would poll(timeout) then be issued on all epoll
> fds. This would result in a very short dispatch path for events for
> high priority events.
>
> What we really need is a few actual event loop implementations to test
> all of these theories. I would find it especially nice if the code
> could be ported to 2.4.x... :-)

I think it's better to wait to define the final interface ( and eventpoll
code bits ) before starting the 2.4.x backport patch.



- Davide


