Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281441AbRKEXyD>; Mon, 5 Nov 2001 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281442AbRKEXxx>; Mon, 5 Nov 2001 18:53:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51472 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281441AbRKEXxn>; Mon, 5 Nov 2001 18:53:43 -0500
Date: Mon, 5 Nov 2001 15:50:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111051811150.27086-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111051543440.15533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Alexander Viro wrote:
>
> Ideally we would need to predict how many (and how large) files
> will go into directory.  We can't - we have no time machines.  But
> heuristics you've mentioned is clearly broken.  It will end up with
> mostly empty trees squeezed into a single cylinder group and when
> they start to get populated that will be pure hell.

Why? Squeezing into a single cylinder group is _good_. Fragmentation is
bad.

Where's the hell? You move over to the next cylinder group when you have
90% filled one ("pick percentage randomly", and there are others that are
clearly less used.

> Benchmarks that try to stress that code tend to be something like
> cvs co, tar x, yodda, yodda.  _All_ of them deal only with "fast-growth"
> pattern.  And yes, FFS inode allocator sucks for that scenario - no
> arguments here.  Unfortunately, the variant you propose will suck for
> slow-growth one and that is going to hurt a lot.

I don't see any arguments for _why_ you claim it would hurt a lot.

Fast-growth is what we should care about from a performance standpoint -
slow growth can be sanely handled with slower-paced maintenance issues
(including approaches like "defragment the disk once a month").

By definition, "slow growth" is amenable to defragmentation. And by
definition, fast growth isn't. And if we're talking about speedups on the
order of _five times_ for something as simple as a "cvs co", I don't see
where your "pure hell" comes in.

A five-time slowdown on real work _is_ pure hell. You've not shown a
credible argument that the slow-growth behaviour would ever result in a
five-time slowdown for _anything_.

		Linus

