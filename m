Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVKAIlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVKAIlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVKAIlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:41:06 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54670
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964981AbVKAIlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:41:04 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
Date: Tue, 1 Nov 2005 02:37:01 -0600
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <53vpu-s9-17@gated-at.bofh.it> <4366E99D.7070606@shaw.ca>
In-Reply-To: <4366E99D.7070606@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010237.01737.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 22:05, Robert Hancock wrote:
> Rob Landley wrote:
> > Under 2.6.14 (UML), I have a workload that runs with 64 megs ram and 256
> > megs swap space.  It completes (albeit swapping like mad) with swappiness
> > at the default 60, but if I set it to 0 the OOM killer kicks in and the
> > script aborts.
>
> You should get some debugging output in dmesg when the OOM killer kicks
> in, can you post this?

Sure:

VFS: Mounted root (hostfs filesystem).
Adding 262136k swap on tmp/ubda.  Priority:-1 extents:1 across:262136k
oom-killer: gfp_mask=0x400d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 14, high 42, batch 7 used:20
cpu 0 cold: low 0, high 14, batch 7 used:8
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        1416kB (0kB HighMem)
Active:14014 inactive:718 dirty:1 writeback:0 unstable:0 free:354 slab:468 
mapped:14722 pagetables:58
DMA free:1416kB min:1024kB low:1280kB high:1536kB active:56056kB 
inactive:2872kB present:65536kB pages_scanned:26577 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 98*4kB 0*8kB 0*16kB 0*32kB 4*64kB 2*128kB 0*256kB 1*512kB 0*1024kB 
0*2048kB 0*4096kB = 1416kB
Normal: empty
HighMem: empty
Swap cache: add 5689, delete 5485, find 583/725, race 0+0
Free swap  = 255420kB
Total swap = 262136kB
Free swap:       255420kB
16384 pages of RAM
0 pages of HIGHMEM
671 reserved pages
1034 pages shared
204 pages swap cached
Out of Memory: Killed process 30055 (cc1).
Badness in handle_page_fault 
at /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/trap_kern.c:98
08bafb10:  [<0805d064>] handle_page_fault+0x1c4/0x260
08bafb50:  [<0805d1a7>] segv+0xa7/0x2e0
08bafb70:  [<0805e713>] setjmp_wrapper+0x83/0x90
08bafba8:  [<0805e6c7>] setjmp_wrapper+0x37/0x90
08bafbd0:  [<0805b1a5>] change_signals+0x65/0x90
08bafbe0:  [<08060d3a>] do_ops+0x14a/0x150
08bafc10:  [<0805f29f>] wait_stub_done+0x5f/0x110
08bafc40:  [<0805d67c>] segv_handler+0x7c/0x90
08bafc60:  [<08060fbe>] user_signal+0x3e/0x70
08bafc80:  [<0805faa0>] userspace+0x180/0x220
08bafcf0:  [<08060711>] fork_handler+0xc1/0xe0

System halted.
