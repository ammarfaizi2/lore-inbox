Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269113AbTCBACK>; Sat, 1 Mar 2003 19:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269114AbTCBACK>; Sat, 1 Mar 2003 19:02:10 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:45704 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269113AbTCBACI>; Sat, 1 Mar 2003 19:02:08 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 1 Mar 2003 16:11:55 -0800
Message-Id: <200303020011.QAA13450@adam.yggdrasil.com>
To: andrea@suse.de, linux-kernel@vger.kernel.org, pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Cc: hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I've created little project for read-only (for now ;-) kitbeeper
> clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> just get it fresh from CVS).

	Thank you for taking some initiative and improving this
situation by constructive means.  You are an example to us all,
as is Andrea Arcangeli with his openbkweb project, which you
will probably want to examine and perhaps integrate
(ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/openbkweb).

	bitbucket is about 350 lines of shell scripts, documentation
and diffs, the most interesting file of which is FORMAT, which
documents some reverse engineering efforts on bitkeeper internal file
formats.  bitkbucket currently uses rsync to update data from the
repository.  openbkweb is 500+ lines of python that implements enough
of the bitkeeper network protocol to do downloads, although perhaps in
inefficiently.  That sounds like some functionality that you might be
interested in integrating.

	I think the suggestion made by Pavel Janik that it would
be better to work on adding BitKeeper-like functionality to existing
free software packages is a bit misdirected.  BitKeeper uses SCCS
format, and we have a GPL'ed SCCS clone ("cssc"), so you are
adding functionality to existing free software version control
code anyhow.

	However, I would like to turn Pavel Janik's point in
what I think might be a more constructive direction.

	Aegis, BitKeeper and probably other configuration management
tools that use sccs or rcs basically share a common type of lower
layer.  This lower layer converts a file-based revision control system
such as sccs to an "uber-cvs", as someone called it in a slashdot
discussion, that can:

	    1. process a transaction against a group of files atomically,
	    2. associate a comment with such a transaction rather than
	       with just one file,
	    3. represent symbolic links, file protections
            4. represent file renames (and perhaps copies?)

	You might want to keep in the back of your mind the
possibility of someday splitting off this lower level into a separate
software package that programs like your bitkeeper clone, aegis could
use in common.  If the interface to this lower level took cvs
commands, then it could probably replace cvs, although the repository
would probably be incompatible since the meaning of things like
checking in multiple files together with a single comment would be
different, and there would be other kinds of changes to represent
beyond what cvs currently does.  Using a repository format that is
compatible with another system (for example bitkeeper or aegis) would
make such a tool more useful, and if such a tool makes it easier for
people to migrate from a prorprietary system to a free one, that's
even better, so your starting with bitkeeper's format seems like an
excellent choice to me.

	Thanks again for starting this project.  I will at least
try to be a user of it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
