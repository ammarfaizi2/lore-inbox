Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUIWVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUIWVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUIWVCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:02:16 -0400
Received: from 114.135.160.66.in-arpa.com ([66.160.135.114]:27908 "EHLO lvsbox")
	by vger.kernel.org with ESMTP id S267356AbUIWUz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:55:57 -0400
Message-ID: <4153384E.1030804@bushytails.net>
Date: Thu, 23 Sep 2004 13:55:42 -0700
From: Randy Gardner <lkml@bushytails.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 OOM on hard drive copy 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put an older 8gb hard drive in today to try to copy the data off of 
it, but whenever I try, I get repeated OOMs starting about 1.3gb into 
the copy.

Quick system specs:
Dual p3s on a MSI 694D Pro motherboard (via chipset), 2GB of ram. 
2.6.8.1 kernel compiled with 4gb memory limit.

A search of the archives shows a very similar problem (and patch) with 
burning audio CDs under 2.6.8.1, so this is probably the same bug, but I 
figure it's different enough to warrant a separate post, even if just to 
help people searching for it.  (I can't find any reference to this 
problem with copying between hard drives).  (If I was wrong to figure 
that, I apologize)

The hard drive being copied from does not work with DMA, and having it 
in results in no dma for any of the drives.  (No message is displayed 
for this, but hdparm shows dma off when it's normally on.  On the box 
the 8gb drive was removed from, dma would always immediately time out)

If I ctrl-c the copy, the box does remain up, but running most any 
command will result in another OOM and another random process killed 
(usually apache, mysql, or something else large).  Rebooting the box at 
this point sometimes succeeds, but sometimes init gets oom-killed first, 
and the box has to be physically reset.

Watching with top shows there's still some physical ram left, and the 
4gb of swap is not being used at all.  As such, it appears the OOM is 
happening when the box is not really out of memory.

Let me know if I should post dmesg output or other further information; 
it's quite long, so figured I'd skip it unless it was needed.  And, of 
course, let me know if there's any experiments I should try to see what 
happens.  For now I'll try -rc2 and see if it helps.


Thanks in advance,
--Randy


Exact message copied from kern.log:

I mount the partition, and begin the copy...  10 minutes (and 1.2 - 
1.3gb; very slow with no dma) later the OOMs start.  It is repeatable at 
the same approximate place.

Sep 23 11:58:52 localhost kernel: EXT3 FS on hdc1, internal journal
Sep 23 11:58:52 localhost kernel: EXT3-fs: recovery complete.
Sep 23 11:58:52 localhost kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Sep 23 12:08:19 localhost kernel: oom-killer: gfp_mask=0xd0
Sep 23 12:08:19 localhost kernel: DMA per-cpu:
Sep 23 12:08:19 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 23 12:08:19 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 23 12:08:19 localhost kernel: cpu 1 hot: low 2, high 6, batch 1
Sep 23 12:08:19 localhost kernel: cpu 1 cold: low 0, high 2, batch 1
Sep 23 12:08:19 localhost kernel: Normal per-cpu:
Sep 23 12:08:19 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 23 12:08:19 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 23 12:08:19 localhost kernel: cpu 1 hot: low 32, high 96, batch 16
Sep 23 12:08:19 localhost kernel: cpu 1 cold: low 0, high 32, batch 16
Sep 23 12:08:19 localhost kernel: HighMem per-cpu:
Sep 23 12:08:19 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 23 12:08:22 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 23 12:08:22 localhost kernel: cpu 1 hot: low 32, high 96, batch 16
Sep 23 12:08:22 localhost kernel: cpu 1 cold: low 0, high 32, batch 16
Sep 23 12:08:22 localhost kernel:
Sep 23 12:08:22 localhost kernel: Free pages:      918916kB (917056kB 
HighMem)
Sep 23 12:08:22 localhost kernel: Active:8455 inactive:54703 dirty:43461 
writeback:0 unstable:0 free:229729 slab:4608 mapped:8431 pagetables:195
Sep 23 12:08:22 localhost kernel: DMA free:44kB min:16kB low:32kB 
high:48kB active:0kB inactive:0kB present:16384kB
Sep 23 12:08:22 localhost kernel: protections[]: 8 476 732
Sep 23 12:08:24 localhost kernel: Normal free:1816kB min:936kB 
low:1872kB high:2808kB active:0kB inactive:200kB present:901120kB
Sep 23 12:08:24 localhost kernel: protections[]: 0 468 724
Sep 23 12:08:24 localhost kernel: HighMem free:917056kB min:512kB 
low:1024kB high:1536kB active:33820kB inactive:218612kB present:1179584kB
Sep 23 12:08:24 localhost kernel: protections[]: 0 0 256
Sep 23 12:08:24 localhost kernel: DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Sep 23 12:08:24 localhost kernel: Normal: 0*4kB 1*8kB 1*16kB 0*32kB 
0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1816kB
Sep 23 12:08:24 localhost kernel: HighMem: 272*4kB 574*8kB 375*16kB 
143*32kB 1583*64kB 710*128kB 108*256kB 44*512kB 45*1024kB 43*2048kB 
128*4096kB = 917056kB
Sep 23 12:08:24 localhost kernel: Swap cache: add 0, delete 0, find 0/0, 
race 0+0
Sep 23 12:08:24 localhost kernel: Out of Memory: Killed process 2665 
(apache2).

At this point further OOMs repeat from the oom-killer line.


