Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSFJVEJ>; Mon, 10 Jun 2002 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFJVEI>; Mon, 10 Jun 2002 17:04:08 -0400
Received: from [129.46.51.59] ([129.46.51.59]:18645 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316601AbSFJVDR>; Mon, 10 Jun 2002 17:03:17 -0400
Message-Id: <5.1.0.14.2.20020610135622.08f678d8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 14:01:24 -0700
To: Tom Rini <trini@kernel.crashing.org>,
        Thunder from the hill <thunder@ngforever.de>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020610200823.GN14252@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > wrt the __func__ thing: is it possible to do:
> > >
> > > #if (compiler version test)
> > > #define __FUNCTION__ __func__
> > > #endif
> > >
> > > to kill the 3.x warning?
> >
> > #include <stdio.h>
> > #define __FUNCTION__ __func__
> >
> > int main(int argc, char **argv) {
> >   int i;
> >
> >   for (i = 0; i < argc; i++) {
> >     printf(__FUNCTION__ " encountered argument ");
> >     printf("%s\n", argv[i]);
> >   }
> >
> >   exit(0);
> > }
> >
> > Obviously, yes.
>
>Nope.
>$ gcc-3.1 -Wall -o foo foo.c
>foo.c: In function `main':
>foo.c:8: parse error before string constant
>
>And line 8 is:
>printf(__FUNCTION__ " encountered argument ");

Well, those will brake. But in general it's possible. And I already do that 
in Bluetooth code (it's been converted recently).

So

#if __GNUC__ <= 2 && __GNUC_MINOR__ < 95
#define __func__ __FUNCTION__
#endif

does the trick. All gcc's newer than 2.95 support __func__.

Bluetooth code compiles just fine with everything from:
         ultrablue:/#sparc64-linux-gcc --version
         egcs-2.92.11
to
         champ:/usr/src/linux/include/net/bluetooth#gcc --version
         gcc (GCC) 3.1

Max

