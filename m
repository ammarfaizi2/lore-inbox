Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSA3XRk>; Wed, 30 Jan 2002 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290729AbSA3XRX>; Wed, 30 Jan 2002 18:17:23 -0500
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:60134 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287607AbSA3XRC>; Wed, 30 Jan 2002 18:17:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 18:18:11 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Eli Carter <eli.carter@inet.com>, Georg Nikodym <georgn@somanetworks.com>,
        Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com> <20020130143608.I22323@work.bitmover.com>
In-Reply-To: <20020130143608.I22323@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130231701.FKGV22669.femail15.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 05:36 pm, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 02:17:05PM -0800, Linus Torvalds wrote:
> > The way BK works now, if we call the quick-and-dirty fix "A", and the
> > real fix "B", the developer has a really hard time just sending "B" to
> > me. He'd have to re-clone an earlier BK tree, re-do B in that tree, and
> > then send me the second version.
> >
> > I'm suggesting that he just send me B, and get rid of his tree. There are
> > no dependencies on A, and I do not want _crap_ in my tree just because A
> > was a temporary state for him.
>
> And you just lost some useful information.  The fact that so-and-so did
> fix A and then did B is actually useful.  It tells me that A didn't work
> and B does.  You think it's "crap" and by tossing it dooms all future
> developers to rethink the A->B transition.

<rant>

The noise to signal ratio is too high.  I think Linus has made it clear that 
he actively does not WANT this information.  (The "A" kind of patch is 
generally posted to linux-kernel, where it is buried deep in the flood.)

If developers can't ever make temporary changes to their tree which they do 
NOT intend to send to linus, they can't FUNCTION.  (Except my not doing 
development in said tree.)

They can, of course, explicitly do an end run around your "bondage and 
discipline" design by doing the "patch against the base tree" thing you 
suggested earlier.  Or just having it create plain diffs.  But if they have 
to go to lengths to work around your design to accomplish what THEY want (not 
what you want for them), then the tool is broken.

> There is a reason that commercial companies guard their revision history
> and fight like mad to preserve it.  It contains useful information,
> even the bad stuff is useful.

Do you REALLY think that Linus wants the experimental, quickly-reverted crutf 
of 300 maintainers accumulating in his tree?

Linux development is not a commercial company.  It is FAR more decentralized. 
 There are WAY more developers, doing WAY more experimentation, than most 
commercial companies could EVER afford to fund the man-hours for.  A 
commercial company generaly doesn't have bored college students futzing 
around with random ideas that have a 95% chance of failure, but occasionally 
produce something brilliant.  And a month of experimental baggage tag along 
with a twenty line patch is just insane. 

Trying out way more bad code than good is probably the NORM for the Linux 
development model.  Certainly outside of the core maintainers and 
lieutenants.  What you're basically saying is that people have to be really 
careful about ever putting any code into their tree, or else just extract 
straight patches from bitkeeper and put up with losing the tracking 
information and comments to avoid having your design ideas cram megabytes of 
cruft down their throat.

Good grief, -I- can see this is a bad idea...

> Some stuff may be so bad that it shouldn't ever get in the tree, but you
> don't accept anything at all from those people in general.

Not directly, no.  So basically, you're trying very hard to prevent bitkeeper 
from spreading far down the maintainer tree, due to the exponentially 
increasing number of overridden patches that bitkeeper will suck out of 
everybody's trees no matter how hard they try to avoid passing that garbage 
on to Linus.

Remember Linus's main job?  Code reviewing everythign and making 
architectural decisions?  Why on earth are you trying to force the poor man 
to read code that the submitter does NOT present to him as the solution?  
(There's 8 zillion ways NOT to fix a given problem.  We're trying to REDUCE 
the bandwidth demands on the guy...)

AAAAAAAAAH!

Okay, I'm better now.

(Sorry, this is a hot button issue with me.  Tool makers who insist they know 
how those tools should be used and what for, and thus reject feedback from 
users asking for greater flexibility with a "no, you don't want to DO that".  
Hammer vendors should not tell me what kind of nails to use.)

> If Al Viro
> takes one pass at a problem and it works well enough that it gets in
> the tree, and then later does a pass two that cleans it up, I can learn
> from that.  That's very useful information, his brain frequently shines
> a light in a dark corner but I'd miss a lot of that without the history.

So go read linux-kernel.

Giving people the OPTION of folding this cruft into the tree is one thing.  
FORCING them to do so is just WRONG.

> Your approach is constantly dropping useful information on the floor.

Information which does not belong in Linus's tree.  (You're basically saying 
Linus should add a subset of the rejected patch set to his tree's revision 
history.  Does it sound like a dumber idea to have Linus put EVERY rejected 
patch he deletes into his tree's history in some automated way?)

Monolithic evil.  Proper tool for proper job, don't try to force the job to 
adapt to what you think the tool is good for.

> It may not be useful to you but it's useful to virtually everyone
> else.

I would like to go on record as saying I don't consider this useful.  I don't 
have always enough bandwidth to read through every -pre diff.  This stuff 
gets discussed on linux-kernel.  People are talking about a patch archive 
system which may save rejected patches for posterity.  This is a seperate 
problem, and has a chance of succeeding exactly because it is NOT tangled 
with the issue of source control for the main tree.

> Saving that information will increase the quality and reduce
> the quantity of the patches you get.

Uh, Larry?  By definition, adding unnecessary reverted patches for dependency 
purposes to the set of patches Linus would have to apply to his tree is 
increasing the number of patches Linus actually would have to deal with, if 
he was using bitkeeper-to-bitkeeper.  You are FORCING people to do everything 
as diff -u and drop MORE information, because YOU are not being flexible here.

</rant>

Rob
