Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291571AbSBAGdu>; Fri, 1 Feb 2002 01:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBAGdk>; Fri, 1 Feb 2002 01:33:40 -0500
Received: from [217.9.226.246] ([217.9.226.246]:11649 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S291570AbSBAGdb>; Fri, 1 Feb 2002 01:33:31 -0500
To: Anton Blanchard <anton@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com>
	<Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain>
	<20020131231242.GA4138@krispykreme>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020131231242.GA4138@krispykreme>
Date: 01 Feb 2002 08:32:40 +0200
Message-ID: <878zad1zlj.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Anton" == Anton Blanchard <anton@samba.org> writes:

Anton> Hi Ingo,

>> Yes, it's very nice. Anton Blanchard has benchmarked both patch variants
>> (tree vs. scalable-hash page buckets) for SMP scalability against the
>> stock hash, on big RAM, many CPUs boxes, via dbench load. He has found
>> performance of radix trees vs. scalable hash to be at least equivalent. (i
>> think Anton has a few links to show the resulting graphs.)

Anton> Here are some results on a 12 way machine. (2.4.16-splay is the radix
Anton> patch):

Anton> http://samba.org/~anton/linux/pagecache_locking/1/summary.png

A correction, "-splay" is the very first variant I posted, which used
splay trees for the page cache.

Anton> As you can see both patches give pretty much equal improvements.

Anton> The other problem with the current pagecache hash is that it maxes out
Anton> at order 9 (due to the get_free_pages limitation) which starts to hurt
Anton> at 4GB RAM and above. On a 32GB machine the average hashchain depth
Anton> was very high:

Anton> http://samba.org/~anton/linux/pagecache/pagecache_before.png

Anton> There were a few solutions (from davem and ingo) to allocate a larger
Anton> hash but with the radix patch we no longer have to worry about this.

Anton> So the radix patch solves 2 problems quite nicely :)

Anton> Anton
