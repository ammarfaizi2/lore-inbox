Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271802AbRHWKEz>; Thu, 23 Aug 2001 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271944AbRHWKEp>; Thu, 23 Aug 2001 06:04:45 -0400
Received: from mail.spylog.com ([194.67.35.220]:4267 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S271802AbRHWKEf>;
	Thu, 23 Aug 2001 06:04:35 -0400
Date: Thu, 23 Aug 2001 14:04:44 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 problem
Message-ID: <20010823140444.A14798@spylog.ru>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be> <20010819205452Z16128-32383+429@humbolt.nl.linux.org> <20010820011356.A6667@spylog.ru> <20010820211403Z16263-32383+585@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20010820211403Z16263-32383+585@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel Phillips,

> > I am have problem with "kernel: __alloc_pages: 0-order allocation failed."
> 
> Could you please try it with this patch, which will tell us a little more 
> about what's happening (patch -p0):
> 
> --- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> +++ ./mm/page_alloc.c	Mon Aug 20 22:05:40 2001
> @@ -502,7 +502,7 @@
>  	}
>  
>  	/* No luck.. */
> -	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
> +	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n", order, gfp_mask, !!(current->flags & PF_MEMALLOC));
>  	return NULL;
>  }

I applied patch, this is result:

...
Aug 23 14:00:29 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 23 14:00:29 sol last message repeated 12 times
Aug 23 14:00:29 sol kernel: cation failed (gfp=0x30/1).
Aug 23 14:00:29 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 23 14:00:53 sol last message repeated 334 times
Aug 23 14:00:53 sol kernel: cation failed (gfp=0x30/1).
Aug 23 14:00:53 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 23 14:00:55 sol last message repeated 300 times
Aug 23 14:00:55 sol kernel: cation failed (gfp=0x30/1).
Aug 23 14:00:55 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Aug 23 14:00:55 sol last message repeated 281 times
...


Hm. That is it?

-- 
bye.
Andrey Nekrasov, SpyLOG.
