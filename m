Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSIEJDk>; Thu, 5 Sep 2002 05:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSIEJDk>; Thu, 5 Sep 2002 05:03:40 -0400
Received: from holomorphy.com ([66.224.33.161]:4522 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317365AbSIEJDi>;
	Thu, 5 Sep 2002 05:03:38 -0400
Date: Thu, 5 Sep 2002 01:59:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] __write_lock_failed() oops
Message-ID: <20020905085924.GE888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020905080310.GF18800@holomorphy.com> <3D77190C.F4562547@zip.com.au> <20020905083240.GC888@holomorphy.com> <20020905084502.GD888@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020905084502.GD888@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 01:32:40AM -0700, William Lee Irwin III wrote:
>> (gdb) p/x $eax
>> $25 = 0xc0331ca0
>> (gdb) p &tasklist_lock
>> $27 = (rwlock_t *) 0xc0331ca0

On Thu, Sep 05, 2002 at 01:45:02AM -0700, William Lee Irwin III wrote:
> The NMI oopser is going here as well (nmi_watchdog=2 for extra safety)
> so I suspect the tasklist_lock semantics are behaving badly. But it's
> not easily reproducible enough to test a quick attempt at a fix if it
> can't be recognized a priori.
> This is literally so difficult to reproduce it hasn't been seen in 2
> releases. kgdb is still going and dhowells is helping me fish stuff
> off the stack.

According to dhowells' analysis, the NMI oopser fired while do_fork()
spun on the tasklist_lock. The contention on the bloody thing is so bad
the kernel cannot survive the NMI oopser. Something is majorly FITH here.
GRRRR!!!


Cheers,
Bill
