Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291437AbSAaXzT>; Thu, 31 Jan 2002 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291441AbSAaXzI>; Thu, 31 Jan 2002 18:55:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64616 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291437AbSAaXyy>; Thu, 31 Jan 2002 18:54:54 -0500
Date: Fri, 1 Feb 2002 00:55:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201005543.K3396@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com> <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain> <20020131231242.GA4138@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020131231242.GA4138@krispykreme>; from anton@samba.org on Fri, Feb 01, 2002 at 10:12:42AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 10:12:42AM +1100, Anton Blanchard wrote:
>  
> Hi Ingo,
> 
> > Yes, it's very nice. Anton Blanchard has benchmarked both patch variants
> > (tree vs. scalable-hash page buckets) for SMP scalability against the
> > stock hash, on big RAM, many CPUs boxes, via dbench load. He has found
> > performance of radix trees vs. scalable hash to be at least equivalent. (i
> > think Anton has a few links to show the resulting graphs.)
> 
> Here are some results on a 12 way machine. (2.4.16-splay is the radix
> patch):
> 
> http://samba.org/~anton/linux/pagecache_locking/1/summary.png
> 
> As you can see both patches give pretty much equal improvements.
> 
> The other problem with the current pagecache hash is that it maxes out
> at order 9 (due to the get_free_pages limitation) which starts to hurt
> at 4GB RAM and above. On a 32GB machine the average hashchain depth
> was very high:
> 
> http://samba.org/~anton/linux/pagecache/pagecache_before.png
> 
> There were a few solutions (from davem and ingo) to allocate a larger
> hash but with the radix patch we no longer have to worry about this.
> 
> So the radix patch solves 2 problems quite nicely :)

all the hashes should be allocated with the bootmem allocator, that
doesn't have the MAX_ORDER limit. Not only the pagecache hash, that is
the only one replaced.

In short, for an optimal comparison between hash and radix tree, we'd
need to fixup the hash allocation with the bootmem allocator first.

Andrea
