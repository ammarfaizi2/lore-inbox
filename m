Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVDFUHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVDFUHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVDFUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:07:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34759 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262295AbVDFUG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:06:59 -0400
Message-ID: <4254414E.9010507@pobox.com>
Date: Wed, 06 Apr 2005 16:06:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] DocBook: changes and extensions to the kernel documentation
References: <20050406114610.287064000@faui31y> <20050406114653.064745000@faui31y>
In-Reply-To: <20050406114653.064745000@faui31y>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> --- linux-docbook.orig/drivers/video/fbmem.c	2005-04-06 12:13:12.674832161 +0200
> +++ linux-docbook/drivers/video/fbmem.c	2005-04-06 12:24:11.946113964 +0200
> @@ -1257,6 +1257,8 @@ int fb_new_modelist(struct fb_info *info
>  static char *video_options[FB_MAX];
>  static int ofonly;
>  
> +extern const char *global_mode_option;
> +
>  /**
>   * fb_get_options - get kernel boot parameters
>   * @name:   framebuffer name as it would appear in
> @@ -1297,9 +1299,6 @@ int fb_get_options(char *name, char **op
>  	return retval;
>  }
>  
> -
> -extern const char *global_mode_option;
> -
>  /**
>   *	video_setup - process command line options
>   *	@options: string of options
> Index: linux-docbook/include/linux/skbuff.h
> ===================================================================
> --- linux-docbook.orig/include/linux/skbuff.h	2005-04-06 12:13:12.677831708 +0200
> +++ linux-docbook/include/linux/skbuff.h	2005-04-06 12:24:11.954112753 +0200
> @@ -974,6 +974,7 @@ static inline void __skb_queue_purge(str
>  		kfree_skb(skb);
>  }
>  
> +#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
>  /**
>   *	__dev_alloc_skb - allocate an skbuff for sending
>   *	@length: length to allocate
> @@ -986,7 +987,6 @@ static inline void __skb_queue_purge(str
>   *
>   *	%NULL is returned in there is no free memory.
>   */
> -#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
>  static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
>  					      int gfp_mask)
>  {
> Index: linux-docbook/mm/vmalloc.c
> ===================================================================
> --- linux-docbook.orig/mm/vmalloc.c	2005-04-06 12:13:12.680831254 +0200
> +++ linux-docbook/mm/vmalloc.c	2005-04-06 12:24:11.963111391 +0200
> @@ -475,6 +475,10 @@ void *vmalloc(unsigned long size)
>  
>  EXPORT_SYMBOL(vmalloc);
>  
> +#ifndef PAGE_KERNEL_EXEC
> +# define PAGE_KERNEL_EXEC PAGE_KERNEL
> +#endif
> +
>  /**
>   *	vmalloc_exec  -  allocate virtually contiguous, executable memory
>   *
> @@ -488,10 +492,6 @@ EXPORT_SYMBOL(vmalloc);
>   *	use __vmalloc() instead.
>   */
>  
> -#ifndef PAGE_KERNEL_EXEC
> -# define PAGE_KERNEL_EXEC PAGE_KERNEL
> -#endif
> -
>  void *vmalloc_exec(unsigned long size)
>  {
>  	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC);


Although these patches do nothing but move code above a comment block, 
they make me worry/grumble, because the author clearly preferred the 
original code layout.

I'm -not- going to NAK this changeset, since it's not my code, but just 
pointing this out.  It would be nice if kernel-doc could grok this sort 
of stuff, but I understand why it can't (without parsing c/cpp).

ACK for the other changesets in your series.

	Jeff


