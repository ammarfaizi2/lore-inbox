Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRLHJkP>; Sat, 8 Dec 2001 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282962AbRLHJjz>; Sat, 8 Dec 2001 04:39:55 -0500
Received: from d-dialin-2699.addcom.de ([213.61.81.59]:18670 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282957AbRLHJjw>; Sat, 8 Dec 2001 04:39:52 -0500
Date: Sat, 8 Dec 2001 10:39:47 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: <linux-kernel@vger.kernel.org>, <kkeil@suse.de>,
        <kai.germaschewski@gmx.de>, <marcelo@conectiva.com.br>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] for pre6: hisax user config MAX_CARD and fix potential
 data trashing
In-Reply-To: <20011208010157.1b6ff664.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0112081026010.1300-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Stephan von Krawczynski wrote:

> attached is the second patch for ISDN-Driver HiSax for kernel-inclusion that does the
> following:

Please send patches to the maintainers (i.e. Karsten/me) first, not 
directly to Linus/Marcelo. Also, CC'ing lkml isn't really necessary, 
either. (Documentation/SubmittingPatches is worth reading)

This makes the procedure take a bit longer, but things like missing 
semicolons get caught in the process ;-)

So let's drop Linus/Marcelo/lkml from CC. I'll submit the patch 
eventually. (If it's already applied, that's fine, too)

Generally the patch looks good (still wondering if you've got that many 
cards in one machine).

Some comments:

(original patch)

> +/* string magic */
> +#define h1(s) h2(s)
> +#define h2(s) #s
> +#define PARM_PARA "1-"h1(HISAX_MAX_CARDS)"i"
> +
you should use __MODULE_STRING (from linux/module.h)

> --- linux/drivers/isdn/hisax/hisax.h-orig	Sat Dec  8 00:24:20 2001
> +++ linux/drivers/isdn/hisax/hisax.h	Sat Dec  8 00:40:49 2001
> @@ -950,7 +950,9 @@
>  #define  MON0_TX	4
>  #define  MON1_TX	8
>  
> +#ifndef HISAX_MAX_CARDS
>  #define	 HISAX_MAX_CARDS	8
> +#endif
>  
>  #define  ISDN_CTYPE_16_0	1
>  #define  ISDN_CTYPE_8_0		2

Why is that necessary?

> @@ -1563,6 +1564,8 @@
>  		if (protocol[i]) {
>  			cards[i].protocol = protocol[i];
>  		}
> +		else
> +			cards[i].protocol = DEFAULT_PROTO;
>  	}
>  	cards[0].para[0] = pcm_irq;
>  	cards[0].para[1] = (int) pcm_iob;

nitpicking:

This should be
		} else
			cards[i]...

Actually, I'd prefer

		} else {
			cards[i]...
		}

I'll fix up these small bits, commit it to our CVS and take care of 
submitting the patch.

Thanks again for your work.

--Kai


