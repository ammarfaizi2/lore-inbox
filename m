Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319292AbSHNUrT>; Wed, 14 Aug 2002 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319302AbSHNUqo>; Wed, 14 Aug 2002 16:46:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9994 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S319297AbSHNUmO>;
	Wed, 14 Aug 2002 16:42:14 -0400
Date: Wed, 14 Aug 2002 22:45:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020814204556.GA7440@alpha.home.local>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5AB250.3070104@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 12:41:04PM -0700, H. Peter Anvin wrote:
> Rogier Wolff wrote:
> >>
> >>Bullsh*t.  It can legitimately transform it into:
> >>
> >>	   i = N;
> >
> >
> >Right! But people are confusing "practise", "published interface", and 
> >"spec" again. 
> >
> >Published interface in this case is that gcc will not optimize an empty
> >loop away, as it is often used to generate a timing loop. 
> >
> 
> Yes.  This is a gcc-specific wart, a bad idea from the start, and 
> apparently one which has caught up with them to the point that they've 
> had to abandon it.

There would be a solution to tell gcc not to optimize things, which may
not require too much work from gcc people. Basically, we would need to
implement a __builtin_nop() function that would respect dependencies but
not generate any code. This way, we could have :

	for (i=0; i<N, i++);

optimized as i=N
and
	for (i=0; i<N; i++)
		__builtin_nop();
or even
	for (i=0; i<N; __builtin_nop(i++));
do the real work.

This way, some loops could be optimized, and the developpers could explicitely
tell the compiler when they need to prevent any optimization.

Cheers,
Willy

