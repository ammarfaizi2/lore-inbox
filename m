Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTHDVRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272253AbTHDVRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:17:10 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:45811 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272251AbTHDVRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:17:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: FS: hardlinks on directories
Date: Mon, 4 Aug 2003 16:16:39 -0500
X-Mailer: KMail [version 1.2]
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk> <20030804165002.791aae3d.skraw@ithnet.com>
In-Reply-To: <20030804165002.791aae3d.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080416163901.04444@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 09:50, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 15:04:28 +0100 (BST)
>
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > For a start the kernel VFS dcache would break because you end up with
> > multiple entries for each inode, one entry for each parallel directory
> > tree.  Read-only you are just about able to get away with it (been there,
> > done that, don't recommend it!) but allow files to be deleted and it will
> > blow up in your face.
>
> I cannot comment, I have no inside knowledge of it.
>
> > You ask for examples of applications?  There are millions!  Anything that
> > walks the directory tree for a start, e.g. ls -R, find, locatedb, medusa,
> > du, any type of search and/or indexing engine, chown -R, cp -R, scp
> > -R, chmod -R, etc...
>
> There is a flaw in this argument. If I am told that mount --bind does just
> about what I want to have as a feature then these applictions must have the
> same problems already (if I mount braindead). So an implementation in fs
> cannot do any _additional_ damage to these applications, or not?

Mount -bind only modifies the transient memory storage of a directory. It 
doesn't change the filesystem. Each bind occupies memory, and on a reboot, 
the bind is gone.

> My saying is not "I want to have hardlinks for creating a big mess of loops
> inside my filesystems". Your view simply drops the fact that there are more
> possibilities to create and use hardlinks without any loops...

been there done that, is is a "big mess of loops".

And you can't prevent the loops either, without scanning the entire graph, or
keeping a graph location reference embeded with the file.
Which then breaks "mv" for renaming directories... It would then have to
scan the entire graph again to locate a possble creation of a loop, and 
regenerate the graph location for every file.
