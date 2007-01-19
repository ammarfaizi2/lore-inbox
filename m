Return-Path: <linux-kernel-owner+w=401wt.eu-S932639AbXASRZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbXASRZh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbXASRZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:25:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2711 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932684AbXASRZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:25:36 -0500
Date: Fri, 19 Jan 2007 18:25:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: [PATCH] Stop making "inline" imply forced inlining.
Message-ID: <20070119172542.GO9093@stusta.de>
References: <Pine.LNX.4.64.0701191156000.24621@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701191156000.24621@CPE00045a9c397f-CM001225dbafb6>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 11:56:30AM -0500, Robert P. J. Day wrote:
> 
>   Remove the macros that define simple "inlining" to mean forced
> inlining, since you can (and *should*) get that effect with the
> CONFIG_FORCED_INLINING kernel config variable instead.

NAK.

I don't see any place in the kernel where we need a non-forced inline.

We have tons of inline's in C files that should simply be removed - 
let's do this instead.

> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   this change was compile tested on x86 with "make allyesconfig",
> followed by turning off forced inlining.
> 
>   now the alpha folks can simplify their compiler.h file. :-)
> 
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 6e1c44a..5a90bd9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -23,9 +23,6 @@
>      (typeof(ptr)) (__ptr + (off)); })
> 
> 
> -#define inline		inline		__attribute__((always_inline))
> -#define __inline__	__inline__	__attribute__((always_inline))
> -#define __inline	__inline	__attribute__((always_inline))
>  #define __deprecated			__attribute__((deprecated))
>  #define  noinline			__attribute__((noinline))
>  #define __attribute_pure__		__attribute__((pure))

Oh, and your patch would have been broken for gcc < 4.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

