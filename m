Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTKYNzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKYNzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:55:40 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:46581 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262074AbTKYNzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:55:37 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Jakob Lell <jlell@JakobLell.de>, root@chaos.analogic.com
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Tue, 25 Nov 2003 07:54:57 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <200311241857.41324.jlell@JakobLell.de>
In-Reply-To: <200311241857.41324.jlell@JakobLell.de>
MIME-Version: 1.0
Message-Id: <03112507545800.03336@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 November 2003 11:57, Jakob Lell wrote:
> Hello
>
> On Monday 24 November 2003 18:14, Richard B. Johnson wrote:
> > On Mon, 24 Nov 2003, Jakob Lell wrote:
> > > Hello,
> > > on Linux it is possible for any user to create a hard link to a file
> > > belonging to another user. This hard link continues to exist even if
> > > the original file is removed by the owner. However, as the link still
> > > belongs to the original owner, it is still counted to his quota. If a
> > > malicious user creates hard links for every temp file created by
> > > another user, this can make the victim run out of quota (or even fill
> > > up the hard disk). This makes a local DoS attack possible.
[snip]
> >
> > A setuid binary created with a hard-link will only work as a setuid
> > binary if the directory it's in is owned by root. If you have users
> > that can create files or hard-links within such directories, you
> > have users who either know the root password already or have used
> > some exploit to become root. In any case, it's not a hard-link
> > problem
>
> Setuid-root binaries also work in a home directory.
> You can try it by doing this test:
> ln /bin/ping $HOME/ping
> $HOME/ping localhost

What? You allow users write access to a filesystem containing privileged
applications????

You really shouldn't do that. Any filesystem a user has write access to should
be mounted nosgid.

> > > To solve the problem, the kernel shouldn't allow users to create hard
> > > links to
> > > files belonging to someone else.
> >
> > No. Users must be able to create hard links to files that belong
> > to somebody else if they are readable. It's a requirement.
>
> If this is REALLY neccessary, it might be possible to prevent hard links to
> setuid binaries.
> Regards
>  Jakob

You would also have to consider setgid binaries.

It also means that you have to read the inode of the source file. Right now,
only the contents of directory have to be read (the file search for the inode
number).
