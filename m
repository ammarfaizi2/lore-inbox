Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVCUNiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVCUNiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVCUNiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:38:10 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:59535 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S261784AbVCUNhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:37:40 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: OOM killer activations when there is plenty of memory and swap available
Date: Mon, 21 Mar 2005 16:37:37 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211637.37564@zigzag.lvk.cs.msu.su>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've just suffered a server crash, related to OOM killer.

Server is a dual-xeon, and is used to provide remote desktops to terminals, 
and normally runs some services and 10-15 KDE sessions. The server has 6G 
of ram and 7G of swap space, running Debian kernel 2.6.10 recompiled with 
highmem64 support.

The problem was the following. Suddenly oom-killer started to kill tasks, 
one after another. It was activated each 10-20 seconds. Soon server became 
unusable and I had to reboot it. On the time of the problem even not all 
physical memory was used, and swap usage was near to zero.

Now I am thinking what to do with this.
Below are several example groups of messages I got into syslog (in total I 
got more than 1000 of such groups). Could someone with better knowledge of 
linux VM, look through those, and tell me which of numbers look incorrect?

Please CC reply to my e-mail address.
Thank you.

Mar 21 13:17:57 zigzag kernel: oom-killer: gfp_mask=0xd1
Mar 21 13:17:57 zigzag kernel: DMA per-cpu:
Mar 21 13:17:57 zigzag kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 2 hot: low 2, high 6, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 2 cold: low 0, high 2, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 3 hot: low 2, high 6, batch 1
Mar 21 13:17:57 zigzag kernel: cpu 3 cold: low 0, high 2, batch 1
Mar 21 13:17:57 zigzag kernel: Normal per-cpu:
Mar 21 13:17:57 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: HighMem per-cpu:
Mar 21 13:17:57 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:17:57 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:17:57 zigzag kernel:
Mar 21 13:17:57 zigzag kernel: Free pages:      787208kB (612672kB HighMem)
Mar 21 13:17:57 zigzag kernel: Active:1086091 inactive:195849 dirty:10629 
writeback:239 unstable:0 free:196802 slab:59409 mapped:721028 
pagetables:10547
Mar 21 13:17:57 zigzag kernel: DMA free:4720kB min:68kB low:84kB high:100kB 
active:0kB inactive:4kB present:16384kB pages_scanned:336 
all_unreclaimable? no
Mar 21 13:17:57 zigzag kernel: protections[]: 0 0 0
Mar 21 13:17:57 zigzag kernel: Normal free:169816kB min:3756kB low:4692kB 
high:5632kB active:390796kB inactive:34692kB present:901120kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:17:57 zigzag kernel: protections[]: 0 0 0
Mar 21 13:17:57 zigzag kernel: HighMem free:612672kB min:512kB low:640kB 
high:768kB active:3953568kB inactive:748700kB present:6422528kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:17:57 zigzag kernel: protections[]: 0 0 0
Mar 21 13:17:57 zigzag kernel: DMA: 758*4kB 165*8kB 23*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4720kB
Mar 21 13:17:57 zigzag kernel: Normal: 20282*4kB 8468*8kB 1071*16kB 59*32kB 
4*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 169816kB
Mar 21 13:17:57 zigzag kernel: HighMem: 69372*4kB 31136*8kB 3003*16kB 
225*32kB 106*64kB 36*128kB 8*256kB 2*512kB 4*1024kB 0*2048kB 3*4096kB = 
612672kB
Mar 21 13:17:57 zigzag kernel: Swap cache: add 361208, delete 356079, find 
12639/16520, race 0+0
Mar 21 13:17:57 zigzag kernel: Out of Memory: Killed process 32638 
(mysqld).



Mar 21 13:15:21 zigzag kernel: oom-killer: gfp_mask=0xd1
Mar 21 13:15:21 zigzag kernel: DMA per-cpu:
Mar 21 13:15:21 zigzag kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 2 hot: low 2, high 6, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 2 cold: low 0, high 2, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 3 hot: low 2, high 6, batch 1
Mar 21 13:15:21 zigzag kernel: cpu 3 cold: low 0, high 2, batch 1
Mar 21 13:15:21 zigzag kernel: Normal per-cpu:
Mar 21 13:15:21 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: HighMem per-cpu:
Mar 21 13:15:21 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:15:21 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:15:21 zigzag kernel:
Mar 21 13:15:21 zigzag kernel: Free pages:      544924kB (427712kB HighMem)
Mar 21 13:15:21 zigzag kernel: Active:1141576 inactive:199896 dirty:453 
writeback:46 unstable:0 free:136231 slab:59805 mapped:796753 
pagetables:11096
Mar 21 13:15:21 zigzag kernel: DMA free:4628kB min:68kB low:84kB high:100kB 
active:12kB inactive:0kB present:16384kB pages_scanned:204 
all_unreclaimable? no
Mar 21 13:15:21 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:21 zigzag kernel: Normal free:112584kB min:3756kB low:4692kB 
high:5632kB active:427920kB inactive:52532kB present:901120kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:15:21 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:21 zigzag kernel: HighMem free:427712kB min:512kB low:640kB 
high:768kB active:4138372kB inactive:747052kB present:6422528kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:15:21 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:21 zigzag kernel: DMA: 759*4kB 155*8kB 22*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4628kB
Mar 21 13:15:21 zigzag kernel: Normal: 14880*4kB 5009*8kB 582*16kB 55*32kB 
4*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 112584kB
Mar 21 13:15:21 zigzag kernel: HighMem: 69966*4kB 15875*8kB 1189*16kB 
37*32kB 4*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 
427712kB
Mar 21 13:15:21 zigzag kernel: Swap cache: add 360907, delete 355920, find 
12556/16396, race 0+0
Mar 21 13:15:21 zigzag kernel: Out of Memory: Killed process 31065 (java).


Mar 21 13:15:26 zigzag kernel: oom-killer: gfp_mask=0xd1
Mar 21 13:15:26 zigzag kernel: DMA per-cpu:
Mar 21 13:15:26 zigzag kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 2 hot: low 2, high 6, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 2 cold: low 0, high 2, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 3 hot: low 2, high 6, batch 1
Mar 21 13:15:26 zigzag kernel: cpu 3 cold: low 0, high 2, batch 1
Mar 21 13:15:26 zigzag kernel: Normal per-cpu:
Mar 21 13:15:26 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: HighMem per-cpu:
Mar 21 13:15:26 zigzag kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 2 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 2 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 3 hot: low 32, high 96, batch 16
Mar 21 13:15:26 zigzag kernel: cpu 3 cold: low 0, high 32, batch 16
Mar 21 13:15:26 zigzag kernel:
Mar 21 13:15:26 zigzag kernel: Free pages:      602292kB (462144kB HighMem)
Mar 21 13:15:26 zigzag kernel: Active:1128920 inactive:198396 dirty:1310 
writeback:53 unstable:0 free:150573 slab:59773 mapped:781310 
pagetables:11071
Mar 21 13:15:26 zigzag kernel: DMA free:4660kB min:68kB low:84kB high:100kB 
active:4kB inactive:0kB present:16384kB pages_scanned:182 
all_unreclaimable? no
Mar 21 13:15:26 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:26 zigzag kernel: Normal free:135488kB min:3756kB low:4692kB 
high:5632kB active:406036kB inactive:51952kB present:901120kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:15:26 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:26 zigzag kernel: HighMem free:462144kB min:512kB low:640kB 
high:768kB active:4109640kB inactive:741632kB present:6422528kB 
pages_scanned:0 all_unreclaimable? no
Mar 21 13:15:26 zigzag kernel: protections[]: 0 0 0
Mar 21 13:15:26 zigzag kernel: DMA: 759*4kB 159*8kB 22*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4660kB
Mar 21 13:15:26 zigzag kernel: Normal: 19170*4kB 5657*8kB 617*16kB 55*32kB 
4*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 135488kB
Mar 21 13:15:26 zigzag kernel: HighMem: 69802*4kB 19887*8kB 1360*16kB 
45*32kB 4*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 
462144kB
Mar 21 13:15:26 zigzag kernel: Swap cache: add 360988, delete 355993, find 
12569/16420, race 0+0
Mar 21 13:15:26 zigzag kernel: Out of Memory: Killed process 613 
(kio_thumbnail).
