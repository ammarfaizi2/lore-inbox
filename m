Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278960AbRKFKYp>; Tue, 6 Nov 2001 05:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRKFKYg>; Tue, 6 Nov 2001 05:24:36 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:21391 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278924AbRKFKYQ>; Tue, 6 Nov 2001 05:24:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Tue, 6 Nov 2001 11:25:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E160sYK-0003WR-00@wagner>
In-Reply-To: <E160sYK-0003WR-00@wagner>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011106102406Z16651-12382+37@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 11:48 pm, Rusty Russell wrote:
> In message <20011105033316Z16051-18972+45@humbolt.nl.linux.org> you write:
> > Yes, sold, if implementing the formatter is part of the plan.
> > 
> > Caveat: by profiling I've found that file ops on proc functions are already
> > eating a significant amount of cpu, going to one-value-per-file is going to 
> > make that worse.  But maybe this doesn't bother you.
> 
> What concerns me most is the pain involved in writing a /proc or
> sysctl interface in the kernel today.  Take kernel/module.c's
> get_ksyms_list as a typical example: 45 lines of code to perform a
> very trivial task.  And this code is sitting in your kernel whether
> proc is enabled or not.  Now, I'm a huge Al Viro fan, but his proposed
> improvements are in the wrong direction, IMHO.
> 
> My first priority is to have the most fool-proof possible inner kernel
> interface.  Second is trying to preserve some of the /proc features
> which actually work well when correctness isn't a huge issue (such as
> "give me everything in one table").  Efficiency of getting these
> things out of the kernel is a distant last (by see my previous comment
> on adapting sysctl(2)).
> 
> I'd like to see /proc (/proc/sys) FINALLY live up to its promise
> (rich, logical, complete) in 2.5.  We can do this by making it the
> simplest option for coders and users.

This is without a doubt the most levelheaded comment I've seen in the thread. 

I'm looking at all those 6+ parameter calls and thinking about cleaning that
up with a struct, which is really what it's trying to be.  I see lots of
proc reads ending with a boringly similar calc_metrics call, this is trying
to move out to the caller.  I'd hope this kind of cleanup, at least, is
noncontroversial.

--
Daniel
