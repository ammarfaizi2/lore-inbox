Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131713AbRCURp4>; Wed, 21 Mar 2001 12:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131715AbRCURpq>; Wed, 21 Mar 2001 12:45:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57576 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131713AbRCURpd>;
	Wed, 21 Mar 2001 12:45:33 -0500
Date: Wed, 21 Mar 2001 11:42:08 -0600 (CST)
From: Josh Grebe <squash@primary.net>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <001401c0b1ef$cb22f5e0$5517fea9@local>
Message-ID: <Pine.LNX.4.32.0103211127510.2260-100000@scarface.primary.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I'm afraid of, in my case we have millions of files that are
dealt with in no real order, and if cache fragmentation will keep the
memory from being freed, we're in for problems. This reading was taken
with the machine having been up for only 5 days. Currently, I show:

inode_cache       194565 234696    480 29337 29337    1 :  124   62
dentry_cache      207257 327300    128 10910 10910    1 :  252  126

However, memory usage is still at 44% according to /proc/meminfo.

I've had to put my SMTP box back to 2.2 as it was up to 90% memory used,
where the others were around 18%. I'm keeping the pop/imap server at 2.4
as 44% is standable, while not exactly desirable. I'm

---
Josh Grebe
Senior Unix Systems Administrator
Primary Network, an MPower Company
http://www.primary.net

On Wed, 21 Mar 2001, Manfred Spraul wrote:

> > inode_cache 189974 243512 480 30439 30439 1 : 124 62
> > dentry_cache 201179 341940 128 11398 11398 1 : 252 126
>
> 1) number of used objects
> 2) number of allocated objects
> 3) size of each object
> 4) number of slabs that are at least partially in use
> 5) number of slabs that are allocated for the cache
> i.e. 5)-4) are the number of freeable slabs in the cache
> 6) size in pages for a slab
> :
> 7) length of the per-cpu list. Each cpu some objects in a local list it
> can use without acquiring a spinlock
> 8) batch count. If the per-cpu list overflows multiple objects are
> freed/allocated in one block.
>
> 7 and 8 are only present if your kernel is compiled for SMP, root can
> tune them with
>
> #echo "<slab name> <length> <batchcount>" > /proc/slabinfo
>
> It seems that the dentry cache is severely fragmented, nearly 20 MB (or
> 30%) are
> unfreeable due to fragmentation.
>
> --
>     Manfred
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>




