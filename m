Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbSJFSuK>; Sun, 6 Oct 2002 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJFSuK>; Sun, 6 Oct 2002 14:50:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15325 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262125AbSJFSuK>;
	Sun, 6 Oct 2002 14:50:10 -0400
Date: Sun, 6 Oct 2002 14:55:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: [RFC] killing DEVFS_FL_AUTO_OWNER
Message-ID: <Pine.GSO.4.21.0210061428540.25699-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Devfs supports an interesting "feature" (read: gaping security
hole waiting to happen).  Namely, there is one (1) driver that asks
for the following behaviour:
	its nodes (/dev/video1394/*) are created with root.root rw-rw-rw-
	opening a node sets (with feel^Wraces) ownership to that of opening
task and mode to rw-------.
	if you close it, wait for dentry to be evicted and open it again -
you get root.root rw-rw-rw- and it will stay that way after open().

Now, I might try and guess WTF had been intended (reversion to permissions
of the Beast upon final close() and subsequent open() acting as the first one),
but even if it would behave that way...

Just ask yourself what will happen to any program that relies on this
behavior on a system where /dev is not on devfs.  And that, BTW, is
the setup suggested by vidoe1394 folks on their homepage.

Now, I don't ask WTF had been smoked to produce that code - I don't want to
know and it's probably illegal anywhere (if it isn't, it should be).  The
question is could we fscking please remove that idiocy?  Unless somebody
gives a good reason why behaviour of DEVFS_FL_AUTO_OWNER is _not_ a
security hole - I'm submitting a patch that removes this crap in a couple
of hours.

