Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSFCDFO>; Sun, 2 Jun 2002 23:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSFCDFN>; Sun, 2 Jun 2002 23:05:13 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:16553 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317262AbSFCDFM>; Sun, 2 Jun 2002 23:05:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: forget_pte() 
In-Reply-To: Your message of "Sat, 01 Jun 2002 09:40:02 MST."
             <20020601164002.GC10243@holomorphy.com> 
Date: Mon, 03 Jun 2002 13:04:03 +1000
Message-Id: <E17Ei8Z-0003Mq-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020601164002.GC10243@holomorphy.com> you write:
> diff -Nru a/mm/memory.c b/mm/memory.c
> --- a/mm/memory.c	Sat Jun  1 09:35:40 2002
> +++ b/mm/memory.c	Sat Jun  1 09:35:40 2002
> @@ -309,15 +309,12 @@
>  }
>  
>  /*
> - * Return indicates whether a page was freed so caller can adjust rss
> + * bug check to be sure pte's are unmapped when no longer used
>   */
> -static inline void forget_pte(pte_t page)
> -{
> -	if (!pte_none(page)) {
> -		printk("forget_pte: old mapping existed!\n");
> -		BUG();
> -	}
> -}
> +#define forget_pte(pte)			\
> +	do {				\
> +		BUG_ON(!pte_none(pte));	\
> +	} while (0)

Hmm... it's only used in two places, and the name is entirely
misleading.  I think it might be neater to replace those two
occurances with:

	/* PTEs must be unmapped */
	BUG_ON(!pte_none(pte));

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
