Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271109AbRHOJN7>; Wed, 15 Aug 2001 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271107AbRHOJNt>; Wed, 15 Aug 2001 05:13:49 -0400
Received: from dialup186.canberra.net.au ([203.33.188.58]:28932 "EHLO
	didi.local.net") by vger.kernel.org with ESMTP id <S271109AbRHOJNp>;
	Wed, 15 Aug 2001 05:13:45 -0400
Message-ID: <000c01c12569$65581630$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Cc: "Nick Piggin" <s3293115@student.anu.edu.au>
Subject: kswapd using all cpu for long periods in 2.4.9-pre4
Date: Wed, 15 Aug 2001 19:05:08 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Somewhere between 2.4.8 and 2.4.9-pre4 kswapd developed a problem. Actually
it looks like it is related to the changes in do_try_to_free_pages...

kswapd is using all cpu for long periods (100-200 seconds then 100-200
seconds break....) there is very little disk activity (heres a vmstat while
its happening)

0 0 1 18372 1872 1628 38540 1 0 4 2 343 127 1 96 3
0 0 1 18360 1992 1628 38416 0 0 0 3 282 120 0 100 0
0 0 1 18312 2188 1632 38244 1 0 31 6 376 147 1 89 10
0 0 1 18324 1908 1632 38252 0 0 0 3 411 130 0 99 0
0 0 1 18324 1996 1632 38260 0 0 1 1 175 115 0 100 0
0 0 1 18324 1852 1632 38336 17 0 36 8 150 163 0 100 0
0 0 1 18324 2028 1632 38336 0 0 0 8 107 119 0 100 0

kswapd task:
Trace; c0145328 <shrink_icache_memory+18/30>
Trace; c012b850 <do_try_to_free_pages+60/c0>
Trace; c012b90e <kswapd+5e/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01054d6 <kernel_thread+26/30>
Trace; c012b8b0 <kswapd+0/c0>

meminfo just before kswapd goes crazy:
Mem-info:
Free pages: 4616kB ( 0kB HighMem)
( Active: 6707, inactive_dirty: 4312, inactive_clean: 895, free: 1154 (256
512 2048) )
5*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB =
1036kB)
483*4kB 104*8kB 5*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB
0*2048kB = 3580kB)
= 0kB)
Swap cache: add 16566, delete 14047, find 17323/32269
Free swap: 110016kB
16368 pages of RAM
0 pages of HIGHMEM
689 reserved pages
10205 pages shared
2519 pages swap cached
0 pages in page table cache
Buffer memory: 1472kB

mem info during:
SysRq: Show Memory
Mem-info:
Free pages: 3744kB ( 0kB HighMem)
( Active: 6946, inactive_dirty: 4296, inactive_clean: 895, free: 936 (256
512 2048) )
5*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB =
1036kB)
263*4kB 105*8kB 5*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB
0*2048kB = 2708kB)
= 0kB)
Swap cache: add 16680, delete 14047, find 17408/32591
Free swap: 110016kB
16368 pages of RAM
0 pages of HIGHMEM
689 reserved pages
10453 pages shared
2633 pages swap cached
0 pages in page table cache
Buffer memory: 1480kB



