Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSJCQsX>; Thu, 3 Oct 2002 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSJCQsX>; Thu, 3 Oct 2002 12:48:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261372AbSJCQsQ>; Thu, 3 Oct 2002 12:48:16 -0400
Date: Thu, 3 Oct 2002 09:51:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Kevin Corry <corryk@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <evms-devel@lists.sourceforge.net>
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <20021003162326.GB32588@kroah.com>
Message-ID: <Pine.LNX.4.44.0210030929510.2067-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Greg KH wrote:
> 
> You can use BitKeeper for kernel development in two ways:
> 	- as a tree to work out of, accepting changes and doing
> 	  incremental things all along the way, including merging with
> 	  the main releases.
> 	- or as a way to send changes to a maintainer.
> 
> I don't think you can really have it both ways

I think this is a pretty good point, and is something that I don't think 
anybody has ever really said explicitly before. 

Some of the BK usage documentation (or "hints") by Jeff clearly imply this 
behaviour, but it's not really stated explicitly anywhere.

Also note that using multiple trees is pretty easy - you _can_ easily do
development in the "export" tree, if you just make sure that you only do 
one kind of development. And then you have a separate "test" tree that is 
a "throw-away combination tree" which just pulls all the other trees and 
has the combination of all the different work trees. 

That multi-tree approach has advantages quite outside of merging cleanly:  
it means that when trouble happens, and something doesn't work, it's
really easy to test out other changes. 

I personally often use the multi-tree approach myself when merging bigger
changes (especially if there are other changes that are in the same area): 
before I apply something big, I clone my regular tree (often down
to a known version, like the last release), and apply those changes in
that separate tree.

Then I build and test that separate tree before I merge it into my "final
merge" tree - it makes it easier to see whether problems are due to a
specific line of patches, or whether it might be some interaction between
different changes.

>  Your repository contains 138 changesets that are not in the main tree.  
> That's not a nice thing to try to make someone pull from (I know in my
> USB work, I sure wouldn't do that.)

One reason it's so easy to merge with the USB people (and with Jeff and
David and a number of others too, for that matter) is exactly the fact
that when I get an email that says "pull this tree to get these USB
changes", that is all I get. Not "random support changes to other parts of
the kernel that I also used on my tree".

If I don't get a clean BK tree to pull from, I just cannot pull it. I end
up applying the diffs by hand instead, at which point when I push out my
end result, the original source of the patches does _not_ get a clean BK 
tree that matches mine, but instead gets a BK tree that has the changes 
TWICE, in addition to all the crud it already had.

Which now makes it doubly hard to see which parts I applied, and which 
ones I didn't - BK will usually have successfully merged the trees, but 
you don't actually get any real "source control". You only get a messy 
tree.

As a result, such a tree is even _less_ useful than it was last time, and
definitely will never be pulled by me ever again, and the poor kernel
developer ends up not getting any of the real advantages of BK at all.

> So I recommend you use two BitKeeper trees.  One to do your work out of
> (much like the one you have today), and one that you use to send changes
> to other people with.  I know the JFS group does it this way, if you
> want to see another example besides the USB group.

Or even more than just two - multiple different trees to develop in and
push from. You obviously has the USB tree, but also the pci hotplug one.
Jeff has his network driver tree, and separate trees for misc things (or
separate trees for different drivers).

Davem has his networking tree and his sparc tree and often a separate
"misc" tree where he pushes the very occasional stuff that is neither.
And Kai has the ISDN tree and the kbuild tree. 

In fact, _most_ people that merge with me using BK seem to use more than
one tree already (some developers are very specialized and only have the
one tree:  JFS and ARM come to mind).

I think it's very much a "getting used to the experience". Some people
don't like it, and that's fine - I have absolutely no problem applying
clean patches either, and some of the major kernel developers have never
used a BK tree to merge with me (Andrew, Viro, Alan, Ingo..) and it hasn't
been a problem.

I personally think there is a very simple rule to using BK: if you're 
doing development, and you only have one tree, you're doing something 
wrong. The "single tree" approach is fine if your use of BK is really more 
of a "anonymous CVS" replacement - you use BK only to track somebody elses 
tree and build that. But if you do real development, you should have 
multiple trees, or you're not really using BK as a SCM.

		Linus

