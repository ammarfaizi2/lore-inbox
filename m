Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbUKEOqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUKEOqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUKEOqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:46:39 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:2319 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S262706AbUKEOq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:46:26 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 5 Nov 2004 08:46:21 -0600
To: linux-kernel@vger.kernel.org
Subject: Kernel memory requirements and BK
Message-ID: <20041105144621.GC7724@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've been having problems with 'bk pull' execution when using kernels
after the 2.6.8/2.6.8.1 releases. My machine has 192M of memory and 100M
of swap, so I believe that the memory requirements for using BK to keep
up with the kernel is sufficient, and when the machine is running with a
2.6.8.1 kernel I can 'bk pull' even if X windows is running. With the
2.6.9 and 2.6.10-rc kernels, BK bombs out with out-of-memory errors once
the repository checking begins. I've run the 'bk pull' under the newer
kernels without X running, as well as shutting down various daemons, and
still things fail with memory errors.

Here's a snippet of /var/log/messages under 2.6.10-rc1 when a
'bk pull' fails:

kernel: oom-killer: gfp_mask=0xd2
kernel: DMA per-cpu:
kernel: cpu 0 hot: low 2, high 6, batch 1
kernel: cpu 0 cold: low 0, high 2, batch 1
kernel: Normal per-cpu:
kernel: cpu 0 hot: low 22, high 66, batch 11
kernel: cpu 0 cold: low 0, high 22, batch 11
kernel: HighMem per-cpu: empty
kernel: 
kernel: Free pages:         420kB (0kB HighMem)
kernel: Active:45877 inactive:64 dirty:0 writeback:0 unstable:0 free:105 slab:1451 mapped:45846 pagetables:195
kernel: DMA free:36kB min:36kB low:72kB high:108kB active:13684kB inactive:0kB present:16384kB pages_scanned:14695 all_unreclaimable? yes
kernel: protections[]: 0 0 0
kernel: Normal free:384kB min:400kB low:800kB high:1200kB active:169824kB inactive:256kB present:180224kB pages_scanned:214215 all_unreclaimable? yes
kernel: protections[]: 0 0 0
kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
kernel: protections[]: 0 0 0
kernel: DMA: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 36kB
kernel: Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 384kB
kernel: HighMem: empty
kernel: Swap cache: add 110618, delete 108152, find 38132/44306, race 0+1

The machine used to have only 128M of memory, and 'bk pull' worked
albiet _very_ slowly as the machine went heavily into swap space usage,
but it seemed that once the number of files went over 20,000 or so I had
to add more memory, and then once again 'bk pull' worked without any
problem.

I realize that there have been many, many changes to the kernel between
2.6.8 and the current BK, but my configuration for my builds has
remained mostly the same, so I am at somewhat of a loss to figure out
just where the extra memory usage is coming from.

Is there a known set of changes that explain the additional memory
requirements?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
