Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVDJXJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVDJXJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDJXJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:09:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:29378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261630AbVDJXJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:09:07 -0400
Date: Sun, 10 Apr 2005 16:10:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <20050410222737.GC5902@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
 <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
 <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
 <20050410222737.GC5902@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Petr Baudis wrote:
> 
> I currently already do a merge when you track someone's source - it will
> throw away your previous HEAD record though

Not only that, it doesn't do what I consider a "merge". 

A real merge should have two or more parents. The "commit-tree" command
already allows that: just add any arbitrary number of "-p xxxxxxxxx"  
switches (well, I think I limited it to 16 parents, but that's just a
totally random number, there's nothing in the file format or anything 
else that limits it).

So while you've merged my "data", but you've not actually merged my
revision history in your tree.

And the reason a real merge _has_ to show both parents properly is that 
unless you do that, you can never merge sanely another time without 
getting lots of clashes from the previous merge. So it's important that a 
merge really shows both trees it got data from.

This is, btw, also the reason I haven't merged with your tree - I want to 
get to the point where I really _can_ merge without throwing away the 
information. In fact, at this point I'd rather not merge with your tree at 
all, because I consider your tree to be "corrupt" thanks to lacking the 
merge history.

So you've done the data merge, but not the history merge.

And because you didn't do the history merge, there's no way to
automatically find out what point of my tree you merged _with_. See?

And since I have no way to see what point in time you merged with me, now
I can't generate a nice 3-way diff against the last common ancestor of
both of our trees.

So now I can't do a three-way merge with you based on any sane ancestor,
unless I start guessing which ancestor of mine you merged with. Now, that
"guess" is easy enough to do with a project like "git" which currently has
just a few tens of commits and effectively only two parallell development
trees, but the whole point is to get to a system where that isn't true..

			Linus
