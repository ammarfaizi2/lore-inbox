Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272665AbRHaLH3>; Fri, 31 Aug 2001 07:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272666AbRHaLHV>; Fri, 31 Aug 2001 07:07:21 -0400
Received: from ns.ithnet.com ([217.64.64.10]:33033 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272665AbRHaLHQ>;
	Fri, 31 Aug 2001 07:07:16 -0400
Date: Fri, 31 Aug 2001 13:06:18 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010831130618.0d3b4b4c.skraw@ithnet.com>
In-Reply-To: <20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
	<20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 01:36:10 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> [...]
> Let's try another way of dealing with it.  What I'm trying to do with the
> patch below is leave a small reserve of 1/12 of pages->min, above the
> emergency reserve, to be consumed by non-PF_MEMALLOC atomic allocators.
> Please bear in mind this is completely untested, but would you try it
> please and see if the failure frequency goes down?
> 
> --- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> +++ ./mm/page_alloc.c	Wed Aug 29 23:47:39 2001
> @@ -493,6 +493,9 @@
>  		}
>  
>  		/* XXX: is pages_min/4 a good amount to reserve for this? */
> +		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
> +				!(current->flags & PF_MEMALLOC))
> +			continue;
>  		if (z->free_pages < z->pages_min / 4 &&
>  				!(current->flags & PF_MEMALLOC))
>  			continue;
> 

Hello Daniel,

I tried this patch and it makes _no_ difference. Failures show up in same situation and amount. Do you need traces? They look the same

Regards,
Stephan
