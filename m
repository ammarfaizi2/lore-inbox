Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVAUIJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVAUIJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVAUIJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:09:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261592AbVAUIJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:09:42 -0500
Date: Fri, 21 Jan 2005 09:09:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050121080940.GA2763@suse.de>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050121074203.GH2755@suse.de> <20050121080520.GA7703@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121080520.GA7703@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21 2005, Andrea Arcangeli wrote:
> On Fri, Jan 21, 2005 at 08:42:08AM +0100, Jens Axboe wrote:
> > And especially not with 500MB of zone normal free, thanks :)
> 
> ;) Are you sure you had 500m free even before the _first_ oom killing?

No it wasn't, the first looked like this:

Jan 20 13:22:15 wiggum kernel: oom-killer: gfp_mask=0xd1
Jan 20 13:22:15 wiggum kernel: DMA per-cpu:
Jan 20 13:22:15 wiggum kernel: cpu 0 hot: low 2, high 6, batch 1
Jan 20 13:22:15 wiggum kernel: cpu 0 cold: low 0, high 2, batch 1
Jan 20 13:22:15 wiggum kernel: Normal per-cpu:
Jan 20 13:22:15 wiggum kernel: cpu 0 hot: low 32, high 96, batch 16
Jan 20 13:22:15 wiggum kernel: cpu 0 cold: low 0, high 32, batch 16
Jan 20 13:22:15 wiggum kernel: HighMem per-cpu: empty
Jan 20 13:22:15 wiggum kernel: 
Jan 20 13:22:15 wiggum kernel: Free pages:      155720kB (0kB HighMem)
Jan 20 13:22:15 wiggum kernel: Active:113367 inactive:14428 dirty:2048 writeback:0 unstable:0 free:38930 slab:6284 mapped:102966 pagetables:2010
Jan 20 13:22:15 wiggum kernel: DMA free:4080kB min:60kB low:72kB high:88kB active:16kB inactive:0kB present:16384kB pages_scanned:21 all_unreclaimable? yes
Jan 20 13:22:15 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:15 wiggum kernel: Normal free:151640kB min:4028kB low:5032kB high:6040kB active:453452kB inactive:57712kB present:1031360kB pages_scanned:0 all_unreclaimable? no
Jan 20 13:22:15 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:15 wiggum kernel: HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 20 13:22:15 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:15 wiggum kernel: DMA: 520*4kB 120*8kB 65*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4080kB
Jan 20 13:22:15 wiggum kernel: Normal: 23636*4kB 6171*8kB 225*16kB 7*32kB 1*64kB 4*128kB 3*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 151640kB
Jan 20 13:22:15 wiggum kernel: HighMem: empty
Jan 20 13:22:15 wiggum kernel: Swap cache: add 35304, delete 31894, find 5456/7337, race 0+0
Jan 20 13:22:15 wiggum kernel: Out of Memory: Killed process 12786 (firefox-bin).
Jan 20 13:22:20 wiggum kernel: oom-killer: gfp_mask=0xd1
Jan 20 13:22:20 wiggum kernel: DMA per-cpu:
Jan 20 13:22:20 wiggum kernel: cpu 0 hot: low 2, high 6, batch 1
Jan 20 13:22:20 wiggum kernel: cpu 0 cold: low 0, high 2, batch 1
Jan 20 13:22:20 wiggum kernel: Normal per-cpu:
Jan 20 13:22:20 wiggum kernel: cpu 0 hot: low 32, high 96, batch 16
Jan 20 13:22:20 wiggum kernel: cpu 0 cold: low 0, high 32, batch 16
Jan 20 13:22:20 wiggum kernel: HighMem per-cpu: empty
Jan 20 13:22:20 wiggum kernel: 
Jan 20 13:22:20 wiggum kernel: Free pages:      215112kB (0kB HighMem)
Jan 20 13:22:20 wiggum kernel: Active:97117 inactive:15986 dirty:2693 writeback:0 unstable:0 free:53778 slab:6223 mapped:85471 pagetables:1948
Jan 20 13:22:20 wiggum kernel: DMA free:4152kB min:60kB low:72kB high:88kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
Jan 20 13:22:20 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:20 wiggum kernel: Normal free:210960kB min:4028kB low:5032kB high:6040kB active:388468kB inactive:63944kB present:1031360kB pages_scanned:0 all_unreclaimable? no
Jan 20 13:22:20 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:20 wiggum kernel: HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 20 13:22:20 wiggum kernel: protections[]: 0 0 0
Jan 20 13:22:20 wiggum kernel: DMA: 524*4kB 125*8kB 66*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4152kB
Jan 20 13:22:20 wiggum kernel: Normal: 29382*4kB 8689*8kB 669*16kB 91*32kB 29*64kB 10*128kB 4*256kB 4*512kB 0*1024kB 2*2048kB 0*4096kB = 210960kB
Jan 20 13:22:20 wiggum kernel: HighMem: empty
Jan 20 13:22:20 wiggum kernel: Swap cache: add 35388, delete 32397, find 5465/7365, race 0+0
Jan 20 13:22:20 wiggum kernel: Out of Memory: Killed process 12909 (xmms).

I've kept the timestamps this time, as you can see there are 5 seconds
between the two kills and the first kill happens with 150MB of zone
normal free! At 13:22:25, my psi IM client gets killed as well.

-- 
Jens Axboe

