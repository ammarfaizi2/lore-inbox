Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291415AbSAaXZh>; Thu, 31 Jan 2002 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291416AbSAaXZ2>; Thu, 31 Jan 2002 18:25:28 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:49164 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291415AbSAaXZP>;
	Thu, 31 Jan 2002 18:25:15 -0500
Date: Fri, 1 Feb 2002 10:12:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131231242.GA4138@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com> <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Ingo,

> Yes, it's very nice. Anton Blanchard has benchmarked both patch variants
> (tree vs. scalable-hash page buckets) for SMP scalability against the
> stock hash, on big RAM, many CPUs boxes, via dbench load. He has found
> performance of radix trees vs. scalable hash to be at least equivalent. (i
> think Anton has a few links to show the resulting graphs.)

Here are some results on a 12 way machine. (2.4.16-splay is the radix
patch):

http://samba.org/~anton/linux/pagecache_locking/1/summary.png

As you can see both patches give pretty much equal improvements.

The other problem with the current pagecache hash is that it maxes out
at order 9 (due to the get_free_pages limitation) which starts to hurt
at 4GB RAM and above. On a 32GB machine the average hashchain depth
was very high:

http://samba.org/~anton/linux/pagecache/pagecache_before.png

There were a few solutions (from davem and ingo) to allocate a larger
hash but with the radix patch we no longer have to worry about this.

So the radix patch solves 2 problems quite nicely :)

Anton
