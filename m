Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWIXOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWIXOrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWIXOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:47:19 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35084 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750974AbWIXOrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:47:18 -0400
Date: Sun, 24 Sep 2006 15:47:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Petr Baudis <pasky@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1
Message-ID: <20060924144710.GG25666@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk> <20060924132213.GE11916@pasky.or.cz> <20060924142005.GF25666@flint.arm.linux.org.uk> <20060924142958.GU13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924142958.GU13132@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 04:29:58PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Sep 24, 2006 at 04:20:06PM CEST, I got a letter
> where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> > I'm now told that the resulting tree after all the commits is correct.
> > The problem is that all the files which were supposed to be deleted by
> > previous patches ended up actually being deleted by the final patch in
> > the series.
> > 
> > So the resulting tree is fine, it's just that the history is rather
> > broken.
> 
> Well, that rewritehist batch should work fine even in this case.
> 
> (Of course that's assuming that no change was supposed to happen to
> those files in the last four days.)
> 
> > I think a solution to this might be to use git-apply, but there's one
> > draw back - I currently have the facility to unpatch at a later date,
> > but git-apply doesn't support -R.
> 
> Yes, if there's not too many patches perhaps using git-apply -R would be
> simpler. git-apply in git-1.4.2.1 does support -R.

I'm just experimenting with git-apply for the forward case, and I'm
hitting a small problem.  I can do:

	cat patch | git-apply --stat

then I come to commit it:

	git commit -F -

but if I just use that, _all_ changes which happen to be in the tree
get committed, not just those which are in the index file.  Manually
doing each step of the commit is far too much work in perl...

Grumble.

And no, I'm not about to try to rewrite my patch database handling
using shell script - I don't know of any way to sanely access a mysql
database from shell.

I guess we'll just have to live with the screwed history until some
of the issues I've brought up with git are resolved (the biggest one
being git commit being able to take a list of files deleted.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
