Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTCBX4n>; Sun, 2 Mar 2003 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTCBX4n>; Sun, 2 Mar 2003 18:56:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27614 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265270AbTCBX4k>; Sun, 2 Mar 2003 18:56:40 -0500
Date: Sun, 02 Mar 2003 16:07:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <88060000.1046650020@[10.10.2.4]>
In-Reply-To: <20030302234252.GL1195@holomorphy.com>
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Still degraded: diffprofile:
>>        781     1.6% total
>>        346     1.0% default_idle
>>        217    10.1% __down
>>         79    12.0% __wake_up
>>         51    70.8% page_address
>>         32    66.7% kmap_atomic
>>         24     5.3% page_remove_rmap
>>         16    19.3% clear_page_tables
>>         14     4.6% release_pages
>>         13    33.3% path_release
>>         13     6.7% __copy_to_user_ll
>>         13   260.0% bad_range
>>         11     1.3% do_schedule
>>         10    15.6% pte_alloc_one
> 
> The largest issue is probably idle time, which appears to have gone up
> enormously in absolute terms. I'll split the pieces out and see what
> happens. From this it looks like the indirection is a slowdown, but the
> cost in absolute terms is insignificant, as there aren't enough samples.
> 
> There's no clear reason __down() should have become more expensive,
> nor __wake_up(). I'd really like an instruction-level profile. AFAICT
> node_nr_running is 100% harmless instruction-wise, unless the copy
> propagated a nonzero value (which would be a bug), and per_cpu
> runqueues are largely unknown, but would be accountable to schedule(),
> which is not particularly offensive wrt. additional cpu time.
> 
> Some kind of dump of internal scheduler statistics to verify they've
> been faithfully preserved would help also. Instruction-level cpu and
> cache profiling would also be helpful. There may very well be an odd
> cache coloring conflict at work here. If it's too big to take on, I
> might need some kind of help or a pointer to a package so I don't have
> to crap all over userspace for the benchmark. I may also need a .config
> in order to reproduce the usual bullcrap like (#@%$ing) link order.

I think you'd be better off profiling the improvement you saw, and working
out where that comes from. 

Failing that, if you can split it into 3 or 4 patches along the lines I
suggested earlier, I'll try benching each bit seperately for you.

M.

