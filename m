Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSFFWHG>; Thu, 6 Jun 2002 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317193AbSFFWHF>; Thu, 6 Jun 2002 18:07:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:58016 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317002AbSFFWHE>;
	Thu, 6 Jun 2002 18:07:04 -0400
Date: Thu, 6 Jun 2002 23:48:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove suser()
Message-ID: <20020606214840.GA1190@elf.ucw.cz>
In-Reply-To: <1023225311.3904.142.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached patch replaces the lone remaining suser() call with capable()
> and then removes suser() itself in a triumphant celebration of the glory
> of capable().  Or something. ;-)
> 
> Small cleanup of capable() and some comments, too.
> 
> Patch is against 2.5.20, please apply.
> 
> 	Robert Love
> 
> diff -urN linux-2.5.20/drivers/net/wan/pc300_drv.c linux/drivers/net/wan/pc300_drv.c
> --- linux-2.5.20/drivers/net/wan/pc300_drv.c	Sun Jun  2 18:44:53 2002
> +++ linux/drivers/net/wan/pc300_drv.c	Tue Jun  4 13:56:54 2002
> @@ -2564,7 +2564,7 @@
>  				return -EINVAL;
>  			return 0;
>  		case SIOCSPC300CONF:
> -			if (!suser())
> +			if (!capable(CAP_NET_ADMIN))
>  				return -EPERM;
>  			if (!arg || 
>  				copy_from_user(&conf_aux.conf, arg, sizeof(pc300chconf_t)))
> diff -urN linux-2.5.20/include/linux/compatmac.h linux/include/linux/compatmac.h
> --- linux-2.5.20/include/linux/compatmac.h	Sun Jun  2 18:44:41 2002
> +++ linux/include/linux/compatmac.h	Tue Jun  4 13:57:33 2002
> @@ -102,8 +102,6 @@
>  
>  #define my_iounmap(x, b)             (((long)x<0x100000)?0:vfree ((void*)x))
>  
> -#define capable(x)                   suser()
> -
>  #define tty_flip_buffer_push(tty)    queue_task(&tty->flip.tqueue, &tq_timer)

This is not right I believe. You want to keep compatibility for older
kernels.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
