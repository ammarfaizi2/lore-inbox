Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281840AbRKWAh0>; Thu, 22 Nov 2001 19:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281841AbRKWAhH>; Thu, 22 Nov 2001 19:37:07 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:2317 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S281840AbRKWAgt>; Thu, 22 Nov 2001 19:36:49 -0500
Date: Thu, 22 Nov 2001 19:36:45 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <E16744i-0004zQ-00@localhost>
Message-ID: <Pine.LNX.4.10.10111221926130.31054-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPUs, because the scheduling decision was moved away from where it really 
> should take place: the scheduler. I'm sure I'm missing something, though.

only that it's nontrivial to estimate the migration costs, I think.
at one point, around 2.3.3*, there was some effort at doing this - 
or something like it.  specifically, the scheduler kept track of 
how long a process ran on average, and was slightly more willing
to migrate a short-slice process than a long-slice.  "short" was 
defined relative to cache size and a WAG at dram bandwidth.

the rationale was that if you run for only 100 us, you probably
don't have a huge working set.  that justification is pretty thin,
and perhaps that's why the code gradually disappeared.

hmm, you really want to monitor things like paging and cache misses,
but both might be tricky, and would be tricky to use sanely.
a really simple, and appealing heuristic is to migrate a process
that hasn't run for a long while - any cache state it may have had
is probably gone by now, so there *should* be no affinity.

regards, mark hahn.

