Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSL3Fcr>; Mon, 30 Dec 2002 00:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSL3Fcr>; Mon, 30 Dec 2002 00:32:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:36859 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266716AbSL3Fcq>;
	Mon, 30 Dec 2002 00:32:46 -0500
Message-ID: <3E0FDC6E.10177843@digeo.com>
Date: Sun, 29 Dec 2002 21:41:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: bad: scheduling while atomic!
References: <20021229204136.GA24616@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 05:41:02.0660 (UTC) FILETIME=[0A09E040:01C2AFC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> Running 2.5.53-mm3, I got the following:
> 
> bad: scheduling while atomic!
> Call Trace:
>  [<c0114381>] do_schedule+0x3d/0x2c8
>  [<c011d9b0>] schedule_timeout+0x80/0xa0
>  [<c011d924>] process_timeout+0x0/0xc
>  [<c0115315>] io_schedule_timeout+0x11/0x1c
>  [<c01de5de>] blk_congestion_wait+0x8a/0xa0
>  [<c0115a54>] autoremove_wake_function+0x0/0x38
>  [<c0115a54>] autoremove_wake_function+0x0/0x38
>  [<c012fbb4>] try_to_free_pages+0x3c/0xbc
>  [<c012a33c>] __alloc_pages+0x1b4/0x260
>  [<c012a410>] __get_free_pages+0x28/0x64
>  [<c012c7e6>] cache_grow+0xb6/0x20c
>  [<c012c9cf>] __cache_alloc_refill+0x93/0x220
>  [<c012cb96>] cache_alloc_refill+0x3a/0x58
>  [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
>  [<c0136460>] pte_chain_alloc+0x38/0x68

OK, thanks.  That's a harmless bug in the new pte_chain_alloc().

Turns out that sleep-in-spinlock debugging is currently broken
for slab allocations - it is only enabled when slab debugging is
enabled.  grr.

I'll fix those things up in the next round.
