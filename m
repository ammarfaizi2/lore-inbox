Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269136AbSIRSJk>; Wed, 18 Sep 2002 14:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269172AbSIRSJk>; Wed, 18 Sep 2002 14:09:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2976 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S269136AbSIRSJj>;
	Wed, 18 Sep 2002 14:09:39 -0400
Date: Wed, 18 Sep 2002 20:21:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: yodaiken@fsmlabs.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918120004.A13778@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0209182015450.25598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002 yodaiken@fsmlabs.com wrote:

> So Solaris made a stupid design decision to encourage people to use a
> thread per call on these big systems and Linux should make the same
> decision for compatibility?

if it can be done, why not? Do you advocate the using of big select()
loops and userspace threading libraries?

i have to admit that there's an inherent simplicity in using one thread
per line, and for the more critical systems it's the simplicity that
matters alot. One process per line would be even nicer - but that has a
much higher resource footprint. While it could all be rewritten into a
IRQ-driven state-machine as well, i dont think that is economic nor
manageable for every case. Guess why Apache is still using the model of
threads/processes, with a serial workflow done by them, and not the model
of an async state-machine that TUX uses.

> I can see why people want this: they have huge ugly systems that they
> would like to port to Linux with as little effort as possible. But it's
> not free for the OS either.

i believe if you do not see the dangers of O(N^2) algorithms then you
should not do RT coding. While it's not at all the goal of the patch i
sent, with some effort we can make Linux to behave in an RT-correct way if
a subset of APIs are used and drivers are carefully controlled.

	Ingo

