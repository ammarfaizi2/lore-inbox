Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314070AbSDQGD7>; Wed, 17 Apr 2002 02:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314071AbSDQGD6>; Wed, 17 Apr 2002 02:03:58 -0400
Received: from bitmover.com ([192.132.92.2]:24513 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314070AbSDQGD4>;
	Wed, 17 Apr 2002 02:03:56 -0400
Date: Tue, 16 Apr 2002 23:03:55 -0700
From: Larry McVoy <lm@bitmover.com>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020416230355.I27525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"M. R. Brown" <mrbrown@0xd6.org>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org> <20020416203721.B27525@work.bitmover.com> <20020417050412.GD5897@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 12:04:12AM -0500, M. R. Brown wrote:
> Not sure I follow here, you're a bit vague about "doing the same thing".
> Do you mean syncing from the mainline kernel?  

Syncing from the main kernel, synching from someone else, syncing with 
a coworker, whatever.  It doesn't really matter.  With the limitation 
that BK wants you to eat everything that the other guy has that you don't,
it all just works.  And you can sync from N different places all of which
happened to have the same patch in the same changeset, and it gets applied
once, BK knows it has it already.

BK isn't perfect, but you are looking at it through CVS colored glasses.
Take 'em off, it's got some stuff that will save you time and effort.

> For the LinuxSH project, we moved from tracking the full kernel tree (via
> CVS) to a drop-in tree structure mainly because of the difficulty in
> tracking all upstream kernel changes at once.  It wasn't really related to
> what CVS did or did not offer.

Disagree.  CVS sucks at tracking an external source of change while
maintaining your own changes at the same time, in the same tree.
It really sucks at that, you are forced into a broken branching model
with awful merge characteristics.  Try the same thing with BK, it's
a lot nicer, most stuff just automerges, and the stuff that doesn't
only needs to be merged once.  Your claim that it isn't about CVS
doesn't make much sense when CVS forces you to split your subtree
out.  Having an _option_ to do that is one thing, being forced to
do it is another.

> I never said anything about working in isolation in any of my posts.  A
> drop-in tree is only usable when "dropped in" or symlinked on top of a full
> kernel tree.  

And if that tree has changes in the files that you are "dropping in"?
You just stomped on them.  Or you are left with an even more broken
merge model than CVS.  And what about file renames.

> Also, the size of a drop-in tree is a side effect of its composition, it
> was used to illustrate the benefit of the simplicity of drop-in trees - if
> you recall the introductory paragraph of my original reply to yours, I said
> that drop-in trees are most useful for kernel subsystems and backend
> (architecture) ports.  

Agreed.  We're headed towards breaking up the kernel tree into
subrepositories for that reason.

> However, I do mind how much of my broadband bandwidth is used
> (since I'm stuck with a flaky ADSL link) and I'm sure developers still on 56K
> links also mind.

BK's pretty stingy with bandwidth.  I think the openlogging tree has
some problems, but other than that, BK uses very little bandwidth, far
less than CVS.  It knows what needs to be transfered, CVS has to look,
over your net connection.  We have lots of people tracking the kernel
trees via a modem.  You can play games to save more bandwidth too,
if you know you have a common gca in a local tree, and you want to get
a local copy of some other "branch", clone -r back to the gca and then
pull from the branch into the new repository.  You'll save transfering
all the stuff that you already had.

> So, splitting trees in BK.  Do you mean by using native BK commands, or by
> planning ahead and using multiple repositories?  Perhaps when you've
> finished flaming me and defaming CVS you can give me a valid response as to
> how one would maintain a drop-in tree using BK.  

Perhaps when you have finished flaming me, you can go use the tool, read
the docs, and learn what it can do.  Part of the problem I have is that
you are, in a public forum, saying that BK is this and that, based on your
perceptions from 2 years ago when you said you used it on the ppc tree.
I can't imagine that you used it very much, because there is not a
single changeset in the tree with your login on it.  So maybe you are
making your comments based on a 2 year old reading of the docs, rather
than actually using it.  That is pretty annoying and a waste of time.
Go learn the tool, if you want an education, then buy some training.

As for splitting trees, "bk help csetprune".  It not only splits trees,
it maintains the repository changeset history graph, no small feat.
But it's a 1-way, 1-time operation, you can't unsplit.  So it's something
that I suspect will happen when Linus wants it.

And you could find this information by

	http://www.bitkeeper.com
	click on search
	type in "split"
	hit return,
	it's the 3rd item down.

> You seem to be stuck on "why CVS sucks" while I'm trying to convey "why CVS
> does what I need it to do" as far as drop-in trees are concerned.  

Except it *doesn't* do what you need it to do.  You proceeded to hand
wave over the many places where CVS won't work.  You haven't addressed
either of the two big problems, renames and content changes in the
upstream tree.  In the 2 months of usage, Linus' tree has seen 1289
renames, of which 767 where real renames, not deletes.  How does your
drop in model handle those?  What about content changes that you don't
have yet, how does it handle that?  In both cases, the answer is "it
doesn't".  So you are doing work that you don't need to do, by hand.
That seems misguided when there is a tool that will do that work for
you.

> conditioned to attack (or belittle) anyone that doesn't accept BK as
> gospel.  I understand taking pride in your work, but damn!  Take it easy.

It's got nothing to do with gospel, it's got everything to do with you
making claims based on no work on your part, not even recent usage.
BK isn't anywhere near Linus' definition of the best (i.e., it can't
get better).  Nowhere near.  But it's quite useful if you figure out
how to use it.  And we're making better as fast as we can.

Contrast your comments / homework with Jeff Garzik, just for fun.  BK
has some limitations he didn't like, so he asked a few polite questions,
figured out how to work around the limitations, and wrote it up in a
doc (have you read it?).  His approach has been widely adopted, there
are at last count around 130 slightly different BK trees sitting on
bkbits.net.  

In summary, because I've had enough of this thread, your drop in tree
is a hack, it doesn't handle even the basics of SCM, and you haven't
shown how to handle those.  BK has plenty of problems, but it least it
handles the basics.  What you are doing is like working in a file system
which makes you edit the raw disk to do renames and/or content merges.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
