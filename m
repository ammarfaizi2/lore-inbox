Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLaKvb>; Tue, 31 Dec 2002 05:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSLaKvb>; Tue, 31 Dec 2002 05:51:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:1946 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261426AbSLaKva>;
	Tue, 31 Dec 2002 05:51:30 -0500
Message-ID: <3E1178A4.8201D270@digeo.com>
Date: Tue, 31 Dec 2002 02:59:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 5.53 mm2 oops during LMbench.
References: <94F20261551DC141B6B559DC491086720445DD@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 10:59:48.0854 (UTC) FILETIME=[BC8D3960:01C2B0BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> Oops came when Lmbench was calculating memory load latency.
> 
> Couldn't capture the entire call trace. Here is the last screen.
> 
> 3ef4c>] shrink_list+0x3c/0x660
>  [<c0109cea>] apic_timer_interrupt+0x1a/0x20
>  [<c013dfca>] __pagevec_release+0x1a/0x30
>  [<c013f7a8>] shrink_cache+0x238/0x460
>  [<c01401b3>] shrink_zone+0x83/0xb0
>  [<c0140250>] shrink_caches+0x70/0xa0
>  [<c0140309>] try_to_free_pages+0x89/0xc0
>  [<c01382a7>] __alloc_pages+0x1f7/0x2c0
>  [<c013839a>] __get_free_pages+0x2a/0x70
>  [<c013b6e1>] cache_grow+0x141/0x380
>  [<c013ba51>] __cache_alloc_refill+0x131/0x440
>  [<c013bda4>] cache_alloc_refill+0x44/0x60
>  [<c013c316>] kmem_cache_alloc+0x56/0x100
>  [<c01485b5>] pgtable_add_rmap+0x55/0x80
>  [<c01416a1>] pte_alloc_map+0xe1/0x180
>  [<c0148f61>] pte_chain_alloc+0x41/0x60

That's probably a `scheduling while atomic' warning coming out
of pte_chain_alloc().   It has a bug.
