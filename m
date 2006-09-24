Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWIXVef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIXVef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIXVef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:34:35 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:52493 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932161AbWIXVee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:34:34 -0400
Date: Sun, 24 Sep 2006 22:34:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Junio C Hamano <junkio@cox.net>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Subject: Re: 2.6.18-mm1
Message-ID: <20060924213422.GD12795@flint.arm.linux.org.uk>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk> <20060924132213.GE11916@pasky.or.cz> <20060924142005.GF25666@flint.arm.linux.org.uk> <20060924142958.GU13132@pasky.or.cz> <20060924144710.GG25666@flint.arm.linux.org.uk> <7veju185j9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7veju185j9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - see the bottom of this message.

On Sun, Sep 24, 2006 at 11:48:26AM -0700, Junio C Hamano wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> > I'm just experimenting with git-apply for the forward case, and I'm
> > hitting a small problem.  I can do:
> >
> > 	cat patch | git-apply --stat
> >
> > then I come to commit it:
> >
> > 	git commit -F -
> >
> > but if I just use that, _all_ changes which happen to be in the tree
> > get committed, not just those which are in the index file.
> 
> That does not sound right.

You're right - I was looking at doing git-apply --stat --apply

>  * "git apply --stat patch" (you do not need "cat |" there) is
>    only to inspect the changes; it does not apply the change to
>    your working tree.  Think of it as "diffstat for git".

The "cat" bit was in there to represent the perl script piping the
patch directly into the program - there isn't a literal "cat"
command in there. 8)

>  * When doing partial commits, having "git apply" to prepare
>    what you want to commit in the index is less error prone
>    (otherwise you would somehow need to parse the patch and find
>    out what is added and what is deleted).  I do not exactly
>    know what you are doing in your Perl wrapper, but I suspect
>    bulk of that is to figure out what is changed and run
>    git-update-index on them -- you can lose all that code by
>    using "git apply --index patch".  Then added, removed and
>    modified paths are all updated in the index.

The problem is that git apply doesn't have a "patch -R" mode - so
if I want to revert such a patch (okay, there's only been one instance
so far) it means falling back to the old way.  So that code exists
one way or t'other.

> > I guess we'll just have to live with the screwed history until some
> > of the issues I've brought up with git are resolved (the biggest one
> > being git commit being able to take a list of files deleted.)
> 
> If you _are_ updating index yourself before calling git-commit,
> you do not need to (and indeed you should not) pass _any_
> pathnames to it.  I think that's where this confusion comes from.

Yes, that is where the confusion's happening.

Thanks for explaining it - the script's now fixed and appears to work
as desired.

akpm - I'm afraid the ARM devel tree has been regenerated almost from
scratch, so you might encouter some issues next time you pull it.
However, despite this issue, the end result appears to be idential
(git-diff-tree -u broken-devel devel shows no changes, but the
individual changes for each commit are now correct.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
