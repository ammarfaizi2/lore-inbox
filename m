Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbTCXDGm>; Sun, 23 Mar 2003 22:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264085AbTCXDGm>; Sun, 23 Mar 2003 22:06:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:64766 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264080AbTCXDGl>;
	Sun, 23 Mar 2003 22:06:41 -0500
Date: Sun, 23 Mar 2003 19:17:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
Message-Id: <20030323191744.56537860.akpm@digeo.com>
In-Reply-To: <9590000.1048475057@[10.10.2.4]>
References: <20030323020646.0dfcc17b.akpm@digeo.com>
	<9590000.1048475057@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 03:17:30.0917 (UTC) FILETIME=[E7BD2D50:01C2F1B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> profile from SDET 64:

SDET is rather irritating because a) nobody has a copy and b) we don't even
know what it does.

> 
> 82303 __down
> 42835 schedule
> 31323 __wake_up
> 26435 .text.lock.sched
> 15924 .text.lock.transaction

But judging by this, it's a rebadged dbench.  The profile is identical.

Note that the lock_kernel() contention has been drastically reduced and we're
now hitting semaphore contention.

Running `dbench 32' on the quad Xeon, this patch took the context switch rate
from 500/sec up to 125,000/sec.

I've asked Alex to put together a patch for spinlock-based locking in the
block allocator (cut-n-paste from ext2).

That will fix up lock_super(), but I suspect the main problem is the
lock_journal() in journal_start().  I haven't thought about that one yet.


