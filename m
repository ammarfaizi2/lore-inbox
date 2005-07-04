Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVGDDyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGDDyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 23:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGDDyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 23:54:18 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:41347 "EHLO mail1.w2cog.org")
	by vger.kernel.org with ESMTP id S261404AbVGDDyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 23:54:06 -0400
Date: Sun, 3 Jul 2005 22:52:43 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Alexander Nyberg <alexn@telia.com>,
       Anthony DiSante <theant@nodivisions.com>, andrea@suse.de, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killings, but I'm not out of memory!
In-Reply-To: <20050703224555.GB21450@logos.cnet>
Message-ID: <Pine.LNX.4.62.0507032247170.25627@hammer.psislidell.com>
References: <42C179D5.3040603@nodivisions.com> <1119977073.1723.2.camel@localhost.localdomain>
 <42C18031.50206@nodivisions.com> <1120049835.1176.7.camel@localhost.localdomain>
 <20050703205357.GA21166@logos.cnet> <Pine.LNX.4.62.0507032142290.25063@hammer.psislidell.com>
 <20050703224555.GB21450@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

 	Roy Keene
 	Planning Systems Inc.

On Sun, 3 Jul 2005, Marcelo Tosatti wrote:

>
> Hi Roy,
>
> On Sun, Jul 03, 2005 at 09:44:37PM -0500, Roy Keene wrote:
>> I think I'm having the same issue.
>>
>> I've 2 systems with 4GB of RAM and 2GB of swap that kill processes when
>> they get a lot of disk I/O.  I've attached the full dmesg output which
>> includes portions where it killed stuff despite having massive amounts of
>> free memory.
>
> What kernel version is that?
>

Linux cog2 2.6.9-11.ELsmp #1 SMP Fri May 20 18:26:27 EDT 2005 i686 i686 i386 GNU/Linux


>> oom-killer: gfp_mask=0xd0
>> Mem-info:
>> DMA per-cpu:
>> cpu 0 hot: low 2, high 6, batch 1
>> cpu 0 cold: low 0, high 2, batch 1
>> cpu 1 hot: low 2, high 6, batch 1
>> cpu 1 cold: low 0, high 2, batch 1
>> cpu 2 hot: low 2, high 6, batch 1
>> cpu 2 cold: low 0, high 2, batch 1
>> cpu 3 hot: low 2, high 6, batch 1
>> cpu 3 cold: low 0, high 2, batch 1
>> Normal per-cpu:
>> cpu 0 hot: low 32, high 96, batch 16
>> cpu 0 cold: low 0, high 32, batch 16
>> cpu 1 hot: low 32, high 96, batch 16
>> cpu 1 cold: low 0, high 32, batch 16
>> cpu 2 hot: low 32, high 96, batch 16
>> cpu 2 cold: low 0, high 32, batch 16
>> cpu 3 hot: low 32, high 96, batch 16
>> cpu 3 cold: low 0, high 32, batch 16
>> HighMem per-cpu:
>> cpu 0 hot: low 32, high 96, batch 16
>> cpu 0 cold: low 0, high 32, batch 16
>> cpu 1 hot: low 32, high 96, batch 16
>> cpu 1 cold: low 0, high 32, batch 16
>> cpu 2 hot: low 32, high 96, batch 16
>> cpu 2 cold: low 0, high 32, batch 16
>> cpu 3 hot: low 32, high 96, batch 16
>> cpu 3 cold: low 0, high 32, batch 16
>>
>> Free pages:       14304kB (1664kB HighMem)
>> Active:7971 inactive:994335 dirty:327523 writeback:25721 unstable:0 free:3576 slab:29113 mapped:7996 pagetables:341
>
> There are about 100M of writeout data onflight - I suppose thats too much.
>
> Guess: can you switch to another IO scheduler than CFQ or reduce its queue size?
>
> IIRC you can do that by reducing /sys/block/device/queue/nr_requests.
>

For all the devices I use this is set to 8192

I set "sda" to 512 now.

[root@cog2 ~]# cat /sys/block/{sda,nbd0,nbd1}/queue/nr_requests
8192
8192
8192


>> DMA free:12640kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB pages_scanned:877 all_unreclaimable? yes
>> protections[]: 0 0 0
>>
>> Normal free:0kB min:928kB low:1856kB high:2784kB active:0kB inactive:739100kB present:901120kB pages_scanned:1556742 all_unreclaimable? yes
>> protections[]: 0 0 0
>
> You've got no reservations for the normal zone either.
>
> How does /proc/sys/vm/lowmem_reserve_ratio looks like?
>
>

It looks like it doesn't exist..
[root@cog2 ~]# ls /proc/sys/vm
block_dump              dirty_ratio                laptop_mode 
max_map_count    nr_pdflush_threads  page-cluster
dirty_background_ratio  dirty_writeback_centisecs  legacy_va_layout 
min_free_kbytes  overcommit_memory   swappiness
dirty_expire_centisecs  hugetlb_shm_group          lower_zone_protection 
nr_hugepages     overcommit_ratio    vfs_cache_pressure
[root@cog2 ~]#
