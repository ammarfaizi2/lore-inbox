Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290586AbSA3Ux5>; Wed, 30 Jan 2002 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290590AbSA3Uxi>; Wed, 30 Jan 2002 15:53:38 -0500
Received: from mail.sonytel.be ([193.74.243.200]:30141 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S290586AbSA3Ux3>;
	Wed, 30 Jan 2002 15:53:29 -0500
Date: Wed, 30 Jan 2002 21:50:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Larry McVoy <lm@bitmover.com>
cc: Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130083756.I23269@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0201302136120.18197-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Larry McVoy wrote:

> > Er, not the pristine tree, the linuxppc_2_4 tree, sorry.  I'll try
> > again.  One of the problems we hit frequently is that we have to move
> > files from linuxppc_2_4_devel into linuxppc_2_4, once they prove stable.
> > But just creating a normal patch, or cp'ing the files means when we pull
> > linuxppc_2_4 back into linuxppc_2_4_devel we get a file conflict, and
> > have to move one of the files (the previously existing one) into the
> > deleted dir.  How do we cleanly move just a few files from a child tree
> > into the parent?  I think this is a lot like what would happen, if Linus
> > used BK and we wanted to send him support for some platforms, but not
> > all of the other changes we have.
> 
> BitKeeper is like a distributed, replicated file system with atomic changes.
> That has certain advantages, much like a database.  What you are asking 
> violates the database rules, if I understand you properly.  Are you asking
> to move part of a changeset?  That's a no no, that's like moving the 
> increment to your bank account without the decrement to mine; the banks
> frown on that :-)
> 
> Or are you asking more about the out of order stuff, i.e., whole changesets
> are fine but not all of them.

If I understand it correctly, yes, you want to `push' only one changeset (the
creation of the new file) to the parent repository. Either directly (through
push), or through creating a patch in the child repository and importing it in
the parent repository.

[ Disclaimer: I'm not that familiar with the  problem Tom mentions ]

However, why couldn't BK automatically resolve this?

In BK, a file creation (or a rename) is simply a changeset, just like a change
to the contents of a file (i.e. a patch that affects one file only), right?

If I modify a file in the child repository, and that change ends up in the
same file in the parent repository (i.e. Linus applied the patch I sent there),
BK will automatically resolve the issue when I do a pull in my child
repository.  How is this different from a new file I added in the child
repository, and the same file (with the same contents, or contents from a
previous revision in the child repository) that got added in the parent later?
If I do a pull, BK should `merge' the change (a new file)? Or am I missing
something?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

