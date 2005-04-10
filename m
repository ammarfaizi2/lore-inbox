Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVDJXW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDJXW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVDJXVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:21:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:54724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261642AbVDJXTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:19:22 -0400
Date: Sun, 10 Apr 2005 16:21:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Li <lkml@chrisli.org>
cc: Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
In-Reply-To: <20050410195354.GH13853@64m.dyndns.org>
Message-ID: <Pine.LNX.4.58.0504101611370.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
 <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
 <20050410190331.GG13853@64m.dyndns.org> <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
 <20050410195354.GH13853@64m.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Christopher Li wrote:
> 
> How about deleting trees from the caches? I don't need to delete stuff from
> the official tree. It is more for my local version control.

I have a plan. Namely to have a "list-needed" command, which you give one
commit, and a flag implying how much "history" you want (*), and then it
spits out all the sha1 files it needs for that history.

Then you delete all the other ones from your SHA1 archive (easy enough to
do efficiently by just sorting the two lists: the list of "needed" files
and the list of "available" files).

Script that, and call the command "prune-tree" or something like that, and 
you're all done.

(*) The amount of history you want might be "none", which is to say that 
you don't want to go back in time, so you want _just_ the list of tree and 
blob objects associated with that commit.

Or you might want a "linear"  history, which would be the longest path
through the parent changesets to the root.

Or you might want "all", which would follow all parents and all trees.

Or you might want to prune the history tree by date - "give me all
history, but cut it off when you hit a parent that was done more than 6
months ago".

This "list-needed" thing is not just for pruning history either. If you
have a local tree "x", and you want to figure out how much of it you need
to send to somebody else who has an older tree "y", then what you'd do is
basically "list-needed x" and remove the set of "list-needed y". That
gives you the answer to the question "what's the minimum set of sha1 files
I need to send to the other guy so that he can re-create my top-of-tree".

My second plan is to make somebody else so fired up about the problem that 
I can just sit back and take patches. That's really what I'm best at. 
Sitting here, in the (rain) on the patio, drinking a foofy tropical drink, 
and pressing the "apply" button. Then I take all the credit for my 
incredible work. 

Hint, hint.

			Linus
