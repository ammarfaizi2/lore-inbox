Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDUWxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDUWxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDUWxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:53:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36746 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261534AbVDUWxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:53:25 -0400
Date: Fri, 22 Apr 2005 00:53:24 +0200
From: Petr Baudis <pasky@ucw.cz>
To: tony.luck@intel.com
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
Message-ID: <20050421225324.GA1474@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org> <200504212155.j3LLtho04949@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504212155.j3LLtho04949@unix-os.sc.intel.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 11:55:43PM CEST, I got a letter
where tony.luck@intel.com told me that...
> I can't quite see how to manage multiple "heads" in git.  I notice that in
> your tree on kernel.org that .git/HEAD is a symlink to heads/master ...
> perhaps that is a clue.
> 
> I'd like to have at least two, or perhaps even three "HEADS" active in my
> tree at all times.  One would correspond to my old "release" tree ... pointing
> to changes that I think are ready to go into the Linus tree.  A second would
> be the "testing" tree ... ready for Andrew to pull into "-mm", but not ready
> for the base. The third (which might only exist in my local tree) would be
> for changes that I'm playing around with.

To set up that, go into your "master" working directory, and do:

	git fork release ~/release
	git fork testing ~/testing

Then in ~/release or ~/testing respectively, you have working trees for
the respective branches.

> I can see how git can easily do this ... but I don't know how to set up my
> public tree so that you and Andrew can pull from the right HEAD.

Currently, git pull will _never_ care about your internal heads
structure in the remote repository. It will just take HEAD at the given
rsync URI, and update the remote branch's head in your repository to
that commit ID.  This actually seems to be one of the very common
pitfalls for people.

The way to work around that is to setup separate rsync URIs for each of
the trees. ;-) I think I will make git-pasky (Cogito) accept also URIs
in form

	rsync://host/path!branchname

which will allow you to select the particular branch in the given
repository, defaulting to the "master" branch.

Would that work for you?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
