Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSAaThn>; Thu, 31 Jan 2002 14:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290623AbSAaThe>; Thu, 31 Jan 2002 14:37:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33706 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289323AbSAaTh3>;
	Thu, 31 Jan 2002 14:37:29 -0500
Date: Thu, 31 Jan 2002 22:34:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Linus Torvalds wrote:

> > then there must be some collision handling that raise the complexity to
> > O(N) like with the hashtable, if the depth is fixed and if 32bits of
> > index are enough regardless of how many entries are in the tree.
>
> No collisions. Each mapping has its own private tree. And mappings are
> virtually indexed by 32 bits. No hashes, no collisions, no nothing.

Yes, it's very nice. Anton Blanchard has benchmarked both patch variants
(tree vs. scalable-hash page buckets) for SMP scalability against the
stock hash, on big RAM, many CPUs boxes, via dbench load. He has found
performance of radix trees vs. scalable hash to be at least equivalent. (i
think Anton has a few links to show the resulting graphs.)

In fact the radix trees showed a slight performance/scalability edge in
some parts of the performance curve. So given the fact that hashes/buckets
were *purely* designed for speed/scalability and not for RAM usage, this
proves that radix trees are superior. Plus the locking is much simpler
than for the hash buckets solution. Which make radix trees a clear winner
IMO.

	Ingo

