Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVDMJmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDMJmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDMJmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:42:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7595 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261281AbVDMJm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:42:28 -0400
Date: Wed, 13 Apr 2005 11:42:27 +0200
From: Petr Baudis <pasky@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413094226.GP16489@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <1113311256.20848.47.camel@hades.cambridge.redhat.com> <20050413094705.B1798@flint.arm.linux.org.uk> <20050413085954.GA13251@pasky.ji.cz> <1113384304.12012.166.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113384304.12012.166.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 11:25:04AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Wed, 2005-04-13 at 10:59 +0200, Petr Baudis wrote:
> > Theoretically, you are never supposed to share your index if you work
> > in fully git environment. 
> 
> Maybe -- if we are prepared to propagate the BK myth that network
> bandwidth and disk space are free. 
> 
> Meanwhile, in the real world, it'd be really useful to support sharing.

It's fine to share the objects database. If you want to share the
directory cache, you are doing something wrong, though. What do you need
it for?

> I'd even like to see support for using multiple branches checked out of
> the same .git/ repository. We already cope with having multiple branches
> _in_ the repository -- all we need to do is cope with multiple indices
> too, so we can have different versions checked out.

I'm working on that right now. (Well, I wish I would, if other things
didn't keep distracting me.)

The idea is to have a command which will do something like:

	mkdir .git
	ln -s $origtree/heads $origtree/objects $origtree/tags .git
	cp $origtree/HEAD .git
	cd ..
	read-tree $(tree-id)

Voila. Now you have a new tree with almost no current neither future
overhead.

This will be used to do the out-tree merges. Command for user to do this
will likely also make it a regular branch, doing

	ln -s $(realpath git/HEAD) .git/heads/branchname

so that you can reference to it easily from your other branches.

Would this do what you want?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
