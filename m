Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312899AbSDTTlR>; Sat, 20 Apr 2002 15:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312987AbSDTTlQ>; Sat, 20 Apr 2002 15:41:16 -0400
Received: from ns.suse.de ([213.95.15.193]:16399 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312899AbSDTTlQ>;
	Sat, 20 Apr 2002 15:41:16 -0400
Date: Sat, 20 Apr 2002 21:41:14 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@suse.de,
        linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420214114.A11894@wotan.suse.de>
In-Reply-To: <20020420201205.M1291@dualathlon.random> <Pine.LNX.4.33.0204201221120.11732-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Besides, I seriously doubt it is any faster than what is there already.
> 
> Time it, and notice how:
> 
>  - fninit takes about 200 cycles
>  - fxrstor takes about 215 cycles

On what CPU? 

I checked the Athlon4 optimization manual and fxrstor is listed as 68/108
cycles (i guess depending on whether there is XMM state or not so 68 cycles
probably apply here) and fninit as 91 cycles. It doesn't list the SSE1 
timings, but i guess the instructions don't take more than 3 cycles
(MMX instructions take that long). So Andrea's way should be 
91+16*3=139+some cycles for emms (or 107 if sse ops take only a single cycle) 
vs 68 or 108.  So the fxrstor wins well. 

On x86-64 the difference is even bigger because it has 16 XMM registers instead
of 8.


> In short, your "fast" code isn't actually any faster than doing it right.

At least on Athlon it should be slower. 

-Andi
