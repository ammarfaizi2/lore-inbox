Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSFJVMW>; Mon, 10 Jun 2002 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSFJVMV>; Mon, 10 Jun 2002 17:12:21 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38096
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316217AbSFJVMS>; Mon, 10 Jun 2002 17:12:18 -0400
Date: Mon, 10 Jun 2002 14:11:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610211152.GQ14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm> <3D050350.A7011AE4@zip.com.au> <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm> <5.1.0.14.2.20020610135622.08f678d8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:01:24PM -0700, Maksim (Max) Krasnyanskiy wrote:
> 
> >> > wrt the __func__ thing: is it possible to do:
> >> >
> >> > #if (compiler version test)
> >> > #define __FUNCTION__ __func__
> >> > #endif
> >> >
> >> > to kill the 3.x warning?
> >>
> >> #include <stdio.h>
> >> #define __FUNCTION__ __func__
> >>
> >> int main(int argc, char **argv) {
> >>   int i;
> >>
> >>   for (i = 0; i < argc; i++) {
> >>     printf(__FUNCTION__ " encountered argument ");
> >>     printf("%s\n", argv[i]);
> >>   }
> >>
> >>   exit(0);
> >> }
> >>
> >> Obviously, yes.
> >
> >Nope.
> >$ gcc-3.1 -Wall -o foo foo.c
> >foo.c: In function `main':
> >foo.c:8: parse error before string constant
> >
> >And line 8 is:
> >printf(__FUNCTION__ " encountered argument ");
> 
> Well, those will brake. But in general it's possible. And I already do that 
> in Bluetooth code (it's been converted recently).
> 
> So
> 
> #if __GNUC__ <= 2 && __GNUC_MINOR__ < 95
> #define __func__ __FUNCTION__
> #endif
> 
> does the trick. All gcc's newer than 2.95 support __func__.

Right.  Maybe it should even go in <linux/compiler.h> if it's not
already there.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
