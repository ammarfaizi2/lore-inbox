Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUBJUNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBJUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:12:14 -0500
Received: from thunk.org ([140.239.227.29]:45770 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264477AbUBJUL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:11:26 -0500
Date: Tue, 10 Feb 2004 15:11:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210201119.GA1253@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Mike Bell <kernel@mikebell.org>, linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210175548.GN4421@tinyvaio.nome.ca> <20040210181932.GI28111@kroah.com> <20040210184302.GP4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210184302.GP4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:43:03AM -0800, Mike Bell wrote:
> That's a valid point against the existing devfs/devfsd, there are a few
> of those (the races, for instance). But it's not inherent to the idea of
> a devfs.

At least some races are inherent to the idea of having a filesystem
which is mounted on /dev.  At some level, this seems to be your main
complaint to the udev/sysfs combination --- that you cannot mount some
particular magic filesystem on top of /dev.  But think about it.  If
you are having the kernel specify a specific name, and then allow
devfsd program to override it (but have it magically appear in /dev if
devfsd is not running) it is very hard to avoid the races, and it
certainly makes it hard to do anything other than the one sender, one
receiver model.

If instead you have a filesystem which fundamentally must be mounted
somewhere else, such that there is no question that it can't be
mounted on /dev, and you have a notifer which tells you what's going
on --- well, you have the udev/sysfs combination.  

You could pontentially do this if you mount the devfs filesystem on
/devfs, but as near as I can tell, that was just a stalking horse by
the devfs folks who tried to be all things to all people.  If you're
going to mount devfs on /devfs, then udev/sysfs does a better job,
because that's what it's designed to do.

> > udev defaults to this.  Which is the sane thing to do.
> 
> I don't know about that. from what I remember of the original devfs
> discussion, it was along the lines of "LSB involves every device in
> /dev, and is dumb.  We need a new scheme, this is as good as any. Anyone
> who has a better idea for how devices should be laid out, let me know."

What udev defaults to is making the namespace be controlled strictly
by the userspace.  (i.e., the mount devfs on /devfs approach).  

As far as putting everything device name in a single directory, that
doesn't happen in /sysfs, since the filesystem tree reflects the
system's device tree.  And in terms of where to put the devices in
/dev, in udev that's strictly a userpsace issue --- which is where it
should be.


						- Ted
