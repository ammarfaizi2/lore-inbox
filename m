Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUKPIiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUKPIiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUKPIiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:38:10 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:49174 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261939AbUKPIh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:37:58 -0500
Message-ID: <4199BC5F.5020400@tebibyte.org>
Date: Tue, 16 Nov 2004 09:37:51 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random>
In-Reply-To: <20041114170339.GB13733@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli escreveu:
> Chris, since you can reproduce so easily, could you try a `vmstat 1`
> while the oom killing happens, and can you post it?

This is with linux-2.6.10-rc2 (and no patches).


procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  2  0   5044   2888   5128  12696  320 1892  4532  1892 1157   295 20 
20  0 60
  0  1   6860    756   3076  15368  148 1920  4428  1920 1175   261 13 
14  0 73
  0  1   9460    712   2492  12404   28 2736  4896  2736 1142   247 15 
19  0 66
  0  2  22228   3176   2460   4144  240 13316  2556 13356 1146   132 14 
30  0 56
  0  1  21612    960   2556   7932  300    0  4936   172 1145   195 16 
12  0 72
  0  2  22964    552   2440   4088  992 1720  6760  1720 1316   407 11 
27  0 62
  0  3  23492    712   2456   3520 1476  876  3968   876 1487   376  2 
18  0 81
  2  2  24904    580   2484   3784 1156 1664  2592  1664 1432   319  1 
13  0 86
  0  3  35012    704   2616   5604  864 10116  2872 10184 1139   207  4 
15  0 81
  2  2  34756    880   2848   6444  232    0  1072   340 1248   171  5 
12  0 83
  0  2  34740    752   2992   7220 1448    0  2308     0 1111   267 23 
13  0 65
  0  2  34740    736   3200   7308 1288    0  1544     0 1109   318 46 
18  0 35
  2  0  34740    548   3364   7436  924    0  1892     0 1116   320 55 
22  0 23
  1  1  34740    932   3216   6592 1196    0  1676     0 1104   183 51 
19  0 30
  0  2  34732    652   3440   5572 1752   12  1752   420 1085   162 74 
4  0 22
  0  1  34736    788   3088   4300 2656    8  2656   384 1235   245 46 
7  0 48
  1  2  35076    700   2740   5068 1940  440  3512   440 1290   303 11 
10  0 80
  0  1  35208    676   2756   5020 1096  192  4480   192 1275   309  1 
11  0 88
  0  1  35432    672   2760   3700  280  408  3884  1076 1579   346 10 
23  0 67
  0  6  35432    396   2760   3300 2512  272  3936   568 4782  2045  0 
25  0 74
  1  1   6260  41364   2800   4480 2220    0  3812     0 1180   359  1 
8  0 91
  1  0   6260  41200   2908   4488   64    0    84   168 1040    52  0 
2 92  6
  0  0   6260  41200   2908   4488    4    0     4     0 1005     8  0 
0 99  1


Nov 16 09:25:20 sleepy oom-killer: gfp_mask=0xd2
Nov 16 09:25:20 sleepy DMA per-cpu:
Nov 16 09:25:20 sleepy cpu 0 hot: low 2, high 6, batch 1
Nov 16 09:25:20 sleepy cpu 0 cold: low 0, high 2, batch 1
Nov 16 09:25:20 sleepy Normal per-cpu:
Nov 16 09:25:20 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 16 09:25:20 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 16 09:25:20 sleepy HighMem per-cpu: empty
Nov 16 09:25:20 sleepy
Nov 16 09:25:20 sleepy Free pages:         244kB (0kB HighMem)
Nov 16 09:25:20 sleepy Active:12246 inactive:392 dirty:0 writeback:0 
unstable:0 free:61 slab:1294 mapped:11933 pagetables:172
Nov 16 09:25:20 sleepy DMA free:60kB min:60kB low:120kB high:180kB 
active:11876kB inactive:0kB present:16384kB pages_scanned:12100 
all_unreclaimable? yes
Nov 16 09:25:20 sleepy protections[]: 0 0 0
Nov 16 09:25:20 sleepy Normal free:184kB min:188kB low:376kB high:564kB 
active:37108kB inactive:1568kB present:49144kB pages_scanned:40510 
all_unreclaimable
? yes
Nov 16 09:25:20 sleepy protections[]: 0 0 0
Nov 16 09:25:20 sleepy HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 16 09:25:20 sleepy protections[]: 0 0 0
Nov 16 09:25:20 sleepy DMA: 1*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 60kB
Nov 16 09:25:20 sleepy Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 184kB
Nov 16 09:25:20 sleepy HighMem: empty
Nov 16 09:25:20 sleepy Swap cache: add 8591929, delete 8588661, find 
723569/2416017, race 3+15
Nov 16 09:25:20 sleepy Out of Memory: Killed process 22511 (ld).
