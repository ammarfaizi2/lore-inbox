Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSBJEb1>; Sat, 9 Feb 2002 23:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSBJEbK>; Sat, 9 Feb 2002 23:31:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21011 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289282AbSBJEaz>; Sat, 9 Feb 2002 23:30:55 -0500
Date: Sat, 9 Feb 2002 22:16:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C65F523.FDDB7FA@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, Andrew Morton wrote:
>
> This is due to BUG() calls in inline functions in headers.  The biggest
> culprit is dget(), in dcache.h.  This causes the full path of the header file
> to be expanded into each and every compilation unit which includes
> dcache.h.

Hmm. Which brings up another issue: can somebody come up with an idea of
how to make the thing not use the whole pathname, but only the basename
relative to the top-of-tree?

I doubt it is possible, but maybe there is some clever way to avoid it..

> I'm showing thirteen header files, for a total of 83k.  I'll do something
> about this...

Ok, so even your gcc obviously is _not_ intelligent enough to throw away
strings from inline functions that aren't used. Oh well.

Note that the correct thing to do may be to un-inline a lot of things.
We've done that before, simply because it often improves performance.

What ends up happening is that some function starts out really small, and
then later on people add logic and debug code to it, and suddenly it's not
really appropriate to inline any more.

		Linus

