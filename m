Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319042AbSHMWJ1>; Tue, 13 Aug 2002 18:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319048AbSHMWJ1>; Tue, 13 Aug 2002 18:09:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15630 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319042AbSHMWJ0>; Tue, 13 Aug 2002 18:09:26 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Date: 13 Aug 2002 15:12:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajc095$hk1$1@cesium.transmeta.com>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>
By author:    Adrian Bunk <bunk@fs.tum.de>
In newsgroup: linux.dev.kernel
> >
> > Because the compiler sees:
> >
> > 	for (i = 0; i < N; i++)
> > 		;
> >
> > and it says "ah ha.  A busy wait delay loop" and leaves it alone.
> >
> > It's actually a special-case inside the compiler to not optimise
> > away such constructs.
> 
> Why is this a special case? As long as a compiler can't prove that the
> computed value of i isn't used later it mustn't optimize it away.
> 

Bullsh*t.  It can legitimately transform it into:

	   i = N;

> Kernighan/Ritchie (German translation of the second edition) contains the
> following example program that shows why the compiler mustn't optimize it
> away:
> 
> <--  snip  -->
> 
> #include <stdio.h>
> 
> main()
> {
>   double nc;
> 
>   for (nc = 0; getchar() != EOF; ++nc)
> 	;
>   printf("%.0f\n", nc);
> 
> }
> 

getchar() has side effects.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
