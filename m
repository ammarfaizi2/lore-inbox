Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUIYAvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUIYAvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 20:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269155AbUIYAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 20:51:15 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:2537 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S269153AbUIYAvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 20:51:07 -0400
Date: Fri, 24 Sep 2004 20:50:58 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [announce] Autofs NG 0.1
To: linux-kernel@vger.kernel.org, autofs@linux.kernel.org
Cc: thockin@hockin.org, raven@themaw.net, mark.fasheh@oracle.com
Message-id: <4154C0F2.708@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi folks,

Some of you may remember my posting of a new way to do autofs in Linux a
while back:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107341940326348&w=2

Anyhow,  I've gotten to the point where I have code that people can play
with.  I've posted it all at http://autofsng.bkbits.net

There are two repos located there, one is the userspace bits (autofsng).
~ It has the 'utility' (automount) and the autofs usermode agent
(autofs).  This tree began as a automount 3.1.7 tree, but has
drastically changed.  Lots of good stuff has yet to be merged in from
the automount 4 daemon.

The kernel bits are in the linux-2.6-autofsng repository.   Broken out
patches are forthcoming in the next (weeks?) [*].  It has the following
major changes to it:

- - changes to the vfsmount tree structures so that you can detach and
re-attach sub-trees of the vfsmount tree.  The current implementation is
admittedly a bit gross and will require work to make it pretty (and to
get rid of having to grab a rwlock on every mntget/mntput!).

- - the addition of a mountpoint file descriptor api.  I don't care for
the interface at the moment, and I'll be posting interface descriptions
later on along with broken out patches so that the interface itself can
be thought through.

- - vfs native support for expiring mountpoints (and entire subtrees of
them).  There currently exists a syscall entry to specify this from
userspace as a way to easily test it.  As well, you can specify expiry
information using the above mountpoint file descriptor api.

- - a new module implementing the 'autofs' filesystem called autofsng.
This filesystem will support automounting of both direct and indirect
maps.  It also supports 'browsing'.  Most of this magic happens using
'->follow_link' walks on directory inodes.   This is ugly, but it
appears to be the best way to properly handle automounting from within
the kernel.

There does remain a good amount of work to do, and I've tried to list
things on the top of my head in the autofsng/autofs/TODO file.  I'm sure
I missed stuff :\

At this point, I can run and pass a ported autofs connectathon
testsuite.  I'm working on figuring out how to get the testsuite
included in the package.  For comparison,  both autofs3 and autofs4
couldn't handle the majority (>%95) of the tests done.  As well, we've
uncovered a couple of nfs related issues that we'll be following up with
on the nfs list.

So, if you have time to spare and you care about automounting, please
have a try at using it.  If you are curious enough to wade through it,
feel free to give feedback/flames/comments on the code/design/weather.

Thanks,

[*] - I know it is bad practice to pop-up out of nowhere with large
changes, but I wasn't able to get anything out much earlier due to a
variety of reasons.  From now on, expect to see much traffic from me as
I feed a broken-out patchsets to the list.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBVMDydQs4kOxk3/MRAnQsAJ0XHLJA/HkAHTLSPjGZU75Bc3oJiQCfUWoE
p94ERBoBhTa2jG2CJjT9Er8=
=1RaX
-----END PGP SIGNATURE-----
