Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265932AbSKBK4y>; Sat, 2 Nov 2002 05:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbSKBK4y>; Sat, 2 Nov 2002 05:56:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:53932 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265932AbSKBK4w>;
	Sat, 2 Nov 2002 05:56:52 -0500
Message-ID: <3DC3B0F3.4C1ABDA7@digeo.com>
Date: Sat, 02 Nov 2002 03:03:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <3DC3A9C0.7979C276@digeo.com.suse.lists.linux.kernel> <p73y98cqlv3.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 11:03:16.0670 (UTC) FILETIME=[720C2DE0:01C2825F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> 
> > (That is, using the movnta instructions for well-aligned copies
> > and clears so that we don't read the destination memory while overwriting
> > it).
> 
> I did some experiments with movnta and it was near always a loss for
> memcpy/copy_*_user type stuff. The reason is that it flushes the destination
> out of cache and when you try to read it afterwards for some reason
> (which happens often - e.g. most copy_*_user uses actually do access it
> afterwards) then you eat a full cache miss for them and that is costly
> and kills all other advantages.

Oh.  I was under the impression that the destination ended up in the
CPU caches.

Yes, if that's not the case then the whole thing is pretty useless.

> It may be a win for direct copy-to-page cache and then page cache DMA
> outside and page cache not mapped anywhere, but even then it's not completely
> clear it's that helpful to have it not in cache. For example an Athlon
> can serve an DMA directly out of its CPU caches and that may be
> faster than serving it out of RAM (Intel CPUs cannot however)

So it may be applicable to write(2) on intel.
