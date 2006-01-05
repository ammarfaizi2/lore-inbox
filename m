Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWAEOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWAEOme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAEOmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:42:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34807 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751375AbWAEOl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:41:58 -0500
Subject: Re: 2.6.15-rc5-rt4 and CONFIG_SLAB=y : structure has no member
	named `nodeid'
From: Daniel Walker <dwalker@mvista.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200601051112.10762.Serge.Noiraud@bull.net>
References: <200512211045.58763.Serge.Noiraud@bull.net>
	 <200601051112.10762.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 05 Jan 2006 06:41:56 -0800
Message-Id: <1136472116.31011.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like nodeid might just be equal to the cpu now. 

You could try turning off CONFIG_DEBUG_SLAB as a temporary solution. It
looks like the DEBUG define depends on that config option .

Daniel

On Thu, 2006-01-05 at 11:12 +0100, Serge Noiraud wrote:
> mercredi 21 Décembre 2005 10:45, Serge Noiraud wrote/a écrit :
> > Hi,
> > 
> > 	testing on i386, I get the following error :
> > ...
> >   CC      mm/slab.o
> > mm/slab.c: In function `cache_alloc_refill':
> > mm/slab.c:2093: error: structure has no member named `nodeid'
> > mm/slab.c: In function `free_block':
> > mm/slab.c:2239: error: structure has no member named `nodeid'
> > mm/slab.c:2239: error: `node' undeclared (first use in this function)
> > mm/slab.c:2239: error: (Each undeclared identifier is reported only once
> > mm/slab.c:2239: error: for each function it appears in.)
> > make[4]: *** [mm/slab.o] Erreur 1
> > ...
> > 
> > You removed nodeid in the slab struct, but many functions use it.
> > 
> I get the same problem with 2.6.15-rt1
> The following patch suppress the error : I'm not sure it's the good correction.
> perhaps we should supress this DEBUG test ?
> 
> --- linux.orig/mm/slab.c
> +++ linux/mm/slab.c
> @@ -2090,7 +2090,6 @@
>             next = slab_bufctl(slabp)[slabp->free];
>  #if DEBUG
>             slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
> -           WARN_ON(numa_node_id() != slabp->nodeid);
>  #endif
>                 slabp->free = next;
>         }
>         check_slabp(cachep, slabp);
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

