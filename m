Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRCUKPx>; Wed, 21 Mar 2001 05:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRCUKPn>; Wed, 21 Mar 2001 05:15:43 -0500
Received: from colorfullife.com ([216.156.138.34]:1811 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131296AbRCUKPa>;
	Wed, 21 Mar 2001 05:15:30 -0500
Message-ID: <001401c0b1ef$cb22f5e0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <jaharkes@cs.cmu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about memory usage in 2.4 vs 2.2
Date: Wed, 21 Mar 2001 11:14:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inode_cache 189974 243512 480 30439 30439 1 : 124 62
> dentry_cache 201179 341940 128 11398 11398 1 : 252 126

1) number of used objects
2) number of allocated objects
3) size of each object
4) number of slabs that are at least partially in use
5) number of slabs that are allocated for the cache
i.e. 5)-4) are the number of freeable slabs in the cache
6) size in pages for a slab
:
7) length of the per-cpu list. Each cpu some objects in a local list it
can use without acquiring a spinlock
8) batch count. If the per-cpu list overflows multiple objects are
freed/allocated in one block.

7 and 8 are only present if your kernel is compiled for SMP, root can
tune them with

#echo "<slab name> <length> <batchcount>" > /proc/slabinfo

It seems that the dentry cache is severely fragmented, nearly 20 MB (or
30%) are
unfreeable due to fragmentation.

--
    Manfred

