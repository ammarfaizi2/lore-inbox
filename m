Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292484AbSBPSaQ>; Sat, 16 Feb 2002 13:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBPSaG>; Sat, 16 Feb 2002 13:30:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27621 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292484AbSBPS37>;
	Sat, 16 Feb 2002 13:29:59 -0500
Date: Sat, 16 Feb 2002 13:29:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Nicolas Pitre <nico@cam.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        That Linux Guy <thatlinuxguy@hotmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Of Bundling, Dao and Cowardice
In-Reply-To: <20020216110857.B32129@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0202161146160.29124-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Feb 2002, Eric S. Raymond wrote:

> Would you ask someone designing a new VM to make it crash and hang exactly
> the same way the old one did?
> 
> Do you demand that a rewrite of a disk driver have the same data-corruption
> bugs as the original before it can go into the tree, and tell the developer
> to add fixes later?
> 
> Pragmatically, the point of rewriting a system is to *fix bugs*.

	That, folks, is a fine example of very common problem.
It's very tempting to try and force your ideas of How The Things
Should Be Done(tm) into the tree by bundling them with genuine
bug fixes and (more or less gracefully) refusing to split the
patch.  Anybody who had done serious work on the tree had felt
that temptation at one point or another.  No arguments - it's very
attractive.  Indeed, you don't have to defend every point of your
design and implementation - you can always point to Bad Bugs(tm)
that are fixed by the entire thing and obfuscate the objections away.
The trouble being, _SUCH_ _BUNDLING_ _IS_ _NOT_ _A_ _VALID_ _STRATEGY_.

	It had been tried.  Many times.  Sometimes it even got the
thing into the tree.  _All_ such cases had lead to trouble.

	There is another way.  It takes more efforts, it requires
readiness to defend every damn part of your design and it means
that you will have to deal with the sad fact that parts of that
design need to be redone.  It will take more time.  It will look
less sexy.  It may very well mean that somebody else will get
alternative design into the tree on the top of your efforts.
There are only two positive things about it - it is honest and
it leads to better tree.

	How does it work?  Simple - look at the path from original
tree to tree with your modifications.  And no, "one big jump" doesn't
count.  Think of the way your ideas can be split into parts.  Think
of the way obstructions to the changes can be split into parts.
Find small and simple changes that can go in right now, would improve
the tree and would make the rest of path easier.  And merge them.
If you find that it can't be done - think what needs to be changed in
the tree (or in your modifications) to make the split possible.
If you see that something is ugly and stands in the way - help the thing
to achieve the form it wants.  That may change all your ideas about the
right design for your modifications.  That's OK - it's a Good Thing(tm).
And merge the small changes.  Step by step.

	_That_ works.  Less glory; more time; more work.  And better
tree afterwards.  The code wants to get cleaner.  In many directions.
The trick is to pick the right ones and let the thing grow into natural
form.  Do that many times in the right order and you will get it where
you want it to be.  Quite possibly - in a better place than you thought
originally.

	Before you start saying that it's impossible - THAT HAD BEEN DONE.
Between 2.3.40 and 2.5.2 (about two years) we got pretty much complete
redesign of VFS,  along with the stuff that was plain impossible with
the old design.  Get the old tree.  Get the current tree.  Compare.  And
realize that more than half of the way was covered during 2.4.  Yes, the
total size of patches had been about 2 times larger than the size of
combined patch.  Definitely took a lot of extra efforts.  You know what?
It was worth the trouble.  Result is better than what I've expected.  And
a lot of things in the first iteration of design had turned out to be
useless - stuff that was there to work around the problems that got _fixed_
by cleanups at some point during these two years.  And I fully expect to
see the same thing happening with the stuff I'm planning and doing now.

	While we are at it, look what Rik is doing right now.  He has
a huge patch pretty much rewriting (what a coincidence) VM.  He had tried
to shove its previous incarnations into the tree whole-sale.  Saying that
it didn't work is putting it _very_ mildly - resulting fight is in l-k
archives and boy, was it nasty...  Look what's going on now - same splitup
and gradual merge strategy.  Sure, extra work.  Guess what?  The thing had
already become better from that work.

	As for your motivations...  If you are doing that for bragging
rights ("I've thought up a new design and now it's in the tree, exactly
as I envisioned it") - find something else to brag about.  Your strategy
is basically a sign of cowardice - you are fighting tooth and nail to avoid
gradual changes and the only way I can interpret it is that you are afraid
to let parts of your design stand on their own.  Not exactly a bragging
material, that...

