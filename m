Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271644AbRHUMRe>; Tue, 21 Aug 2001 08:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRHUMRZ>; Tue, 21 Aug 2001 08:17:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39043 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271644AbRHUMRN>; Tue, 21 Aug 2001 08:17:13 -0400
Date: Tue, 21 Aug 2001 08:17:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: gonzales@dns1.austriaone.at
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 "rrunner.c" wont compile
In-Reply-To: <20010821114536Z268924-760+4176@vger.kernel.org>
Message-ID: <Pine.LNX.3.95.1010821080612.19279A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 gonzales@dns1.austriaone.at wrote:

> 
> hello list,
> 
> recently I tried to compile 2.4.9. however, allthough being a so-called
> "stable production release", it fails being compiled.
> 
>   :  gonzales:/usr/src/linux # make modules
>   :  [...]
>   :  make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE" MAKING_MODULES=1 modules
>   :  make[1]: Entering directory `/usr/src/linux/kernel'
>   :
>   :  gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rrunner.o rrunner.c
>   :  rrunner.c:1241: macro `min' used with only 2 args
>   :  rrunner.c:1252: macro `min' used with only 2 args
>   :  rrunner.c: In function `rr_dump':
>   :  rrunner.c:1241: parse error before `__x'
>   :  rrunner.c:1241: `__x' undeclared (first use in this function)
>   :  rrunner.c:1241: (Each undeclared identifier is reported only once
>   :  rrunner.c:1241: for each function it appears in.)
>   :  rrunner.c:1241: `__y' undeclared (first use in this function)
>   :  rrunner.c:1252: parse error before `__x'
>   :  rrunner.c:1221: warning: `len' might be used uninitialized in this function
>   :  make[2]: *** [rrunner.o] Error 1
>   :  make[2]: Leaving directory `/usr/src/linux/drivers/net'
>   :  make[1]: *** [_modsubdir_net] Error 2
>   :  make[1]: Leaving directory `/usr/src/linux/drivers'
>   :  make: *** [_mod_drivers] Error 2
> 
> I understand this not. what does "min used with only 2 args" mean?
> why would a comparison need more than 2 arguments?
> 
> sincerly,
> gonazeles

The min() macro got changed. You might want to #undef it and make
your own because this will be a political thing that won't go
away until Linus rules.

'min' is most often used to select a value that is the smaller
of a request length and a buffer length. A lot of software that
uses this function (macro) doesn't respect signed-ness or size.

This can cause problems. A universal solution doesn't exist because
an unsigned compare, which is most often what you want, isn't
mathematically correct and the comparison between an 'int' and
a 'long' is okay for some architectures and bogus for others.

Adding another parameter to a macro, which will ultimately be
used for a cast, is ugly. The casts, if necessary, should be
in the code.

So, I suggest you just define your own, which is correct for your
code.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


