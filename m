Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUAFC3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUAFC3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:29:32 -0500
Received: from smtp7.hy.skanova.net ([195.67.199.140]:56820 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265265AbUAFC3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:29:30 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	<200401041242.47410.kernel@kolivas.org>
	<slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>
	<200401041658.57796.kernel@kolivas.org> <m2ptdxq3vf.fsf@telia.com>
	<3FFA1149.5030009@cyberone.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jan 2004 03:28:47 +0100
In-Reply-To: <3FFA1149.5030009@cyberone.com.au>
Message-ID: <m2ekudq080.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Peter Osterlund wrote:
> 
> >But the scheduler is also far from fair in this situation. If I run
> 
> snip a good analysis...
> 
> ... but fairness is not about a set of numbers the scheduler gives to
> each process, its about the amount of CPU time processes are given.
> 
> In this case I don't know if I find it objectionable that X and xterm
> are considered interactive and perl considered a CPU hog. What is the
> actual problem?

The problem is that if perl would get only slightly more cpu time, it
would get ahead of xterm, which would make this test case run
something like 10 times faster than it currently does. (Because xterm
switches to jump scrolling when it can't keep up.)

I guess it would be possible to fix this by introducing a
usleep(10000) at some strategic place in the xterm source code, but I
still find it strange that two tasks eating 40% cpu time each are
considered interactive, while a task eating 4% is considered a cpu
hog, especially since the 4% task never got a chance to prove that it
didn't want to steal all cpu time. All that was proven was that it
wanted more than 4% of the cpu.

Also, while my test case runs, other tasks (such as running "ps" from
a network login) are very slow, at least until the extra load makes
the scheduler realize that the two tasks eating most of the cpu time
should not have maximum priority bonus.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
