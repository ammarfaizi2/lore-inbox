Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSKCCPM>; Sat, 2 Nov 2002 21:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSKCCPM>; Sat, 2 Nov 2002 21:15:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57853 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261556AbSKCCPL>;
	Sat, 2 Nov 2002 21:15:11 -0500
Date: Sat, 2 Nov 2002 21:21:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> The reason I like directory entries as opposed to inodes is that if you
> work this way, you can actually give different people _different_
> capabilities for the same program.  You don't need to have two different
> installs, you can have one install and two different links to it.

	<shrug> that can be done without doing anything to filesystem.
Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
Then use bindings instead of links.  *Note* - binary _is_ marked suid,
mask tells which capabilities _not_ to gain.  It's OK - attempt to
link(2) to the thing using binding will see that oldname and newname
are within different vfsmounts, so instead of link to suid-root binary
you get -EXDEV.

	And that works on any fs, can be made per-user and can be _seen_
by admin - bindings are visible in /proc/mounts (yes, I remember that
we need to fix the crap with pathnames).

	I can do that thing in a weekend - it's trivial to implement.
No need to bugger filesystems for that.

