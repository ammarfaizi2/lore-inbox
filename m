Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289211AbSA3N7K>; Wed, 30 Jan 2002 08:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289216AbSA3N67>; Wed, 30 Jan 2002 08:58:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18603 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289211AbSA3N66>;
	Wed, 30 Jan 2002 08:58:58 -0500
Date: Wed, 30 Jan 2002 16:56:32 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rob Landley <landley@trommello.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201291845.g0TIjSU16741@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201301630300.4935-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Rob Landley wrote:

> And a paralell tree to Linus's, dedicated to patch processing and
> tracking patches, with a patch submission system dedicated to routing
> patches to the proper maintainers, reviewing and cross-checking
> patches from maintainers, resolving conflicts, subjecting the lot to
> public scrutiny and being a one-stop-shopping place for people who
> want to find bugs in something...  Like Alan Cox did for years, and
> like Dave Jones is doing now...  This is a totally different subject
> then?

you are banging on open doors. We have and need multiple trees. And no, a
*single* 'integration' or 'patch penguin' tree will not be able to solve
this problem. The 'small stuff' tree is a tree that does *not* apply
nontrivial patches. It's a tree for *pure* small stuff.

also, the -ac, -dj and -aa trees all act as a 'small stuff' tree currently
but the problem Alan pointed out is that Linus often rejects small stuff
from these sources as well, which creates high latency for small stuff and
decreases the 'end user' quality of the Linus tree. (and also we lose some
of the newbie developers who by definition start with small stuff.) So by
making a *separate* and *small stuff only* tree Linus could start trusting
those patches as small-stuff-only.

A small stuff tree will not and cannot replace the multiple experimental
trees that explore riskier patches (but only a few a time) like the -dj
tree or the -ac tree. (although i'd say the -ac tree isnt purely that,
it's more like a productization tree. The -dj and the devel-based -aa tree
is a good example.)

this way all the people who have the experience and stamina to integrate
patches can act as an experimental ground to 'cook' bigger patches before
they are sent to Linus. Linus' tree is 'cooking' a few patches as well,
but only in orthogonal areas. Eg. right now we have the bio changes, the
vfs cleanups, the device handing cleanups, and the scheduler cleanups
going on in parallel. The -dj tree might (and does) 'cook' patches that
shouldnt be applied to the Linus tree right now even if they were
'perfect' as a starting point. [i still have to see a complex patch that
is truly perfect and needs no iterations. Much of the true integration
steps are still done in the Linus tree these days.]

but integration (of nontrivial patches) on such level *can* be
parallelized to a certain degree. If patches are 'pre-cooked' well (in the
-ac, -dj and -aa, etc. trees and actual users see and test them) then the
load on the Linus tree and the latency of transition of the Linus tree can
be decreased somewhat. But i think we are still very far from the point
when Linus gets only 'perfect' (nontrivial-) patches. I doubt we'll ever
reach that point, and in that case Linus wont have much fun himself so i
doubt we want to reach that point :)

the small stuff tree on the other hand does not need to be parallelized,
small stuff is atomic and such patches scale almost infinitely. So a
single small stuff tree could indeed not only serve as a trusted source
for Linus, but could also take off the load from the other trees so they
can concentrate on the not-so-small-stuff like driver updates and other
subsystem updates, or even bigger patches. Formalizing and automating the
small-stuff tree might work as well, due to its inherent simplicity.

	Ingo

