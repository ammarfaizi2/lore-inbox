Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSKTVrr>; Wed, 20 Nov 2002 16:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKTVrr>; Wed, 20 Nov 2002 16:47:47 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:16522 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261660AbSKTVrq>;
	Wed, 20 Nov 2002 16:47:46 -0500
Date: Wed, 20 Nov 2002 21:55:40 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021120215540.GA11879@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDB09C2.3070100@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > (That said, I'm not entirely convinced that blocking signals in cfork()
> > is so bad, if we assume that cfork() is a relatively expensive
> > operation anyway...)
> 
> It could mean a signal cannot be delivered and reacted on in time.  The
> other threads could have blocked the signal which arrives.  Every time
> signals have to be blocked to implement a function something is wrong,

I don't buy this argument.  You block signals, do something, unblock
signals.  There may be a _tiny_ delay in delivering the signal - of
the order of a single system call time, i.e. not significant.  (That
delay is much shorter than signal delivery time itself).  No signals
are actually _lost_, which would be important if it could happen.

Blocking signals briefly is very similar to taking a spinlock.  It has
a small overhead, which is probably not significant in the case of
cfork() and its likely applications.

Regarding whether clone() needs a separate child tid_address pointer -
I have no strong opinion (you can implement cfork() with or without),
but you might want to consider, from Glibc's perspective, that there
aren't many argument words left for future uses..

-- Jamie
