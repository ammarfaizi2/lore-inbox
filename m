Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQLIF3y>; Sat, 9 Dec 2000 00:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLIF3o>; Sat, 9 Dec 2000 00:29:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41706 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129765AbQLIF3i>;
	Sat, 9 Dec 2000 00:29:38 -0500
Date: Fri, 8 Dec 2000 23:59:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.LNX.4.10.10012081437150.31310-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012082343370.27010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Linus Torvalds wrote:

> Looking more at this issue, I suspect that the easiest pretty solution
> that everybody can probably agree is reasonable is to either pass down the
> end-of-io callback to ll_rw_block as you suggested, or, preferably by just
> forcing the _caller_ to do the buffer locking, and just do the b_end_io
> stuff inside the buffer lock and get rid of all the races that way
> instead (and make ll_rw_block() verify that the buffers it is passed are
> always locked).

Hmm... I've looked through the ll_rw_block() callers and yes, it seems
to be doable. BTW, we probably want a helper function that would do
lock+ll_rw_block+wait - it will simplify the life in filesystems.
I'll do a patch tonight.
						Cheers,
							Al
PS: alpha-testers needed for sysvfs patches - right now the thing is racey
as hell and unlike minixfs I can't test it myself. It's more or less
straightforward port of minixfs patch that went into the tree sometime
ago, so it shouldn't be too bad, but... IOW, if somebody has boxen to
test the thing on - yell.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
