Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSHMVib>; Tue, 13 Aug 2002 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSHMVib>; Tue, 13 Aug 2002 17:38:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2276 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317742AbSHMVia>; Tue, 13 Aug 2002 17:38:30 -0400
Date: Tue, 13 Aug 2002 23:42:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
In-Reply-To: <3D56B13A.D3F741D1@zip.com.au>
Message-ID: <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Andrew Morton wrote:

> Alan Cox wrote:
> >
> > On Sun, 2002-08-11 at 08:38, Andrew Morton wrote:
> > > This information loss is unfortunate.  Examples:
> > >
> > >       for (i = 0; i < N; i++)
> > >               prefetch(foo[i]);
> > >
> > >    Problem is, if `prefetch' is a no-op, the compiler will still
> > >    generate an empty busy-wait loop.  Which it must do.
> >
> > Why - nothing there is volatile
>
> Because the compiler sees:
>
> 	for (i = 0; i < N; i++)
> 		;
>
> and it says "ah ha.  A busy wait delay loop" and leaves it alone.
>
> It's actually a special-case inside the compiler to not optimise
> away such constructs.

Why is this a special case? As long as a compiler can't prove that the
computed value of i isn't used later it mustn't optimize it away.

Kernighan/Ritchie (German translation of the second edition) contains the
following example program that shows why the compiler mustn't optimize it
away:

<--  snip  -->

#include <stdio.h>

main()
{
  double nc;

  for (nc = 0; getchar() != EOF; ++nc)
	;
  printf("%.0f\n", nc);

}

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



