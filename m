Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVIUQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVIUQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVIUQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:53:26 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:57298 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751171AbVIUQxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:53:25 -0400
Message-ID: <43318FFA.4010706@nortel.com>
Date: Wed, 21 Sep 2005 10:53:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: dentry_cache using up all my zone normal memory
References: <433189B5.3030308@nortel.com>
In-Reply-To: <433189B5.3030308@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 16:53:19.0573 (UTC) FILETIME=[F8255850:01C5BECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Marcelo's suggestion, I modified the oom killer code to dump the 
stack.  The dmesg output of the first process being killed is as follows:


oom-killer: gfp_mask=0xd0
  [<c0137701>] out_of_memory+0x51/0xb0
  [<c0138888>] __alloc_pages+0x3d8/0x3f0
  [<c01388bb>] __get_free_pages+0x1b/0x40
  [<c013bbc2>] kmem_getpages+0x22/0xb0
  [<c013c7d9>] cache_grow+0xa9/0x170
  [<c013ca4d>] cache_alloc_refill+0x1ad/0x1f0
  [<c013cc78>] kmem_cache_alloc+0x38/0x40
  [<c01655f1>] d_alloc+0x21/0x170
  [<c015b15d>] cached_lookup+0x7d/0x90
  [<c015c53d>] __lookup_hash+0x8d/0xe0
  [<c015c5ad>] lookup_hash+0x1d/0x30
  [<c015e737>] sys_rename+0x137/0x230
  [<c01106e0>] recalc_task_prio+0xc0/0x1c0
  [<c010250d>] sysenter_past_esp+0x52/0x75
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:     2484556kB (2480576kB HighMem)
Active:1787 inactive:419 dirty:2 writeback:0 unstable:0 free:621139 
slab:217642 mapped:1511 pagetables:102
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB 
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3912kB min:3756kB low:4692kB high:5632kB active:0kB 
inactive:0kB present:901120kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:2480576kB min:512kB low:640kB high:768kB active:7148kB 
inactive:1676kB present:3276800kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 68kB
Normal: 2*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 1*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 3912kB
HighMem: 244*4kB 116*8kB 73*16kB 66*32kB 44*64kB 25*128kB 16*256kB 
3*512kB 0*1024kB 1*2048kB 601*4096kB = 2480576kB
Out of Memory: Killed process 595 (portmap).
