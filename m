Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSDTXOG>; Sat, 20 Apr 2002 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313205AbSDTXOF>; Sat, 20 Apr 2002 19:14:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17931 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313190AbSDTXOE>; Sat, 20 Apr 2002 19:14:04 -0400
Date: Sat, 20 Apr 2002 16:13:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <20020420214114.A11894@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0204201611320.3643-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andi Kleen wrote:

> > Besides, I seriously doubt it is any faster than what is there already.
> >
> > Time it, and notice how:
> >
> >  - fninit takes about 200 cycles
> >  - fxrstor takes about 215 cycles
>
> On what CPU?

Sorry, should have mentioned. That's a P4.

> I checked the Athlon4 optimization manual and fxrstor is listed as 68/108
> cycles (i guess depending on whether there is XMM state or not so 68 cycles
> probably apply here) and fninit as 91 cycles. It doesn't list the SSE1
> timings, but i guess the instructions don't take more than 3 cycles
> (MMX instructions take that long). So Andrea's way should be
> 91+16*3=139+some cycles for emms (or 107 if sse ops take only a single cycle)
> vs 68 or 108.  So the fxrstor wins well.

The athlon should be able to do two MMX / cycle (the throughput is much
lower, but there are no data dependencies here).

> > In short, your "fast" code isn't actually any faster than doing it right.
>
> At least on Athlon it should be slower.

I suspect that the real answer is "the speed difference is _way_ in the
noise".

		Linus

