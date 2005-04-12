Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVDLU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVDLU5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVDLUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:54:39 -0400
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:62698 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262152AbVDLUom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:44:42 -0400
Date: Tue, 12 Apr 2005 16:44:29 -0400
From: David Eger <eger@havoc.gtf.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050412204429.GA24910@havoc.gtf.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412081613.GA18545@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The reason I am questioning this point is the GIT README file.

Linus makes explicit that a "blob" is just the "file contents," and that
really, a "blob" is not just the SHA1 of the "blob":

> In particular, the "current directory cache" certainly does not need to
> be consistent with the current directory contents, but it has two very
> important attributes:
> 
> (a) it can re-generate the full state it caches (not just the directory
>     structure: through the "blob" object it can regenerate the data too)

And he defines "TREE" with the same name: blob

> TREE: The next hierarchical object type is the "tree" object.  A tree
> object is a list of permission/name/blob data, sorted by name.

Therefore, "TREE" must be the *full* data, and since we have the following
definition for CHANGESET:

> A "changeset" is defined by the tree-object that it results in, the
> parent changesets (zero, one or more) that led up to that point, and a
> comment on what happened.

That each changeset remembers *everything* for *each point in the tree*.

Linus, if you actually mean to differentiate between the full data
and a SHA1 of the data, *please please please* say "blob" in one place
and "SHA1 of the blob" elsewhere.  It's quite confusing, to me at least.

Also, the details of just what data constitutes a 'changeset' would be
lovely... i.e. a precise spec of what Pat is describing below...

-dte 

> where David Eger <eger@havoc.gtf.org> told me that...
> > So with git, *every* changeset is an entire (compressed) copy of the
> > kernel.  Really?  Every patch you accept adds 37 MB to your hard disk?
> > 
> > Am I missing something here?
> 
> Yes. Only changes files re-appear. The unchanged files keep the same
> SHA1 hash, therefore they don't re-appear in the repository.
> 
> So, if Linus gets a patch which sanitizes drivers/char/selection.c,
> only these new objects appear in the repository:
> 
> 	drivers/char/selection.c
> 	drivers/char
> 	drivers
> 	. (project root)
> 	commit message
> 
