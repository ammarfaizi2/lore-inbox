Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154811AbPKLRph>; Fri, 12 Nov 1999 12:45:37 -0500
Received: by vger.rutgers.edu id <S154784AbPKLRpb>; Fri, 12 Nov 1999 12:45:31 -0500
Received: from chiara.csoma.elte.hu ([157.181.71.18]:10604 "EHLO chiara.csoma.elte.hu") by vger.rutgers.edu with ESMTP id <S154733AbPKLRoV>; Fri, 12 Nov 1999 12:44:21 -0500
Date: Fri, 12 Nov 1999 19:49:32 +0100 (CET)
From: Ingo Molnar <mingo@chiara.csoma.elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.rutgers.edu, Alan Cox <number6@the-village.bc.nu>
Subject: Re: [patch] zoned-2.3.27-E0
In-Reply-To: <14380.20335.320349.368261@dukat.scot.redhat.com>
Message-ID: <Pine.LNX.4.10.9911121945220.10104-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Fri, 12 Nov 1999, Stephen C. Tweedie wrote:

> > Stephen noticed that 2.3.27 doesnt boot on <=16MB boxes due to the zoned
> > allocator changes. The attached patch should fix this. Unfortunately i
> > found no way to prevent introducing the runtime 'nr_zones' variable.
> 
> A quick special-case check on zones known to be empty would allow you to
> maintain performance even if you have zones which will never have any
> pages in them on a given machine.

yes, i first did something like this, but it's just as slow in the end.
(well, there is just an academic slowdown anyway)

> You need this anyway --- Alan pointed out that it is a significant hit
> on benchmarks if, during normal running, one zone fills up and you
> start falling back routinely to a lower zone.

at that point we are wasting much more time already walking page tables in
kswapd and try_to_free_pages to free RAM.

and we'd have to get the spinlock to rely on zone->free_pages, and for any
non-page-sized allocation request zone->free_pages is not authorative.

-- mingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
