Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTL1R5i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTL1R5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:57:36 -0500
Received: from a0.complang.tuwien.ac.at ([128.130.173.25]:14349 "EHLO
	a0.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261850AbTL1R4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:56:03 -0500
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <17tHK-3K6-21@gated-at.bofh.it>
Date: Sun, 28 Dec 2003 17:17:34 GMT
Message-ID: <2003Dec28.181734@a0.complang.tuwien.ac.at>
References: <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>And you should realize that I do not dispute it because the applications
>themselves would run slower with cache coloring.

Ok, I guess I misunderstood that until now.

> Most applications don't
>much care,

Yes, at least as long as the associativity is high enough.

> they either fit in the cache, or the cache misses have random
>enough access patterns that cache layout doesn't much matter.

Random mapping hurts those applications most that do fit in the cache
in principle, but that have enough hot memory (whether accessed
regularly or randomly) that random mapping usually introduces cache
conflicts (this will happen for many applications with direct-mapped
caches, but hardly ever with high-associativity caches).

>And it has to be better on average on _everything_ that Linux supports,
>not just one particular braindamaged piece of hardware. I'm totally not
>interested in something that makes performance on most machines go down,
>if it then improves one or two braindead setups with direct-mapped caches.

As has been discussed in another thread, direct-mapped caches seem to
pretty standard for off-chip caches, and this is not just a
braindamage issue: Higher associativity requires more wires to the
tags, and also to the data, if you want to access the data in parallel
with the tags for lower latency.  Running a lot of wires off-chip is a
problem.  So the choices are:

- Small on-chip cache with high associativity.

- Medium cache with off-chip data, on-chip tags, high associativity
and high latency.

- Large cache with off-chip data and off-chip tags, and low
associativity.

However, over time off-chip caches seem to become less commonplace, so
we may get rid of low associativity for L2/L3 caches eventually.

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
