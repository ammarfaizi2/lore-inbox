Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136805AbREISPM>; Wed, 9 May 2001 14:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136806AbREISPB>; Wed, 9 May 2001 14:15:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17668 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136805AbREISOx>; Wed, 9 May 2001 14:14:53 -0400
Date: Wed, 9 May 2001 13:36:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mark Hemment <markhe@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
In-Reply-To: <Pine.LNX.4.21.0105090957420.31900-100000@alloc>
Message-ID: <Pine.LNX.4.21.0105091334540.13878-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 May 2001, Mark Hemment wrote:

> 
> On Tue, 8 May 2001, David S. Miller wrote: 
> > Actually, the change was made because it is illogical to try only
> > once on multi-order pages.  Especially because we depend upon order
> > 1 pages so much (every task struct allocated).  We depend upon them
> > even more so on sparc64 (certain kinds of page tables need to be
> > allocated as 1 order pages).
> > 
> > The old code failed _far_ too easily, it was unacceptable.
> > 
> > Why put some strange limit in there?  Whatever number you pick
> > is arbitrary, and I can probably piece together an allocation
> > state where the choosen limit is too small.
> 
>   Agreed, but some allocations of non-zero orders can fall back to other
> schemes (such as an emergency buffer, or using vmalloc for a temp
> buffer) and don't want to be trapped in __alloc_pages() for too long.
> 
>   Could introduce another allocation flag (__GFP_FAIL?) which is or'ed
> with a __GFP_WAIT to limit the looping?

__GFP_FAIL is in the -ac tree already and it is being used by the bounce
buffer allocation code. 



