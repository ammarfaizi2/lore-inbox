Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSEKSfy>; Sat, 11 May 2002 14:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316247AbSEKSfx>; Sat, 11 May 2002 14:35:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316243AbSEKSfx>; Sat, 11 May 2002 14:35:53 -0400
Date: Sat, 11 May 2002 11:35:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
 IDE 56)
In-Reply-To: <20020511111935.B30126@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, Larry McVoy wrote:
>
> You're only halfway right.  You want to avoid the mmap altogether.

See my details on doing the perfect zero-copy copy thing.

The mmap doesn't actually touch the page tables - it ends up being nothing
but a "placeholder".

So if you do

        addr = mmap( ..  MAP_UNCACHED ..  src .. )
        mwrite(dst, addr, len);

then you can think of the mmap as just a "cookie" or the "hose" between
the source and the destination.

Does it have to be an mmap? No. But the advantage of the mmap is that you
can use the mmap to modify the stream if you want to, quite transparently.
And it gives the whole thing a whole lot more flexibility, in that if you
generate the data yourself, you'd just do the mwrite() - again with zero
copy overhead.

And I personally believe that "generate the data yourself" is actually a
very common case. A pure pipe between two places is not what a computer is
good at, or what a computer should be used for.

		Linus

