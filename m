Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSJJDbq>; Wed, 9 Oct 2002 23:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJJDbq>; Wed, 9 Oct 2002 23:31:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26109 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263188AbSJJDbp>;
	Wed, 9 Oct 2002 23:31:45 -0400
Message-ID: <3DA4F5DD.8D4587B6@mvista.com>
Date: Wed, 09 Oct 2002 20:37:01 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix __SI_CODE
References: <20021010123822.64c9bbc1.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi Linus,
> 
> This small patch is extracted from George Anzinger's High-res-timer
> patches.  Even if George's patches do not go in, this patch is necessary
> to fix up something I missed when I consolidated the siginfo stuff.

Yeah, that has been there for a long time.  The fix to
nano_sleep should also go in.  I am sure there are others...

You might try this on a 2.5.4x system:

time sleep 60

Now remember the standard says NO timer should finish
early.  On most boxes this will sleep less than 60 seconds.

Bad Bad timer :)

-g
> 
> Thanks, George.
> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> diff -ruN 2.5.41-1.715/include/asm-generic/siginfo.h 2.5.41-1.715-si.2/include/asm-generic/siginfo.h
> --- 2.5.41-1.715/include/asm-generic/siginfo.h  2002-06-09 16:12:33.000000000 +1000
> +++ 2.5.41-1.715-si.2/include/asm-generic/siginfo.h     2002-10-10 12:26:46.000000000 +1000
> @@ -91,7 +91,7 @@
>  #define __SI_FAULT     (3 << 16)
>  #define __SI_CHLD      (4 << 16)
>  #define __SI_RT                (5 << 16)
> -#define __SI_CODE(T,N) ((T) << 16 | ((N) & 0xffff))
> +#define __SI_CODE(T,N) ((T) | ((N) & 0xffff))
>  #else
>  #define __SI_KILL      0
>  #define __SI_TIMER     0
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
