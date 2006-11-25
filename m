Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967258AbWKYWFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967258AbWKYWFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967260AbWKYWFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:05:23 -0500
Received: from main.gmane.org ([80.91.229.2]:6378 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S967258AbWKYWFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:05:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas <gimpel@sonnenkinder.org>
Subject: Re: 2.6.19-rc6-rt5
Date: Sat, 25 Nov 2006 22:01:11 +0000 (UTC)
Message-ID: <loom.20061125T225412-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.245.160.42 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.8.1) Gecko/20061107 BonEcho/2.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is really wrong with page alloc on this one. Compiled 2.6.19-rc6-rt5
with the one patch to page_alloc.c as posted on the list here.

Kernel uses around 50% mem and 30% swap without doing anything.
I get a lot of these:

X invoked oom-killer: gfp_mask=0xd0, order=0, oomkilladj=0
 [<c0148426>] out_of_memory+0x176/0x1d0
 [<c0149dc6>] __alloc_pages+0x286/0x2f0
 [<c0149e76>] __get_free_pages+0x46/0x60
 [<c01749e0>] __pollwait+0xb0/0x100
 [<c04e92f6>] unix_poll+0xc6/0xd0
 [<c0477c03>] sock_poll+0x23/0x30
 [<c0174038>] do_select+0x288/0x4c0
 [<c0174930>] __pollwait+0x0/0x100
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0174493>] core_sys_select+0x223/0x360
 [<c04eed09>] __schedule+0x2e9/0x6b0
 [<c0108732>] convert_fxsr_from_user+0x22/0xf0
 [<c0174b2f>] sys_select+0xff/0x1e0
 [<c0121e1b>] sys_gettimeofday+0x3b/0x90
 [<c01030e5>] sysenter_past_esp+0x56/0x79
 =======================
Mem-info:
DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Normal per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  31   Cold: hi:   62, btch:  15 usd:  58
HighMem per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  66   Cold: hi:   62, btch:  15 usd:  14
Active:111463 inactive:36109 dirty:0 writeback:0 unstable:0 free:4018
slab:163934 mapped:26114 pagetables:874
DMA free:3560kB min:68kB low:84kB high:100kB active:396kB inactive:356kB
present:16256kB pages_scanned:1370 all_unreclaimable? yes
lowmem_reserve[]: 0 873 1254
Normal free:3720kB min:3744kB low:4680kB high:5616kB active:111304kB
inactive:108296kB present:894080kB pages_scanned:339028 all_unreclaimable? yes
lowmem_reserve[]: 0 0 3047
HighMem free:8792kB min:380kB low:788kB high:1196kB active:334152kB
inactive:35784kB present:390084kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB
0*4096kB = 3560kB
Normal: 0*4kB 5*8kB 0*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB
1*2048kB 0*4096kB = 3720kB
HighMem: 924*4kB 517*8kB 40*16kB 2*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 8792kB
Swap cache: add 107141, delete 56933, find 4493/5856, race 0+0
Free swap  = 113440kB
Total swap = 488336kB
Free swap:       113440kB
327664 pages of RAM
98288 pages of HIGHMEM
4383 reserved pages
94253 pages shared
50208 pages swap cached
0 pages dirty
0 pages writeback
26114 pages mapped
163934 pages slab
874 pages pagetables
327664 pages of RAM
98288 pages of HIGHMEM
4383 reserved pages
94253 pages shared
50208 pages swap cached
0 pages dirty
0 pages writeback
26114 pages mapped
163934 pages slab
874 pages pagetables
audacious invoked oom-killer: gfp_mask=0xd0, order=0, oomkilladj=0
 [<c0148426>] out_of_memory+0x176/0x1d0
 [<c0149dc6>] __alloc_pages+0x286/0x2f0
 [<c016205e>] cache_alloc_refill+0x30e/0x5d0
 [<c0161d47>] kmem_cache_alloc+0x57/0x60
 [<c0477d29>] sock_alloc_inode+0x19/0x60
 [<c017b219>] alloc_inode+0x19/0x190
 [<c0166d45>] fget_light+0x85/0xa0
 [<c017c066>] new_inode+0x16/0x90
 [<c0478bf4>] sock_alloc+0x14/0x70
 [<c047a446>] sys_accept+0x56/0x270
 [<c0102a12>] do_notify_resume+0x402/0x750
 [<c0108732>] convert_fxsr_from_user+0x22/0xf0
 [<c047a731>] sys_socketcall+0xd1/0x280
 [<c01030e5>] sysenter_past_esp+0x56/0x79
 =======================
Mem-info:
DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Normal per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  31   Cold: hi:   62, btch:  15 usd:  58
HighMem per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  66   Cold: hi:   62, btch:  15 usd:  14
Active:111494 inactive:36078 dirty:0 writeback:0 unstable:0 free:4018
slab:163934 mapped:26114 pagetables:874
DMA free:3560kB min:68kB low:84kB high:100kB active:396kB inactive:356kB
present:16256kB pages_scanned:1370 all_unreclaimable? yes
lowmem_reserve[]: 0 873 1254
Normal free:3720kB min:3744kB low:4680kB high:5616kB active:111420kB
inactive:108180kB present:894080kB pages_scanned:339127 all_unreclaimable? yes
lowmem_reserve[]: 0 0 3047
HighMem free:8792kB min:380kB low:788kB high:1196kB active:334160kB
inactive:35776kB present:390084kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB
0*4096kB = 3560kB
Normal: 0*4kB 5*8kB 0*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB
1*2048kB 0*4096kB = 3720kB
HighMem: 924*4kB 517*8kB 40*16kB 2*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 8792kB
Swap cache: add 107141, delete 56933, find 4493/5856, race 0+0
Free swap  = 113440kB
Total swap = 488336kB
Free swap:       113440kB
X invoked oom-killer: gfp_mask=0xd0, order=0, oomkilladj=0
 [<c0148426>] out_of_memory+0x176/0x1d0
 [<c0149dc6>] __alloc_pages+0x286/0x2f0
 [<c0149e76>] __get_free_pages+0x46/0x60
 [<c01749e0>] __pollwait+0xb0/0x100
 [<c04e92f6>] unix_poll+0xc6/0xd0
 [<c0477c03>] sock_poll+0x23/0x30
 [<c0174038>] do_select+0x288/0x4c0
 [<c0174930>] __pollwait+0x0/0x100
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0118db0>] default_wake_function+0x0/0x20
 [<c0174493>] core_sys_select+0x223/0x360
 [<c04eed09>] __schedule+0x2e9/0x6b0
 [<c0108732>] convert_fxsr_from_user+0x22/0xf0
 [<c0174b2f>] sys_select+0xff/0x1e0
 [<c0121e1b>] sys_gettimeofday+0x3b/0x90
 [<c01030e5>] sysenter_past_esp+0x56/0x79
 =======================
...
...
Out of Memory: Kill process 13677 (kdeinit) score 320232 and children.
Out of memory: Killed process 13691 (kio_file).
Out of Memory: Kill process 13677 (kdeinit) score 317057 and children.
Out of memory: Killed process 13727 (gxine).
Out of Memory: Kill process 11641 (mozilla-launche) score 184632 and children.
Out of memory: Killed process 11650 (firefox-bin).
Out of Memory: Kill process 9293 (apache2) score 102567 and children.
Out of memory: Killed process 9294 (apache2).
Out of Memory: Kill process 9293 (apache2) score 102420 and children.
Out of memory: Killed process 9389 (apache2).




