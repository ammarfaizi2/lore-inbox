Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTHDOEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHDOEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:04:31 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:40884 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S271740AbTHDOEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:04:30 -0400
Date: Mon, 4 Aug 2003 15:04:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030804155604.2cdb96e7.skraw@ithnet.com>
Message-ID: <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl>
 <20030804155604.2cdb96e7.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 15:44:15 +0200
> Andries Brouwer <aebr@win.tue.nl> wrote:
> > On Mon, Aug 04, 2003 at 02:15:48PM +0200, Stephan von Krawczynski wrote:
> > > although it is very likely I am entering (again :-) an ancient discussion I
> > > would like to ask why hardlinks on directories are not allowed/no supported
> > > fs action these days.
> >
> > Quite a lot of software thinks that the file hierarchy is a tree,
> > if you wish a forest.
> >
> > Things would break badly if the hierarchy became an arbitrary graph.
>
> Care to name one? What exactly is the rule you see broken? Sure you can build
> loops, but you cannot prevent people from doing braindamaged things to their
> data anyway. You would not ban dd either for being able to flatten your
> harddisk only because of one mistyping char...
> Every feature can be misused and then damaging, but that is no real reason not
> to have it - IMHO.

For a start the kernel VFS dcache would break because you end up with
multiple entries for each inode, one entry for each parallel directory
tree.  Read-only you are just about able to get away with it (been there,
done that, don't recommend it!) but allow files to be deleted and it will
blow up in your face.

You ask for examples of applications?  There are millions!  Anything that
walks the directory tree for a start, e.g. ls -R, find, locatedb, medusa,
du, any type of search and/or indexing engine, chown -R, cp -R, scp
-R, chmod -R, etc...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
