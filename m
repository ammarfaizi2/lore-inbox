Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSLaXTa>; Tue, 31 Dec 2002 18:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbSLaXTa>; Tue, 31 Dec 2002 18:19:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:14760 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264857AbSLaXTa>;
	Tue, 31 Dec 2002 18:19:30 -0500
Message-ID: <3E1227F4.E4B98632@digeo.com>
Date: Tue, 31 Dec 2002 15:27:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: "Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update)
References: <200212312202.OAA10841@adam.yggdrasil.com>
	 <3E121D28.47282D77@digeo.com> <3E1226FF.9010407@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 23:27:48.0940 (UTC) FILETIME=[3B2AE0C0:01C2B124]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
>         void *mempool_alloc_td (int mem_flags, void *pool)
>         {
>                 struct td *td;
>                 dma_addr_t dma;
> 
>                 td = dma_pool_alloc (pool, mem_flags, &dma);
>                 if (!td)
>                         return td;
>                 td->td_dma = dma;       /* feed to the hardware */
>                 ... plus other init
>                 return td;
>         }

The existing mempool code can be used to implement this, I believe.  The
pool->alloc callback is passed an opaque void *, and it returns
a void * which can point at any old composite caller-defined blob.
