Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRADIja>; Thu, 4 Jan 2001 03:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbRADIjL>; Thu, 4 Jan 2001 03:39:11 -0500
Received: from patan.Sun.COM ([192.18.98.43]:9724 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S129962AbRADIjD>;
	Thu, 4 Jan 2001 03:39:03 -0500
Message-ID: <3A5437A1.F540D794@sun.com>
Date: Thu, 04 Jan 2001 00:43:13 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>
> The key idea here is to disable preemption on spin lock and reenable on
> spin unlock.  That's a practical idea, highly compatible with the
> current way of doing things.  Its a fairly heavy hit on spinlock
> performance, but maybe the overall performance hit is small.  Benchmarks
> are needed.
>

I'm not sure the hit on spinlock is this heavy (one increment for lock
and one dec + test on unlock), but I completely agree (and volonteer)
for benchmarking. I'm not convinced a full preemptive kernel is something
interesting mainly due to the context switch cost (actually mmu contex switch).
Benchmarking is a good way to get a global overview on this.
What about only preemptable kernel threads ?

>
> A more ambitious way to proceed is to change spinlocks so they can sleep
> (not in interrupts of course).  There would not be any extra overhead
> for this on spin_lock (because the sleep test is handled off the fast
> path) but spin_unlock gets a little slower - it has to test and jump on
> a flag if there are sleepers.
>

I may be tired but I believe you're focusing on SMP architecture ?
This code simply defer the preemption at the end of the spinlock/lock
section. I don't see how you can easily mix sleeping lock and this
mechanism.

Ludo.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
