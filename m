Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272815AbTHEOVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272816AbTHEOVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:21:13 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:59642 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272815AbTHEOVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:21:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: FS: hardlinks on directories
Date: Tue, 5 Aug 2003 09:20:41 -0500
X-Mailer: KMail [version 1.2]
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080416163901.04444@tabby> <20030805013425.03fb9871.skraw@ithnet.com>
In-Reply-To: <20030805013425.03fb9871.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080509204101.05972@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 18:34, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 16:16:39 -0500
>
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> > > > You ask for examples of applications?  There are millions!  Anything
> > > > that walks the directory tree for a start, e.g. ls -R, find,
> > > > locatedb, medusa, du, any type of search and/or indexing engine,
> > > > chown -R, cp -R, scp -R, chmod -R, etc...
> > >
> > > There is a flaw in this argument. If I am told that mount --bind does
> > > just about what I want to have as a feature then these applictions must
> > > have the same problems already (if I mount braindead). So an
> > > implementation in fs cannot do any _additional_ damage to these
> > > applications, or not?
> >
> > Mount -bind only modifies the transient memory storage of a directory. It
> > doesn't change the filesystem. Each bind occupies memory, and on a
> > reboot, the bind is gone.
>
> What kind of an argument is this? What difference can you see between a
> transient loop and a permanent loop for the applications? Exactly zero I
> guess. In my environments nil boots ought to happen.

simple .. tar --one-file-system will not process past a mount point.

> This is the reason why I would in fact be satisfied with mount -bind if
> only I could export it via nfs...

it's a MOUNT point. NFS doesn't export across mount points just as it doesn't
allow exporting a NFS mounted directory.

>
> > > My saying is not "I want to have hardlinks for creating a big mess of
> > > loops inside my filesystems". Your view simply drops the fact that
> > > there are more possibilities to create and use hardlinks without any
> > > loops...
> >
> > been there done that, is is a "big mess of loops".
> >
> > And you can't prevent the loops either, without scanning the entire
> > graph, or keeping a graph location reference embeded with the file.
>
> Or marking the links as type links somehow.
>
> > Which then breaks "mv" for renaming directories... It would then have to
> > scan the entire graph again to locate a possble creation of a loop, and
> > regenerate the graph location for every file.
>
> There should be no difference if only a hardlink is simply marked as such
> by any kind of marker you possibly can think of.

think about what happens with a "rm -rf name". If there are two parents you 
cant remove the other parents link without first finding it. hard links
do not have a marker.
