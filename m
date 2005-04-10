Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVDJXpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDJXpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDJXpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:45:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:17357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261641AbVDJXo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:44:59 -0400
Date: Sun, 10 Apr 2005 16:46:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <20050410232637.GC18661@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
 <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local>
 <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz>
 <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz>
 <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org> <20050410232637.GC18661@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Petr Baudis wrote:
> 
> (BTW, it would be useful to have a tool which just blindly takes what
> you give it on input and throws it to an object of given type; I will
> need to construct arbitrary commits during the rebuild if I'm to keep
> the correct dates.)

Hah. That's what "COMMITTER_NAME" "COMMITTER_EMAIL" and "COMMITTER_DATE" 
are there for.

There's two things to commits: when (and by whom) it was committed to a
tree, and when the changes were really done.

So set the COMMITTER_xxx things to the person/time you want to consider 
the _original_ one, and let "commit-tree" author you as the creator of the 
commit itself. The regular "ChangeLog" thing should only show the author 
and original time, but it's nice to see who created the commit itself.

I did this very much on purpose: see how I always try to attribute 
authorship in BK to the person who actually wrote the code. At the same 
time, I think it's interesting from a tracking standpoint to also see 
when/where that change got introduced into a tree.

I _tried_ to get this right in the sparse tree conversion. I won't 
guarantee that it's all correct, but the top commit in the sparse tree 
looks like this:

	tree 67607f05a66e36b2f038c77cfb61350d2110f7e8
	parent 9c59995fef9b52386e5f7242f44720a7aca287d7
	author Christopher Li <sparse@chrisli.org> Sat Apr  2 09:30:09 PST 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Thu Apr  7 20:06:31 2005

	...

exactly because I tracked when I committed it to the sparse tree 
_separately_ from tracking when it was created.

So when I re-create the sparse-tree, I'll also end up re-writing the 
"committer" information. And that's proper. That's really saying "this 
sha1 object was created by Xxxx at time Xxxx".

Btw, the "COMMITTER_xxxx" environment variables are very confusingly
named. They actually go into the _author_ line in the commit object. I'm a
total retard, and I really don't know why I called it "COMMITTER_xxx"  
instead of "AUTHOR_xxx".

			Linus "retard" Torvalds
