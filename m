Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311611AbSCTNx3>; Wed, 20 Mar 2002 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSCTNxN>; Wed, 20 Mar 2002 08:53:13 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13329 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311621AbSCTNus>;
	Wed, 20 Mar 2002 08:50:48 -0500
Date: Wed, 20 Mar 2002 10:50:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-200-active_page_swapout
In-Reply-To: <3C980A11.AD5A7660@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203201048590.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

> Don't bother checking for active pages in the swapout path.
>
> Not sure about this one.  Clearly the page isn't *likely* to be on the
> active list, because the caller found it on the inactive list.

Mmmm nope.

The caller of swap_out (shrink_caches) may have been scanning the
inactive list, but swap_out itself scans the page tables.

This means it can encounter all kinds of pages, active, inactive
and even reserved pages.

> --- 2.4.19-pre3/mm/vmscan.c~aa-200-active_page_swapout	Tue Mar 19 19:49:04 2002
> +++ 2.4.19-pre3-akpm/mm/vmscan.c	Tue Mar 19 19:49:04 2002
> @@ -83,10 +83,6 @@ static inline int try_to_swap_out(struct
>  		return 0;
>  	}
>
> -	/* Don't bother unmapping pages that are active */
> -	if (PageActive(page))
> -		return 0;
> -
>  	/* Don't bother replenishing zones not under pressure.. */
>  	if (!memclass(page_zone(page), classzone))
>  		return 0;
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

