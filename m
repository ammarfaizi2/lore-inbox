Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273665AbSISWcI>; Thu, 19 Sep 2002 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273703AbSISWbe>; Thu, 19 Sep 2002 18:31:34 -0400
Received: from holomorphy.com ([66.224.33.161]:42116 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S273665AbSISWbH>;
	Thu, 19 Sep 2002 18:31:07 -0400
Date: Thu, 19 Sep 2002 15:30:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020919223007.GP28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, from some private responses, it appeared this is of more general
interest than linux-mm, so I'm reposting here.

I'll follow up with some suggested patches for addressing some of the
performance issues that may have been encountered.

>From dbench 512 on a 32x NUMA-Q with 32GB of RAM running 2.5.36-mm1:

c01053a4 14040139 35.542      default_idle
c0114ab8 4436882  11.2318     load_balance
c015c5c6 4243413  10.742      .text.lock.dcache
c01317f4 2229431  5.64371     generic_file_write_nolock
c0130d10 2182906  5.52593     file_read_actor
c0114f30 2126191  5.38236     scheduler_tick
c0154b83 1905648  4.82407     .text.lock.namei
c011749d 1344623  3.40386     .text.lock.sched
c019f8ab 1102566  2.7911      .text.lock.dec_and_lock
c01066a8 612167   1.54968     .text.lock.semaphore
c015ba5c 440889   1.11609     d_lookup
c013f81c 314222   0.79544     blk_queue_bounce
c0111798 310317   0.785554    smp_apic_timer_interrupt
c013fac4 228103   0.577433    .text.lock.highmem
c01523b8 206811   0.523533    path_lookup
c0115274 164177   0.415607    do_schedule
c019f830 143365   0.362922    atomic_dec_and_lock
c0114628 136075   0.344468    try_to_wake_up
c01062dc 125245   0.317052    __down
c010d9d8 121864   0.308494    timer_interrupt
c015ae30 114653   0.290239    prune_dcache
c0144e00 102093   0.258444    generic_file_llseek
c015b714 83273    0.210802    d_instantiate

with akpm's removal of lock section directives:

c01053a4 31781009 38.3441     default_idle
c0114968 13184373 15.9071     load_balance
c0114de0 6545861  7.89765     scheduler_tick
c0151718 4514372  5.44664     path_lookup
c015ac4c 3314721  3.99924     d_lookup
c0130560 3153290  3.80448     file_read_actor
c0131044 2816477  3.39811     generic_file_write_nolock
c015a8e4 1980809  2.38987     d_instantiate
c019e1b0 1959187  2.36378     atomic_dec_and_lock
c0111668 1447604  1.74655     smp_apic_timer_interrupt
c0159fc0 1291884  1.55867     prune_dcache
c015a714 1089696  1.31473     d_alloc
c01062cc 1030194  1.24294     __down
c015b0dc 625279   0.754405    d_rehash
c013edac 554017   0.668427    blk_queue_bounce
c0115128 508229   0.613183    do_schedule
c01144c8 441818   0.533058    try_to_wake_up
c010d8f8 403607   0.486956    timer_interrupt
c01229a4 333023   0.401796    update_one_process
c015af70 322781   0.389439    d_delete
c01508a0 248442   0.299748    do_lookup
c01155f4 213738   0.257877    __wake_up
c013e63c 185472   0.223774    kmap_high

