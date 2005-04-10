Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVDJXa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDJXa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDJX2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:28:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25056 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261648AbVDJX0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:26:42 -0400
Date: Mon, 11 Apr 2005 01:26:37 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410232637.GC18661@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 01:10:58AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Mon, 11 Apr 2005, Petr Baudis wrote:
> > 
> > I currently already do a merge when you track someone's source - it will
> > throw away your previous HEAD record though
> 
> Not only that, it doesn't do what I consider a "merge". 
> 
> A real merge should have two or more parents. The "commit-tree" command
> already allows that: just add any arbitrary number of "-p xxxxxxxxx"  
> switches (well, I think I limited it to 16 parents, but that's just a
> totally random number, there's nothing in the file format or anything 
> else that limits it).
> 
> So while you've merged my "data", but you've not actually merged my
> revision history in your tree.

Well, that's exactly what I was (am) going to do. :-) That's also why I
said that I (virtually) throw the local commits away now. Instead, if
there were any local commits, I will do git merge:

	commit-tree $(write-tree) -p $local_head -p $tracked_tree

Note that I will need to make this two-phase - first applying the
changes, then doing the commit; between those two phases, the user
should resolve potential conflicts and check if the merge went right.

I think I will name the first phase git merge and the second phase will
be just git commit, and I will store the merge information in
.dircache/. (BTW, I think the directory name is pretty awful; what about
.git/ ?)

> And the reason a real merge _has_ to show both parents properly is that 
> unless you do that, you can never merge sanely another time without 
> getting lots of clashes from the previous merge. So it's important that a 
> merge really shows both trees it got data from.
> 
> This is, btw, also the reason I haven't merged with your tree - I want to 
> get to the point where I really _can_ merge without throwing away the 
> information. In fact, at this point I'd rather not merge with your tree at 
> all, because I consider your tree to be "corrupt" thanks to lacking the 
> merge history.
> 
> So you've done the data merge, but not the history merge.
> 
> And because you didn't do the history merge, there's no way to
> automatically find out what point of my tree you merged _with_. See?
> 
> And since I have no way to see what point in time you merged with me, now
> I can't generate a nice 3-way diff against the last common ancestor of
> both of our trees.
> 
> So now I can't do a three-way merge with you based on any sane ancestor,
> unless I start guessing which ancestor of mine you merged with. Now, that
> "guess" is easy enough to do with a project like "git" which currently has
> just a few tens of commits and effectively only two parallell development
> trees, but the whole point is to get to a system where that isn't true..

Well, I've wanted to get the basic things working first before doing git
merge. (Especially since until recently, diff-tree was PITA to work
with, and before that it didn't even exist.) If you want, I can rebuild
my tree with doing the merging properly, after I have git merge working.

(BTW, it would be useful to have a tool which just blindly takes what
you give it on input and throws it to an object of given type; I will
need to construct arbitrary commits during the rebuild if I'm to keep
the correct dates.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
