Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbRLXAzm>; Sun, 23 Dec 2001 19:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284304AbRLXAzd>; Sun, 23 Dec 2001 19:55:33 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:36871 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284302AbRLXAzV>;
	Sun, 23 Dec 2001 19:55:21 -0500
Date: Mon, 24 Dec 2001 11:52:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache - take two
Message-ID: <20011224005258.GB15536@krispykreme>
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> This is the second mutation of the scalable page cache patch.  It:

I ran the dbench test over it just to annoy Andrew:

http://samba.org/~anton/linux/pagecache_locking/2/

This is the still 12 way ppc64, the results are similar to the last
test. It confirms that the current pagecache locking is a bottleneck
for larger SMP machines.

We quickly hit the following spinlocks with the pagecache lock out of
the way:

ext2_get_block: BKL
refile_buffer: lru_list_lock
remove_from_queues: lru_list_lock
try_to_free_buffers: lru_list_lock
d_lookup: dcache_lock
ext2_discard_prealloc: BKL

Is someone working on removing the BKL from ext2 in 2.5?

Anton
