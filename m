Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVDKSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVDKSbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDKSbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:31:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50821 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261885AbVDKSay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:30:54 -0400
Date: Mon, 11 Apr 2005 20:30:51 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, pj@engr.sgi.com, junkio@cox.net,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: Re: more git updates..
Message-ID: <20050411183051.GA22339@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410161457.2a30099a.pj@engr.sgi.com> <Pine.LNX.4.58.0504101634250.1267@ppc970.osdl.org> <20050411084931.4aaf7ae0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411084931.4aaf7ae0.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 05:49:31PM CEST, I got a letter
where "Randy.Dunlap" <rddunlap@osdl.org> told me that...
> On Sun, 10 Apr 2005 16:38:00 -0700 (PDT) Linus Torvalds wrote:
..snip..
> | Yes. Crappy old tree, but it can still read my git.git directory, so you 
> | can use it to update to my current source base.
> 
> Please go into a little more detail about how to do this step...
> that seems to be the most basic concept that I am missing.
> i.e., how to find the "latest/current" tree (version/commit)
> and check it out (read-tree, checkout-cache, etc.).

Well, its ID is by convention kept in .dircache/HEAD. But that is really
only a convention, no "core git" tool reads it directly, and you need to
update it manually after you do commit-tree.

First, you need to get the accompanying tree's id. git-pasky's shortcut
is $(tree-id), but manually you can do it by

	$(cat-file commit $(cat .dircache/HEAD)) | egrep '^tree'

Note that if you ever forgot to update HEAD or if you have multiple
branches in your repository, you can list all "head commits" (that is,
commits which have no other commits referencing them as parents) by
doing fsck-cache.

Now, you need to populate the directory cache by the tree (see Paul
Jackson's diagram):

	read-tree $tree_id

And now you want to update your working tree from the cache:

	checkout-cache -a -f

This will bring your tree in sync with the cache (it won't remove any
stale files, though). That means it will overwrite your local changes
too - turn that off by omitting the "-f". If you want to update only
some files, omit the "-a" and list them.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
