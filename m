Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269886AbUJHA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbUJHA6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269896AbUJHA4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:56:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:31421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269886AbUJHAvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:51:23 -0400
Date: Thu, 7 Oct 2004 17:51:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007175110.Q2357@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net> <20041007164044.23bac609.akpm@osdl.org> <4165E0A7.7080305@yahoo.com.au> <20041007173748.0be87160.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007173748.0be87160.akpm@osdl.org>; from akpm@osdl.org on Thu, Oct 07, 2004 at 05:37:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > >I think a good starting point here will be to revert the most recent
> >  >change.
> >  >
> > 
> >  That may fix it for the simple fact that kswapd will just go through its
> >  priority loop once then stop.
> 
> No it won't.  It'll probably make the priority windup worse.

In the interest of data collection, here's the last bit before I reboot.

SysRq : Show Memory
Mem-info:
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Node 0 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
Node 0 HighMem per-cpu: empty

Free pages:       53200kB (0kB HighMem)
Active:239438 inactive:178323 dirty:8 writeback:0 unstable:0 free:13300 slab:76700 mapped:52305 pagetables:2172
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
Node 1 Normal free:25272kB min:1020kB low:2040kB high:3060kB active:624172kB inactive:282700kB present:1047936kB
protections[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
Node 0 DMA free:728kB min:12kB low:24kB high:36kB active:788kB inactive:7848kB present:16384kB
protections[]: 0 0 0
Node 0 Normal free:27200kB min:1004kB low:2008kB high:3012kB active:332792kB inactive:422744kB present:1032188kB
protections[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
Node 1 DMA: empty
Node 1 Normal: 150*4kB 66*8kB 45*16kB 0*32kB 192*64kB 55*128kB 8*256kB 2*512kB 1*1024kB 0*2048kB 0*4096kB = 25272kB
Node 1 HighMem: empty
Node 0 DMA: 8*4kB 1*8kB 1*16kB 13*32kB 4*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 728kB
Node 0 Normal: 10*4kB 3*8kB 2*16kB 3*32kB 308*64kB 43*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 27200kB
Node 0 HighMem: empty
Swap cache: add 79, delete 1, find 0/0, race 0+0
Free swap:       2031292kB
524127 pages of RAM
10946 reserved pages
263444 pages shared
78 pages swap cached
