Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVCDSS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVCDSS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDSS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:18:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:25554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262951AbVCDSRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:17:21 -0500
Date: Fri, 4 Mar 2005 10:18:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, jgarzik@pobox.com,
       davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <1109940685.26799.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com>  <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com>  <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net>  <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com>  <4226CA7E.4090905@pobox.com> 
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>  <422751C1.7030607@pobox.com>
 <20050303181122.GB12103@kroah.com>  <20050303151752.00527ae7.akpm@osdl.org>
  <1109894511.21781.73.camel@localhost.localdomain>  <20050303182820.46bd07a5.akpm@osdl.org>
  <1109933804.26799.11.camel@localhost.localdomain>  <20050304032820.7e3cb06c.akpm@osdl.org>
 <1109940685.26799.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Alan Cox wrote:
>
> On Gwe, 2005-03-04 at 11:28, Andrew Morton wrote:
> > I think you're assuming that 2.6.x.y will have larger scope than is intended.
> 
> The examples I gave for remap_vm_area and exec are both from real world
> "gosh look I am root isn't that fun" type security holes. If that is
> outside the scope of 2.6.x.y then you need to go back to the drawing
> board.

Alan, I think your problem is that you really think that the tree _I_ want 
is what _you_ want.

I look at this from a _layering_ standpoint. Not from a "stable tree"  
standpoint at all.

We're always had the "wild" kernels, and 90% of the time the point of the
"wild" kernels has been to let people test out the experimental stuff,
that's not always ready for merging. Like it or not, I've considered even
the -ac kernel historically very much a "wild" thing, not a "bugfixes" 
thing.

What I'd like to set up is the reverse. The same way the "wild" kernels
tend to layer on top of my standard kernel, I'd like to have a lower
level, the "anti-wild" kernel.  Something that is comprised of patches
that _everybody_ can agree on, and that doesn't get anything else. AT ALL.

And that means that such a kernel would not get all patches that you'd 
want. That's fine. That was never the aim of it. The _only_ point of this 
kernel would be to have a baseline that nobody can disagree with.

In other words, it's not a "let's fix all serious bugs we can fix", but a 
"this is the least common denominator that is basically acceptable to 
everybody, regardless of what their objectives are".

So if you want to fix a security issue, and the fix is too big or invasive 
or ugly for the "least common denominator" thing, then it simply does not 
_go_ into that kernel. At that point, it goes into an -ac kernel, or into 
my kernel, or into a vendor kernel. See?

The point is not to make a perfect kernel. Two reasons:

 - aiming for perfect doesn't work, and would just stress out the 
   maintainer of the sucker-tree. In contrast, aiming for "is this 
   _totally_ non-offensive to everybody" is something that can be done by 
   consensus fairly easily - it's enough that one person says "no", and 
   the issue is solved. No stress, no gray areas.

 - perfect doesn't _exist_. As you yourself point out, different people 
   have different goals. The development kernel is not supposed to just
   revert a patch unless the patch itself was fundamentally flawed. And
   the development kernel is generally much more geared towards "let's fix
   this right"  rather than "let's apply an ugly bandaid that makes it 
   harder to fix it properly later".

So as long as you see this sucker-tree as a _replacement_ for the -ac 
kernels, you will _never_ be happy. But my whole point is that it's not a 
replacement at all. It's a starting point for others. It's something that 
should be fairly easy to set up, and exactly _because_ the aim is to be 
inoffensive, it's somethign where people can basically rely on the fact 
that they don't have to think about things that go into the sucker-tree: 
we'll set it up so that it's an acceptable base-line for everybody.

Is it an acceptable _solution_ for everybody? No. It's not even aiming to
be. It's aiming to be a "let's get at 45% of the way, with 5% of the
effort". And the way we make the effort low is by having the hard rules, 
and having the "single vote throws it out" approach. That's also what 
limits the tree, but hey, that's ok.

So how do you get to your solution? You could have a "slightly more wild" 
tree that takes the "other" patches. That "slightly more wild" tree would 
be for somebody _else_ to maintain (ie it might be you), and that would be 
the fixes that aren't acceptable to everybody. 

In other words: I'm talking about scalability of development, not about 
fixing every single serious bug. I think this one will catch the 
embarrassing brown-paper-bag kinds of things, and maybe 90% of the "duh, 
we had this race forever, but we never even realized", but it wouldn't 
solve the ones where we had "damn, we did the locking wrong".

But let's face it - _most_ security bugs are of the "duh" variety. That's 
easy to overlook, because those are the ones you don't worry about, but 
the fact is, if we can get a tree that makes it possible for most people 
to just get those fixes without thinking about it, then that's a _good_ 
thing.

So think of it as a piece in the puzzle, not the whole picture.

			Linus
