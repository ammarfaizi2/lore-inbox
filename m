Return-Path: <linux-kernel-owner+w=401wt.eu-S965375AbXATUUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbXATUUg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbXATUUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:20:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:35098 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965375AbXATUUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:20:34 -0500
Date: Sat, 20 Jan 2007 15:20:32 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: 2.6.19.2, cp 18gb_file 18gb_file.2 = OOM killer, 100% reproducible
Message-ID: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps its time to back to a stable (2.6.17.13 kernel)?

Anyway, when I run a cp 18gb_file 18gb_file.2 on a dual raptor sw raid1 
partition, the OOM killer goes into effect and kills almost all my 
processes.

Completely 100% reproducible.

Does 2.6.19.2 have some of memory allocation bug as well?

System Events
=-=-=-=-=-=-=
Jan 20 15:13:13 p34 kernel: [ 8204.430917] top invoked oom-killer: 
gfp_mask=0xd0, order=0, oomkilladj=0
Jan 20 15:13:15 p34 kernel: [ 8204.430929]  [<c013cce3>] 
out_of_memory+0x189/0x1b6
Jan 20 15:13:15 p34 kernel: [ 8204.430939]  [<c013e577>] 
__alloc_pages+0x27b/0x2db
Jan 20 15:13:15 p34 kernel: [ 8204.430949]  [<c013e619>] 
__get_free_pages+0x42/0x4d
Jan 20 15:13:15 p34 kernel: [ 8204.430955]  [<c018bc99>] 
proc_file_read+0x72/0x28e
Jan 20 15:13:15 p34 kernel: [ 8204.430962]  [<c027bec9>] 
_atomic_dec_and_lock+0x2d/0x54
Jan 20 15:13:15 p34 kernel: [ 8204.430968]  [<c016cb53>] 
mntput_no_expire+0x1c/0x7d
Jan 20 15:13:15 p34 kernel: [ 8204.430975]  [<c0158141>] 
vfs_read+0x9d/0x17b
Jan 20 15:13:15 p34 kernel: [ 8204.430983]  [<c0158644>] 
sys_read+0x4b/0x74
Jan 20 15:13:15 p34 kernel: [ 8204.430988]  [<c0103013>] 
syscall_call+0x7/0xb
Jan 20 15:13:15 p34 kernel: [ 8204.430994]  =======================
Jan 20 15:13:15 p34 kernel: [ 8204.430997] Mem-info:
Jan 20 15:13:15 p34 kernel: [ 8204.430999] DMA per-cpu:
Jan 20 15:13:15 p34 squid[2515]: Squid Parent: child process 2517 exited 
due to signal 9
Jan 20 15:13:15 p34 kernel: [ 8204.431003] CPU    0: Hot: hi:    0, btch:   
1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Jan 20 15:13:15 p34 kernel: [ 8204.431007] CPU    1: Hot: hi:    0, btch:   
1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Jan 20 15:13:15 p34 kernel: [ 8204.431010] Normal per-cpu:
Jan 20 15:13:15 p34 kernel: [ 8204.431013] CPU    0: Hot: hi:  186, btch:  
31 usd: 166   Cold: hi:   62, btch:  15 usd:  50
Jan 20 15:13:15 p34 kernel: [ 8204.431017] CPU    1: Hot: hi:  186, btch:  
31 usd:  30   Cold: hi:   62, btch:  15 usd:  60
Jan 20 15:13:15 p34 kernel: [ 8204.431021] HighMem per-cpu:
Jan 20 15:13:15 p34 kernel: [ 8204.431024] CPU    0: Hot: hi:  186, btch:  
31 usd:  13   Cold: hi:   62, btch:  15 usd:   3
Jan 20 15:13:15 p34 kernel: [ 8204.431028] CPU    1: Hot: hi:  186, btch:  
31 usd:  23   Cold: hi:   62, btch:  15 usd:  14
Jan 20 15:13:15 p34 kernel: [ 8204.431033] Active:8356 inactive:247241 
dirty:58126 writeback:146669 unstable:0 free:41510 slab:61581 mapped:5339 
pagetables:470
Jan 20 15:13:15 p34 kernel: [ 8204.431038] DMA free:3544kB min:68kB 
low:84kB high:100kB active:0kB inactive:0kB present:16256kB 
pages_scanned:0 all_unreclaimable? yes
Jan 20 15:13:15 p34 kernel: [ 8204.431055] lowmem_reserve[]: 0 873 1991
Jan 20 15:13:15 p34 kernel: [ 8204.431064] Normal free:2788kB min:3744kB 
low:4680kB high:5616kB active:4kB inactive:30496kB present:894080kB 
pages_scanned:47944
all_unreclaimable? yes
Jan 20 15:13:15 p34 kernel: [ 8204.431068] lowmem_reserve[]: 0 0 8945
Jan 20 15:13:15 p34 kernel: [ 8204.431077] HighMem free:159708kB min:512kB 
low:1708kB high:2908kB active:33420kB inactive:958468kB present:1145032kB 
pages_scanned:224
all_unreclaimable? no
Jan 20 15:13:15 p34 kernel: [ 8204.431080] lowmem_reserve[]: 0 0 0
Jan 20 15:13:15 p34 kernel: [ 8204.431097] DMA: 0*4kB 1*8kB 1*16kB 0*32kB 
1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3544kB
Jan 20 15:13:15 p34 kernel: [ 8204.431114] Normal: 1*4kB 0*8kB 0*16kB 
3*32kB 0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2788kB
Jan 20 15:13:15 p34 kernel: [ 8204.431132] HighMem: 1*4kB 1*8kB 3997*16kB 
2194*32kB 353*64kB 17*128kB 3*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 
159708kB
Jan 20 15:13:15 p34 kernel: [ 8204.431150] Swap cache: add 2551, delete 
2533, find 11/16, race 0+0
Jan 20 15:13:15 p34 kernel: [ 8204.431153] Free swap  = 2190716kB
Jan 20 15:13:15 p34 kernel: [ 8204.431155] Total swap = 2200760kB
Jan 20 15:13:15 p34 kernel: [ 8204.431157] Free swap:       2190716kB
Jan 20 15:13:15 p34 kernel: [ 8204.436274] 517888 pages of RAM
Jan 20 15:13:15 p34 kernel: [ 8204.436279] 288512 pages of HIGHMEM
Jan 20 15:13:15 p34 kernel: [ 8204.436281] 5662 reserved pages
Jan 20 15:13:15 p34 kernel: [ 8204.436283] 246964 pages shared
Jan 20 15:13:15 p34 kernel: [ 8204.436285] 18 pages swap cached
Jan 20 15:13:15 p34 kernel: [ 8204.436288] 58126 pages dirty
Jan 20 15:13:15 p34 kernel: [ 8204.436290] 146669 pages writeback
Jan 20 15:13:15 p34 kernel: [ 8204.436292] 5339 pages mapped
Jan 20 15:13:15 p34 kernel: [ 8204.436294] 61581 pages slab
Jan 20 15:13:15 p34 kernel: [ 8204.436296] 470 pages pagetables
Jan 20 15:13:15 p34 kernel: [ 8204.436391] Out of Memory: Kill process 
1848 (named) score 12591 and children.
Jan 20 15:13:15 p34 kernel: [ 8204.436395] Out of memory: Killed process 
1848 (named).
Jan 20 15:13:15 p34 kernel: [ 8204.437143] bash invoked oom-killer: 
gfp_mask=0xd0, order=0, oomkilladj=0
Jan 20 15:13:15 p34 kernel: [ 8204.437151]  [<c013cce3>] 
out_of_memory+0x189/0x1b6
Jan 20 15:13:15 p34 kernel: [ 8204.437160]  [<c013e577>] 
__alloc_pages+0x27b/0x2db
Jan 20 15:13:15 p34 kernel: [ 8204.437166]  [<c0154855>] 
cache_alloc_refill+0x2e9/0x540
Jan 20 15:13:15 p34 kernel: [ 8204.437172]  [<c015456a>] 
kmem_cache_alloc+0x40/0x42
Jan 20 15:13:15 p34 kernel: [ 8204.437177]  [<c011231d>] 
pgd_alloc+0x18/0x1c
Jan 20 15:13:15 p34 kernel: [ 8204.437183]  [<c0118c27>] mm_init+0xbc/0xe9
Jan 20 15:13:15 p34 kernel: [ 8204.437188]  [<c015ce45>] 
do_execve+0x6c/0x1dc
Jan 20 15:13:15 p34 kernel: [ 8204.437193]  [<c010135b>] 
sys_execve+0x3c/0x97
Jan 20 15:13:15 p34 kernel: [ 8204.437198]  [<c0103013>] 
syscall_call+0x7/0xb
Jan 20 15:13:15 p34 kernel: [ 8204.437202]  [<c042007b>] 
schedule+0x34b/0x8cd
Jan 20 15:13:15 p34 kernel: [ 8204.437208]  =======================
Jan 20 15:13:15 p34 kernel: [ 8204.437211] Mem-info:
Jan 20 15:13:15 p34 kernel: [ 8204.437213] DMA per-cpu:
Jan 20 15:13:15 p34 kernel: [ 8204.437216] CPU    0: Hot: hi:    0, btch:   
1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Jan 20 15:13:15 p34 kernel: [ 8204.437220] CPU    1: Hot: hi:    0, btch:   
1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Jan 20 15:13:15 p34 kernel: [ 8204.437223] Normal per-cpu:
Jan 20 15:13:15 p34 kernel: [ 8204.437227] CPU    0: Hot: hi:  186, btch:  
31 usd: 177   Cold: hi:   62, btch:  15 usd:  50
Jan 20 15:13:15 p34 kernel: [ 8204.437237] CPU    1: Hot: hi:  186, btch:  
31 usd:  30   Cold: hi:   62, btch:  15 usd:  60
Jan 20 15:13:15 p34 kernel: [ 8204.437244] HighMem per-cpu:
Jan 20 15:13:15 p34 kernel: [ 8204.437249] CPU    0: Hot: hi:  186, btch:  
31 usd: 176   Cold: hi:   62, btch:  15 usd:   3
Jan 20 15:13:15 p34 kernel: [ 8204.437256] CPU    1: Hot: hi:  186, btch:  
31 usd:  22   Cold: hi:   62, btch:  15 usd:  14
Jan 20 15:13:15 p34 kernel: [ 8204.437264] Active:8072 inactive:245472 
dirty:58126 writeback:146669 unstable:0 free:43401 slab:61581 mapped:4967 
pagetables:470
Jan 20 15:13:15 p34 kernel: [ 8204.437272] DMA free:3544kB min:68kB 
low:84kB high:100kB active:0kB inactive:0kB present:16256kB 
pages_scanned:0 all_unreclaimable? yes
Jan 20 15:13:15 p34 kernel: [ 8204.437275] lowmem_reserve[]: 0 873 1991
Jan 20 15:13:15 p34 kernel: [ 8204.437284] Normal free:2788kB min:3744kB 
low:4680kB high:5616kB active:4kB inactive:30496kB present:894080kB 
pages_scanned:47944

