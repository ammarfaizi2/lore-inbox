Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278839AbRKDVIT>; Sun, 4 Nov 2001 16:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278841AbRKDVII>; Sun, 4 Nov 2001 16:08:08 -0500
Received: from lilly.ping.de ([62.72.90.2]:34564 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S278839AbRKDVHz>;
	Sun, 4 Nov 2001 16:07:55 -0500
Date: 4 Nov 2001 22:06:41 +0100
Message-ID: <20011104220641.A788@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <20011104192725.A847@planetzork.spacenet> <Pine.LNX.4.33.0111041047230.6919-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0111041047230.6919-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 04, 2001 at 10:53:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 10:53:43AM -0800, Linus Torvalds wrote:

Hello,

with the complete patch (s.b.) the kernel did kill processes while running
make -j100. So I tried only the second part of the patch (the SetPage-part)
and here are the results (this time only the make -j100 part:

2.4.14-pre8vmscan2:   6:12.06
2.4.14-pre8vmscan2:   6:41.43
2.4.14-pre8vmscan2:   6:53.22
2.4.14-pre8vmscan2:   7:12.03
2.4.14-pre8vmscan2:   5:49.82

I will run the whole test tonight and I will keep you posted. If you
want me to try a different patch, just let me know.

> (The first chunk just says that we _can_ unmap active pages: it's up to
> refill_inactive to perhaps de-activate them and free them on demand. The
> second chunk says that when refill_inactive() moves a page to the inactive
> list, it's already been "touched once", so another access will activate it
> again).
> 
> 		Linus
> 
> ----
> diff -u --recursive pre8/linux/mm/vmscan.c linux/mm/vmscan.c
> --- pre8/linux/mm/vmscan.c	Sun Nov  4 09:41:04 2001
> +++ linux/mm/vmscan.c	Sun Nov  4 10:41:59 2001
> @@ -54,9 +54,11 @@
>  		return 0;
>  	}
> 
> +#if 0
>  	/* Don't bother unmapping pages that are active */
>  	if (PageActive(page))
>  		return 0;
> +#endif
> 
>  	/* Don't bother replenishing zones not under pressure.. */
>  	if (!memclass(page->zone, classzone))
> @@ -541,6 +543,7 @@
> 
>  		del_page_from_active_list(page);
>  		add_page_to_inactive_list(page);
> +		SetPageReferenced(page);
>  	}
>  	spin_unlock(&pagemap_lru_lock);
>  }
> 

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
