Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275067AbSITFP5>; Fri, 20 Sep 2002 01:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275086AbSITFP5>; Fri, 20 Sep 2002 01:15:57 -0400
Received: from holomorphy.com ([66.224.33.161]:4998 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275067AbSITFP4>;
	Fri, 20 Sep 2002 01:15:56 -0400
Date: Thu, 19 Sep 2002 22:14:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920051455.GI3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8A5FE6.4C5DE189@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
> It would be interesting to know the context switch rate
> during this test, and to see what things look like with HZ=100.

Ow! Throughput went down by something like 25% by just bumping HZ down
to 100. (or so it appears)

One of the odd things here is that this is absolutely not being allowed
to sample times when the test is not running. So default_idle is some
kind of actual scheduling artifact, though I'm not entirely sure when
it's sitting idle. It may just be the most predominant sampled thing
within the kernel despite 98% non-idle system time and HZ == 1000 is not
the issue. Not sure.


Cheers,
Bill

Out-of-line lock version:

c01053a4 20974286 42.2901     default_idle
c015c586 5759482  11.6127     .text.lock.dcache
c0154b43 5747223  11.588      .text.lock.namei
c01317e4 4653534  9.38284     generic_file_write_nolock
c0130d00 1861383  3.75308     file_read_actor
c0114a98 1230049  2.48013     load_balance
c019f6bb 866076   1.74625     .text.lock.dec_and_lock
c01066a8 796042   1.60505     .text.lock.semaphore
c013f7fc 749976   1.51216     blk_queue_bounce
c019f640 497122   1.00234     atomic_dec_and_lock
c0114f10 321897   0.649036    scheduler_tick
c0152378 262290   0.528851    path_lookup
c0144dc0 223189   0.450012    generic_file_llseek
c015adf0 207285   0.417945    prune_dcache
c011748d 185193   0.373402    .text.lock.sched
c0115258 184852   0.372714    do_schedule
c0114628 171719   0.346234    try_to_wake_up
c013676c 170725   0.34423     .text.lock.slab
c013faa4 143586   0.28951     .text.lock.highmem
c01062dc 142571   0.287464    __down
c015ba1c 140737   0.283766    d_lookup
c014675c 130760   0.263649    __fput
c0152a30 126688   0.255439    open_namei

