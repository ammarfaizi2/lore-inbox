Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPT36>; Thu, 16 Nov 2000 14:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKPT3t>; Thu, 16 Nov 2000 14:29:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1692 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129183AbQKPT3h>;
	Thu, 16 Nov 2000 14:29:37 -0500
Date: Thu, 16 Nov 2000 13:59:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.21.0011161934370.30811-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0011161352260.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Jean-Marc Saffroy wrote:

> Now I see your point : by "." or "foo/." you mean the directory itself,
> while "foo" or "foo/" refer to the link to the directory, and they are
> obviously different objects... at least since hard links on directories
> were introduced. Fine.

Sorry, no. Directories still have only one parent. However, "." _is_ a
link. It's not a shortcut or something like that - it's a real, normal,
honest-to-$DEITY directory entry. Aka link.

> Ok, now I get it. Thanks for this much clearer explanation.
> 
> I guess that this was not a problem in 2.2 precisely because hard links on
> directories were forbidden, right ?

That was a problem and that still _is_ a problem - these races are unsolvable
without a pretty serious namei.c rewrite and unless Alan is willing to go
for that in 2.2 they are there to stay.

As for the hard links being forbidden - in some sense they never were, in
some sense they still are. Situation didn't change - directory can't have
more than one parent. OTOH, every directory has at least two links - from
the parent and from itself (+ one from each child).

> > Besides, we clearly violated
> > all relevant standards - rmdir() and rename() are required to fail
> > if the last component of name happens to "." or "..".
> 
> By standard, do you imply 'de facto' ? Or does any source clearly state
> this ?

POSIX, for one thing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
