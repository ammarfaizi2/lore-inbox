Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRKFBhr>; Mon, 5 Nov 2001 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRKFBhh>; Mon, 5 Nov 2001 20:37:37 -0500
Received: from [202.135.142.194] ([202.135.142.194]:17158 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S276988AbRKFBh0>; Mon, 5 Nov 2001 20:37:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit. 
In-Reply-To: Your message of "Mon, 05 Nov 2001 04:34:19 BST."
             <20011105033316Z16051-18972+45@humbolt.nl.linux.org> 
Date: Tue, 06 Nov 2001 09:48:52 +1100
Message-Id: <E160sYK-0003WR-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011105033316Z16051-18972+45@humbolt.nl.linux.org> you write:
> Yes, sold, if implementing the formatter is part of the plan.
> 
> Caveat: by profiling I've found that file ops on proc functions are already
> eating a significant amount of cpu, going to one-value-per-file is going to 
> make that worse.  But maybe this doesn't bother you.

What concerns me most is the pain involved in writing a /proc or
sysctl interface in the kernel today.  Take kernel/module.c's
get_ksyms_list as a typical example: 45 lines of code to perform a
very trivial task.  And this code is sitting in your kernel whether
proc is enabled or not.  Now, I'm a huge Al Viro fan, but his proposed
improvements are in the wrong direction, IMHO.

My first priority is to have the most fool-proof possible inner kernel
interface.  Second is trying to preserve some of the /proc features
which actually work well when correctness isn't a huge issue (such as
"give me everything in one table").  Efficiency of getting these
things out of the kernel is a distant last (by see my previous comment
on adapting sysctl(2)).

I'd like to see /proc (/proc/sys) FINALLY live up to its promise
(rich, logical, complete) in 2.5.  We can do this by making it the
simplest option for coders and users.

Rusty.
--
Premature optmztion is rt of all evl. --DK
