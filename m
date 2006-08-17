Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWHQFwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWHQFwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWHQFwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:52:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:44214 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932310AbWHQFwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:52:20 -0400
X-Authenticated: #14349625
Subject: Re: Maximum number of processes in Linux
From: Mike Galbraith <efault@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Willy Tarreau <w@1wt.eu>,
       Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608160720210.4352@chaos.analogic.com>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
	 <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com>
	 <20060815182219.GL8776@1wt.eu>
	 <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
	 <44E2ED07.6070203@aitel.hist.no>
	 <Pine.LNX.4.61.0608160720210.4352@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 08:00:29 +0000
Message-Id: <1155801629.25655.26.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 07:33 -0400, linux-os (Dick Johnson) wrote:
> On Wed, 16 Aug 2006, Helge Hafting wrote:
> > Doesn't work here.  Without ulimit, I wasn't surprised
> > about the resulting OOM mess.
> >
> > Problem was, it never stopped.  I expected OOM to kill
> > this program, and quite possibly lots of other running programs
> > as well.  What I got, was ever-rolling OOM messages
> > with stack traces inbetween.
> > 2.6.18-rc4-mm1 never recovered and had to be killed by sysrq.
> >
> > Helge Hafting
> 

> Runs fine here. I'm using 2.6.14.24. Maybe your kernel version still
> has an OEM bug???

Hmm.  For grins, I ran it as root in 2.6.18-rc4-mm1, and didn't even get
an oom.  I did a SysRq-E, ran it again, and watched it fork off 18600
kids, then hang the box again.

SysRq : Terminate All Tasks
SysRq : Changing Loglevel
Loglevel set to 9

(start forkbomb... generates ~18600 kids, I thumb twiddle then...)

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:56
cpu 0 cold: high 62, batch 15 used:59
cpu 1 hot: high 186, batch 31 used:61
cpu 1 cold: high 62, batch 15 used:49
HighMem per-cpu:
cpu 0 hot: high 42, batch 7 used:6
cpu 0 cold: high 14, batch 3 used:13
cpu 1 hot: high 42, batch 7 used:1
cpu 1 cold: high 14, batch 3 used:11
Active:130198 inactive:1205 dirty:0 writeback:0 unstable:0 free:3009 slab:64587 mapped:518 pagetables:55775
DMA free:4096kB min:68kB low:84kB high:100kB active:3652kB inactive:4656kB present:16384kB pages_scanned:27 all_unreclaimable? no
lowmem_reserve[]: 0 880 1007
Normal free:7836kB min:3756kB low:4692kB high:5632kB active:426716kB inactive:156kB present:901120kB pages_scanned:44713 all_unreclaimable? no
lowmem_reserve[]: 0 0 1023
HighMem free:104kB min:128kB low:264kB high:400kB active:90424kB inactive:8kB present:131008kB pages_scanned:46493 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 1*4096kB = 4096kB
Normal: 1*4kB 1*8kB 1*16kB 2*32kB 1*64kB 0*128kB 4*256kB 5*512kB 0*1024kB 0*2048kB 1*4096kB = 7836kB
HighMem: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 104kB
Swap cache: add 280, delete 69, find 0/0, race 0+0
Free swap  = 1027032kB
Total swap = 1028152kB
Free swap:       1027032kB
262128 pages of RAM
32752 pages of HIGHMEM
5276 reserved pages
521412 pages shared
211 pages swap cached
0 pages dirty
0 pages writeback
518 pages mapped
64587 pages slab
55775 pages pagetables
SysRq : Terminate All Tasks

> Since the forked process never touches any of its memory, it
> shouldn't use anything except space in the kernel for a new task-
> structure and space in user-space for stack. COW wouldn't have
> happened yet. I don't see how you get out of memory before you
> run out of PIDs!
> 
> The first instance of the fork failing should cause a signal
> to be sent to all the children, killing them:
> 
>          case -1:	// Failed
>          printf("%lu\n", i);
>              kill(0, SIGTERM);
>              exit(0);

No oom-kill action here.

	-Mike

