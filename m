Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVJCBxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVJCBxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJCBxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:53:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932113AbVJCBxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:53:47 -0400
Date: Sun, 2 Oct 2005 21:53:39 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051003012604.GO6290@lkcl.net>
Message-ID: <Pine.LNX.4.63.0510022145360.27456@cuia.boston.redhat.com>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.63.0510021922290.27456@cuia.boston.redhat.com>
 <20051003012604.GO6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:

>  how about message passing by reference - a la c++? 

>  _and_ you use the parallel message bus to communicate memory
>  allocation, locking, etc.

Then you lose.  It's the act of passing itself that causes
scalability problems and a loss of performance.

The best way to get SMP scalability is to avoid message
passing alltogether, using things like per-cpu data
structures and RCU.

Not having to pass a message is faster than any message
passing mechanism.

>  ... but i digress - but enough to demonstrate, i hope, that
>  this isn't some "pie-in-the-sky" thing,

You've made a lot of wild claims so far, most of which I'm
not ready to belief without some proof to back them up.

>  it's one hint at a solution to the problem that a lot of hardware
>  designers haven't been able to solve, and up until now they haven't
>  had to even _consider_ it.

The main problem is that communication with bits of silicon
four inches away is a lot slower, or takes much more power,
than communication with bits of silicon half a millimeter away.

This makes cross-core communication, and even cross-thread
communication in SMT/HT, slower than not having to have such
communication at all.

>  the question is - and i iterate it again: can the present
>  linux kernel design _cope_ with such monster parallelism?

The SGI and IBM people seem fairly happy with current 128 CPU
performance, and appear to be making serious progress towards
512 CPUs and more.

>  question _that_ raises: do you _want_ to [make it cope with such
>  monster parallelism]?
> 
>  and if the answer to that is "no, definitely not", then the
>  responsibility can be offloaded onto a microkernel,

No, that cannot be done, for all the reasons I mentioned
earlier in the thread.

Think about something like the directory entry cache (dcache),
all the CPUs need to see that cache consistently, and you cannot
avoid locking overhead by having the locking done by a microkernel.

The only way to avoid locking overhead is by changing the data
structure to something that doesn't need locking.

No matter how low your locking overhead - once you have 1024
CPUs it's probably too high.

-- 
All Rights Reversed
