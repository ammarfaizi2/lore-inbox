Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLVHtG>; Sun, 22 Dec 2002 02:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSLVHtG>; Sun, 22 Dec 2002 02:49:06 -0500
Received: from egil.codesourcery.com ([66.92.14.122]:37253 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S264853AbSLVHtG>; Sun, 22 Dec 2002 02:49:06 -0500
To: linux-kernel@vger.kernel.org
In-Reply-To: <200212212244.gBLMixLR002262@darkstar.example.net>
References: <200212212244.gBLMixLR002262@darkstar.example.net> <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com>
Subject: Re: Kernel GCC Optimizations
From: Zack Weinberg <zack@codesourcery.com>
Date: Sat, 21 Dec 2002 23:57:12 -0800
Message-ID: <87k7i2wko7.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So, let's make it -O6 per default for 2.7.x/3.1.x?
>
> A higher -O setting does not necessarily mean better performance -
> loop unrolling is one compiler optimisation that I *think* is
> performed by GCC at high -O settings, and that *often* causes code to
> be slower.

In all official releases of GCC, -Ox, x >= 4, has exactly the same
effect as -O3.  This is unlikely to change anytime soon.

-O3 enables exactly two optimizations relative to -O2:
-finline-functions and -frename-registers.  This may or may not change
in the future.  It does *not* enable loop unrolling. -finline-functions
is almost always a major performance loss, because it makes the code
huge and blows out the I-cache.  I'm not familiar with the performance
effects of -frename-registers; it might be worth experimenting with
just that switch.

zw
