Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317600AbSGOS5H>; Mon, 15 Jul 2002 14:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGOS5G>; Mon, 15 Jul 2002 14:57:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49169 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317600AbSGOS5F>; Mon, 15 Jul 2002 14:57:05 -0400
Date: Mon, 15 Jul 2002 11:56:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <1026750413.939.97.camel@sinai>
Message-ID: <Pine.LNX.4.33.0207151151200.19586-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 Jul 2002, Robert Love wrote:
> 
> A cleaner solution to this issue is a higher resolution timer, e.g. the
> high-res-timers project which has high resolution POSIX timers.

But that really doesn't solve the problem either.

You still need to have some limit on the timer resolution. Whether you
call that limit "HZ" or something else is irrelevant in the end. Just
calling them "high-resolution" doesn't make the problem go away, you still
have some resolution (*).

So once you set some magic limit on the fine-grained resolution (let's
call that "MAX_FINE_HZ"), you might as well realize that that really is
100% equivalent to just making HZ _be_ that value. Together with possibly
making the actual timer tick happen at a slower rate according to some
other heuristics (ie "the system doesn't need timers right now, let's just
not do them").

		Linus

(*) Which is a lot less than the hw can generate, since you mustn't allow
users to bog down the system in timer interrupts by just using
"itimer(ITIMER_REAL, .. fine-resolution..)".

