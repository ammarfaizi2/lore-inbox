Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSKSB0k>; Mon, 18 Nov 2002 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKSB0k>; Mon, 18 Nov 2002 20:26:40 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:45955 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265096AbSKSB0j>;
	Mon, 18 Nov 2002 20:26:39 -0500
Date: Tue, 19 Nov 2002 01:34:00 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ulrich Drepper <drepper@redhat.com>, Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119013400.GC4377@bjl1.asuk.net>
References: <20021118225625.GB3939@bjl1.asuk.net> <Pine.LNX.4.44.0211181553430.979-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211181553430.979-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > 1. Fwiw, I would really like to see epoll extended beyond fds, to a more
> > general edge-triggered event collector - signals, timers, aios.  I've
> > written about this before as you know (but been too busy lately to
> > pursue the idea).  I'm not going to say any more about this until I
> > have time to code something...
> 
> Anything that "exposes" a file* interface that support f_op->poll() is
> usable with epoll. File rocks !! :)

I agree, fds are pretty good, and it's nice that they work equally
well with poll/select/sigio as with epoll.

It's just that to write an ideal, general event loop, pollable fds
need to be created on the fly for futexes, signals, timers and aio
requests at least.  Currently this is already done for futexes.  In
addition, some kinds of event result need to return a few words of
data with each event (for example, SIGCHLD events).

Perhaps it's not a bad idea, but I do wonder whether fds created on
the fly for every requested event, and events than can only report
"readable" not anything richer than that are a good solution.

-- Jamie
