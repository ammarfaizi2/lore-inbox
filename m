Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSETBTx>; Sun, 19 May 2002 21:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSETBTw>; Sun, 19 May 2002 21:19:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39941 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315627AbSETBTv>; Sun, 19 May 2002 21:19:51 -0400
Date: Sun, 19 May 2002 18:20:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.21.0205200311420.23394-100000@serv>
Message-ID: <Pine.LNX.4.44.0205191817260.20628-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Roman Zippel wrote:
>
> There is another problem even on rather "normal" systems, a pgd/pmd
> directory doesn't have to be of PAGE_SIZE size, e.g. on m68k it's 512
> bytes.

Note that the generic VM code doesn't actually call any of these functions
directly - an architecture can choose to redefine the whole thing for its
own uses if it wants to.

In particular, even if the architecture wants to share everything else in
the generic tlb.h, you can solve the particular problem you mention by
just not defining "pmd_free_tlb()" to be "tlb_remove_page()". In short:
there should be absolutely nothing in the setup that _requires_ you to
consider page directories to be normal pages. It just happens to work out
that way on x86 (and a number of other architectures).

		Linus

