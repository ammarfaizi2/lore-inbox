Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264123AbTCXGvm>; Mon, 24 Mar 2003 01:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264131AbTCXGvm>; Mon, 24 Mar 2003 01:51:42 -0500
Received: from mx1.elte.hu ([157.181.1.137]:34499 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264123AbTCXGvl>;
	Mon, 24 Mar 2003 01:51:41 -0500
Date: Mon, 24 Mar 2003 08:02:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: 2.5.65-mm4
In-Reply-To: <20030323191744.56537860.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303240756010.1587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Mar 2003, Andrew Morton wrote:

> Note that the lock_kernel() contention has been drastically reduced and
> we're now hitting semaphore contention.
> 
> Running `dbench 32' on the quad Xeon, this patch took the context switch
> rate from 500/sec up to 125,000/sec.

note that there is _nothing_ wrong in doing 125,000 context switches per
sec, as long as performance increases over the lock_kernel() variant.

> I've asked Alex to put together a patch for spinlock-based locking in
> the block allocator (cut-n-paste from ext2).

sure, do this if it increases performance. But if it _decreases_
performance then it's plain pointless to do this just to avoid
context-switches. With the 2.4 scheduler i'd agree - avoid
context-switches like the plague. But context-switches are 100% localized
to the same CPU with the O(1) scheduler, they (should) cause (almost) no
scalability problem. The only thing this change will 'fix' is the
context-switch statistics.

plus someone might want to try some simple spin-sleep semaphore
implementation at this point. The context-switch takes roughly 2 usecs on
a typical x86 box, so i'd say spinning for 0.5 or 1.0 usecs could provide
some speedup.

	Ingo

