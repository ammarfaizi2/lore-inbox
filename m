Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSFJRCN>; Mon, 10 Jun 2002 13:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFJRCM>; Mon, 10 Jun 2002 13:02:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315529AbSFJRCL>; Mon, 10 Jun 2002 13:02:11 -0400
Date: Mon, 10 Jun 2002 10:02:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: Andreas Dilger <adilger@clusterfs.com>, Dan Aloni <da-x@gmx.net>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.GSO.4.05.10206101846060.17299-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.4.44.0206100954250.30535-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, Thomas 'Dent' Mirlacher wrote:
>
> ok, the point that *_t is hiding implementation details (when used for
> structs is valid). but is there a general consens on not using typedefs
> for structs?

The linux coding style _tends_ to avoid using typedefs. It's not a hard
rule (and I did in fact apply this patch, since it otherwise looked fine),
but it's fairly common to use an explicit "struct xxxx" instead of
"xxxx_t".

I dislike type abstraction if it has no real reason. And saving on typing
is not a good reason - if your typing speed is the main issue when you're
coding, you're doing something seriously wrong.

(Similarly, if you are trying to compress lines to be shorter, you have
other problems, nothing to do with type names).

Does code look "prettier" with a "_t" rather than a "struct "? I don't
know. I personally don't think so, and I also hate the "_p" (or even more
the just plain "p") convention for "pointer".

Hiding the fact that it's a struct causes bad things if people don't
realize it: allocating structs on the stack is something you should be
aware of (and careful with), and passing them as parameters is is much
better done explicitly as a "pointer to struct".

There are _some_ exceptions. For example, "pte_t" etc might well be a
struct on most architectures, and that's ok: it's expressly designed to be
an opaque (and still fairly small) thing. This is an example of where
there are clear _reasons_ for the abstraction, not just abstraction for
its own sake.

But in the end, maintainership matters. I personally don't want the
typedef culture to get the upper hand, but I don't mind a few of them, and
people who maintain their own code usually get the last word.

		Linus

