Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTGCOxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTGCOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:53:36 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13283 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263777AbTGCOvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:51:24 -0400
Date: Thu, 03 Jul 2003 07:27:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: More on io_schedule hang
Message-ID: <47040000.1057242430@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I did mm3 + feral but without highpte last night.

It successfully completed the SDET stress test (50 runs at
each of 1,2,4,8,16,32,64,128 clients), which I left running
overnight. Came in this morning, box looked fine. Downloaded
2.5.74, uploaded a patch or two, extracted a new view, and
then tried to patch 2.5.74 into the view with bzcat | patch.
Wedge-o-rama. I guess I'll try the non-feral driver next.

telnet> send break
SysRq : Show Memory
Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
cpu 4 hot: low 2, high 6, batch 1
cpu 4 cold: low 0, high 2, batch 1
cpu 5 hot: low 2, high 6, batch 1
cpu 5 cold: low 0, high 2, batch 1
cpu 6 hot: low 2, high 6, batch 1
cpu 6 cold: low 0, high 2, batch 1
cpu 7 hot: low 2, high 6, batch 1
cpu 7 cold: low 0, high 2, batch 1
cpu 8 hot: low 2, high 6, batch 1
cpu 8 cold: low 0, high 2, batch 1
cpu 9 hot: low 2, high 6, batch 1
cpu 9 cold: low 0, high 2, batch 1
cpu 10 hot: low 2, high 6, batch 1
cpu 10 cold: low 0, high 2, batch 1
cpu 11 hot: low 2, high 6, batch 1
cpu 11 cold: low 0, high 2, batch 1
cpu 12 hot: low 2, high 6, batch 1
cpu 12 cold: low 0, high 2, batch 1
cpu 13 hot: low 2, high 6, batch 1
cpu 13 cold: low 0, high 2, batch 1
cpu 14 hot: low 2, high 6, batch 1
cpu 14 cold: low 0, high 2, batch 1
cpu 15 hot: low 2, high 6, batch 1
cpu 15 cold: low 0, high 2, batch 1
cpu 16 hot: low 2, high 6, batch 1
cpu 16 cold: low 0, high 2, batch 1
cpu 17 hot: low 2, high 6, batch 1
cpu 17 cold: low 0, high 2, batch 1
cpu 18 hot: low 2, high 6, batch 1
cpu 18 cold: low 0, high 2, batch 1
cpu 19 hot: low 2, high 6, batch 1
cpu 19 cold: low 0, high 2, batch 1
cpu 20 hot: low 2, high 6, batch 1
cpu 20 cold: low 0, high 2, batch 1
cpu 21 hot: low 2, high 6, batch 1
cpu 21 cold: low 0, high 2, batch 1
cpu 22 hot: low 2, high 6, batch 1
cpu 22 cold: low 0, high 2, batch 1
cpu 23 hot: low 2, high 6, batch 1
cpu 23 cold: low 0, high 2, batch 1
cpu 24 hot: low 2, high 6, batch 1
cpu 24 cold: low 0, high 2, batch 1
cpu 25 hot: low 2, high 6, batch 1
cpu 25 cold: low 0, high 2, batch 1
cpu 26 hot: low 2, high 6, batch 1
cpu 26 cold: low 0, high 2, batch 1
cpu 27 hot: low 2, high 6, batch 1
cpu 27 cold: low 0, high 2, batch 1
cpu 28 hot: low 2, high 6, batch 1
cpu 28 cold: low 0, high 2, batch 1
cpu 29 hot: low 2, high 6, batch 1
cpu 29 cold: low 0, high 2, batch 1
cpu 30 hot: low 2, high 6, batch 1
cpu 30 cold: low 0, high 2, batch 1
cpu 31 hot: low 2, high 6, batch 1
cpu 31 cold: low 0, high 2, batch 1
Node 0 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 0 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu: empty
Node 1 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu: empty
Node 2 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu: empty
Node 3 HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
cpu 2 hot: low 32, high 96, batch 16
cpu 2 cold: low 0, high 32, batch 16
cpu 3 hot: low 32, high 96, batch 16
cpu 3 cold: low 0, high 32, batch 16
cpu 4 hot: low 32, high 96, batch 16
cpu 4 cold: low 0, high 32, batch 16
cpu 5 hot: low 32, high 96, batch 16
cpu 5 cold: low 0, high 32, batch 16
cpu 6 hot: low 32, high 96, batch 16
cpu 6 cold: low 0, high 32, batch 16
cpu 7 hot: low 32, high 96, batch 16
cpu 7 cold: low 0, high 32, batch 16
cpu 8 hot: low 32, high 96, batch 16
cpu 8 cold: low 0, high 32, batch 16
cpu 9 hot: low 32, high 96, batch 16
cpu 9 cold: low 0, high 32, batch 16
cpu 10 hot: low 32, high 96, batch 16
cpu 10 cold: low 0, high 32, batch 16
cpu 11 hot: low 32, high 96, batch 16
cpu 11 cold: low 0, high 32, batch 16
cpu 12 hot: low 32, high 96, batch 16
cpu 12 cold: low 0, high 32, batch 16
cpu 13 hot: low 32, high 96, batch 16
cpu 13 cold: low 0, high 32, batch 16
cpu 14 hot: low 32, high 96, batch 16
cpu 14 cold: low 0, high 32, batch 16
cpu 15 hot: low 32, high 96, batch 16
cpu 15 cold: low 0, high 32, batch 16
cpu 16 hot: low 32, high 96, batch 16
cpu 16 cold: low 0, high 32, batch 16
cpu 17 hot: low 32, high 96, batch 16
cpu 17 cold: low 0, high 32, batch 16
cpu 18 hot: low 32, high 96, batch 16
cpu 18 cold: low 0, high 32, batch 16
cpu 19 hot: low 32, high 96, batch 16
cpu 19 cold: low 0, high 32, batch 16
cpu 20 hot: low 32, high 96, batch 16
cpu 20 cold: low 0, high 32, batch 16
cpu 21 hot: low 32, high 96, batch 16
cpu 21 cold: low 0, high 32, batch 16
cpu 22 hot: low 32, high 96, batch 16
cpu 22 cold: low 0, high 32, batch 16
cpu 23 hot: low 32, high 96, batch 16
cpu 23 cold: low 0, high 32, batch 16
cpu 24 hot: low 32, high 96, batch 16
cpu 24 cold: low 0, high 32, batch 16
cpu 25 hot: low 32, high 96, batch 16
cpu 25 cold: low 0, high 32, batch 16
cpu 26 hot: low 32, high 96, batch 16
cpu 26 cold: low 0, high 32, batch 16
cpu 27 hot: low 32, high 96, batch 16
cpu 27 cold: low 0, high 32, batch 16
cpu 28 hot: low 32, high 96, batch 16
cpu 28 cold: low 0, high 32, batch 16
cpu 29 hot: low 32, high 96, batch 16
cpu 29 cold: low 0, high 32, batch 16
cpu 30 hot: low 32, high 96, batch 16
cpu 30 cold: low 0, high 32, batch 16
cpu 31 hot: low 32, high 96, batch 16
cpu 31 cold: low 0, high 32, batch 16

Free pages:    15194704kB (15188928kB HighMem)
Active:39696 inactive:75308 dirty:5369 writeback:1803 unstable:0 free:3798676
Node 0 DMA free:184kB min:20kB low:40kB high:60kB active:1176kB inactive:4192kB
Node 0 Normal free:5592kB min:1000kB low:2000kB high:3000kB active:107480kB inactive:225988kB
Node 0 HighMem free:2765824kB min:512kB low:1024kB high:1536kB active:40964kB inactive:68408kB
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 1 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 1 HighMem free:4139072kB min:512kB low:1024kB high:1536kB active:3440kB inactive:2268kB
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 2 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 2 HighMem free:4141184kB min:512kB low:1024kB high:1536kB active:3608kB inactive:364kB
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 3 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
Node 3 HighMem free:4142848kB min:512kB low:1024kB high:1536kB active:2116kB inactive:12kB
Node 0 DMA: 28*4kB 3*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 184kB
Node 0 Normal: 724*4kB 175*8kB 19*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 5592kB
Node 0 HighMem: 1556*4kB 854*8kB 280*16kB 60*32kB 14*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 670*4096kB = 2765824kB
Node 1 DMA: empty
Node 1 Normal: empty
Node 1 HighMem: 1182*4kB 1107*8kB 675*16kB 288*32kB 96*64kB 20*128kB 5*256kB 3*512kB 0*1024kB 1*2048kB 999*4096kB = 4139072kB
Node 2 DMA: empty
Node 2 Normal: empty
Node 2 HighMem: 1232*4kB 1254*8kB 825*16kB 392*32kB 214*64kB 64*128kB 10*256kB 3*512kB 3*1024kB 0*2048kB 994*4096kB = 4141184kB
Node 3 DMA: empty
Node 3 Normal: empty
Node 3 HighMem: 1362*4kB 1175*8kB 742*16kB 347*32kB 139*64kB 35*128kB 11*256kB 4*512kB 1*1024kB 1*2048kB 997*4096kB = 4142848kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
4162048 pages of RAM
3833856 pages of HIGHMEM
142950 reserved pages
108735 pages shared
0 pages swap cached

telnet> send break
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 003448F4     1      0     2               (NOTLB)
f019fec0 00000086 f019fed4 003448f4 00000400 c3b9b900 00000246 c39435a0 
       c01230ed c39435a0 00000246 ef475dc0 c3b9b900 f019ff68 c0123b70 f019fed4 
       ef4854a0 00000104 c3943dec c3943dec 003448f4 00000001 4b87ad6e c0123ad8 
Call Trace:
 [<c01230ed>] add_timer+0x5d/0x6c
 [<c0123b70>] schedule_timeout+0x8c/0xac
 [<c0123ad8>] process_timeout+0x0/0xc
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c0108cc7>] syscall_call+0x7/0xb

migration/0   S C3932BC0     2      1             3       (L-TLB)
c3ba9fd0 00000046 c3933580 c3932bc0 c3ba8000 c3bad330 00000003 00000001 
       00000000 e5281e04 c3932bc0 e5dc9340 c3bad330 c3ba9fec c011a5a6 c011a508 
       00000000 00000000 c3933580 00000063 00000000 c0106fb1 00000000 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S C3BA6000     3      1             4     2 (L-TLB)
c3ba7fdc 00000046 c3ba6000 c3ba6000 c0387380 c3bacd00 00000246 00000000 
       00000000 00000246 c3ba6000 e59187e0 c3bacd00 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000000 00000000 00000000 
Call Trace:
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/1   S C393ABC0     4      1             5     3 (L-TLB)
c3ba5fd0 00000046 c393b580 c393abc0 c3ba4000 c3bac6d0 00000003 00000001 
       00000000 c7b0fe04 c393abc0 ef46c9c0 c3bac6d0 c3ba5fec c011a5a6 c011a508 
       00000000 00000000 c393b580 00000063 00000000 c0106fb1 00000001 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/1   S C3BA2000     5      1             6     4 (L-TLB)
c3ba3fdc 00000046 c3ba2000 c3ba2000 c0387380 c3bac0a0 00000246 00000001 
       c011ff0a 00000246 c3ba2000 eeae0940 c3bac0a0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000001 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/2   S C3942BC0     6      1             7     5 (L-TLB)
c3bfffd0 00000046 c3943580 c3942bc0 c3bfe000 c3ba1980 00000003 00000002 
       00000000 c76a1e04 c3942bc0 c76c7e40 c3ba1980 c3bfffec c011a5a6 c011a508 
       00000000 00000000 c3943580 00000063 00000000 c0106fb1 00000002 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/2   S C3BFC000     7      1             8     6 (L-TLB)
c3bfdfdc 00000046 c3bfc000 c3bfc000 c0387380 c3ba1350 00000246 00000002 
       00000040 00000246 c3bfc000 ef475dc0 c3ba1350 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000002 00000000 00000000 
Call Trace:
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/3   S C394ABC0     8      1             9     7 (L-TLB)
c3bfbfd0 00000046 c394b580 c394abc0 c3bfa000 c3ba0d20 00000003 00000003 
       00000000 e4955e04 c394abc0 ef475c40 c3ba0d20 c3bfbfec c011a5a6 c011a508 
       00000000 00000000 c394b580 00000063 00000000 c0106fb1 00000003 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/3   S C3BF8000     9      1            10     8 (L-TLB)
c3bf9fdc 00000046 c3bf8000 c3bf8000 c0387380 c3ba06f0 00000246 00000003 
       c011ff0a 00000246 c3bf8000 eeae0940 c3ba06f0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000003 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/4   S C3952BC0    10      1            11     9 (L-TLB)
c3bf7fd0 00000046 c3953580 c3952bc0 c3bf6000 c3ba00c0 00000003 00000004 
       00000000 e4d93e04 c3952bc0 e4e4aca0 c3ba00c0 c3bf7fec c011a5a6 c011a508 
       00000000 00000000 c3953580 00000063 00000000 c0106fb1 00000004 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/4   S C3BF2000    11      1            12    10 (L-TLB)
c3bf3fdc 00000046 c3bf2000 c3bf2000 c0387380 c3bf59a0 00000246 00000004 
       c011ff0a 00000246 c3bf2000 e49a6ca0 c3bf59a0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000004 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/5   S C395ABC0    12      1            13    11 (L-TLB)
c3bf1fd0 00000046 c395b580 c395abc0 c3bf0000 c3bf5370 00000003 00000005 
       00000000 e628de04 c395abc0 e7708980 c3bf5370 c3bf1fec c011a5a6 c011a508 
       00000000 00000000 c395b580 00000063 00000000 c0106fb1 00000005 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/5   S C3BEE000    13      1            14    12 (L-TLB)
c3beffdc 00000046 c3bee000 c3bee000 c0387380 c3bf4d40 00000246 00000005 
       c011ff0a 00000246 c3bee000 e51bb6e0 c3bf4d40 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000005 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/6   S C3962BC0    14      1            15    13 (L-TLB)
c3bddfd0 00000046 c3963580 c3962bc0 c3bdc000 c3bf4710 00000003 00000006 
       00000000 e46efe04 c3962bc0 e5167240 c3bf4710 c3bddfec c011a5a6 c011a508 
       00000000 00000000 c3963580 00000063 00000000 c0106fb1 00000006 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/6   S C3BDA000    15      1            16    14 (L-TLB)
c3bdbfdc 00000046 c3bda000 c3bda000 c0387380 c3bf40e0 00000246 00000006 
       c011ff0a 00000246 c3bda000 e55a21c0 c3bf40e0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000006 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/7   S C396ABC0    16      1            17    15 (L-TLB)
c3bd7fd0 00000046 c396b580 c396abc0 c3bd6000 c3bd9900 00000003 00000007 
       00000000 e6661e04 c396abc0 e444f040 c3bd9900 c3bd7fec c011a5a6 c011a508 
       00000000 00000000 c396b580 00000063 00000000 c0106fb1 00000007 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/7   S C3BD4000    17      1            18    16 (L-TLB)
c3bd5fdc 00000046 c3bd4000 c3bd4000 c0387380 c3bd92d0 00000246 00000007 
       c011ff0a 00000246 c3bd4000 e5167240 c3bd92d0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000007 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/8   S C3972BC0    18      1            19    17 (L-TLB)
c3bd3fd0 00000046 c3973580 c3972bc0 c3bd2000 c3bd8ca0 00000003 00000008 
       00000000 eadcfe04 c3972bc0 e543ee60 c3bd8ca0 c3bd3fec c011a5a6 c011a508 
       00000000 00000000 c3973580 00000063 00000000 c0106fb1 00000008 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/8   S C3BD0000    19      1            20    18 (L-TLB)
c3bd1fdc 00000046 c3bd0000 c3bd0000 c0387380 c3bd8670 00000246 00000008 
       c011ff0a 00000246 c3bd0000 e5918360 c3bd8670 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000008 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/9   S C397ABC0    20      1            21    19 (L-TLB)
c3bcffd0 00000046 c397b580 c397abc0 c3bce000 c3bd8040 00000003 00000009 
       00000000 e4491e04 c397abc0 e5895860 c3bd8040 c3bcffec c011a5a6 c011a508 
       00000000 00000000 c397b580 00000063 00000000 c0106fb1 00000009 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/9   S C3BCA000    21      1            22    20 (L-TLB)
c3bcbfdc 00000046 c3bca000 c3bca000 c0387380 c3bcd920 00000246 00000009 
       c011ff0a 00000246 c3bca000 e4dc36c0 c3bcd920 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 00000009 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/10  S C3982BC0    22      1            23    21 (L-TLB)
f0179fd0 00000046 c3983580 c3982bc0 f0178000 c3bcd2f0 00000003 0000000a 
       00000000 e4491e04 c3982bc0 e4e4ee00 c3bcd2f0 f0179fec c011a5a6 c011a508 
       00000000 00000000 c3983580 00000063 00000000 c0106fb1 0000000a 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/10  S F0176000    23      1            24    22 (L-TLB)
f0177fdc 00000046 f0176000 f0176000 c0387380 c3bcccc0 00000246 0000000a 
       c011ff0a 00000246 f0176000 e444fdc0 c3bcccc0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000a 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/11  S C398ABC0    24      1            25    23 (L-TLB)
f0175fd0 00000046 c398b580 c398abc0 f0174000 c3bcc690 00000003 0000000b 
       00000000 e4491e04 c398abc0 e5869e20 c3bcc690 f0175fec c011a5a6 c011a508 
       00000000 00000000 c398b580 00000063 00000000 c0106fb1 0000000b 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/11  S F0172000    25      1            26    24 (L-TLB)
f0173fdc 00000046 f0172000 f0172000 c0387380 c3bcc060 00000246 0000000b 
       c011ff0a 00000246 f0172000 e47e63e0 c3bcc060 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000b 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/12  S C3992BC0    26      1            27    25 (L-TLB)
f016ffd0 00000046 c3993580 c3992bc0 f016e000 f0171940 00000003 0000000c 
       00000000 e490be04 c3992bc0 e8338e40 f0171940 f016ffec c011a5a6 c011a508 
       00000000 00000000 c3993580 00000063 00000000 c0106fb1 0000000c 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/12  S F016C000    27      1            28    26 (L-TLB)
f016dfdc 00000046 f016c000 f016c000 c0387380 f0171310 00000246 0000000c 
       c011ff0a 00000246 f016c000 e4432260 f0171310 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000c 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/13  S C399ABC0    28      1            29    27 (L-TLB)
f016bfd0 00000046 c399b580 c399abc0 f016a000 f0170ce0 00000003 0000000d 
       00000000 e42a3e04 c399abc0 e4de6200 f0170ce0 f016bfec c011a5a6 c011a508 
       00000000 00000000 c399b580 00000063 00000000 c0106fb1 0000000d 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/13  S F0168000    29      1            30    28 (L-TLB)
f0169fdc 00000046 f0168000 f0168000 c0387380 f01706b0 00000246 0000000d 
       000001a0 00000246 f0168000 e4432e60 f01706b0 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000d 00000000 00000000 
Call Trace:
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/14  S C39A2BC0    30      1            31    29 (L-TLB)
f0157fd0 00000046 c39a3580 c39a2bc0 f0156000 f0170080 00000003 0000000e 
       00000000 e460fe04 c39a2bc0 e5863c80 f0170080 f0157fec c011a5a6 c011a508 
       00000000 00000000 c39a3580 00000063 00000000 c0106fb1 0000000e 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/14  S F0152000    31      1            32    30 (L-TLB)
f0153fdc 00000046 f0152000 f0152000 c0387380 f0155960 00000246 0000000e 
       c011ff0a 00000246 f0152000 e4143de0 f0155960 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000e 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

migration/15  S C39AABC0    32      1            33    31 (L-TLB)
f0151fd0 00000046 c39ab580 c39aabc0 f0150000 f0155330 00000003 0000000f 
       00000000 e460fe04 c39aabc0 e4dc33c0 f0155330 f0151fec c011a5a6 c011a508 
       00000000 00000000 c39ab580 00000063 00000000 c0106fb1 0000000f 00000000 
Call Trace:
 [<c011a5a6>] migration_thread+0x9e/0xe4
 [<c011a508>] migration_thread+0x0/0xe4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

ksoftirqd/15  S F014E000    33      1            34    32 (L-TLB)
f014ffdc 00000046 f014e000 f014e000 c0387380 f0154d00 00000246 0000000f 
       c011ff0a 00000246 f014e000 eeae0ac0 f0154d00 00000000 c01203f1 c0120368 
       00000000 00000000 c0106fb1 0000000f 00000000 00000000 
Call Trace:
 [<c011ff0a>] do_softirq+0x6a/0xbc
 [<c01203f1>] ksoftirqd+0x89/0xc4
 [<c0120368>] ksoftirqd+0x0/0xc4
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/0      S F01D7000    34      1            35    33 (L-TLB)
f013df9c 00000046 00000282 f01d7000 f013c000 f01546d0 00000082 f01d7020 
       00000003 00000001 00000000 eeae0340 f01546d0 ef47a000 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7000 f01d7014 f01d700c c01a9774 f013c000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01a9774>] flush_to_ldisc+0x0/0xc8
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/1      S F01D7060    35      1            36    34 (L-TLB)
f013bf9c 00000046 00000282 f01d7060 f013a000 f01540a0 00000082 f01d7080 
       00000003 00000001 00000000 e51bbb60 f01540a0 ef47a000 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7060 f01d7074 f01d706c c01a9774 f013a000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01a9774>] flush_to_ldisc+0x0/0xc8
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/2      S F01D70C0    36      1            37    35 (L-TLB)
f0137f9c 00000046 00000282 f01d70c0 f0136000 f0139980 00000082 f01d70e0 
       00000003 00000001 00000000 ef475dc0 f0139980 ef47a000 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d70c0 f01d70d4 f01d70cc c01a9774 f0136000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01a9774>] flush_to_ldisc+0x0/0xc8
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/3      S F01D7120    37      1            38    36 (L-TLB)
f0135f9c 00000046 00000282 f01d7120 f0134000 f0139350 00000082 f01d7140 
       00000003 00000001 00000000 ef065820 f0139350 ef47a000 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7120 f01d7134 f01d712c c01a9774 f0134000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01a9774>] flush_to_ldisc+0x0/0xc8
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/4      S F01D7180    38      1            39    37 (L-TLB)
f0133f9c 00000046 00000282 f01d7180 f0132000 f0138d20 00000086 f01d71a0 
       00000003 00000001 00000000 e51bbb60 f0138d20 e4955eb8 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7180 f01d7194 f01d718c c0129890 f0132000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0129890>] __call_usermodehelper+0x0/0x50
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/5      S F01D71F4    39      1            40    38 (L-TLB)
f0131f9c 00000046 f0130000 f01d71f4 f0130000 f01386f0 f0131ff0 00000005 
       f01386f0 f017c184 00010000 c02e33e0 f01386f0 00000005 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d71e0 f01d71f4 f01d71ec c3b9b900 f0130000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/6      S F01D7254    40      1            41    39 (L-TLB)
f012ff9c 00000046 f012e000 f01d7254 f012e000 f01380c0 f012fff0 00000006 
       f01380c0 f017bbe4 00010000 c02e33e0 f01380c0 00000006 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7240 f01d7254 f01d724c c3b9b900 f012e000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/7      S F01D72B4    41      1            42    40 (L-TLB)
f012bf9c 00000046 f012a000 f01d72b4 f012a000 f012d9a0 f012bff0 00000007 
       f012d9a0 f017b6c4 00010000 c02e33e0 f012d9a0 00000007 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d72a0 f01d72b4 f01d72ac c3b9b900 f012a000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

events/8      S F01D7300    42      1            43    41 (L-TLB)
f0129f9c 00000046 00000282 f01d7300 f0128000 f012d370 00000082 f01d7320 
       00000003 00000001 00000000 e6174dc0 f012d370 e56e9eb8 c0129ce6 c0129bac 
       00000000 00000000 00000000 f01d7300 f01d7314 f01d730c c0129890 f0128000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] work0 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01caa58>] as_work_handler+0x0/0x48
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/3     S F00CE120    53      1            54    52 (L-TLB)
ef767f9c 00000046 00000282 f00ce120 ef766000 ef76ccc0 00000082 00000003 
       00000060 00000001 00000000 e51bbb60 ef76ccc0 ef629600 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce120 f00ce134 f00ce12c c01caa58 ef766000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01caa58>] as_work_handler+0x0/0x48
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/4     S F00CE180    54      1            55    53 (L-TLB)
ef765f9c 00000046 00000282 f00ce180 ef764000 ef76c690 00000086 00000004 
       00000080 00000001 00000000 e51bbb60 ef76c690 ef629600 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce180 f00ce194 f00ce18c c01c3c00 ef764000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/5     S F00CE1E0    55      1            56    54 (L-TLB)
ef763f9c 00000046 00000282 f00ce1e0 ef762000 ef76c060 00000086 f00ce200 
       00000003 00000001 00000000 ef093800 ef76c060 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce1e0 f00ce1f4 f00ce1ec c01c3c00 ef762000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/6     S F00CE240    56      1            57    55 (L-TLB)
ef75ff9c 00000046 00000282 f00ce240 ef75e000 ef761940 00000086 00000006 
       000000c0 00000001 00000000 e48081c0 ef761940 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce240 f00ce254 f00ce24c c01c3c00 ef75e000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/7     S F00CE2A0    57      1            58    56 (L-TLB)
ef75df9c 00000046 00000282 f00ce2a0 ef75c000 ef761310 00000086 f00ce2c0 
       00000003 00000001 00000000 e6711de0 ef761310 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce2a0 f00ce2b4 f00ce2ac c01c3c00 ef75c000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/8     S F00CE300    58      1            59    57 (L-TLB)
ef75bf9c 00000046 00000282 f00ce300 ef75a000 ef760ce0 00000082 00000008 
       00000100 00000001 00000000 e6c617c0 ef760ce0 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce300 f00ce314 f00ce30c c01c3c00 ef75a000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/9     S F00CE360    59      1            60    58 (L-TLB)
ef759f9c 00000046 00000282 f00ce360 ef758000 ef7606b0 00000082 f00ce380 
       00000003 00000001 00000000 e7fdb4e0 ef7606b0 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce360 f00ce374 f00ce36c c01c3c00 ef758000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/10    S F00CE3C0    60      1            61    59 (L-TLB)
ef757f9c 00000046 00000282 f00ce3c0 ef756000 ef760080 00000082 0000000a 
       00000140 00000001 00000000 e7469940 ef760080 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce3c0 f00ce3d4 f00ce3cc c01c3c00 ef756000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/11    S F00CE420    61      1            62    60 (L-TLB)
ef753f9c 00000046 00000282 f00ce420 ef752000 ef755960 00000082 0000000b 
       00000003 00000001 00000000 ea0be560 ef755960 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce420 f00ce434 f00ce42c c01c3c00 ef752000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/12    S F00CE480    62      1            63    61 (L-TLB)
ef751f9c 00000046 00000282 f00ce480 ef750000 ef755330 00000086 f00ce4a0 
       00000003 00000001 00000000 e51a6540 ef755330 ef628e00 c0129ce6 c0129bac 
       00000000 00000000 00000000 f00ce480 f00ce494 f00ce48c c01c3c00 ef750000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c01c3c00>] blk_unplug_work+0x0/0x14
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kblockd/13    S F00CE4E0    63      1            64    62 (L-TLB)
ef74ff9c 00000f675f48 f0202550 ef6779a0 ef6779a0 00000000 
       00000001 ef675f10 ef675f10 c02e33e0 ef6779a0 f0200000 c013b8d3 c013b7cc 
       00000000 00000000 00000000 ef674000 ef675fdc ef674000 00000000 00000000 
Call Trace:
 [<c013b8d3>] kswapd+0x107/0x124
 [<c013b7cc>] kswapd+0x0/0x124
 [<c0108cee>] work_resched+0x5/0x16
 [<c013b7cc>] kswapd+0x0/0x124
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd2       S EF679F48    70      1            69    71 (L-TLB)
ef679f20 00000046 ef679fdc ef679f48 f2c02550 ef6820c0 ef6820c0 00000000 
       00000001 ef679f10 ef679f10 c02e33e0 ef6820c0 f2c00000 c013b8d3 c013b7cc 
       00000000 00000000 00000000 ef678000 ef679fdc ef678000 00000000 00000000 
Call Trace:
 [<c013b8d3>] kswapd+0x107/0x124
 [<c013b7cc>] kswapd+0x0/0x124
 [<c0108cee>] work_resched+0x5/0x16
 [<c013b7cc>] kswapd+0x0/0x124
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd1       S EF67BF48    69      1            68    70 (L-TLB)
ef67bf20 00000046 ef67bfdc ef67bf48 f5602550 ef6826f0 ef6826f0 00000000 
       00000001 ef67bf10 ef67bf10 c02e33e0 ef6826f0 f5600000 c013b8d3 c013b7cc 
       00000000 00000000 00000000 ef67a000 ef67bfdc ef67a000 00000000 00000000 
Call Trace:
 [<c013b8d3>] kswapd+0x107/0x124
 [<c013b7cc>] kswapd+0x0/0x124
 [<c0108cee>] work_resched+0x5/0x16
 [<c013b7cc>] kswapd+0x0/0x124
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kswapd0       S EF67DF48    68      1            72    69 (L-TLB)
ef67df20 00000046 ef67dfdc ef67df48 c03a9550 ef682d20 00000001 ef67df44 
       0000000a 00000000 c013b8eb e51bbb60 ef682d20 c03a7000 c013b8d3 c013b7cc 
       00000000 00000000 00000000 ef67c000 ef67dfdc ef67c000 000000af 0000179a 
Call Trace:
 [<c013b8eb>] kswapd+0x11f/0x124
 [<c013b8d3>] kswapd+0x107/0x124
 [<c013b7cc>] kswapd+0x0/0x124
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/0         S EF64B014    72      1            73    68 (L-TLB)
ef623f9c 00000046 ef622000 ef64b014 ef622000 ef677370 ef623ff0 00000000 
       ef677370 f00c9184 00010000 c02e33e0 ef677370 00000000 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b000 ef64b014 ef64b00c c0108cee ef622000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0108cee>] work_resched+0x5/0x16
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/1         S EF64B074    73      1            74    72 (L-TLB)
ef621f9c 00000046 ef620000 ef64b074 ef620000 ef676d40 ef621ff0 00000001 
       ef676d40 ef64abe4 00010000 c02e33e0 ef676d40 00000001 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b060 ef64b074 ef64b06c c3b9b900 ef620000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/2         S EF64B0D4    74      1            75    73 (L-TLB)
ef61ff9c 00000046 ef61e000 ef64b0d4 ef61e000 ef676710 ef61fff0 00000002 
       ef676710 ef64a6c4 00010000 c02e33e0 ef676710 00000002 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b0c0 ef64b0d4 ef64b0cc c3b9b900 ef61e000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/3         S EF64B134    75      1            76    74 (L-TLB)
ef61df9c 00000046 ef61c000 ef64b134 ef61c000 ef6760e0 ef61dff0 00000003 
       ef6760e0 ef64a1a4 00010000 c02e33e0 ef6760e0 00000003 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b120 ef64b134 ef64b12c c3b9b900 ef61c000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/4         S EF64B194    76      1            77    75 (L-TLB)
ef619f9c 00000046 ef618000 ef64b194 ef618000 ef61b900 ef619ff0 00000004 
       ef61b900 ef649c04 00010000 c02e33e0 ef61b900 00000004 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b180 ef64b194 ef64b18c c3b9b900 ef618000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/5         S EF64B1F4    77      1            78    76 (L-TLB)
ef617f9c 00000046 ef616000 ef64b1f4 ef616000 ef61b2d0 ef617ff0 00000005 
       ef61b2d0 ef6496e4 00010000 c02e33e0 ef61b2d0 00000005 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b1e0 ef64b1f4 ef64b1ec c3b9b900 ef616000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/6         S EF64B254    78      1            79    77 (L-TLB)
ef615f9c 00000046 ef614000 ef64b254 ef614000 ef61aca0 ef615ff0 00000006 
       ef61aca0 ef6491c4 00010000 c02e33e0 ef61aca0 00000006 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b240 ef64b254 ef64b24c c3b9b900 ef614000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/7         S EF64B2B4    79      1            80    78 (L-TLB)
ef613f9c 00000046 ef612000 ef64b2b4 ef612000 ef61a670 ef613ff0 00000007 
       ef61a670 ef648bc4 00010000 c02e33e0 ef61a670 00000007 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b2a0 ef64b2b4 ef64b2ac c3b9b900 ef612000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/8         S EF64B314    80      1            81    79 (L-TLB)
ef611f9c 00000046 ef610000 ef64b314 ef610000 ef61a040 ef611ff0 00000008 
       ef61a040 ef6486a4 00010000 c02e33e0 ef61a040 00000008 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b300 ef64b314 ef64b30c c3b9b900 ef610000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/9         S EF64B374    81      1            82    80 (L-TLB)
ef60df9c 00000046 ef60c000 ef64b374 ef60c000 ef60f920 ef60dff0 00000009 
       ef60f920 ef648184 00010000 c02e33e0 ef60f920 00000009 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b360 ef64b374 ef64b36c c3b9b900 ef60c000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/10        S EF64B3D4    82      1            83    81 (L-TLB)
ef60bf9c 00000046 ef60a000 ef64b3d4 ef60a000 ef60f2f0 ef60bff0 0000000a 
       ef60f2f0 ef647be4 00010000 c02e33e0 ef60f2f0 0000000a c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b3c0 ef64b3d4 ef64b3cc c3b9b900 ef60a000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/11        S EF64B434    83      1            84    82 (L-TLB)
ef609f9c 00000046 ef608000 ef64b434 ef608000 ef60ecc0 ef609ff0 0000000b 
       ef60ecc0 ef6476c4 00010000 c02e33e0 ef60ecc0 0000000b c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b420 ef64b434 ef64b42c c3b9b900 ef608000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/12        S EF64B494    84      1            85    83 (L-TLB)
ef607f9c 00000046 ef606000 ef64b494 ef606000 ef60e690 ef607ff0 0000000c 
       ef60e690 ef6471a4 00010000 c02e33e0 ef60e690 0000000c c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b480 ef64b494 ef64b48c c3b9b900 ef606000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/13        S EF64B4F4    85      1            86    84 (L-TLB)
ef605f9c 00000046 ef604000 ef64b4f4 ef604000 ef60e060 ef605ff0 0000000d 
       ef60e060 ef646c04 00010000 c02e33e0 ef60e060 0000000d c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b4e0 ef64b4f4 ef64b4ec c3b9b900 ef604000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/14        S EF64B554    86      1            87    85 (L-TLB)
ef601f9c 00000046 ef600000 ef64b554 ef600000 ef603940 ef601ff0 0000000e 
       ef603940 ef6466e4 00010000 c02e33e0 ef603940 0000000e c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b540 ef64b554 ef64b54c c3b9b900 ef600000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio/15        S EF64B5B4    87      1            88    86 (L-TLB)
ef5fff9c 00000046 ef5fe000 ef64b5b4 ef5fe000 ef603310 ef5ffff0 0000000f 
       ef603310 ef6461c4 00010000 c02e33e0 ef603310 0000000f c0129ce6 c0129bac 
       00000000 00000000 00000000 ef64b5a0 ef64b5b4 ef64b5ac c3b9b900 ef5fe000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/0    S EF645014    88      1            89    87 (L-TLB)
ef5fdf9c 00000046 ef5fc000 ef645014 ef5fc000 ef602ce0 ef5fdff0 00000000 
       ef602ce0 ef644bc4 00010000 c02e33e0 ef602ce0 00000000 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645000 ef645014 ef64500c c3b9b900 ef5fc000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/1    S EF645074    89      1            90    88 (L-TLB)
ef5fbf9c 00000046 ef5fa000 ef645074 ef5fa000 ef6026b0 ef5fbff0 00000001 
       ef6026b0 ef6446a4 00010000 c02e33e0 ef6026b0 00000001 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645060 ef645074 ef64506c c3b9b900 ef5fa000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/2    S EF6450D4    90      1            91    89 (L-TLB)
ef5f9f9c 00000046 ef5f8000 ef6450d4 ef5f8000 ef602080 ef5f9ff0 00000002 
       ef602080 ef644184 00010000 c02e33e0 ef602080 00000002 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef6450c0 ef6450d4 ef6450cc c3b9b900 ef5f8000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/3    S EF645134    91      1            92    90 (L-TLB)
ef5f5f9c 00000046 ef5f4000 ef645134 ef5f4000 ef5f7960 ef5f5ff0 00000003 
       ef5f7960 ef643be4 00010000 c02e33e0 ef5f7960 00000003 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645120 ef645134 ef64512c c3b9b900 ef5f4000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/4    S EF645194    92      1            93    91 (L-TLB)
ef5e3f9c 00000046 ef5e2000 ef645194 ef5e2000 ef5f7330 ef5e3ff0 00000004 
       ef5f7330 ef6436c4 00010000 c02e33e0 ef5f7330 00000004 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645180 ef645194 ef64518c c3b9b900 ef5e2000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/5    S EF6451F4    93      1            94    92 (L-TLB)
ef5e1f9c 00000046 ef5e0000 ef6451f4 ef5e0000 ef5f6d00 ef5e1ff0 00000005 
       ef5f6d00 ef6431a4 00010000 c02e33e0 ef5f6d00 00000005 c0129ce6 c012ef5f60a0 00000007 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef6452a0 ef6452b4 ef6452ac c3b9b900 ef5dc000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/8    S EF645314    96      1            97    95 (L-TLB)
ef5d9f9c 00000046 ef5d8000 ef645314 ef5d8000 ef5db980 ef5d9ff0 00000008 
       ef5db980 ef6421c4 00010000 c02e33e0 ef5db980 00000008 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645300 ef645314 ef64530c c3b9b900 ef5d8000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/9    S EF645374    97      1            98    96 (L-TLB)
ef5d7f9c 00000046 ef5d6000 ef645374 ef5d6000 ef5db350 ef5d7ff0 00000009 
       ef5db350 ef641bc4 00010000 c02e33e0 ef5db350 00000009 c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645360 ef645374 ef64536c c3b9b900 ef5d6000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/10   S EF6453D4    98      1            99    97 (L-TLB)
ef5d5f9c 00000046 ef5d4000 ef6453d4 ef50118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/14   S EF645554   102      1           103   101 (L-TLB)
ef5cbf9c 00000046 ef5ca000 ef645554 ef5ca000 ef5cf370 ef5cbff0 0000000e 
       ef5cf370 ef6401a4 00010000 c02e33e0 ef5cf370 0000000e c0129ce6 c0129bac 
       00000000 00000000 00000000 ef645540 ef645554 ef64554c c3b9b900 ef5ca000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

aio_fput/15   S EF6455B4   103      1           104   102 (L-TLB)
ef5c9f9c 00000046 ef5c8000 ef6455b4 ef5c8000 ef5ced40 ef5c9ff0 0000000f 
       ef5ced40 ef63fc04 00010000 c02e33e0 ef5ced40 0000000f c0129ce6 c0129bac 
       00000000 00000000 00000000 ef6455a0 ef6455b4 ef6455ac c3b9b900 ef5c8000 
Call Trace:
 [<c0129ce6>] worker_thread+0x13a/0x280
 [<c0129bac>] worker_thread+0x0/0x280
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_0     S EF57FFA0   104      1           105   103 (L-TLB)
ef57ff78 00000046 ef57ffdc ef57ffa0 00000286 ef5ce710 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef5ce710 ef5ce710 c0107c82 c3b9c000 
       ef57e000 ef57ffdc ef57ffdc 00000000 00000001 ef5ce710 c0118f38 ef57ffe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_1     S EF57DFA0   105      1           106   104 (L-TLB)
ef57df78 00000046 ef57dfdc ef57dfa0 00000286 ef5ce0e0 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef5ce0e0 ef5ce0e0 c0107c82 ef574000 
       ef57c000 ef57dfdc ef57dfdc 00000000 00000001 ef5ce0e0 c0118f38 ef57dfe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_2     S EF569FA0   106      1           107   105 (L-TLB)
ef569f78 00000046 ef569fdc ef569fa0 00000286 ef56b900 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef56b900 ef56b900 c0107c82 ef56c000 
       ef568000 ef569fdc ef569fdc 00000000 00000001 ef56b900 c0118f38 ef569fe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_3     S EF55FFA0   107      1           108   106 (L-TLB)
ef55ff78 00000046 ef55ffdc ef55ffa0 00000286 ef56b2d0 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef56b2d0 ef56b2d0 c0107c82 ef560000 
       ef55e000 ef55ffdc ef55ffdc 00000000 00000001 ef56b2d0 c0118f38 ef55ffe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_4     S EF55DFA0   108      1           109   107 (L-TLB)
ef55df78 00000046 ef55dfdc ef55dfa0 00000286 ef56aca0 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef56aca0 ef56aca0 c0107c82 ef554000 
       ef55c000 ef55dfdc ef55dfdc 00000000 00000001 ef56aca0 c0118f38 ef55dfe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

isp_thrd4     S EF553EF0   109      1           110   108 (L-TLB)
ef553ec8 00000046 ef553fdc ef553ef0 00000286 ef56a670 00000006 00000113 
       00000000 00210813 00004000 c02e33e0 ef56a670 ef56a670 c0107c82 00000000 
       ef553fdc ef553ff0 ef5541bc 00000000 00000001 ef56a670 c0118f38 ef553fe8 
Call Trace:
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01ddcbf>] .text.lock.isp_linux+0x277/0x308
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0108bda>] ret_from_fork+0x6/0x14
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_5     S EF52DFA0   110      1           111   109 (L-TLB)
ef52df78 00000046 ef52dfdc ef52dfa0 00000286 ef56a040 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 ef56a040 ef56a040 c0107c82 ef528000 
       ef52c000 ef52dfdc ef52dfdc 00000000 00000001 ef56a040 c0118f38 ef52dfe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

isp_thrd5     S F01A5EF0   111      1           112   110 (L-TLB)
f01a5ec8 00000046 f01a5fdc f01a5ef0 00000286 f01a7920 00000092 00000202 
       ef5b0320 00000001 f01a5ecc c02e33e0 f01a7920 f01a7920 c0107c82 00000000 
       00000000 f01a5ff0 ef5281bc 00000000 00000001 f01a7920 c0118f38 f01a5fe8 
Call Trace:
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01ddcbf>] .text.lock.isp_linux+0x277/0x308
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0108bda>] ret_from_fork+0x6/0x14
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_6     S EF523FA0   112      1           113   111 (L-TLB)
ef523f78 00000046 ef523fdc ef523fa0 00000286 f01a72f0 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 f01a72f0 f01a72f0 c0107c82 ef524000 
       ef522000 ef523fdc ef523fdc 00000000 00000001 f01a72f0 c0118f38 ef523fe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

isp_thrd6     S EF521EF0   113      1           114   112 (L-TLB)
ef521ec8 00000046 ef521fdc ef521ef0 00000286 f01a6cc0 00000092 00000202 
       ef5b0320 00000003 ef521ecc c02e33e0 f01a6cc0 f01a6cc0 c0107c82 00000000 
       00000000 ef521ff0 ef5241bc 00000000 00000001 f01a6cc0 c0118f38 ef521fe8 
Call Trace:
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01ddcbf>] .text.lock.isp_linux+0x277/0x308
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0108cee>] work_resched+0x5/0x16
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

scsi_eh_7     S EF4F7FA0   114      1           115   113 (L-TLB)
ef4f7f78 00000046 ef4f7fdc ef4f7fa0 00000286 f01a6690 c0118f51 c3b9b900 
       00000003 00000000 00000000 c02e33e0 f01a6690 f01a6690 c0107c82 ef4f8000 
       ef4f6000 ef4f7fdc ef4f7fdc 00000000 00000001 f01a6690 c0118f38 ef4f7fe8 
Call Trace:
 [<c0118f51>] default_wake_function+0x19/0x20
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01d2bc5>] .text.lock.scsi_error+0xb1/0xbc
 [<c01d280c>] scsi_error_handler+0x0/0x128
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

isp_thrd7     S EF4F5EF0   115      1           188   114 (L-TLB)
ef4f5ec8 00000046 ef4f5fdc ef4f5ef0 00000286 f01a6060 00000092 00000202 
       ef5b0320 00000002 ef4f5ecc c02e33e0 f01a6060 f01a6060 c0107c82 00000000 
       00000000 ef4f5ff0 ef4f81bc 00000000 00000001 f01a6060 c0118f38 ef4f5fe8 
Call Trace:
 [<c0107c82>] __down_interruptible+0x9a/0x134
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0107d73>] __down_failed_interruptible+0x7/0xc
 [<c01ddcbf>] .text.lock.isp_linux+0x277/0x308
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0108cee>] work_resched+0x5/0x16
 [<c01dd0ac>] isp_task_thread+0x0/0x8d8
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

kjournald     S 00000001   188      1           215   115 (L-TLB)
ef21bf88 00000046 ef15cc00 00000001 ef15cc6c ef0fe6d0 00000246 ef15cc54 
       00000003 00000001 00000000 ef46c0c0 ef0fe6d0 00000000 c018f0bb c018ef10 
       00000000 00000000 00000000 ef15cc54 ef21bfbc 00000000 ef0fe6d0 c011ab54 
Call Trace:
 [<c018f0bb>] kjournald+0x1ab/0x220
 [<c018ef10>] kjournald+0x0/0x220
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c018ef00>] commit_timeout+0x0/0xc
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

portmap       S EF155F64   215      1           279   188 (NOTLB)
ef155f1c 00000082 7fffffff ef155f64 ef155f68 ef0fe0a0 00000145 00000000 
       ef0acba0 c01fd479 ef0acb20 ef46c540 ef0fe0a0 7fffffff c0123af8 00000000 
       ef155f64 ef210be0 ef155f64 ef155f68 7fffffff c015c98f 00000002 ef210be8 
Call Trace:
 [<c01fd479>] sock_poll+0x1d/0x24
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c015c98f>] do_poll+0x67/0xc8
 [<c015c9d1>] do_poll+0xa9/0xc8
 [<c015cb72>] sys_poll+0x182/0x240
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c0108cc7>] syscall_call+0x7/0xb

syslogd       D EEBF3B90   279      1           282   215 (NOTLB)
eebf3b54 00000082 c396abc0 eebf3b90 eebf3ba4 eeafcd40 ef537660 00000008 
       ef628e00 eebf3b54 00000000 ef46c840 eeafcd40 eebf3b60 c0119e1c eebf3b90 
       de86f758 c014c985 de86f758 00000002 00000000 ef48b000 c038e280 00000000 
Call Trace:
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c014c985>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c014da4a>] __bread_slow_wq+0x8a/0xc0
 [<c014dcc3>] __bread_wq+0x2f/0x38
 [<c0193ca0>] ext2_get_branch_wq+0x80/0x148
 [<c019405b>] ext2_get_block_wq+0x57/0x33c
 [<c01314e5>] find_get_page+0x1d/0x30
 [<c019436f>] ext2_get_block_async+0x2f/0x34
 [<c014e47f>] __block_prepare_write+0x157/0x41c
 [<c014eef5>] block_prepare_write+0x21/0x38
 [<c0194340>] ext2_get_block_async+0x0/0x34
 [<c01943fd>] ext2_prepare_write+0x19/0x20
 [<c0194340>] ext2_get_block_async+0x0/0x34
 [<c01331db>] generic_file_aio_write_nolock+0x6b7/0xa68
 [<c0133626>] generic_file_write_nolock+0x9a/0xb8
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01fcb6d>] sockfd_lookup+0x11/0x68
 [<c01fdf6d>] sys_recvfrom+0xad/0x104
 [<c01fdfb3>] sys_recvfrom+0xf3/0x104
 [<c0134a5f>] free_hot_page+0x7/0x8
 [<c0134f4a>] __free_pages+0x2e/0x40
 [<c0134faa>] free_pages+0x4e/0x50
 [<c015bfea>] poll_freewait+0x3e/0x48
 [<c01338c1>] generic_file_writev+0x35/0xa8
 [<c014bd4b>] do_readv_writev+0x1ab/0x254
 [<c0133710>] generic_file_write+0x0/0xc0
 [<c01fe724>] sys_socketcall+0x194/0x240
 [<c014be87>] vfs_writev+0x4b/0x50
 [<c014bf09>] sys_writev+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

klogd         S EF171DFC   282      1           291   279 (NOTLB)
ef171da4 00000082 7fffffff ef171dfc ef171e10 ef01b900 00000000 00000001 
       ef48e3dc ef171da4 00000246 eeae0c40 ef01b900 ef23ec40 c0123af8 ef171dfc 
       ef171dfc ffffffe0 0000003e 00000000 c01ff74e 00000202 ef171dfc ef171dfc 
Call Trace:
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01ff74e>] sock_alloc_send_pskb+0x72/0x22c
 [<c0245150>] unix_wait_for_peer+0x94/0xb4
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0245baa>] unix_dgram_sendmsg+0x38a/0x498
 [<c0131eb5>] __generic_file_aio_read+0x1f9/0x220
 [<c01fcfe3>] sock_aio_write+0xcb/0xd4
 [<c014b908>] do_sync_write+0xac/0xe0
 [<c0118e76>] schedule+0x412/0x4d4
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0118656>] rebalance_tick+0xca/0xe0
 [<c011c957>] do_syslog+0x127/0x380
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0176f95>] kmsg_read+0x11/0x18
 [<c014b9ed>] vfs_write+0xb1/0xd0
 [<c014ba89>] sys_write+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

inetd         S 00000000   291      1           295   282 (NOTLB)
eebb7ec4 00000086 7fffffff 00000000 000003f0 ef20a080 ef10eb80 00000145 
       ef10ed1c eebb7f68 c0217ed5 ef4754c0 ef20a080 eebb7f68 c0123af8 eeab78c0 
       00000000 ef485c20 c01fd479 eeab78c0 eeb4b8e0 eebb7f5c eeab78c0 c015c2e4 
Call Trace:
 [<c0217ed5>] tcp_poll+0x2d/0x154
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01fd479>] sock_poll+0x1d/0x24
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c0108cc7>] syscall_call+0x7/0xb

lpd           S 00000000   295      1           309   291 (NOTLB)
eea01ec4 00000086 7fffffff 00000000 00000060 ef44b350 ef08eba0 00000145 
       ef08ed3c eea01f68 c0217ed5 ef093e00 ef44b350 eea01f68 c0123af8 ef14f140 
       00000000 ef14fcc0 c01fd479 ef14f140 ef06caa0 eea01f5c ef14f140 c015c2e4 
Call Trace:
 [<c0217ed5>] tcp_poll+0x2d/0x154
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01fd479>] sock_poll+0x1d/0x24
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c01fe66b>] sys_socketcall+0xdb/0x240
 [<c0108cc7>] syscall_call+0x7/0xb

sshd          S 00000104   309      1   333     312   295 (NOTLB)
eea33ec4 00000082 7fffffff 00000104 00000028 eeafc710 ef10e800 00000145 
       ef10e99c 00000246 e57b3000 eeae0340 eeafc710 eea33f68 c0123af8 edfb35a0 
       00000104 c0156e55 edfb35a0 eeac7b20 eea33f5c edfb35a0 00000145 c015c2e4 
Call Trace:
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c0156e55>] pipe_poll+0x25/0x64
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c0108cc7>] syscall_call+0x7/0xb

rpc.statd     S 00000000   312      1           317   309 (NOTLB)
eeac5ec4 00000086 7fffffff 00000000 00000038 eeafc0e0 ef10e480 00000145 
       ef10e61c eeac5f68 c0217ed5 eeae04c0 eeafc0e0 eeac5f68 c0123af8 ef0ac9a0 
       00000000 ef14f9c0 c01fd479 ef0ac9a0 eeb4b260 eeac5f5c ef0ac9a0 c015c2e4 
Call Trace:
 [<c0217ed5>] tcp_poll+0x2d/0x154
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01fd479>] sock_poll+0x1d/0x24
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c014c53c>] fput+0x14/0x18
 [<c0108cc7>] syscall_call+0x7/0xb

wu-ftpd       S EE968000   317      1           320   312 (NOTLB)
ee969e30 00000082 7fffffff ee968000 ef10e128 ee957920 c03a8800 00000000 
       c03a94c8 c0134c0a c03a8800 eeae0640 ee957920 7fffffff c0123af8 ef10e100 
       ee968000 00000000 00000000 c03a8800 00000246 00000202 ef10e100 00000247 
Call Trace:
 [<c0134c0a>] __alloc_pages+0x82/0x2b4
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c021c7b4>] wait_for_connect+0xdc/0x170
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c021c8d4>] tcp_accept+0x8c/0x1b0
 [<c023869b>] inet_accept+0x2f/0x140
 [<c01fdb8e>] sys_accept+0x6e/0xfc
 [<c0116390>] do_page_fault+0x0/0x478
 [<c02183d8>] tcp_listen_start+0x190/0x1e8
 [<c0237d63>] inet_listen+0xdf/0xe8
 [<c01fdb15>] sys_listen+0x4d/0x58
 [<c01fe67f>] sys_socketcall+0xef/0x240
 [<c0109731>] error_code+0x2d/0x38
 [<c0108cc7>] syscall_call+0x7/0xb

atd           S 00057E41   320      1           323   317 (NOTLB)
ef433f10 00000082 ef433f74 00057e41 00000000 ee9572f0 00000246 c39335a0 
       c01230ed c39335a0 00000246 eeae0040 ee9572f0 ef433f44 c012cc36 ef433f74 
       00000000 bffffb78 00000000 ef432000 ef432000 ef432000 ef43201c 00000000 
Call Trace:
 [<c01230ed>] add_timer+0x5d/0x6c
 [<c012cc36>] do_clock_nanosleep+0x17a/0x2f0
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c012c8b8>] nanosleep_wake_up+0x0/0xc
 [<c012c95e>] sys_nanosleep+0x86/0xe4
 [<c0108cc7>] syscall_call+0x7/0xb

cron          S 00001771   323      1  5930     326   320 (NOTLB)
ef243f10 00000082 ef243f74 00001771 00000000 ee956cc0 00000246 c394b5a0 
       c01230ed c394b5a0 00000246 ef065820 ee956cc0 ef243f44 c012cc36 ef243f74 
       00000000 bffffbb8 00000000 ef242000 ef242000 ef242000 ef24201c 00000000 
Call Trace:
 [<c01230ed>] add_timer+0x5d/0x6c
 [<c012cc36>] do_clock_nanosleep+0x17a/0x2f0
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c012c8b8>] nanosleep_wake_up+0x0/0xc
 [<c012c95e>] sys_nanosleep+0x86/0xe4
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   326      1           327   323 (NOTLB)
ef229eac 00000086 7fffffff 00000001 ef229f54 ef20b940 0000000d 0000000e 
       00000000 00000000 c0391820 ef270960 ef20b940 ef110000 c0123af8 00000008 
       00000001 ef110000 00000008 c01b8d97 c01b8c4f ef110000 00000246 ef110938 
Call Trace:
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   327      1           328   326 (NOTLB)
eebadeac 00000082 7fffffff 00000001 eebadf54 ef20b310 00000020 00000000 
       c01b867c eea20000 eebadf2c ef2707e0 ef20b310 eea20000 c0123af8 00000008 
       00000001 eea20000 00000008 c01b8d97 c01b8c4f eea20000 00000246 eea20938 
Call Trace:
 [<c01b867c>] do_con_write+0x62c/0x690
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   328      1           329   327 (NOTLB)
eebb3eac 00000086 7fffffff 00000001 eebb3f54 eeafd9a0 00000020 00000020 
       c01b867c eebfe000 eebb3f2c ef093200 eeafd9a0 eebfe000 c0123af8 00000008 
       00000001 eebfe000 00000008 c01b8d97 c01b8c4f eebfe000 00000246 eebfe938 
Call Trace:
 [<c01b867c>] do_con_write+0x62c/0x690
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   329      1           330   328 (NOTLB)
eea47eac 00000086 7fffffff 00000001 eea47f54 ee956690 00000020 00000020 
       c01b867c ee9d1000 eea47f2c eeae0dc0 ee956690 ee9d1000 c0123af8 00000008 
       00000001 ee9d1000 00000008 c01b8d97 c01b8c4f ee9d1000 00000246 ee9d1938 
Call Trace:
 [<c01b867c>] do_con_write+0x62c/0x690
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   330      1           331   329 (NOTLB)
ee9f1eac 00000082 7fffffff 00000001 ee9f1f54 ee956060 00000020 00000020 
       c01b867c eea30000 ee9f1f2c ef46c240 ee956060 eea30000 c0123af8 00000008 
       00000001 eea30000 00000008 c01b8d97 c01b8c4f eea30000 00000246 eea30938 
Call Trace:
 [<c01b867c>] do_con_write+0x62c/0x690
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

getty         S 00000001   331      1           332   330 (NOTLB)
ee9c7eac 00000086 7fffffff 00000001 ee9c7f54 ef44b980 00000020 00000020 
       c01b867c ef07e000 ee9c7f2c ef46c3c0 ef44b980 ef07e000 c0123af8 00000008 
       00000001 ef07e000 00000008 c01b8d97 c01b8c4f ef07e000 00000246 ef07e938 
Call Trace:
 [<c01b867c>] do_con_write+0x62c/0x690
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01b8d97>] con_flush_chars+0x33/0x34
 [<c01b8c4f>] con_write+0x23/0x2c
 [<c01ac477>] read_chan+0x3b7/0x884
 [<c01ac4c8>] read_chan+0x408/0x884
 [<c01acb44>] write_chan+0x200/0x220
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c01a766c>] tty_read+0xd8/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

bash          S EE9B59DC   332      1  6017   26402   331 (NOTLB)
ef123f70 00000082 fffffe00 ee9b59dc eeafd370 ee9b5940 c011d8ea 00001781 
       ef122000 c01a8ff7 00001781 ef093380 ee9b5940 ee9b5940 c011f028 ffffffff 
       00000000 ffffffff ef122000 00000000 ee9b59dc ef122000 00000001 00000000 
Call Trace:
 [<c011d8ea>] session_of_pgrp+0x26/0x84
 [<c01a8ff7>] tiocspgrp+0x6f/0x94
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

sshd          S 00000104   333    309   335    6016       (NOTLB)
eebcbec4 00000082 7fffffff 00000104 00000098 ef01a040 00000246 ef0cd000 
       c01adb69 ef0cc000 00000000 ef475340 ef01a040 eebcbf68 c0123af8 ef0ac5a0 
       00000104 c01a8a60 ef0cd000 ef0ac5a0 eebcbf5c ef0ac5a0 00000145 c015c2e4 
Call Trace:
 [<c01adb69>] pty_chars_in_buffer+0x1d/0x44
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c01a8a60>] tty_poll+0x84/0x90
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c0108cc7>] syscall_call+0x7/0xb

bash          S EF01A70C   335    333  6014               (NOTLB)
ee8d5f70 00000086 fffffe00 ef01a70c e4a3e670 ef01a670 c011d8ea 0000177e 
       ee8d4000 c01a8ff7 0000177e ef46c0c0 ef01a670 ef01a670 c011f028 ffffffff 
       00000000 ffffffff ee8d4000 00000000 ef01a70c ee8d4000 00000001 00000000 
Call Trace:
 [<c011d8ea>] session_of_pgrp+0x26/0x84
 [<c01a8ff7>] tiocspgrp+0x6f/0x94
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

pdflush       S E592BFE4 26402      1          4527   332 (L-TLB)
e592bfb8 00000046 e592bfd8 e592bfe4 e592a000 e60e60c0 00000000 00000400 
       00000001 00000000 00000000 ef46c9c0 e60e60c0 00000001 c0136661 c0136774 
       00000000 00000000 00000000 c013677f e592bfd8 e60e60c0 00000000 000014f2 
Call Trace:
 [<c0136661>] __pdflush+0x91/0x1a4
 [<c0136774>] pdflush+0x0/0x14
 [<c013677f>] pdflush+0xb/0x14
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

pdflush       D 00000000  4527      1               26402 (L-TLB)
e6451bbc 00000046 c399abc0 00000000 e6451bf4 e7392ca0 00000000 00000000 
       00000000 00000000 00000000 e6870360 e7392ca0 e6451bc8 c0119e1c ef74563c 
       ef745620 c0133f24 c3d1b724 ff84e000 e0dea000 c3d1bd24 00000000 e7392ca0 
Call Trace:
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c0133f24>] mempool_alloc+0x104/0x11c
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c013c34d>] __blk_queue_bounce+0xb1/0x234
 [<c013c50e>] blk_queue_bounce+0x3e/0x44
 [<c01c4880>] __make_request+0x54/0x470
 [<c01c4edb>] generic_make_request+0x23f/0x254
 [<c01502e9>] bio_add_page+0x5d/0x110
 [<c01c4f76>] submit_bio+0x86/0x94
 [<c0168afe>] mpage_bio_submit+0x22/0x28
 [<c01695c7>] mpage_writepage+0x427/0x664
 [<c014db37>] bh_lru_install+0xb7/0xd8
 [<c014db4c>] bh_lru_install+0xcc/0xd8
 [<c01395dc>] mark_page_accessed+0x1c/0x38
 [<c014dc20>] __find_get_block+0xc8/0xd0
 [<c014dc45>] __getblk+0x1d/0x38
 [<c01699e2>] mpage_writepages+0x1de/0x28b
 [<c0194374>] ext2_get_block+0x0/0x24
 [<c014d941>] mark_buffer_dirty+0x39/0x40
 [<c019538f>] ext2_update_inode+0x35b/0x36c
 [<c01944e8>] ext2_writepages+0x14/0x18
 [<c0194374>] ext2_get_block+0x0/0x24
 [<c0135fe4>] do_writepages+0x18/0x2c
 [<c016815c>] __sync_single_inode+0xb4/0x1ec
 [<c0168311>] __writeback_single_inode+0x7d/0x84
 [<c01684c1>] sync_sb_inodes+0x1a9/0x234
 [<c01685a4>] writeback_inodes+0x58/0x88
 [<c0135e15>] wb_kupdate+0xb5/0x10c
 [<c01366d9>] __pdflush+0x109/0x1a4
 [<c0136774>] pdflush+0x0/0x14
 [<c013677f>] pdflush+0xb/0x14
 [<c0135d60>] wb_kupdate+0x0/0x10c
 [<c0106fb1>] kernel_thread_helper+0x5/0xc

cron          S EF01E290  5930    323  5931               (NOTLB)
e698ff0c 00000086 ef01e220 ef01e290 e698ff4c e7392040 00000000 ef46ccc0 
       c01401b0 ef46ccc0 ebad7920 ef46ccc0 e7392040 e698ff38 c01568f0 ef452160 
       ebda9960 ef01e220 00000000 00000000 e7392040 c011ab54 e698ff44 e698ff44 
Call Trace:
 [<c01401b0>] vma_link+0x54/0x74
 [<c01568f0>] pipe_wait+0x70/0x94
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0156ab1>] pipe_read+0x19d/0x208
 [<c010f3d7>] old_mmap+0xfb/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

sh            S E739399C  5931   5930  5932               (NOTLB)
e5615f70 00000082 fffffe00 e739399c e7392670 e7393900 00000000 00000000 
       bffff900 e5615fac e5615f98 ef46cb40 e7393900 e7393900 c011f028 ffffffff 
       00000000 ffffffff e5614000 00000008 e739399c e5614000 00000001 00000000 
Call Trace:
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

run-parts     S 00000104  5932   5931  5958               (NOTLB)
e6d41ec4 00000082 7fffffff 00000104 00000028 e7392670 000000d0 ee97f640 
       c0134e88 00000246 e5488000 ef46ce40 e7392670 e6d41f68 c0123af8 ee97f740 
       00000104 c0156e55 ee97f740 ef452ba0 e6d41f5c ee97f740 00000145 c015c2e4 
Call Trace:
 [<c0134e88>] __get_free_pages+0x4c/0x54
 [<c0123af8>] schedule_timeout+0x14/0xac
 [<c0156e55>] pipe_poll+0x25/0x64
 [<c015c2e4>] do_select+0x1b0/0x2d8
 [<c015c3c9>] do_select+0x295/0x2d8
 [<c015bff4>] __pollwait+0x0/0x9c
 [<c015c76a>] sys_select+0x336/0x470
 [<c0108cc7>] syscall_call+0x7/0xb

find          S EF0FF9FC  5958   5932  5961               (NOTLB)
e55ddf70 00000086 fffffe00 ef0ff9fc ee9b46b0 ef0ff960 00000000 00000000 
       bffff850 e55ddfac e55ddf98 eeae07c0 ef0ff960 ef0ff960 c011f028 ffffffff 
       00000000 ffffffff e55dc000 00000008 ef0ff9fc e55dc000 00000001 00000000 
Call Trace:
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

updatedb      S EE9B474C  5961   5958  5969               (NOTLB)
e4955f70 00000082 fffffe00 ee9b474c e4a3f2d0 ee9b46b0 00000000 00000000 
       bffff5b0 e4955fac e4955f98 eeae0940 ee9b46b0 ee9b46b0 c011f028 ffffffff 
       00000000 ffffffff e4954000 00000008 ee9b474c e4954000 00000001 00000000 
Call Trace:
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

updatedb      S EF0FF3CC  5969   5961  5970    5971       (NOTLB)
e4f2df70 00000086 fffffe00 ef0ff3cc e4a3f900 ef0ff330 00000000 00000001 
       bffff264 e4f2dfac e4f2df98 e51bb260 ef0ff330 ef0ff330 c011f028 ffffffff 
       00000000 ffffffff e4f2c000 00000008 ef0ff3cc e4f2c000 00000001 00000000 
Call Trace:
 [<c011f028>] sys_wait4+0x20c/0x244
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0118f38>] default_wake_function+0x0/0x20
 [<c0108cc7>] syscall_call+0x7/0xb

find          D E92B9E00  5970   5969                     (NOTLB)
e92b9dc4 00000086 c394abc0 e92b9e00 e92b9e14 e4a3f900 ef537660 00000008 
       ef628e00 e92b9dc4 00000000 e51bbb60 e4a3f900 e92b9dd0 c0119e1c e92b9e00 
       df320da4 c014c985 df320da4 00000002 00000000 00017a04 c038dda0 00000000 
Call Trace:
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c014c985>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c014da4a>] __bread_slow_wq+0x8a/0xc0
 [<c014dc8c>] __bread+0x2c/0x34
 [<c0194c85>] ext2_get_inode+0x99/0xf8
 [<c0194d5f>] ext2_read_inode+0x23/0x2f8
 [<c01956d6>] ext2_lookup+0x56/0x98
 [<c015791c>] real_lookup+0x54/0xc4
 [<c0157b5b>] do_lookup+0x4f/0x94
 [<c01580f7>] link_path_walk+0x557/0x7fc
 [<c01586c1>] path_lookup+0x155/0x15c
 [<c01587e4>] __user_walk+0x28/0x40
 [<c0154266>] vfs_lstat+0x16/0x44
 [<c0154807>] sys_lstat64+0x13/0x30
 [<c0108cc7>] syscall_call+0x7/0xb

sort          S EF01E130  5971   5961          5972  5969 (NOTLB)
e627ff0c 00000086 ef01e0c0 ef01e130 e627ff4c ef20ace0 00000008 e92e0480 
       c01d35db e92e0480 00000001 e51bb860 ef20ace0 e627ff38 c01568f0 ef4528a0 
       edfb3f20 ef01e0c0 00000000 00000000 ef20ace0 c011ab54 e627ff44 e627ff44 
Call Trace:
 [<c01d35db>] scsi_io_completion+0x1ef/0x420
 [<c01568f0>] pipe_wait+0x70/0x94
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0156ab1>] pipe_read+0x19d/0x208
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

frcode        S EF01E6B0  5972   5961                5971 (NOTLB)
e5b5bf0c 00000086 ef01e640 ef01e6b0 e5b5bf4c e4a3f2d0 ee9cb6a0 ef270380 
       e4a67000 c01164c3 ef270360 ef270360 e4a3f2d0 e5b5bf38 c01568f0 ef452a20 
       ee9d58a0 ef01e640 00000000 00000000 e4a3f2d0 c011ab54 e5b5bf44 e5b5bf44 
Call Trace:
 [<c01164c3>] do_page_fault+0x133/0x478
 [<c01568f0>] pipe_wait+0x70/0x94
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0156ab1>] pipe_read+0x19d/0x208
 [<c010f3d7>] old_mmap+0xfb/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

bash          D E8447C6C  6014    335          6015       (NOTLB)
e8447c30 00000082 c3932bc0 e8447c6c e8447c80 e4a3e040 ef628ec4 00000000 
       c01c3d1c ef628e00 e8447c6c ece68ce0 e4a3e040 e8447c3c c0119e1c e8447c6c 
       c380c174 c013149d c32e3e78 ee20f1c8 00000000 00000000 c32e3e78 00000000 
Call Trace:
 [<c01c3d1c>] blk_run_queues+0x78/0xa0
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c013149d>] __lock_page_wq+0xa9/0xcc
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01319de>] do_generic_mapping_read+0x1aa/0x3bc
 [<c0131eb5>] __generic_file_aio_read+0x1f9/0x220
 [<c0131bf0>] file_read_actor+0x0/0xcc
 [<c0131fd5>] generic_file_read+0xa5/0xc0
 [<c0134c0a>] __alloc_pages+0x82/0x2b4
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01379ff>] cache_init_objs+0x3b/0x64
 [<c0137c2e>] cache_grow+0x1d6/0x2ec
 [<c0137f34>] cache_alloc_refill+0x1f0/0x240
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c0155258>] kernel_read+0x40/0x4c
 [<c0155c7d>] prepare_binprm+0xa5/0xb0
 [<c01560a0>] do_execve+0x120/0x1f0
 [<c010770b>] sys_execve+0x2f/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

bash          D EA345938  6015    335                6014 (NOTLB)
ea3458fc 00000082 c3932bc0 ea345938 ea34594c e4a3e670 ea34594c edf88418 
       c038df44 ea34007b c01c007b ef475640 e4a3e670 ea345908 c0119e1c ea345938 
       edf88418 c014c985 edf88418 00000002 00000000 ef48b000 c038df40 00000000 
Call Trace:
 [<c01c007b>] .text.lock.sys+0xd4/0x109
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c014c985>] __wait_on_buffer_wq+0xb9/0xd8
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c014da4a>] __bread_slow_wq+0x8a/0xc0
 [<c014dcc3>] __bread_wq+0x2f/0x38
 [<c0193ca0>] ext2_get_branch_wq+0x80/0x148
 [<c019405b>] ext2_get_block_wq+0x57/0x33c
 [<c01c4edb>] generic_make_request+0x23f/0x254
 [<c0194394>] ext2_get_block+0x20/0x24
 [<c0168d4b>] do_mpage_readpage+0x147/0x40c
 [<c015fdb0>] d_callback+0x0/0x30
 [<c01a0615>] radix_tree_node_alloc+0x15/0x60
 [<c01a071a>] radix_tree_extend+0x22/0x58
 [<c01a0772>] radix_tree_insert+0x22/0xa4
 [<c013115a>] add_to_page_cache+0x42/0xe0
 [<c01690c6>] mpage_readpages+0xb6/0x14c
 [<c0194374>] ext2_get_block+0x0/0x24
 [<c01943dd>] ext2_readpages+0x19/0x20
 [<c0194374>] ext2_get_block+0x0/0x24
 [<c0136a4d>] read_pages+0x2d/0x138
 [<c0134b78>] buffered_rmqueue+0x10c/0x11c
 [<c0134c0a>] __alloc_pages+0x82/0x2b4
 [<c0136d11>] do_page_cache_readahead+0x1b9/0x200
 [<c0136e27>] page_cache_readahead+0xcf/0x12c
 [<c01318fd>] do_generic_mapping_read+0xc9/0x3bc
 [<c0131eb5>] __generic_file_aio_read+0x1f9/0x220
 [<c0131bf0>] file_read_actor+0x0/0xcc
 [<c0131fd5>] generic_file_read+0xa5/0xc0
 [<c0134c0a>] __alloc_pages+0x82/0x2b4
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01379ff>] cache_init_objs+0x3b/0x64
 [<c0137c2e>] cache_grow+0x1d6/0x2ec
 [<c0137f34>] cache_alloc_refill+0x1f0/0x240
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c0155258>] kernel_read+0x40/0x4c
 [<c0155c7d>] prepare_binprm+0xa5/0xb0
 [<c01560a0>] do_execve+0x120/0x1f0
 [<c010770b>] sys_execve+0x2f/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb

sshd          D DA949E0C  6016    309                 333 (NOTLB)
da949dd0 00000086 c3932bc0 da949e0c da949e20 e60e66f0 edfb3a20 00000000 
       00000001 edfb3a6c da949e0c e61f3200 e60e66f0 da949ddc c0119e1c da949e0c 
       c380a680 c013149d c32dbae8 ee8ceae8 00000000 00000000 c32dbae8 00000000 
Call Trace:
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c013149d>] __lock_page_wq+0xa9/0xcc
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01319de>] do_generic_mapping_read+0x1aa/0x3bc
 [<c0131eb5>] __generic_file_aio_read+0x1f9/0x220
 [<c0131bf0>] file_read_actor+0x0/0xcc
 [<c0131fd5>] generic_file_read+0xa5/0xc0
 [<c01401b0>] vma_link+0x54/0x74
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c0140983>] do_mmap_pgoff+0x487/0x610
 [<c010f3d7>] old_mmap+0xfb/0x134
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c014ba3d>] sys_read+0x31/0x4c
 [<c0108cc7>] syscall_call+0x7/0xb

bash          D DA94FC6C  6017    332                     (NOTLB)
da94fc30 00000082 c3972bc0 da94fc6c da94fc80 eeafd370 ebaa46e0 00000008 
       00000004 ebaa472c da94fc6c e4e4ec80 eeafd370 da94fc3c c0119e1c da94fc6c 
       c38a5708 c013149d f5305888 ee6b88e8 00000000 00000000 f5305888 00000000 
Call Trace:
 [<c0119e1c>] io_schedule+0x28/0x34
 [<c013149d>] __lock_page_wq+0xa9/0xcc
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01319de>] do_generic_mapping_read+0x1aa/0x3bc
 [<c0131eb5>] __generic_file_aio_read+0x1f9/0x220
 [<c0131bf0>] file_read_actor+0x0/0xcc
 [<c0131fd5>] generic_file_read+0xa5/0xc0
 [<c015fdb0>] d_callback+0x0/0x30
 [<c0134c0a>] __alloc_pages+0x82/0x2b4
 [<c011ab54>] autoremove_wake_function+0x0/0x38
 [<c01379ff>] cache_init_objs+0x3b/0x64
 [<c0137c2e>] cache_grow+0x1d6/0x2ec
 [<c0137f34>] cache_alloc_refill+0x1f0/0x240
 [<c014b82c>] vfs_read+0xa0/0xd0
 [<c0155258>] kernel_read+0x40/0x4c
 [<c0155c7d>] prepare_binprm+0xa5/0xb0
 [<c01560a0>] do_execve+0x120/0x1f0
 [<c010770b>] sys_execve+0x2f/0x6c
 [<c0108cc7>] syscall_call+0x7/0xb


