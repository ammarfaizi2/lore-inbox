Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVAYPCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVAYPCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVAYPCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:02:32 -0500
Received: from v6.netlin.pl ([62.121.136.6]:26385 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261965AbVAYPCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:02:24 -0500
Message-ID: <41F65F1E.3070504@pointblue.com.pl>
Date: Tue, 25 Jan 2005 16:00:46 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swap is never used on ultrasparc64/32 - 2.6.11-rc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've 2.6.11-rc2 sparc64 kernel, userland is 32bits.

I was compiling few things, fired up firefox, and kaboom. No memory.

Meanwhile, I runned swapoff -a, mkswap -v1 /dev/hda2 , swapon -a, and 
tried to replace swap partition with swap file, which didn't worked either.
Here's dmesg:

oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 6, high 18, batch 3
cpu 0 cold: low 0, high 6, batch 3
Normal per-cpu: empty
HighMem per-cpu: empty

Free pages:        3520kB (0kB HighMem)
Active:28 inactive:13023 dirty:0 writeback:0 unstable:0 free:440 
slab:908 mapped:18446744073704443093 pagetables:167
DMA free:3520kB min:1408kB low:1760kB high:2112kB active:224kB 
inactive:104184kB present:125192kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:256kB low:320kB high:384kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 240*8kB 14*16kB 1*32kB 1*64kB 2*128kB 2*256kB 1*512kB 0*1024kB 
0*2048kB 0*4096kB 0*8192kB = 3520kB
Normal: empty
HighMem: empty
Swap cache: add 310, delete 310, find 41/50, race 0+0
Out of Memory: Killed process 15926 (mozilla-bin).
Out of Memory: Killed process 15923 (mozilla-bin).
Out of Memory: Killed process 15927 (mozilla-bin).
Out of Memory: Killed process 15931 (mozilla-bin).
ioctl32(esd:16474): Unknown cmd fd(10) cmd(40045500){00} arg(efffe35c) 
on /dev/snd/controlC0
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 6, high 18, batch 3
cpu 0 cold: low 0, high 6, batch 3
Normal per-cpu: empty
HighMem per-cpu: empty

Free pages:        2312kB (0kB HighMem)
Active:14 inactive:13186 dirty:0 writeback:0 unstable:0 free:289 
slab:895 mapped:18446744073704347582 pagetables:161
DMA free:2312kB min:1408kB low:1760kB high:2112kB active:112kB 
inactive:105488kB present:125192kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:256kB low:320kB high:384kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 95*8kB 11*16kB 1*32kB 1*64kB 2*128kB 2*256kB 1*512kB 0*1024kB 
0*2048kB 0*4096kB 0*8192kB = 2312kB
Normal: empty
HighMem: empty
Swap cache: add 310, delete 310, find 41/50, race 0+0
Out of Memory: Killed process 16456 (firefox-bin).
Out of Memory: Killed process 16450 (firefox-bin).
Out of Memory: Killed process 16457 (firefox-bin).
Out of Memory: Killed process 16461 (firefox-bin).
Adding 249936k swap on /dev/hda2.  Priority:-2 extents:1
ioctl32(esd:16742): Unknown cmd fd(10) cmd(40045500){00} arg(efffe35c) 
on /dev/snd/controlC0
Adding 127984k swap on /swap.  Priority:-3 extents:5



top shows that swap memory is present, but it never get used.

-- 
GJ
