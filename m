Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSE3T6S>; Thu, 30 May 2002 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSE3T6R>; Thu, 30 May 2002 15:58:17 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58894 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316853AbSE3T6Q>; Thu, 30 May 2002 15:58:16 -0400
Message-ID: <3CF68446.644850F8@linux-m68k.org>
Date: Thu, 30 May 2002 21:57:58 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: missing bit from signal patches
In-Reply-To: <20020530220828.3c3192cd.sfr@canb.auug.org.au>
		<Pine.LNX.4.21.0205301442410.17583-100000@serv> <20020530232636.09d7b7eb.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Rothwell wrote:

> Try this ...

This almost works. :)

> diff -ruN 2.5.19/include/asm-m68k/siginfo.h 2.5.19-si.4/include/asm-m68k/siginfo.h
> --- 2.5.19/include/asm-m68k/siginfo.h   Thu May 30 09:44:38 2002
> +++ 2.5.19-si.4/include/asm-m68k/siginfo.h      Thu May 30 23:17:10 2002
> @@ -2,6 +2,7 @@
>  #define _M68K_SIGINFO_H
> 
>  #define HAVE_ARCH_SIGINFO_T
> +#define HAVE_ARCH_COPY_SIGINFO
> 
>  #include <asm-generic/siginfo.h>
> 
> @@ -68,6 +69,18 @@
>  #define si_uid16       _sifields._kill._uid
>  #else
>  #define si_uid         _sifields._kill._uid
> +
> +#include <linux/string.h>
> +
> +static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
> +{
> +       if (from->si_code < 0)
> +               memcpy(to, from, sizeof(*to));
> +       else
> +               /* _sigchld is currently the largest know union member */
> +               memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
> +}
> +
>  #endif /* __KERNEL__ */
> 
>  #endif

The function is in the #else part of #ifdef __KERNEL__.

bye, Roman
