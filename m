Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSGUQYt>; Sun, 21 Jul 2002 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGUQYt>; Sun, 21 Jul 2002 12:24:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47528 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314938AbSGUQYs>;
	Sun, 21 Jul 2002 12:24:48 -0400
Date: Sun, 21 Jul 2002 18:26:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
In-Reply-To: <ahau4q$1n2$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207211817200.17344-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jul 2002, Linus Torvalds wrote:

> The thing is, nobody should really ever use timeouts, because the notion
> of "I want to sleep X seconds" is simply not _useful_ if the process
> also just got delayed by a page-out event as it said so.  What does "X
> seconds" mean at that point? It's ambiguous - and the kernel will (quite
> naturally) just always assume that it is "X seconds from when the kernel
> got notified".
> 
> A _useful_ interface would be to say "I want to sleep to at most time X"
> or "to at least time X".  Those are unambiguous things to say, and are
> not open to interpretation.

on the other hand, the application itself cannot even know what exact
absolute time it is, in any unambiguous form - what if right after the
gettimeofday() it got scheduled away and swapped out for many seconds?

so the notion of 'sleep until absolute time X' just brings the 'time
uncertainity' down one more level, it doesnt eliminate it.

the rounding issue is valid when an unlimited number of restarts are
allowed - N x relative timeouts are numerically inaccurate. But there is
no fundamental difference (only performance difference): correct timeouts
can be achieved even if the kernel interface only supports relative
timeouts: the application has to save the absolute target time and has to
recalculate the relative timeout based on the target date and current
date. (which involves multiple calls to gettimeofday(), so it's additional
overhead.)

	Ingo

