Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbULXStb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbULXStb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULXSta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:49:30 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9621 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261433AbULXSt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:49:27 -0500
Date: Fri, 24 Dec 2004 19:48:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [1/4]
Message-ID: <20041224184844.GK13747@dualathlon.random>
References: <20041224173519.GB13747@dualathlon.random> <20041224100016.530a004c.davem@davemloft.net> <20041224182031.GG13747@dualathlon.random> <1103913664.3921.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103913664.3921.2.camel@krustophenia.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 01:41:03PM -0500, Lee Revell wrote:
> On Fri, 2004-12-24 at 19:20 +0100, Andrea Arcangeli wrote:
> > Yep, I remeber this was the case in some old alpha. But did they
> > support smp too? I can't see how that old hardware could support smp.
> > If they're UP they're fine.
> 
> Isn't there still a race with PREEMPT?  Or am I missing something?

I was thinking the same right now, OTOH used_math is most important
during exceptions and sure preempt can't affect exceptions.

There are a few corner cases that you'd need to check to know if
used_math can be changed during normal kernel context and not only
during exceptions. Probably it's racy though. But what's the point of
enabling preempt in such an ancient hardare?

I'm not against fixing it up though, but at least we'd need a

#define _HAVE_BYTE_ATOMIC_GRANULARITY
#define _HAVE_SHORT_ATOMIC_GRANULARITY

(assuming short is the minimal smp atomic granularity we support in
linux)

to be able to write optimal code for anything that 99.999% of the
userbase would be using.
