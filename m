Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSBITwl>; Sat, 9 Feb 2002 14:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBITwV>; Sat, 9 Feb 2002 14:52:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15369 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286161AbSBITwP>; Sat, 9 Feb 2002 14:52:15 -0500
Date: Sat, 9 Feb 2002 13:37:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C6579DB.E93DAD92@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202091335340.1196-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, Andrew Morton wrote:
> >
>
> Is better, except the filename gets expanded multipe times into
> the object file.  How about:
>
> #define BUG()                   \
>         asm(    "ud2\n"         \
>                 "\t.word %0\n"  \
>                 "\t.long %1\n"  \
>                  : : "i" (__LINE__), "i" (__FILE__))

Even better.

That way you can actually totally remove the "verbose bug" config option,
because even the verbose BUG's aren't actually using up any noticeable
amounts of space.

This is all assuming that gcc doesn't create the string for inline
functions that aren't used, which it probably cannot, so maybe this
doesn't work out.

			Linus

