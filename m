Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269719AbRHCX7f>; Fri, 3 Aug 2001 19:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269720AbRHCX7Z>; Fri, 3 Aug 2001 19:59:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33291 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269719AbRHCX7W>; Fri, 3 Aug 2001 19:59:22 -0400
Date: Fri, 3 Aug 2001 19:29:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeremy Linton <jlinton@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Free memory starvation in a zone?
In-Reply-To: <01fa01c11c41$51462cd0$bef7020a@mammon>
Message-ID: <Pine.LNX.4.21.0108031923390.8951-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Jeremy Linton wrote:

> In kreclaimd() there is a nice loop that looks like
> 
>  for(i = 0; i < MAX_NR_ZONES; i++) {
>     zone_t *zone = pgdat->node_zones + i;
>     if (!zone->size)
>         continue;
> 
>     while (zone->free_pages < zone->pages_low) {
>         struct page * page;
>         page = reclaim_page(zone);
>         if (!page)
>             break;
>         __free_page(page);
>     }
> }
> 
> I was playing around with the page age algorithm when i noticed that it
> appears that the machine will get into a state where the inner loop _NEVER_
> exits the current zone because applications running in that zone are eating
> the memory as fast as it is being freed up.

Normal allocations are going to block giving a chance for kreclaimd to run
(and remember, the loop and the freeing routines are really fast).

Are you sure you're seeing kreclaimd looping too much here ?

I've never seen that, and if I did I would get really really
concerned: we rely on kreclaimd to avoid atomic allocations from failing
in a fragile way. 

