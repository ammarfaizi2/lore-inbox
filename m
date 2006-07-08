Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWGHUrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWGHUrd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWGHUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:47:33 -0400
Received: from relay01.pair.com ([209.68.5.15]:56075 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030364AbWGHUrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:47:33 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 15:47:06 -0500
User-Agent: KMail/1.9.3
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
References: <20060705114630.GA3134@elte.hu> <m38xn3j1um.fsf@defiant.localdomain> <200607081541.07449.chase.venters@clientec.com>
In-Reply-To: <200607081541.07449.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081547.29870.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 15:40, Chase Venters wrote:
> You need the barrier for both the CPU and the compiler. The CPU barrier
> comes from an instruction like '*fence' on x86 (or a locked bus op), while
> the compiler barrier comes from the memory clobber. Because the spinlocks
> already _must_ have both of these (including the other constraints in the
> inline asm), 'volatile' on the spinlock ctr is useless.

Btw, perhaps what is going on here is a misunderstanding of 
terminology? "Barrier" or "Memory barrier" can refer to both a hardware or 
compiler barrier, which is why Documentation/memory-barriers.txt speaks of 
both in the same file. Indeed, you often have both in the same spot, and the 
names are even similar:

barrier() -> compiler memory barrier
wmb() -> write memory barrier
...

Sometimes you'll see "optimization barrier", but you should remember that 
barrier() boils down to:

asm volatile ("" ::: "memory")

...because it's preventing memory caching/reordering across the unpredictable 
memory clobber.

See?

>
> Thanks,
> Chase
