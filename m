Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272253AbTHDVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272255AbTHDVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:24:16 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:59891 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272253AbTHDVYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:24:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: FS: hardlinks on directories
Date: Mon, 4 Aug 2003 16:23:42 -0500
X-Mailer: KMail [version 1.2]
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804170506.11426617.skraw@ithnet.com> <Pine.LNX.4.53.0308041142520.802@chaos>
In-Reply-To: <Pine.LNX.4.53.0308041142520.802@chaos>
MIME-Version: 1.0
Message-Id: <03080416234202.04444@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 10:57, Richard B. Johnson wrote:
> On Mon, 4 Aug 2003, Stephan von Krawczynski wrote:
> > On Mon, 4 Aug 2003 09:33:44 -0500
> >
> > Jesse Pollard <jesse@cats-chateau.net> wrote:
> > > Find for one. Any application that must scan the tree in a search. Any
> > > application that must backup every file for another (I know, dump
> > > bypasses the filesystem to make backups, tar doesn't).
> >
> > All that can handle symlinks already have the same problem nowadays.
> > Where is the difference? And yet again: it is no _must_ for the feature
> > to use it for creating complete loops inside your fs.
> > You _can_ as well dd if=/dev/zero of=/dev/hda, but of course you
> > shouldn't. Have you therefore deleted dd from your bin ?
> >
> > > It introduces too many unique problems to be easily handled. That is
> > > why symbolic links actually work. Symbolic links are not hard links,
> > > therefore they are not processed as part of the tree. and do not cause
> > > loops.
> >
> > tar --dereference loops on symlinks _today_, to name an example.
> > All you have to do is to provide a way to find out if a directory is a
> > hardlink, nothing more. And that should be easy.
>
> [SNIPPED...]
>
> Reading Denis Howe's  Free Online Dictionary of Computing;
> http://burks.bton.ac.uk/burks/foldoc/55/51.html, we see that
> the chief reason for no directory hard-links is that `rm`
> and `rmdir` won't allow you to delete them. There is no
> POSIX requirement for eliminating them, and it is possible
> "Some systems provide link and unlink commands which give
> direct access to the system calls of the same name, for
> which no such restrictions apply."
>
> Perhaps Linux does support hard-links to directories?
>
> mkdir("foo", 0644)                      = 0
> link("foo", "bar")                      = -1 EPERM (Operation not
> permitted) _exit(0)                                = ?
>
> Nah... No such luck. I'll bet it's artificial. I think you
> could remove that S_IFDIR check and get away with it!

Nope -- what you get is a corrupted filesystem.... Usually, a lost directory
gets put in lost+found, othertimes you get a "corrupted inode", and if the
inode is cleared you then find every file that was contained in the directory
that used to be the inode, is now in lost+found.

The only place I can think of that this might not happen are those filesystems
that don't use the UNIX style tree structure.
