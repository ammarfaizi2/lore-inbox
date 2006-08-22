Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWHVHZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWHVHZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHVHZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:25:33 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27595 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751314AbWHVHZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:25:32 -0400
Date: Tue, 22 Aug 2006 11:24:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nicholas Miell <nmiell@comcast.net>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060822072448.GA5126@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156230051.8055.27.camel@entropy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 11:24:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:00:51AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> On Mon, 2006-08-21 at 14:19 +0400, Evgeniy Polyakov wrote:
> > Generic event handling mechanism.
> 
> Since this is the sixth[1] event notification system that's getting
> added to the kernel, could somebody please convince me that the
> userspace API is right this time? (Evidently, the others weren't and are
> now just backward compatibility bloat.)
> 
> Just looking at the proposed kevent API, it appears that the timer event
> queuing mechanism can't be used for the queuing of POSIX.1b interval
> timer events (i.e. via a SIGEV_KEVENT notification value in a struct
> sigevent) because (being a very thin veneer over the internal kernel
> timer system) you can't specify a clockid, the time value doesn't have
> the flexibility of a struct itimerspec (no re-arm timeout or absolute
> times), and there's no way to alter, disable or query a pending timer or
> query a timer overrun count.
> 
> Overall, kevent timers appear to be inconvenient to use and limited
> compared to POSIX interval timers (excepting the fact you can read their
> expiray events out of a queue, of course).
 
Kevent timers are just trivial kevent user.
But even as is it is not that bad solution.
I, as user, do not want to know which timer is used  - I only need to
get some signal when interval completed, especially I do not want to
have some troubles when timer with given clockid has disappeared.
Kevent timer can be trivially rearmed (acutally it is always rearmed 
until one-shot flag is set).
Of course it can be disabled by removing requested kevent.
I can add possibility to alter timeout without removing kevent if there
is strong requirement for that.

Timer notifications were designed not from committee point of view, when
theoretical discussions end up in multi-megabyte documentation 99.9% of
which can not be used without major brain surgery.

I just implemented what I use, if you want more - say what you need.
 
> [1] Previously: select, poll, AIO, epoll, and inotify. Did I miss any?

Let me guess - kevent, which can do all above and a lot of other things?
And you forget netlink-based notificators - netlink, rtnetlink,
gennetlink, connector and tons of accounting application based on them,
kobject, kobject_uevent.
There also filessytem based ones - sysfs, procfs, debugfs, relayfs.

> -- 
> Nicholas Miell <nmiell@comcast.net>

-- 
	Evgeniy Polyakov
