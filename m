Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbTCMBqP>; Wed, 12 Mar 2003 20:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbTCMBqP>; Wed, 12 Mar 2003 20:46:15 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:59582 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S261860AbTCMBqN>;
	Wed, 12 Mar 2003 20:46:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Thu, 13 Mar 2003 03:00:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303122037.h2CKboc7031958@pincoya.inf.utfsm.cl>
In-Reply-To: <200303122037.h2CKboc7031958@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030313015658.4008E414D3@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Mar 03 21:37, Horst von Brand wrote:
> Daniel Phillips <phillips@arcor.de> said:
> > This is why changesets need to be first-class objects in the repository,
>
> Right.
>
> > that can be versioned,
>
> Versioned how? Have different versions of a changeset? Don't see the point.

So that fix.foobar-2.5.64 that you got from davem applies to 2.5.64 that you 
got from Linus, and a later version of it, e.g., with some macro respelled by 
you (in line with Linus's recent changes) applies correctly to 2.5.69.

> ...The changeset should be seen as a (conceptually atomic)
> change to the _local_ repository.

No argument there, and no inconsistency.  Well, except that it's entirely ok 
to "soften" a changeset by adding context and send it off to somebody else.  
That somebody else may need to massage it to get it to apply, and so they end 
up with the exact changeset you sent them, which conflicts, and their own 
version of it, which works.  Then, when somebody asks them to forward the 
same changeset , they've got two chances to send one that works on the first 
try.  And so on forth.

> The "conceptually atomic" part is from
> Linus' style of "break up your megapatch into self-contained pieces, do one
> step at a time".

Really essential.

> The changeset must make local sense if you want to be able
> to undo, see what it changes, handle dependencies, ... Locally, what was
> changed remotely (generating the changeset in the first place) is useless
> (as the context isn't here).

Yes, but I fail to see why that means you can't send the thing on to someone 
else to accomplish something useful.  This has always worked well with 
patches, why did it stop working with changesets?

> >                                  and recombined.
>
> Recombined how? Take changesets A and B, create C from half of each? Better
> keep A, B, and create another one that gets rid of the junk.

Yes of course.  Why would you throw any changeset away?  It's all good data. 
C would be a recombination of A and B, and all of them end up in the 
repository, though not necessarily all applied.

In order to recombine efficiently, you have to be able to explode A and B 
into their component parts (chunks make a convenient starting point) then 
reassemble them, hopefully with the help of regex matches and so on.  You 
also want to be able to do the equivalent of editing a patch, but in a way 
that isn't so error-prone.  A nice way to do that is to apply the patch, edit 
the result, then regenerate the patch.  The tedious bookkeeping aspect of 
this can be automated nicely.

> Or do a C from
> scratch (perhaps by applying A and B as patches, fixing up the mess, and
> declaring the resulting change a changeset).

Yes.

> It does make sense to group changesets, but not this way AFAICS.
>
> >                                                  I'd be able to pull
> > slightly differing changesets from a variety of sources, *merge
> > the changesets* and carry the result forward in my repository.  This
> > way, no changeset needs to lose its identity until I explicity want it
> > to.
>
> This is doing merging among changesets, not merging changesets into the
> repository.

No, I meant merging the changesets into the repository.  Then the system 
regenerates the changeset, and understands it to be a descendant version of 
the original changeset.  The result is a "merged" changeset, i.e., one that 
applies correctly, whereas the original didn't.

> I'd prefer the later (as it reduces this special-purpose
> operation to others that have to be there anyway).

I suppose that we're violently agreeing, and just haggling over terminology.

Regards,

Daniel
