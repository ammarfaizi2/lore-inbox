Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSHOXLl>; Thu, 15 Aug 2002 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSHOXLl>; Thu, 15 Aug 2002 19:11:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31580 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S317661AbSHOXLl>; Thu, 15 Aug 2002 19:11:41 -0400
Date: Fri, 16 Aug 2002 00:16:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Gilad Ben-Yossef <gilad@benyossef.com>
cc: Marcelo <marcelo@conectiva.com.br>,
       The Usual Suspects <linux-kernel@vger.kernel.org>,
       Patch Trivia <trivial@rustcorp.com.au>
Subject: Re: [PATCH] Add PAGE_CACHE_PAGES
In-Reply-To: <1029443580.2508.18.camel@gby.benyossef.com>
Message-ID: <Pine.LNX.4.44.0208152359360.1161-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 2002, Gilad Ben-Yossef wrote:
> 
> Thus spake mm/shmem.c:
> 
>   idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
>   idx += vma->vm_pgoff;
> 
> But include/linux/mm.h says:
> 
> unsigned long vm_pgoff;         /* Offset (within vm_file) in PAGE_SIZE
>                                    units, *not* PAGE_CACHE_SIZE */

Good observation, but it's certainly not something for Marcelo to worry
about for 2.4.  This is only one of many confusions which would need to
be fixed to get PAGE_CACHE_SIZE > PAGE_SIZE working.  mm/shmem.c
is probably especially confused (since it's backing a PAGE_CACHE_SIZE-
orientated filesystem with PAGE_SIZE-orientated swap), but much else too.

I think it was a mistake to introduce the PAGE_CACHE_SIZE definition
before it could be allowed to diverge from PAGE_SIZE: I find it very
hard to work out the right way to go, and would prefer it to vanish. 
But Ben LaHaise did succeed in getting a PAGE_CACHE_SIZE > PAGE_SIZE
patch working on 2.4.6 (no patch to mm/shmem.c, but it was a little
different then anyway, right or wrong I don't know).

Hugh

