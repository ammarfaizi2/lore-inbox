Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269660AbSIRScI>; Wed, 18 Sep 2002 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269665AbSIRScI>; Wed, 18 Sep 2002 14:32:08 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:729 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S269660AbSIRScH>;
	Wed, 18 Sep 2002 14:32:07 -0400
Date: Wed, 18 Sep 2002 12:33:53 -0600
From: yodaiken@fsmlabs.com
To: Ingo Molnar <mingo@elte.hu>
Cc: yodaiken@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918123353.B10917@hq.fsmlabs.com>
References: <20020918120004.A13778@hq.fsmlabs.com> <Pine.LNX.4.44.0209182015450.25598-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209182015450.25598-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 18, 2002 at 08:21:38PM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 08:21:38PM +0200, Ingo Molnar wrote:
> 
> On Wed, 18 Sep 2002 yodaiken@fsmlabs.com wrote:
> 
> > So Solaris made a stupid design decision to encourage people to use a
> > thread per call on these big systems and Linux should make the same
> > decision for compatibility?
> 
> if it can be done, why not? Do you advocate the using of big select()
> loops and userspace threading libraries?

I like request/servers and state machines. I also think that there
may be some smart ways to fold multiple threads into one. And there is 
nothing wrong with userspace threading libraries.

> i have to admit that there's an inherent simplicity in using one thread
> per line, and for the more critical systems it's the simplicity that

There is a simplicity acquired by pushing the complexity to somewhere else.

> matters alot. One process per line would be even nicer - but that has a
> much higher resource footprint. While it could all be rewritten into a
> IRQ-driven state-machine as well, i dont think that is economic nor
> manageable for every case. Guess why Apache is still using the model of
> threads/processes, with a serial workflow done by them, and not the model
> of an async state-machine that TUX uses.

Because Linux does not provide an easy and highly efficient API for 
building state machines and because even if it did, a crappy threads
model that runs on NT as well as Linux is more attractive.

> > I can see why people want this: they have huge ugly systems that they
> > would like to port to Linux with as little effort as possible. But it's
> > not free for the OS either.
> 
> i believe if you do not see the dangers of O(N^2) algorithms then you
> should not do RT coding. While it's not at all the goal of the patch i
> sent, with some effort we can make Linux to behave in an RT-correct way if
> a subset of APIs are used and drivers are carefully controlled.

Huh?
Just for information, don't try to apply asymptotic analysis blindly to 
bounded conditions.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

