Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315560AbSETAjt>; Sun, 19 May 2002 20:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315600AbSETAjs>; Sun, 19 May 2002 20:39:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315560AbSETAjr>; Sun, 19 May 2002 20:39:47 -0400
Date: Sun, 19 May 2002 17:39:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.21.0205200211380.23394-100000@serv>
Message-ID: <Pine.LNX.4.44.0205191736420.10180-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Roman Zippel wrote:
>
> Two questions about asm-generic/tlb.h:
> - freed is never incremented, callers of tlb_remove_page have to do the
>   rss update themselves?

No, that's just a missed thing (for a while I thought I could use "nr" for
"freed", so I changed the code and forgot to add back the free'd).

> - will a non smp version later be added again?

Not likely, at least not in the form it was before of having two
completely different paths.

But I was thinking of doing a one-source thing that the compiler can
statically optimize, with something like

	#ifdef CONFIG_SMP
	#define fast_case(tlb) ((tlb)->nr == ~0UL)
	#else
	#define fast_case(tlb) (1)
	#endif

which allows us to have one set of sources for both UP and SMP, but the UP
case gets optimized by the compiler.

Do you want to do the freed and the above and test it?

		Linus

