Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUDAOy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUDAOy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:54:26 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:9152 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262244AbUDAOyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:54:24 -0500
Date: Thu, 1 Apr 2004 16:53:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040401145346.GA10393@wohnheim.fh-wedel.de>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <Pine.LNX.4.58.0403251237200.1106@ppc970.osdl.org> <m1k718zi5r.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1k718zi5r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 March 2004 15:16:48 -0700, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Thu, 25 Mar 2004, Jamie Lokier wrote:
> > > 
> > > That is not useful for me or the other people who want to use this to
> > > duplicate large source trees and run "diff" between trees.
> > > 
> > > "diff" depends on being able to check if files in the two trees are
> > > identical -- by checking whether the inode number and device (and
> > > maybe other stat data) are identical.  This allows "diff -ur" between
> > > two cloned trees the size of linux to be quite fast.  Without that
> > > optimisation, it's very slow indeed.
> > 
> > I think the correct thing to do is to just admit that cowlinks aren't
> > POSIX, and instead see the inode number as a way to see whether the link
> > has been broken or not. Ie just accept the inode number potentially
> > changing.
> > 
> > That would make "diff" (adn most other uses) ok with this, and anythign 
> > that isn't, just couldn't be used with cowlinked files.
> 
> Really?
> 
> tar and cp still need to be taught about them.  And if they are not taught
> they will do the wrong thing and hard link the files removing the
> copy on write semantics.  Which would do ugly thing when you restore
> from your backup.
> 
> I don't have a problem with the inode number changing when you write to
> a file, because I can't think of much that would care either way.
> But having the inode number of an open file change sounds like a very
> difficult problem to track. 
> 
> Maybe aiming cow links at things like a live cd filesystem is too
> ambitious, but it sounds like a minimal clean way to handle all of
> the dependencies on writeable files that show up.  

Either method could work with some restrictions.  Either way, some
userspace tools need to be taught about the changes.  Personally I
don't care much either way, but the simple trick is already working on
my notebook and the problems are not too bad (not too good either).

BTW: sendfile() for ext[23] is finished, so the actual copy can be
done inside the kernel now.  Patch will follow soon. (-EBUSY)

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
