Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbRGFSpO>; Fri, 6 Jul 2001 14:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266790AbRGFSpE>; Fri, 6 Jul 2001 14:45:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62473 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265245AbRGFSo5>; Fri, 6 Jul 2001 14:44:57 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why Plan 9 C compilers don't have asm("")
Date: Fri, 6 Jul 2001 18:44:31 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9i50uf$tla$1@penguin.transmeta.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010704002436.C1294@ftsoj.fsmlabs.com> <9hvjd4$1ok$1@penguin.transmeta.com> <20010706023835.A5224@ftsoj.fsmlabs.com>
X-Trace: palladium.transmeta.com 994445095 23486 127.0.0.1 (6 Jul 2001 18:44:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Jul 2001 18:44:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010706023835.A5224@ftsoj.fsmlabs.com>,
Cort Dougan  <cort@fsmlabs.com> wrote:
>I'm talking about _modern_ processors, not processors that dominate the
>modern age.  This isn't x86.

NONE of my examples were about the x86.

I gave the alpha as a specific example.  The same issues are true on
ia64, sparc64, and mips64.  How more "modern" can you get? Name _one_
reasonably important high-end CPU that is more modern than alpha and
ia64.. 

On ia64, you probably end up with function calls costing even more than
alpha, because not only does the function call end up being a
synchronization point for the compiler, it also means that the compiler
cannot expose any parallelism, so you get an added hit from there.  At
least with other CPU's that find the parallelism dynamically they can do
out-of-order stuff across function calls. 

>Unconditional branches are definitely predictable so icache pre-fetches are
>not more complicated that straight-line code.

Did you READ my mail at all?

Most of these "unconditional branches" are indirect, because rather few
64-bit architectures have a full 64-bit branch.  That means that in
order to predict them, you either have to do data-prediction (pretty
much nobody does this), or you have a branch target prediction cache,
which works very well indeed but has the problem that it only works for
stuff in the cache, and the cache tends to be fairly limited (because
you need to cache the whole address - it's more than a "which direction
do we go in"). 

There are lots of good arguments for function calls: they improve icache
when done right, but if you have some non-C-semantics assembler sequence
like "cli" or a spinlock that you use a function call for, that would
_decrease_ icache effectiveness simply because the call itself is bigger
than the instruction (and it breaks up the instruction sequence so you
get padding issues). 

		Linus
