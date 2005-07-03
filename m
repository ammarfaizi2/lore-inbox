Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVGDDml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVGDDml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 23:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGDDml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 23:42:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17628 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261403AbVGDDlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 23:41:55 -0400
Date: Sun, 3 Jul 2005 19:45:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Roy Keene <rkeene@psislidell.com>
Cc: Alexander Nyberg <alexn@telia.com>,
       Anthony DiSante <theant@nodivisions.com>, andrea@suse.de, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killings, but I'm not out of memory!
Message-ID: <20050703224555.GB21450@logos.cnet>
References: <42C179D5.3040603@nodivisions.com> <1119977073.1723.2.camel@localhost.localdomain> <42C18031.50206@nodivisions.com> <1120049835.1176.7.camel@localhost.localdomain> <20050703205357.GA21166@logos.cnet> <Pine.LNX.4.62.0507032142290.25063@hammer.psislidell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507032142290.25063@hammer.psislidell.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Roy,

On Sun, Jul 03, 2005 at 09:44:37PM -0500, Roy Keene wrote:
> I think I'm having the same issue.
> 
> I've 2 systems with 4GB of RAM and 2GB of swap that kill processes when 
> they get a lot of disk I/O.  I've attached the full dmesg output which 
> includes portions where it killed stuff despite having massive amounts of 
> free memory.

What kernel version is that?

> oom-killer: gfp_mask=0xd0
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: low 2, high 6, batch 1
> cpu 0 cold: low 0, high 2, batch 1
> cpu 1 hot: low 2, high 6, batch 1
> cpu 1 cold: low 0, high 2, batch 1
> cpu 2 hot: low 2, high 6, batch 1
> cpu 2 cold: low 0, high 2, batch 1
> cpu 3 hot: low 2, high 6, batch 1
> cpu 3 cold: low 0, high 2, batch 1
> Normal per-cpu:
> cpu 0 hot: low 32, high 96, batch 16
> cpu 0 cold: low 0, high 32, batch 16
> cpu 1 hot: low 32, high 96, batch 16
> cpu 1 cold: low 0, high 32, batch 16
> cpu 2 hot: low 32, high 96, batch 16
> cpu 2 cold: low 0, high 32, batch 16
> cpu 3 hot: low 32, high 96, batch 16
> cpu 3 cold: low 0, high 32, batch 16
> HighMem per-cpu:
> cpu 0 hot: low 32, high 96, batch 16
> cpu 0 cold: low 0, high 32, batch 16
> cpu 1 hot: low 32, high 96, batch 16
> cpu 1 cold: low 0, high 32, batch 16
> cpu 2 hot: low 32, high 96, batch 16
> cpu 2 cold: low 0, high 32, batch 16
> cpu 3 hot: low 32, high 96, batch 16
> cpu 3 cold: low 0, high 32, batch 16
> 
> Free pages:       14304kB (1664kB HighMem)
> Active:7971 inactive:994335 dirty:327523 writeback:25721 unstable:0 free:3576 slab:29113 mapped:7996 pagetables:341

There are about 100M of writeout data onflight - I suppose thats too much. 

Guess: can you switch to another IO scheduler than CFQ or reduce its queue size?

IIRC you can do that by reducing /sys/block/device/queue/nr_requests.

> DMA free:12640kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB pages_scanned:877 all_unreclaimable? yes
> protections[]: 0 0 0
>
> Normal free:0kB min:928kB low:1856kB high:2784kB active:0kB inactive:739100kB present:901120kB pages_scanned:1556742 all_unreclaimable? yes
> protections[]: 0 0 0

You've got no reservations for the normal zone either. 

How does /proc/sys/vm/lowmem_reserve_ratio looks like?

