Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272248AbTHDVJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272250AbTHDVJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:09:58 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:44275 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272248AbTHDVJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:09:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: FS: hardlinks on directories
Date: Mon, 4 Aug 2003 16:09:28 -0500
X-Mailer: KMail [version 1.2]
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com>
In-Reply-To: <20030804170506.11426617.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080416092800.04444@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 10:05, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 09:33:44 -0500
>
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> > Find for one. Any application that must scan the tree in a search. Any
> > application that must backup every file for another (I know, dump
> > bypasses the filesystem to make backups, tar doesn't).
>
> All that can handle symlinks already have the same problem nowadays. Where
> is the difference? And yet again: it is no _must_ for the feature to use it
> for creating complete loops inside your fs.
> You _can_ as well dd if=/dev/zero of=/dev/hda, but of course you shouldn't.
> Have you therefore deleted dd from your bin ?

The difference is "SYMLINK". That is not a hard link. The are file with a
mode bit that identifies them as a symlink. The contents of the file is the
reference to the real file.

A symlink is a file with its' own inode number. It may point to files on any
filesystem (or none actually).

>
> > It introduces too many unique problems to be easily handled. That is why
> > symbolic links actually work. Symbolic links are not hard links,
> > therefore they are not processed as part of the tree. and do not cause
> > loops.
>
> tar --dereference loops on symlinks _today_, to name an example.
> All you have to do is to provide a way to find out if a directory is a
> hardlink, nothing more. And that should be easy.

Yup - because a symlink is NOT a hard link. it is a file.

If you use hard links then there is no way to determine which is the "proper"
link.

>
> > It was also done in one of the "popular" code management systems under
> > unix. (it allowed a "mount" of the system root to be under the CVS
> > repository to detect unauthorized modifications...). Unfortunately,
> > the system could not be backed up anymore. 1. A dump of the CVS
> > filesystem turned into a dump of the entire system... 2. You could not
> > restore the backups... The dumps failed (bru at the time) because the
> > pathnames got too long, the restore failed since it ran out of disk space
> > due to the multiple copies of the tree being created.
>
> And they never heard of "--exclude" in tar, did they?

Doesn't work. Remember - you have to --exclude EVERY possible loop. And 
unless you know ahead of time, you can't exclude it. The only way we found
to reliably do the backup was to dismount the CVS.

> > The KIS principle is the key. A graph is NOT simple to maintain.
>
> This is true. But I am very willing to believe reiserfs is not simple
> either, still it is there ;-)

The filesystem structure IS simple.
