Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290919AbSAaE6o>; Wed, 30 Jan 2002 23:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290921AbSAaE6f>; Wed, 30 Jan 2002 23:58:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40398 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290919AbSAaE6V>;
	Wed, 30 Jan 2002 23:58:21 -0500
Date: Wed, 30 Jan 2002 23:58:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130195154.R22323@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0201302335370.15689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jan 2002, Larry McVoy wrote:

> However, what you described *completely* misses the point.  Linus isn't
> asking for an anti-patch, he doesn't want the bad patch in the revision
> history at all.  He wants to be able to go backwards, across revisions,
> and remove stuff in the middle.  He doesn't want the checkin comments,
> he doesn't want the data, he wants no sign the patch was ever in the
> revision history.

I can't speak for Linus, but my main problem with BK is similar to what
you'd described.  Here's what I'm usually doing and what I'd like to
be able to do with BK:

Suppose I have 5 deltas - A, B, C, D, E.  I want to kill A.

I add a branch that consists of B' (B backported to original) and
ABB'^{-1}.  It joins the original at AB.

I backport C to B'.  Now I've got B', C', ABC(B'C')^{-1}.  Again, it
joins the original branch.

Repeat for D and E.  Now I've got the following picture (apologies for BUAG):

* -B'-> * -C'-> * -D'-> * -E'-> *
|                              /
A                            crap
V                            V
* -B-> * -C-> * -D-> * -E-> *

_Now_ I change the direction of last arrow.  Yes, it's more or less reverted
A.  And now I want to consider the top branch as the main history.

IOW, what I want is ability to play revisionist.  And it's not limited to
removing patches - if I've found a bug in A,  I want to be able to add A-fix
and move it all way back to right after A.  And merge them.  B, C, D and E
might have changed from that, but that's what I want.  Moreover, I might
have some junk left in the end (i.e. ABCDEA-fix == (AA-fix)B'C'D'E'noise)
and I'd really like to be able to say that (AA-fix)B'C'D'E' is the main
history now and other path (ABCDE A-fix noise^{-1}) is buried.

If you can give a way to do that - I'm happy.

