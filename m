Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310595AbSCGXaV>; Thu, 7 Mar 2002 18:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310594AbSCGXaM>; Thu, 7 Mar 2002 18:30:12 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:23284 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310595AbSCGXaA>;
	Thu, 7 Mar 2002 18:30:00 -0500
Date: Thu, 7 Mar 2002 15:28:06 -0800
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [PATCH] make irtty.c compile again
Message-ID: <20020307152806.A3481@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020307211527.GA7597@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020307211527.GA7597@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Thu, Mar 07, 2002 at 10:15:27PM +0100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 10:15:27PM +0100, Anders Gustafsson wrote:
> Hi,
> 
> irtty.c includes irqueue.h which includes linux/cache.h (via
> asm/processor.h <- asm/thread_info.h <- linux/thread_info.h <-
> linux/spinlock.h)
> 
> both irqueue.h and cache.h defines a ALIGN (for different
> purposes). 
> 
> This patch renames ALIGN in irqueue.h to IRDA_ALIGN.
> 
> Guess i'll go grepping for more places ALIGN might be defined.
> 
> -- 
> 
> //anders/g

	Wow ! As soon as I make an update of IrDA, "they" manage to
break it. It didn't take long ;-)
	Thanks for the hint. Your patch is obviously correct. Either
you send it directly to Linus, or I'll do it later with other updates.

	Jean

> --- linux-2.5.6-pre3/include/net/irda/irda.h	Thu Mar  7 19:13:01 2002
> +++ linux-2.5.6-pre3-mekk/include/net/irda/irda.h	Thu Mar  7 21:24:18 2002
> @@ -54,8 +54,8 @@
>  #define IRDA_MIN(a, b) (((a) < (b)) ? (a) : (b))
>  #endif
>  
> -#ifndef ALIGN
> -#  define ALIGN __attribute__((aligned))
> +#ifndef IRDA_ALIGN
> +#  define IRDA_ALIGN __attribute__((aligned))
>  #endif
>  #ifndef PACK
>  #  define PACK __attribute__((packed))
> diff -ru linux-2.5.6-pre3/include/net/irda/irqueue.h linux-2.5.6-pre3-mekk/include/net/irda/irqueue.h
> --- linux-2.5.6-pre3/include/net/irda/irqueue.h	Thu Mar  7 19:39:58 2002
> +++ linux-2.5.6-pre3-mekk/include/net/irda/irqueue.h	Thu Mar  7 21:24:18 2002
> @@ -49,8 +49,8 @@
>  #define HASHBIN_SIZE   8
>  #define HASHBIN_MASK   0x7
>  
> -#ifndef ALIGN 
> -#define ALIGN __attribute__((aligned))
> +#ifndef IRDA_ALIGN 
> +#define IRDA_ALIGN __attribute__((aligned))
>  #endif
>  
>  #define Q_NULL { NULL, NULL, "", 0 }
> @@ -75,8 +75,8 @@
>  	__u32      magic;
>  	int        hb_type;
>  	int        hb_size;
> -	spinlock_t hb_mutex[HASHBIN_SIZE] ALIGN;
> -	irda_queue_t   *hb_queue[HASHBIN_SIZE] ALIGN;
> +	spinlock_t hb_mutex[HASHBIN_SIZE] IRDA_ALIGN;
> +	irda_queue_t   *hb_queue[HASHBIN_SIZE] IRDA_ALIGN;
>  
>  	irda_queue_t* hb_current;
>  } hashbin_t;
