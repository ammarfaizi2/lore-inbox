Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSL3Alb>; Sun, 29 Dec 2002 19:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSL3Ala>; Sun, 29 Dec 2002 19:41:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:8696 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262452AbSL3Ala>;
	Sun, 29 Dec 2002 19:41:30 -0500
Message-ID: <3E0F9829.D1A9CC95@digeo.com>
Date: Sun, 29 Dec 2002 16:49:45 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
References: <20021229202610.GA24554@lnuxlab.ath.cx> <3E0F5E2C.70F7D112@digeo.com> <20021229233236.GA25035@lnuxlab.ath.cx> <3E0F8B4C.568C018C@digeo.com> <20021230002604.GA25134@lnuxlab.ath.cx> <3E0F8EF6.3C264886@digeo.com> <20021230005107.GA25318@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 00:49:46.0227 (UTC) FILETIME=[5945D430:01C2AF9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> ...
> And here is dmesg:
> 
> xmms: page allocation failure. order:5, mode:0x20
> Call Trace:
>  [<c012a3e7>] __alloc_pages+0x25f/0x26c
>  [<c012a41c>] __get_free_pages+0x28/0x60
>  [<c010e36e>] dma_alloc_coherent+0x3e/0x74
>  [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
>  [<c021c31d>] set_dac2_rate+0xb5/0xe0
>  [<c021f01d>] es1371_ioctl+0x10d5/0x140c
>  [<c012d228>] kmem_cache_free+0x174/0x1b8
>  [<c014ccf9>] sys_ioctl+0x1fd/0x254
>  [<c01089af>] syscall_call+0x7/0xb
> 

OK, thanks.  The audio driver is trying to allocate a large DMA
buffer and just falls back to a smaller size if it fails.

And dma_alloc_coherent() forces GFP_ATOMIC, which is quite broken
of it.

Let's leave this one as-is.  It'll be OK when all the debug code
is pulled out.
