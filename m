Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280998AbRKCSEw>; Sat, 3 Nov 2001 13:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281001AbRKCSEm>; Sat, 3 Nov 2001 13:04:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9491 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280998AbRKCSE0>; Sat, 3 Nov 2001 13:04:26 -0500
Date: Sat, 3 Nov 2001 10:01:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: <jogi@planetzork.ping.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0111031304250.311-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0111030953250.1680-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Nov 2001, Mike Galbraith wrote:
>
> > Otherwise -pre5aa1 still seems to be the fastest kernel *in this test*.
>
> My box agrees.  Notice pre5aa1/ac IO numbers below.  I'm getting
> ~good %user/wallclock with pre6/pre7 despite (thrash?) IO numbers.

Well, pre7 gets the second-best numbers, and the reason I really don't
like pre5aa1 is that since pre4, the virgin kernels have had all mapped
pages in the LRU queue, and can use that knowledge to decide when to
start swapping.

So in those kernels, the balance between scanning the VM tables and
scanning the regular unmapped caches is something that is strictly
deterministic, which is something I _really_ want to have.

We've had too much trouble with the "let's hope this works" approach.
Which is why I want the anonymous pages to clearly show up in the
scanning, and not have them be these virtual ghosts that only show up when
you start swapping stuff out.

Your array cut down to just the ones that made the benchmark in under 8
minutes makes it easier to read, and clearly pre6+ seems to be a bit _too_
swap-happy. I'm trying the "dynamic max_mapped" approach now.

		Linus

