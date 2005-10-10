Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVJJL4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVJJL4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVJJL4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:56:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63431 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750751AbVJJL4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:56:51 -0400
Date: Mon, 10 Oct 2005 13:56:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Etienne Lorrain <etienne.lorrain@masroudeau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Message-ID: <20051010115641.GA2983@elf.ucw.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300> <20051007144631.GA1294@elf.ucw.cz> <2520.192.168.201.6.1128943428.squirrel@pc300>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2520.192.168.201.6.1128943428.squirrel@pc300>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>  It perfectly works for me, and even after reading those tens of times
> >> I no more find anything to change or improve.
> >>  Can someone propose a way forward, either in the direction of
> >> linux-2.6.14/15 or in the -mm tree, and/or propose improvement or
> >> point me to my bug(s) ?
> >
> > And advantages are? Having to maintain both C and assembly version
> > does not seem like improvement to me.
> 
>   The problem is that you call the assembly version "maintained".
>  When I started hacking that part, in 1998, I tried to rewrite it

It seems to work okay here. Now, rewriting current boot system into C
may be good goal...

>  I am not alone to not want to touch those assembler files: If you
>  have a look at Linux/arch/x86_64/boot/video.S you will see that
>  on an X86_64 architecture, people are doing I/O port and PCI
>  peek/poke all over the place to detect video cards which have
>  only been available on ISA bus, two bus generation ago!
>  I seriously doubt you can even imagine an AMD 64 bits with an ISA
>  trident 8900 video card inside, even for fun: you cannot plug it
>  in.

Feel free to fix that. [I think I could get PCI-to-ISA bridge and plug
it into my x86-64 box...]

> >> +#define STR static const char
> >
> > Ouch.
> 
>   Well, you want to comment on the only file which is a standalone
>  application and not released under GPL but BSD license, because it
>  may be usefull elsewhere.

Well, if you want to distribute the file with kernel, it should
folllow kernel coding style. If not, sorry for the noise.

>  The fact that it is released on a BSD license (if a collection
>  of GZIP utilities is ever built) also changes the indentation
>  rules if that matter.

License does not say anything about coding style. 

> >  +const unsigned maskvesa = 0
> >
> >> +#ifndef CONFIG_FB_VESA
> >> +	| (1 << 0)	/* Cannot boot in MASKVESA_1BPP */
> >> +	| (1 << 1)	/* Cannot boot in MASKVESA_2BPP */
> >> +	| (1 << 3)	/* Cannot boot in MASKVESA_4BPP */
> >> +	| (1 << 7)	/* Cannot boot in MASKVESA_8BPP */
> >> +	| (1 << 14)	/* Cannot boot in MASKVESA_15BPP */
> >> +	| (1 << 15)	/* Cannot boot in MASKVESA_16BPP */
> >> +	| (1 << 23)	/* Cannot boot in MASKVESA_24BPP */
> >> +	| (1 << 31)	/* Cannot boot in MASKVESA_32BPP */
> >> +#endif
> >> +#if defined (CONFIG_VGA_CONSOLE) || defined (CONFIG_MDA_CONSOLE)
> >> +	| (1 << 16)	/* able to boot in text mode */
> >> +#endif
> >> +	// | (1 << 17)	/* not able to boot in VESA1 mode */
> >> +#ifdef CONFIG_FB_VESA
> >> +	| (1 << 18)	/* able to boot in VESA2 linear mode */
> >> +#endif
> >> +	// | (1 << 19)	/* force VESA1 if in VESA2 */
> >> +	| (1 << 20)	/* Cannot handle VGA graphic modes */
> >> +	;
> 
>   No comment here. Well I know the use of ifdef's is deprecated, but
>  there is simply no other way here - and lets face it: recompiling
>  a 10 lines C function (with the host compiler and not the target one
>  when cross compiling) at each kernel configuration change is not that
>  long.

// comments are deprecated, too, and you probably should use symbolic
constant, no?

> > if you have sharp zaurus hardware you don't need... you know my address
> 
>   Sorry I do not... fun but not enough storage space.

Takes CF cards just fun. You can get 1GB CF cards these days, and
microdrives are even bigger.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
