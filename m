Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbUCYWTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbUCYWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:18:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35981 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263674AbUCYWRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:17:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
	<m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
	<m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
	<Pine.LNX.4.58.0403251237200.1106@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Mar 2004 15:16:48 -0700
In-Reply-To: <Pine.LNX.4.58.0403251237200.1106@ppc970.osdl.org>
Message-ID: <m1k718zi5r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 25 Mar 2004, Jamie Lokier wrote:
> > 
> > That is not useful for me or the other people who want to use this to
> > duplicate large source trees and run "diff" between trees.
> > 
> > "diff" depends on being able to check if files in the two trees are
> > identical -- by checking whether the inode number and device (and
> > maybe other stat data) are identical.  This allows "diff -ur" between
> > two cloned trees the size of linux to be quite fast.  Without that
> > optimisation, it's very slow indeed.
> 
> I think the correct thing to do is to just admit that cowlinks aren't
> POSIX, and instead see the inode number as a way to see whether the link
> has been broken or not. Ie just accept the inode number potentially
> changing.
> 
> That would make "diff" (adn most other uses) ok with this, and anythign 
> that isn't, just couldn't be used with cowlinked files.

Really?

tar and cp still need to be taught about them.  And if they are not taught
they will do the wrong thing and hard link the files removing the
copy on write semantics.  Which would do ugly thing when you restore
from your backup.

I don't have a problem with the inode number changing when you write to
a file, because I can't think of much that would care either way.
But having the inode number of an open file change sounds like a very
difficult problem to track. 

Maybe aiming cow links at things like a live cd filesystem is too
ambitious, but it sounds like a minimal clean way to handle all of
the dependencies on writeable files that show up.  

Eric
