Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbRL0GLu>; Thu, 27 Dec 2001 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285055AbRL0GLk>; Thu, 27 Dec 2001 01:11:40 -0500
Received: from dsl-213-023-038-250.arcor-ip.net ([213.23.38.250]:17416 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285286AbRL0GLd>;
	Thu, 27 Dec 2001 01:11:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Blanchard <anton@samba.org>, Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] Scalable page cache - take two
Date: Thu, 27 Dec 2001 07:15:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg> <20011224005258.GB15536@krispykreme>
In-Reply-To: <20011224005258.GB15536@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JTok-0000cu-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 24, 2001 01:52 am, Anton Blanchard wrote:
> This is the still 12 way ppc64, the results are similar to the last
> test. It confirms that the current pagecache locking is a bottleneck
> for larger SMP machines.
> 
> We quickly hit the following spinlocks with the pagecache lock out of
> the way:
> 
> ext2_get_block: BKL
> refile_buffer: lru_list_lock
> remove_from_queues: lru_list_lock
> try_to_free_buffers: lru_list_lock
> d_lookup: dcache_lock
> ext2_discard_prealloc: BKL
> 
> Is someone working on removing the BKL from ext2 in 2.5?

Al has already done most of the work, it won't take much to complete it.  It 
wasn't a priority before 2.5 (stability was).

It's nice to see somebody still cares about the speed of Ext2 ;)

--
Daniel
