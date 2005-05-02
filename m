Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEBWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEBWah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEBWa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:30:28 -0400
Received: from waste.org ([216.27.176.166]:52379 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261188AbVEBWaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:30:11 -0400
Date: Mon, 2 May 2005 15:30:02 -0700
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Morten Welinder <mwelinder@gmail.com>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050502223002.GP21897@waste.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com> <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 03:02:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 2 May 2005, Bill Davidsen wrote:
> > 
> > If there is a functional reason to use git, something Mercurial doesn't 
> > do, then developers will and should use git. But the associated hassles 
> > with large change size, rather than the absolute size, are worth 
> > considering.
> 
> Note that we discussed this early on, and the issues with full-file 
> handling haven't changed. It does actually have real functional 
> advantages:
> 
>  - you can share the objects freely between different trees, never 
>    worrying about one tree corrupting another trees object by mistake.

Not sure if this is terribly useful. It just makes it harder to pull
the subset you're interested in.

>  - you can drop old objects.

You can't drop old objects without dropping all the changesets that
refer to them or otherwise being prepared to deal with the broken
links.

> delta models very fundamentally don't support this. 

The latter can be done in a pretty straightforward manner in mercurial
with one pass over the data. But I have a goal to make keeping the
whole history cheap enough that no one balks at it.

> For example, a simple tree re-linker will work on any mirror site, and
> work reliably, even if I end up uploading new objects with some tool that
> doesn't know to break hardlinks etc. That can easily be much more than a
> 10x win for a git repository site (imagine something like bkbits.net, but
> got git).

What is a tree re-linker? Finds duplicate files and hard-links them?
Ok, that makes some sense. But it's a win on one machine and a lose
everywhere else.

> Whether it is a huge deal or not, I don't know. I do know that the big 
> deal to me is just the simplicity of the git object models. It makes me 
> trust it, even in the presense of inevitable bugs. It's a very safe model, 
> and right now safe is good.

I've added an "hg verify" command to Mercurial. It doesn't attempt to
fix anything up yet, but it can catch a couple things that git
probably can't (like file revisions that aren't owned by any
changeset), namely because there's more metadata around to look at.

I'll probably post an updated version tomorrow, I'm beginning to work
on a git2hg script.

-- 
Mathematics is the supreme nostalgia of our time.
