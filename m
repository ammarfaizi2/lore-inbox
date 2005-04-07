Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVDGPbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVDGPbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVDGPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:31:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:56235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262489AbVDGPaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:30:35 -0400
Date: Thu, 7 Apr 2005 08:32:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <1112858331.6924.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <1112858331.6924.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, David Woodhouse wrote:
>
> On Wed, 2005-04-06 at 08:42 -0700, Linus Torvalds wrote:
> > PS. Don't bother telling me about subversion. If you must, start reading
> > up on "monotone". That seems to be the most viable alternative, but don't
> > pester the developers so much that they don't get any work done. They are
> > already aware of my problems ;)
> 
> One feature I'd want to see in a replacement version control system is
> the ability to _re-order_ patches, and to cherry-pick patches from my
> tree to be sent onwards. The lack of that capability is the main reason
> I always hated BitKeeper.

I really disliked that in BitKeeper too originally. I argued with Larry
about it, but Larry (correctly, I believe) argued that efficient and
reliable distribution really requires the concept of "history is
immutable". It makes replication much easier when you know that the known
subset _never_ shrinks or changes - you only add on top of it.

And that implies no cherry-picking.

Also, there's actually a second reason why I've decided that cherry-
picking is wrong, and it's non-technical. 

The thing is, cherry-picking very much implies that the people "up" the 
foodchain end up editing the work of the people "below" them. The whole 
reason you want cherry-picking is that you want to fix up somebody elses 
mistakes, ie something you disagree with.

That sounds like an obviously good thing, right? Yes it does.

The problem is, it actually results in the wrong dynamics and psychology 
in the system. First off, it makes the implicit assumption that there is 
an "up" and "down" in the food-chain, and I think that's wrong. It's 
increasingly a "network" in the kernel. I'm less and less "the top", as 
much as a "fairly central" person. And that is how it should be. I used to 
think of kernel development as a hierarchy, but I long since switched to 
thinking about it as a fairly arbitrary network.

The other thing it does is that it implicitly puts the burden of quality 
control at the upper-level maintainer ("I'll pick the good things out of 
your tree"), while _not_ being able to cherry-pick means that there is 
pressure in both directions to keep the tree clean.

And that is IMPORTANT. I realize that not cherry-picking means that people
who want to merge upstream (or sideways or anything) are now forced to do
extra work in trying to keep their tree free of random crap. And that's a
HUGELY IMPORTANT THING! It means that the pressure to keep the tree clean
flows in all directions, and takes pressure off the "central" point. In
onther words it distributes the pain of maintenance.

In other words, somebody who can't keep their act together, and creates 
crappy trees because he has random pieces of crud in it, quite 
automatically gets actively shunned by others. AND THAT IS GOOD! I've 
pushed back on some BK users to clean up their trees, to the point where 
we've had a number of "let's just re-do that" over the years. That's 
WONDERFUL. People are irritated at first, but I've seen what the end 
result is, and the end result is a much better maintainer. 

Some people actually end up doing the cleanup different ways. For example,
Jeff Garzik kept many separate trees, and had a special merge thing.
Others just kept a messy tree for development, and when they are happy,
they throw the messy tree away and re-create a cleaner one. Either is fine
- the point is, different people like to work different ways, and that's
fine, but makign _everybody_ work at being clean means that there is no
train wreck down the line when somebody is forced to try to figure out
what to cherry-pick.

So I've actually changed from "I want to cherry-pick" to "cherry-picking
between maintainers is the wrong workflow". Now, as part of cleaning up,
people may end up exporting the "ugly tree" as patches and re-importing it
into the clean tree as the fixed clean series of patches, and that's
"cherry-picking", but it's not between developers.

NOTE! The "no cherry-picking" model absolutely also requires a model of 
"throw-away development trees". The two go together. BK did both, and an 
SCM that does one but not the other would be horribly broken.

(This is my only real conceptual gripe with "monotone". I like the model,
but they make it much harder than it should be to have throw-away trees
due to the fact that they seem to be working on the assumption of "one
database per developer" rather than "one database per tree". You don't 
have to follow that model, but it seems to be what the setup is geared 
for, and together with their "branches" it means that I think a monotone 
database easily gets very cruddy. The other problem with monotone is 
just performance right now, but that's hopefully not _too_ fundamental).

		Linus
