Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274790AbRIUT0Y>; Fri, 21 Sep 2001 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274791AbRIUT0O>; Fri, 21 Sep 2001 15:26:14 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:53773 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274790AbRIUT0B>; Fri, 21 Sep 2001 15:26:01 -0400
Date: Fri, 21 Sep 2001 15:26:26 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 vsnprintf fix.
Message-ID: <20010921152626.A8188@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15k20v-00008w-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15k20v-00008w-00@wagner>; from rusty@rustcorp.com.au on Thu, Sep 20, 2001 at 09:29:05PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 20/09/01 21:29 +1000 - Rusty Russell:
> Following patch fixes calling vsnprintf with (NULL, 0) to get the
> length of the string.  The problem is that the end ptr is set to
> 0xFFFFFFFF in this case, causing a write into address 0 as start <
> end.

Doh! Egg on face. Between this and the sysrq bugs, I'm thinking of going
into dance instead of hacking anymore. Sorry about this, it is a basic
mistake (right up there with going up against a scicilian when death is
on the line.)

> 
> Cheers,
> Rusty. 
> --
> Premature optmztion is rt of all evl. --DK
> 
> --- working-pmac-module/lib/vsprintf.c.~1~	Mon Sep 17 08:53:56 2001
> +++ working-pmac-module/lib/vsprintf.c	Thu Sep 20 21:26:05 2001
> @@ -246,6 +246,8 @@
>  				/* 'z' support added 23/7/1999 S.H.    */
>  				/* 'z' changed to 'Z' --davidm 1/25/99 */
>  
> +	/* buf = NULL, size = 0 is common for getting length */
> +	if (size == 0) buf = (void *)1;
>  	str = buf;
>  	end = buf + size - 1;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
