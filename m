Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUCYUjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUCYUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:39:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:40623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263617AbUCYUjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:39:04 -0500
Date: Thu, 25 Mar 2004 12:38:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <20040325194303.GE11236@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0403251237200.1106@ppc970.osdl.org>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
 <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
 <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
 <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
 <20040325194303.GE11236@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Mar 2004, Jamie Lokier wrote:
> 
> That is not useful for me or the other people who want to use this to
> duplicate large source trees and run "diff" between trees.
> 
> "diff" depends on being able to check if files in the two trees are
> identical -- by checking whether the inode number and device (and
> maybe other stat data) are identical.  This allows "diff -ur" between
> two cloned trees the size of linux to be quite fast.  Without that
> optimisation, it's very slow indeed.

I think the correct thing to do is to just admit that cowlinks aren't
POSIX, and instead see the inode number as a way to see whether the link
has been broken or not. Ie just accept the inode number potentially
changing.

That would make "diff" (adn most other uses) ok with this, and anythign 
that isn't, just couldn't be used with cowlinked files.

		Linus
