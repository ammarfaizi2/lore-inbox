Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264090AbTCXD7O>; Sun, 23 Mar 2003 22:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264091AbTCXD7O>; Sun, 23 Mar 2003 22:59:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6340 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264090AbTCXD7F>; Sun, 23 Mar 2003 22:59:05 -0500
Date: Sun, 23 Mar 2003 20:10:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-ID: <11750000.1048479004@[10.10.2.4]>
In-Reply-To: <20030323191744.56537860.akpm@digeo.com>
References: <20030323020646.0dfcc17b.akpm@digeo.com>
 <9590000.1048475057@[10.10.2.4]> <20030323191744.56537860.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> profile from SDET 64:
> 
> SDET is rather irritating because a) nobody has a copy and b) we don't
> even know what it does.

Yeah, I know. sorry ... I'm trying to get aim7 done instead.

> and b) we don't even know what it does.

Lots of shell scripty stuff, I think.

>> 82303 __down
>> 42835 schedule
>> 31323 __wake_up
>> 26435 .text.lock.sched
>> 15924 .text.lock.transaction
> 
> But judging by this, it's a rebadged dbench.  The profile is identical.

Not sure what dbench does. But I'm probably doing lots of small reads
and writes inside pagecache.
 
> Note that the lock_kernel() contention has been drastically reduced and
> we're now hitting semaphore contention.
> 
> Running `dbench 32' on the quad Xeon, this patch took the context switch
> rate from 500/sec up to 125,000/sec.
> 
> I've asked Alex to put together a patch for spinlock-based locking in the
> block allocator (cut-n-paste from ext2).

OK, sounds like a plan. Made a huge impact for ext2, and might enable
us to actually be able to see the rest of it through the sem cloud.
 
> That will fix up lock_super(), but I suspect the main problem is the
> lock_journal() in journal_start().  I haven't thought about that one yet.

Thanks,

M.

