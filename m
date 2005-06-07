Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVFGPiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVFGPiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVFGPhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:37:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:59321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261904AbVFGP1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:27:06 -0400
Date: Tue, 7 Jun 2005 08:28:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050607130535.GD16602@harddisk-recovery.com>
Message-ID: <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050607130535.GD16602@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Jun 2005, Erik Mouw wrote:
> 
> Over here the script can get the  correct information from git
> branches:
> 
> > Jeff Garzik:
> >   Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
> 
> But for your own changes it seems to fail:
> 
> > Linus Torvalds:
> >   Linux 2.6.12-rc6
> >   Automatic merge of 'misc-fixes' branch from
> 
> ... from what?

Yeah, I guess I need to redo my merge messages. Or alternatively, I should 
just remove merges from the shortlog.

The merge message that goes along with that shortlog entry is

	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
	Date:   Sat Jun 4 08:18:39 2005 -0700

	    Automatic merge of 'misc-fixes' branch from
    
	        rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6

which is pretty readable in the long format, but causes the shortlog to 
pick up just the partial (largely uninteresing) first line.

Removing merges from the shortlog is actually likely the _right_ thing to 
do, since we already miss a lot of merges: any truly trivial merge (ie no 
parallellism) is invisible anyway, except that the committer changed. 
Besides, it's what the old BK changelogs did.

So I guess I'll leave the merge message as is (unless somebody can suggest 
a more readable format), and just update my release scripts to not include 
merge messages.

(Using Jeff's syntax for merge messages isn't very good, since with remote
repositories the names of the repos get so long that the message gets 
unwieldly..)

> >   Automatic merge of rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6
> >   Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
> 
> And this again works.

That's because they don't have branches - when I take the HEAD of the 
repostitory, the changelog entry ends up being just a one-liner again.

Do a "git log" if you have the git tree (or just look at the full 
ChangeLog, which is just the output of that), you'll see what's up.

(Btw, Jeff, I think the git-shortlog script is slightly buggered, it
doesn't do the nice word-wrap, and it _only_ takes the first line, even
from a multi-line header. I think it should stop at the first empty line
in the commit, not just take the first one).

		Linus
