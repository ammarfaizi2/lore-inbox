Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVJUKJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVJUKJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVJUKJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:09:12 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:63883 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932552AbVJUKJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P7cSUOpzmLIuwXh6PXfB2p/Pko9n50G5uuHVVVDwXf0Q7APpZ2xC2qTaN/MhH57KHbAMz/KHZ6LQMvCUs18wbvOMgeposH0l0Msauk8+qxdVWfqQ7o6/44n+ocdKunkR/gghPvvO/pS31eeBzRxw3w2Y/Tp/LRBzRSsIfGqSMzg=
Message-ID: <5486cca80510210309o77f94e73l@mail.gmail.com>
Date: Fri, 21 Oct 2005 12:09:10 +0200
From: Antonio <tritemio@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5-rt2 bug report
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to the list.

This is my first post to lkml. I'm a linux audio user and I've build
the rt2 patch for the 2.6.14-rc5 kernel and I want to report some log
in hope they can be useful.

On start up I get this in dmesg:

Time: tsc clocksource has been installed.
WARNING: non-monotonic time!
softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:101
 [<c011b058>] __WARN_ON+0x68/0xa0 (8)
 [<c0133435>] ktime_get+0xe5/0x100 (48)
 [<c0133ff2>] ktimer_run_queues+0x22/0x120 (40)
 [<c0115ba8>] __wake_up+0x48/0x80 (12)
 [<c0124027>] run_timer_softirq+0xc7/0x410 (44)
 [<c0322935>] schedule+0x85/0x120 (12)
  [<c011fccd>] ksoftirqd+0xad/0x110 (28)
  [<c011fc20>] ksoftirqd+0x0/0x110 (32)
  [<c012fa45>] kthread+0xb5/0xc0 (4)
  [<c012f990>] kthread+0x0/0xc0 (24)
 [<c0101105>] kernel_thread_helper+0x5/0x10 (16)

Then, when the system start up, I can trigger the bug below loading a
lash session. I saw this bug also with some previous version of the
patch.

Best Regards,

  ~ Antonio

/var/log/messages:
Oct 21 11:32:33 localhost kernel: oom-killer: gfp_mask=0x400d2, order=0
Oct 21 11:32:33 localhost kernel: Mem-info:
Oct 21 11:32:33 localhost kernel: DMA per-cpu:
Oct 21 11:32:33 localhost kernel: cpu 0 hot: low 2, high 6, batch 1 used:0
Oct 21 11:32:33 localhost kernel: cpu 0 cold: low 0, high 2, batch 1 used:0
Oct 21 11:32:33 localhost kernel: Normal per-cpu:
Oct 21 11:32:33 localhost kernel: cpu 0 hot: low 62, high 186, batch 31 used:0
Oct 21 11:32:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 31 used:0
Oct 21 11:32:33 localhost kernel: HighMem per-cpu: empty
Oct 21 11:32:33 localhost kernel: Free pages:        3676kB (0kB HighMem)
Oct 21 11:32:33 localhost kernel: Active:28592 inactive:27720 dirty:0
writeback:5 unstable:0 free:919 slab:2817 mapped:54612 pagetables:297
Oct 21 11:32:33 localhost kernel: DMA free:1080kB min:124kB low:152kB
high:184kB active:6508kB inactive:5332kB present:16384kB
pages_scanned:12452 all_unreclaimable? yes
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 239 239
Oct 21 11:32:33 localhost kernel: Normal free:2596kB min:1916kB
low:2392kB high:2872kB active:107860kB inactive:105548kB
present:245696kB pages_scanned:363 all_unreclaimable? no
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 0 0
Oct 21 11:32:33 localhost kernel: HighMem free:0kB min:128kB low:160kB
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 0 0
Oct 21 11:32:33 localhost kernel: DMA: 0*4kB 1*8kB 1*16kB 1*32kB
0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1080kB
Oct 21 11:32:33 localhost kernel: Normal: 143*4kB 15*8kB 1*16kB 1*32kB
1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2596kB
Oct 21 11:32:33 localhost kernel: HighMem: empty
Oct 21 11:32:33 localhost kernel: Swap cache: add 75375, delete 28348,
find 664/1261, race 0+0
Oct 21 11:32:33 localhost kernel: Free swap  = 223964kB
Oct 21 11:32:33 localhost kernel: Total swap = 514024kB
Oct 21 11:32:33 localhost kernel: Free swap:       223964kB
Oct 21 11:32:33 localhost kernel: 65520 pages of RAM
Oct 21 11:32:33 localhost kernel: 0 pages of HIGHMEM
Oct 21 11:32:33 localhost kernel: 1693 reserved pages
Oct 21 11:32:33 localhost kernel: 22535 pages shared
Oct 21 11:32:33 localhost kernel: 47027 pages swap cached
Oct 21 11:32:33 localhost kernel: 0 pages dirty
Oct 21 11:32:33 localhost kernel: 5 pages writeback
Oct 21 11:32:33 localhost kernel: 54612 pages mapped
Oct 21 11:32:33 localhost kernel: 2817 pages slab
Oct 21 11:32:33 localhost kernel: 297 pages pagetables
Oct 21 11:32:33 localhost kernel: current: hald/3309.
Oct 21 11:32:33 localhost kernel:  [out_of_memory+271/304]
out_of_memory+0x10f/0x130 (8)
Oct 21 11:32:33 localhost kernel:  [__alloc_pages+1074/1088]
__alloc_pages+0x432/0x440 (28)
Oct 21 11:32:33 localhost kernel:  [_read_unlock+11/16]
_read_unlock+0xb/0x10 (52)
Oct 21 11:32:33 localhost kernel:  [read_swap_cache_async+95/240]
read_swap_cache_async+0x5f/0xf0 (28)
Oct 21 11:32:33 localhost kernel:  [swapin_readahead+131/208]
swapin_readahead+0x83/0xd0 (28)
Oct 21 11:32:33 localhost kernel:  [do_swap_page+472/784]
do_swap_page+0x1d8/0x310 (36)
Oct 21 11:32:33 localhost kernel:  [__handle_mm_fault+233/480]
__handle_mm_fault+0xe9/0x1e0 (52)
Oct 21 11:32:33 localhost kernel:  [do_page_fault+507/1535]
do_page_fault+0x1fb/0x5ff (48)
Oct 21 11:32:33 localhost kernel:  [do_page_fault+0/1535]
do_page_fault+0x0/0x5ff (64)
Oct 21 11:32:33 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54 (8)
Oct 21 11:32:33 localhost kernel: victim: lashd/4516.
Oct 21 11:32:33 localhost kernel: c1439cd0 c881e9a0 c03f5f40 00000001
00000286 00000e77 c881ead8 c3547f60
Oct 21 11:32:33 localhost kernel:        c014b8c5 c881e9a0 7aa1671d
00000088 0016e4a0 00000000 c1438000 7fffffff
Oct 21 11:32:33 localhost kernel:        c1436fac c1439cec c0322935
c1439e8c c126e8a0 c014bc5c c126c7c4 c1436d60
Oct 21 11:32:33 localhost kernel: Call Trace:
Oct 21 11:32:33 localhost kernel:  [cache_grow+309/656]
cache_grow+0x135/0x290 (36)
Oct 21 11:32:33 localhost kernel:  [schedule+133/288] schedule+0x85/0x120 (40)
Oct 21 11:32:33 localhost kernel:  [cache_alloc_refill+572/624]
cache_alloc_refill+0x23c/0x270 (12)
Oct 21 11:32:33 localhost kernel:  [schedule_timeout+133/208]
schedule_timeout+0x85/0xd0 (16)
Oct 21 11:32:33 localhost kernel:  [prepare_to_wait+62/112]
prepare_to_wait+0x3e/0x70 (32)
Oct 21 11:32:33 localhost kernel:  [unix_stream_data_wait+132/208]
unix_stream_data_wait+0x84/0xd0 (20)
Oct 21 11:32:33 localhost kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60 (12)
Oct 21 11:32:33 localhost kernel:  [unix_stream_recvmsg+754/1152]
unix_stream_recvmsg+0x2f2/0x480 (28)
Oct 21 11:32:33 localhost kernel:  [sock_recvmsg+257/352]
sock_recvmsg+0x101/0x160 (100)
Oct 21 11:32:33 localhost kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60 (116)
Oct 21 11:32:33 localhost kernel:  [copy_pte_range+192/480]
copy_pte_range+0xc0/0x1e0 (32)
Oct 21 11:32:33 localhost kernel:  [fget+104/160] fget+0x68/0xa0 (52)
Oct 21 11:32:33 localhost kernel:  [sys_recvfrom+216/368]
sys_recvfrom+0xd8/0x170 (32)
Oct 21 11:32:33 localhost kernel:  [sched_clock+100/160]
sched_clock+0x64/0xa0 (20)
Oct 21 11:32:33 localhost kernel:  [sched_clock+100/160]
sched_clock+0x64/0xa0 (24)
Oct 21 11:32:33 localhost kernel:  [__schedule+816/1760]
__schedule+0x330/0x6e0 (20)
Oct 21 11:32:33 localhost kernel:  [preempt_schedule+100/128]
preempt_schedule+0x64/0x80 (12)
Oct 21 11:32:33 localhost kernel:  [unlock_page+60/80]
unlock_page+0x3c/0x50 (36)
Oct 21 11:32:33 localhost kernel:  [do_wp_page+550/976]
do_wp_page+0x226/0x3d0 (20)
Oct 21 11:32:33 localhost kernel:  [preempt_schedule+100/128]
preempt_schedule+0x64/0x80 (8)
Oct 21 11:32:33 localhost kernel:  [sys_recv+55/64] sys_recv+0x37/0x40 (64)
Oct 21 11:32:33 localhost kernel:  [sys_socketcall+368/640]
sys_socketcall+0x170/0x280 (28)
Oct 21 11:32:33 localhost kernel:  [do_page_fault+0/1535]
do_page_fault+0x0/0x5ff (48)
Oct 21 11:32:33 localhost kernel:  [sysenter_past_esp+84/117]
sysenter_past_esp+0x54/0x75 (8)
Oct 21 11:32:33 localhost kernel: Out of Memory: Killed process 4540 (om).
Oct 21 11:32:33 localhost kernel: oom-killer: gfp_mask=0x601d2, order=0
Oct 21 11:32:33 localhost kernel: Mem-info:
Oct 21 11:32:33 localhost kernel: DMA per-cpu:
Oct 21 11:32:33 localhost kernel: cpu 0 hot: low 2, high 6, batch 1 used:0
Oct 21 11:32:33 localhost kernel: cpu 0 cold: low 0, high 2, batch 1 used:0
Oct 21 11:32:33 localhost kernel: Normal per-cpu:
Oct 21 11:32:33 localhost kernel: cpu 0 hot: low 62, high 186, batch 31 used:0
Oct 21 11:32:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 31 used:0
Oct 21 11:32:33 localhost kernel: HighMem per-cpu: empty
Oct 21 11:32:33 localhost kernel: Free pages:        2996kB (0kB HighMem)
Oct 21 11:32:33 localhost kernel: Active:28818 inactive:27694 dirty:0
writeback:28 unstable:0 free:749 slab:2817 mapped:54725 pagetables:297
Oct 21 11:32:33 localhost kernel: DMA free:1080kB min:124kB low:152kB
high:184kB active:6508kB inactive:5332kB present:16384kB
pages_scanned:12452 all_unreclaimable? yes
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 239 239
Oct 21 11:32:33 localhost kernel: Normal free:1916kB min:1916kB
low:2392kB high:2872kB active:108764kB inactive:105444kB
present:245696kB pages_scanned:7112 all_unreclaimable? no
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 0 0
Oct 21 11:32:33 localhost kernel: HighMem free:0kB min:128kB low:160kB
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Oct 21 11:32:33 localhost kernel: lowmem_reserve[]: 0 0 0
Oct 21 11:32:33 localhost kernel: DMA: 0*4kB 1*8kB 1*16kB 1*32kB
0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1080kB
Oct 21 11:32:33 localhost kernel: Normal: 1*4kB 1*8kB 1*16kB 1*32kB
1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1916kB
Oct 21 11:32:33 localhost kernel: HighMem: empty
Oct 21 11:32:33 localhost kernel: Swap cache: add 75751, delete 28653,
find 715/1415, race 0+0
Oct 21 11:32:33 localhost kernel: Free swap  = 223972kB
Oct 21 11:32:33 localhost kernel: Total swap = 514024kB
Oct 21 11:32:33 localhost kernel: Free swap:       223972kB
Oct 21 11:32:33 localhost kernel: 65520 pages of RAM
Oct 21 11:32:33 localhost kernel: 0 pages of HIGHMEM
Oct 21 11:32:33 localhost kernel: 1693 reserved pages
Oct 21 11:32:33 localhost kernel: 22526 pages shared
Oct 21 11:32:33 localhost kernel: 47098 pages swap cached
Oct 21 11:32:33 localhost kernel: 0 pages dirty
Oct 21 11:32:33 localhost kernel: 27 pages writeback
Oct 21 11:32:33 localhost kernel: 54725 pages mapped
Oct 21 11:32:33 localhost kernel: 2817 pages slab
Oct 21 11:32:33 localhost kernel: 297 pages pagetables
Oct 21 11:32:33 localhost kernel: current: hald/3309.
Oct 21 11:32:33 localhost kernel:  [out_of_memory+271/304]
out_of_memory+0x10f/0x130 (8)
Oct 21 11:32:33 localhost kernel:  [__alloc_pages+1074/1088]
__alloc_pages+0x432/0x440 (28)
Oct 21 11:32:33 localhost kernel:  [__do_page_cache_readahead+354/432]
__do_page_cache_readahead+0x162/0x1b0 (80)
Oct 21 11:32:33 localhost kernel:  [filemap_nopage+816/1088]
filemap_nopage+0x330/0x440 (56)
Oct 21 11:32:33 localhost kernel:  [do_no_page+159/1056]
do_no_page+0x9f/0x420 (60)
Oct 21 11:32:33 localhost kernel:  [do_swap_page+354/784]
do_swap_page+0x162/0x310 (16)
Oct 21 11:32:33 localhost kernel:  [__handle_mm_fault+414/480]
__handle_mm_fault+0x19e/0x1e0 (52)
Oct 21 11:32:33 localhost kernel:  [do_page_fault+507/1535]
do_page_fault+0x1fb/0x5ff (48)
Oct 21 11:32:33 localhost kernel:  [do_page_fault+0/1535]
do_page_fault+0x0/0x5ff (64)
Oct 21 11:32:33 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54 (8)
