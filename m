Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135766AbRDZRj7>; Thu, 26 Apr 2001 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135794AbRDZRjk>; Thu, 26 Apr 2001 13:39:40 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:36104 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S135799AbRDZRjf>; Thu, 26 Apr 2001 13:39:35 -0400
Date: Thu, 26 Apr 2001 11:33:03 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Feng Xian <fxian@fxian.jukie.net>, linux-kernel@vger.kernel.org,
        Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
Message-ID: <20010426113303.A16399@vger.timpanogas.org>
In-Reply-To: <20010426001539.A14115@vger.timpanogas.org> <Pine.LNX.4.30.0104261942160.16238-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0104261942160.16238-100000@fs131-224.f-secure.com>; from szaka@f-secure.com on Thu, Apr 26, 2001 at 08:00:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 08:00:12PM +0200, Szabolcs Szakacsits wrote:
> 
> On Thu, 26 Apr 2001, Jeff V. Merkey wrote:

The request should fail after two or three attempts rather than hang
the entire system waiting for memory.

Jeff

> 
> > I am seeing this as well on 2.4.3 with both _get_free_pages() and
> > kmalloc().  In the kmalloc case, the modules hang waiting
> > for memory.
> 
> One possible source of this hang is due to the change below in
> 2.4.3, non GPF_ATOMIC and non-recursive allocations (PF_MEMALLOC is set)
> will loop until the requested continuous memory is available.
> 
> 	Szaka
> 
> diff -u --recursive --new-file v2.4.2/linux/mm/page_alloc.c
> linux/mm/page_alloc.c--- v2.4.2/linux/mm/page_alloc.c        Sat Feb  3
> 19:51:32 2001
> +++ linux/mm/page_alloc.c       Tue Mar 20 15:05:46 2001
> @@ -455,8 +455,7 @@
>                         memory_pressure++;
>                         try_to_free_pages(gfp_mask);
>                         wakeup_bdflush(0);
> -                       if (!order)
> -                               goto try_again;
> +                       goto try_again;
>                 }
>         }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
