Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSIEItR>; Thu, 5 Sep 2002 04:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSIEItQ>; Thu, 5 Sep 2002 04:49:16 -0400
Received: from holomorphy.com ([66.224.33.161]:1194 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317341AbSIEItQ>;
	Thu, 5 Sep 2002 04:49:16 -0400
Date: Thu, 5 Sep 2002 01:45:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] __write_lock_failed() oops
Message-ID: <20020905084502.GD888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020905080310.GF18800@holomorphy.com> <3D77190C.F4562547@zip.com.au> <20020905083240.GC888@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020905083240.GC888@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 01:42:52AM -0700, Andrew Morton wrote:
>> That's all the assembly hacks in the rwlock code not having proper
>> stack frames.  You may have to ksymoops it.
>> At a guess: use-after-free bug against an address_space.  You may
>> be able to catch it with slab poisoning.

On Thu, Sep 05, 2002 at 01:32:40AM -0700, William Lee Irwin III wrote:
> (gdb) p/x $eax
> $25 = 0xc0331ca0
> (gdb) p &tasklist_lock
> $27 = (rwlock_t *) 0xc0331ca0

The NMI oopser is going here as well (nmi_watchdog=2 for extra safety)
so I suspect the tasklist_lock semantics are behaving badly. But it's
not easily reproducible enough to test a quick attempt at a fix if it
can't be recognized a priori.

This is literally so difficult to reproduce it hasn't been seen in 2
releases. kgdb is still going and dhowells is helping me fish stuff
off the stack.


Cheers,
Bill
