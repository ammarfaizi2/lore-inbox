Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273748AbSISXKX>; Thu, 19 Sep 2002 19:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273781AbSISXKX>; Thu, 19 Sep 2002 19:10:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10222 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273748AbSISXKV>;
	Thu, 19 Sep 2002 19:10:21 -0400
Date: Thu, 19 Sep 2002 16:18:38 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <68630000.1032477517@w-hlinder>
In-Reply-To: <20020919223007.GP28202@holomorphy.com>
References: <20020919223007.GP28202@holomorphy.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, September 19, 2002 15:30:07 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

> From dbench 512 on a 32x NUMA-Q with 32GB of RAM running 2.5.36-mm1:
> 
> c015c5c6 4243413  10.742      .text.lock.dcache
> c01317f4 2229431  5.64371     generic_file_write_nolock
> c0130d10 2182906  5.52593     file_read_actor
> c0114f30 2126191  5.38236     scheduler_tick
> c0154b83 1905648  4.82407     .text.lock.namei
> c011749d 1344623  3.40386     .text.lock.sched
> c019f8ab 1102566  2.7911      .text.lock.dec_and_lock
> c01066a8 612167   1.54968     .text.lock.semaphore
> c015ba5c 440889   1.11609     d_lookup

> 
> with akpm's removal of lock section directives:
> 
> c0114de0 6545861  7.89765     scheduler_tick
> c0151718 4514372  5.44664     path_lookup
> c015ac4c 3314721  3.99924     d_lookup
> c0130560 3153290  3.80448     file_read_actor
> c0131044 2816477  3.39811     generic_file_write_nolock
> c015a8e4 1980809  2.38987     d_instantiate
> c019e1b0 1959187  2.36378     atomic_dec_and_lock
> c0111668 1447604  1.74655     smp_apic_timer_interrupt
> c0159fc0 1291884  1.55867     prune_dcache
> c015a714 1089696  1.31473     d_alloc
> c01062cc 1030194  1.24294     __down

	So akpm's removal of lock section directives breaks down the
functions holding locks that previously were reported under the 
.text.lock.filename?  Looks like fastwalk might not behave so well
on this 32 cpu numa system...

Hanna

