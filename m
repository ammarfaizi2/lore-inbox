Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWJSXox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWJSXox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWJSXox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:44:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751631AbWJSXow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:44:52 -0400
Date: Thu, 19 Oct 2006 16:44:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
In-Reply-To: <4537EB67.8030208@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Oct 2006, Pierre Ossman wrote:
> 
> Stuff that need a bit more testing will be put in a public "for-andrew"
> branch. From what I gather, Andrew does a pull and a diff of these kinds
> of branches before putting together a -mm set. So this should be
> sufficient for your needs? Do you also prefer getting "[GIT PULL]"
> requests, or do you do the pull periodically anyway?
> 
> Patches that are considered stable, either directly or by virtue of
> being in -mm for a while, will be moved into a "for-linus" tree and a
> "[GIT PULL]" sent to herr Torvalds.

That all sounds fine. Please just check the format for the "[GIT PULL]" 
message: Andrew pulls peoples trees on his own and largely automatically, 
so he doesn't much care _what_ is in the tree, but I care deeply. So I 
want the diffstat and shortlog listings, and preferably a few sentences at 
the top of the email describing what's going on and why things are 
happening.

I think people have seen the messages that other people send out (eg at 
least Greg KH tends to Cc: those messages to linux-kernel, so others can 
see what's going on too - although not all other maintainers do that).

Basically, I want to know that the thing I pull makes sense for the stage 
I'm pulling in (ie if it's after -rc1, think about trying to explain why 
the fixes are all important bug-fixes for example), and what it affects. 
The diffstat is part of that, but please include any other explanations 
that seem meaningful.

> Now, the patch in "for-linus" will be a duplicate of one or several
> commits in "for-andrew". Will I get any problems from git once I do a
> new pull from Linus' tree into "for-andrew"?

No, git will take care of it, unless, of course, your extra patches 
conflict with the ones you sent me. 

> Another concern is all the merges. As I have modifications in my tree,
> every merge should generate at least one commit and one tree object. Is
> this kind of noise in the git history something that needs concern?

Yes and no.

An occasional merge by you is fine, and if the merge is about _you_ 
merging your own branches into one branch for me or Andrew to pull, then 
the merge actually adds valid information.

HOWEVER. Please don't just pull from my tree just to keep your 
development tree "up-to-date". Your development tree is YOUR development 
tree, it should be about the stuff _you_ did - not about merging stuff 
that I merged from others. See?

So there's simply no point in merging from me, unless you know that there 
are clashes due to other development, and you actually want to fix them 
up. You will just cause unnecessary criss-cross merges if you pull from my 
tree after you've started development, and the history gets really really 
messy.

There's several ways to handle this:

 - just base your work on a certain release, and ignore all the other 
   changes. Then, when you're ready, just ask me to pull your changes. git 
   will just merge it up to my current version, and everything will be 
   fine. 

   (Of course, once I _have_ merged your changes, if you pull at that 
   point, you'll just fast-forward, and there will be no unnecessary 
   back-and-forth merging)

 - If you actually want your development tree to "track" my tree, I'd 
   suggest you have your "for-linus" branch that you put the work you want 
   to track into, and then a plain "linus" branch which tracks _my_ tree. 
   Then you can just fetch my tree (to keep your "linus" branch 
   up-to-date), and if you want your development branch to track those 
   changes, you can just do a "git rebase linus" in your "for-linus" 
   branch.

 - If you actually notice that the stuff in my tree conflicts with the 
   stuff you develop, _then_ you obviously want to merge (you can try to 
   "rebase" things too and fix it up durign the rebase, but merging is 
   often easier, and at this point the merge is no longer "unnecessary 
   noise", it's actually a real action of you doing a real merge to handle 
   the conflict.

And hey, if there is occasionally an unnecessary merge, nobody really 
cares. So don't be _too_ worried about it. But a clean history makes 
things simpler to track, so I'm asking people to not generate noise that 
simply doesn't help.

Other git maintainers may have other hints about how they work. Anybody?

			Linus
