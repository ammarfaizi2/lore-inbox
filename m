Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWEYCnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWEYCnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEYCnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:43:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:44783 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964833AbWEYCnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:43:12 -0400
Message-ID: <447519BE.9090103@comcast.net>
Date: Wed, 24 May 2006 22:43:10 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOM'ing with 2GB of ram and no "large" memory processes. 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was trigged when concurrently encoding multiple gigabytes of video 
with mencoder. Mencoder doesn't appear to be leaking any memory however, 
and in fact only seems to be using 20MB each.  I have 2GB of ram and 
apparently as far as "free" is concerned, 1.67GB of it is in cache.  My 
largest memory hogging process is X with 85MB resident, firefox then 
thunderbird following.  I dont run swap.  I'm not sure why OOM was 
triggered and why it apparently wanted to kill some daemons and firefox 
(even though both were still running afterwards).  If anyone can tell me 
why, that would be greatly appreciated.   Here is what dmesg gave me.


oom-killer: gfp_mask=0xd0, order=0

Call Trace: <ffffffff801561f2>{out_of_memory+50} 
<ffffffff8015854c>{__alloc_pages+556}
       <ffffffff80127633>{__wake_up+67} 
<ffffffff80158977>{__get_free_pages+55}
       <ffffffff80188bfa>{__pollwait+74} 
<ffffffff88000dd1>{:unix:unix_poll+33}
       <ffffffff80189396>{do_sys_poll+486} <ffffffff80188bb0>{__pollwait+0}
       <ffffffff8010ee1e>{do_gettimeofday+94} 
<ffffffff801895ea>{sys_poll+58}
       <ffffffff8010aebe>{system_call+126}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:183
cpu 0 cold: high 62, batch 15 used:15
cpu 1 hot: high 186, batch 31 used:14
cpu 1 cold: high 62, batch 15 used:22
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       16012kB (0kB HighMem)
Active:496970 inactive:69 dirty:1 writeback:0 unstable:0 free:4003 
slab:5606 mapped:493395 pagetables:2739
DMA free:8052kB min:32kB low:40kB high:48kB active:4344kB inactive:0kB 
present:12104kB pages_scanned:5436 all_unreclaimable? yes
lowmem_reserve[]: 0 2004 2004 2004
DMA32 free:7960kB min:5708kB low:7132kB high:8560kB active:1983536kB 
inactive:276kB present:2052260kB pages_scanned:299393 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
1*2048kB 1*4096kB = 8052kB
DMA32: 590*4kB 12*8kB 4*16kB 2*32kB 0*64kB 2*128kB 0*256kB 0*512kB 
1*1024kB 0*2048kB 1*4096kB = 7960kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
524272 pages of RAM
9080 reserved pages
115766 pages shared
0 pages swap cached
Out of Memory: Kill process 29712 (mysqld) score 36803 and children.
Out of memory: Killed process 29712 (mysqld).


Then some more and finally

oom-killer: gfp_mask=0x201d2, order=0

Call Trace: <ffffffff801561f2>{out_of_memory+50} 
<ffffffff8015854c>{__alloc_pages+556}
       <ffffffff80335b7f>{thread_return+0} 
<ffffffff80159c69>{__do_page_cache_readahead+265}
       <ffffffff80335ca2>{io_schedule+50} 
<ffffffff80336595>{__wait_on_bit_lock+101}
       <ffffffff8015292f>{__lock_page+95} 
<ffffffff80154793>{filemap_nopage+323}       
<ffffffff80161957>{__handle_mm_fault+999} 
<ffffffff8010b592>{retint_kernel+38}
       <ffffffff8011ce29>{do_page_fault+1065} 
<ffffffff80335b7f>{thread_return+0}
       <ffffffff80335bd0>{thread_return+81} <ffffffff8010bc2d>{error_exit+0}
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:132
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:125
cpu 1 cold: high 62, batch 15 used:52
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       15244kB (0kB HighMem)
Active:492811 inactive:4841 dirty:0 writeback:0 unstable:0 free:3811 
slab:5260 mapped:493784 pagetables:2723
DMA free:8048kB min:32kB low:40kB high:48kB active:4380kB inactive:0kB 
present:12104kB pages_scanned:5494 all_unreclaimable? yes
lowmem_reserve[]: 0 2004 2004 2004
DMA32 free:7196kB min:5708kB low:7132kB high:8560kB active:1966736kB 
inactive:19364kB present:2052260kB pages_scanned:2593343 
all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
1*2048kB 1*4096kB = 8048kB
DMA32: 387*4kB 16*8kB 7*16kB 1*32kB 0*64kB 2*128kB 0*256kB 0*512kB 
1*1024kB 0*2048kB 1*4096kB = 7196kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
524272 pages of RAM
9080 reserved pages
115335 pages shared
0 pages swap cached
Out of Memory: Kill process 3583 (httpd) score 8175 and children.
Out of memory: Killed process 3583 (httpd).




I'm using 2.6.16 still, amd64 arch, dual core. 
