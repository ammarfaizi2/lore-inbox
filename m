Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDMRBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDMRBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDMRBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:01:34 -0400
Received: from iabervon.org ([66.92.72.58]:56325 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261369AbVDMRBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:01:24 -0400
Date: Wed, 13 Apr 2005 13:01:34 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Petr Baudis <pasky@ucw.cz>
cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
In-Reply-To: <20050413094226.GP16489@pasky.ji.cz>
Message-ID: <Pine.LNX.4.21.0504131244410.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Petr Baudis wrote:

> Dear diary, on Wed, Apr 13, 2005 at 11:25:04AM CEST, I got a letter
> where David Woodhouse <dwmw2@infradead.org> told me that...
> > On Wed, 2005-04-13 at 10:59 +0200, Petr Baudis wrote:
> > > Theoretically, you are never supposed to share your index if you work
> > > in fully git environment. 
> > 
> > Maybe -- if we are prepared to propagate the BK myth that network
> > bandwidth and disk space are free. 
> > 
> > Meanwhile, in the real world, it'd be really useful to support sharing.
> 
> It's fine to share the objects database. If you want to share the
> directory cache, you are doing something wrong, though. What do you need
> it for?
> 
> > I'd even like to see support for using multiple branches checked out of
> > the same .git/ repository. We already cope with having multiple branches
> > _in_ the repository -- all we need to do is cope with multiple indices
> > too, so we can have different versions checked out.
> 
> I'm working on that right now. (Well, I wish I would, if other things
> didn't keep distracting me.)
> 
> The idea is to have a command which will do something like:
> 
> 	mkdir .git
> 	ln -s $origtree/heads $origtree/objects $origtree/tags .git
> 	cp $origtree/HEAD .git
> 	cd ..
> 	read-tree $(tree-id)
> 
> Voila. Now you have a new tree with almost no current neither future
> overhead.

For future reference, git is unhappy if you actually do this, because your
HEAD won't match the (empty) contents of the new directory. The easiest
thing is to cp -r your original, replace the shared stuff with links, and
go from there.

	-Daniel
*This .sig left intentionally blank*

