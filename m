Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVATMeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVATMeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVATMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:34:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1188 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262136AbVATMeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:34:07 -0500
Date: Thu, 20 Jan 2005 13:34:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: oom killer gone nuts
Message-ID: <20050120123402.GA4782@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using current BK on my x86-64 workstation, it went completely nuts today
killing tasks left and right with oodles of free memory available.
Here's a little snippet from messages:


Out of Memory: Killed process 2847 (screen).
oom-killer: gfp_mask=0xd1
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:      529184kB (0kB HighMem)
Active:19127 inactive:20440 dirty:92 writeback:0 unstable:0 free:132296 slab:3827 mapped:3503 pagetables:164
DMA free:4536kB min:60kB low:72kB high:88kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:524648kB min:4028kB low:5032kB high:6040kB active:76508kB inactive:81760kB present:1031360kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 556*4kB 155*8kB 65*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4536kB
Normal: 29800*4kB 25115*8kB 6953*16kB 1251*32kB 326*64kB 103*128kB 31*256kB 12*512kB 3*1024kB 1*2048kB 0*4096kB = 524648kB
HighMem: empty
Swap cache: add 59864, delete 55781, find 6188/8478, race 0+0
Out of Memory: Killed process 27326 (bash).
oom-killer: gfp_mask=0xd1
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:      530472kB (0kB HighMem)
Active:18861 inactive:20434 dirty:147 writeback:0 unstable:0 free:132618 slab:3836 mapped:2955 pagetables:144
DMA free:4536kB min:60kB low:72kB high:88kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:525936kB min:4028kB low:5032kB high:6040kB active:75444kB inactive:81736kB present:1031360kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 556*4kB 155*8kB 65*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4536kB
Normal: 30040*4kB 25124*8kB 6953*16kB 1255*32kB 328*64kB 103*128kB 31*256kB 12*512kB 3*1024kB 1*2048kB 0*4096kB = 525936kB
HighMem: empty
Swap cache: add 59864, delete 55781, find 6188/8478, race 0+0


-- 
Jens Axboe

