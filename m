Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSBJDRq>; Sat, 9 Feb 2002 22:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289228AbSBJDRg>; Sat, 9 Feb 2002 22:17:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289226AbSBJDRX>; Sat, 9 Feb 2002 22:17:23 -0500
Date: Sat, 9 Feb 2002 21:03:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <E16Zjw9-0000Dr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202092056590.10530-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Feb 2002, Alan Cox wrote:
>
> I also don't understand what the problem you are trying to solve is. If you
> want to debug the kernel you build with debug verbose. If not you don't.

No.

With the old stupid code, if you wanted to debug the kernel, you had to
make sure that the VERBOSE flag was _off_.

Because if it wasn't off, the printk's that triggered would totally
destroy the register state at the point of the BUG, which often hides real
information (the register state is what tends to contain the exact flags
that were tested for the bug).

> With the symbol table you can still easily trace down BUG events.

.. and with VERBOSE it end sup often being much simpler.

Also note that if you want to save space, what you should do is disable
BUG() altogether. In a real embedded device where memory is that tight,
the output generally won't make it anywhere anyway.

That will speed up the kernel a bit too (don't test for conditions that
cannot happen).

So don't be a proponent for stupidity. Which the old CONFIG_DEBUG_VERBOSE
was.

		Linus

