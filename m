Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbRARSvE>; Thu, 18 Jan 2001 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131695AbRARSuy>; Thu, 18 Jan 2001 13:50:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131645AbRARSuk>; Thu, 18 Jan 2001 13:50:40 -0500
Date: Thu, 18 Jan 2001 10:50:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rick Jones <raj@cup.hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A6735F0.C10759E0@cup.hp.com>
Message-ID: <Pine.LNX.4.10.10101181044510.18287-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Rick Jones wrote:

> Linus Torvalds wrote:
> > Remember the UNIX philosophy: everything is a file.
> 
> ...and a file is simply a stream of bytes (iirc?)

Indeed.

And normal applications really shouldn't need to worry about things like
packetization etc.

Of course, many applications still do. stdio does "fstat" on the file
descriptor to get the st_blksize thing - which despite it's name is really
only meant to say "this is an efficient blocksize to write to this fd".
That only really works for regular files, and is just a heuristic even
there.

But TCP_CORK can be used to kind of "wrap" such applications, if you know
that they don't have interactive behaviour. 

99% of the time you probably don't care enough. Not very many people use
TCP_CORK, I suspect. It's too Linux-specific, and you really have to watch
the packets on the network to see the effect of it (unless you use it
wrong, and forget to uncork, in which case you can certainly see the
effect of it the wrong way ;)

Oh, well. The same is obviously largely true of "sendfile()" in general.
The people who use senfile() under Linux are probably largely the same
people who know about and use TCP_CORK.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
