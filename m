Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULAFMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULAFMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULAFMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:12:14 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:33013 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261172AbULAFMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:12:00 -0500
Message-ID: <41AD5290.9060704@comcast.net>
Date: Wed, 01 Dec 2004 00:11:44 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Lougher <phil.lougher@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
References: <41ABF7C5.5070609@comcast.net>	 <cce9e37e041130112243beb62d@mail.gmail.com>	 <41AD218E.7090305@comcast.net> <cce9e37e04113018465091010f@mail.gmail.com>
In-Reply-To: <cce9e37e04113018465091010f@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Phil Lougher wrote:
|
| Yes you're right.  What I said was total rubbish.  I read your
| statement as meaning to dynamically allocate/deallocate inodes from a
| set configured at filesystem creation...
|

heh :P np

|
|>
|>Ugly, but ok.  What happens when i actually have >4G inodes though?
|
|
| Well this is an issue that affects all filesystems on 32-bit systems
| (as Alan said inode numbers are 64 bits on 64 bit systems).  To be
| honest I've never let this worry me...
|
| A 32-bit system can never cache 4G inodes in memory without falling
| over, and so a simple solution would be to allocate the 32-bit inode
| number dynamically (e.g. starting at one and going up, keeping track
| of inode numbers still used for use when/if wraparound occured), this
| would guarantee inode number uniqueness for the subset of file inodes
| in memory at any one time, with the drawback that inode numbers
| allocated to files will change over filesystem mounts.  Alternatively
| from reading fs/inode.c it appears that inode numbers only need to be
| unique if the fast hashed inode cache lookup functions are used, there
| are other inode cache lookup functions that can be used if inode
| numbers are not unique.
|

*blink*

slower next time.

|
|>| I've had people trying to store 500,000 + files in a Squashfs
|>| directory.  Needless to say with the original directory implementation
|>| this didn't work terribly well...
|>|
|>
|>Ouch.  Someone told me the directory had to be O(1) lookup . . . .
|
|
| Ideally yes, but ultimately with your filesystem you make the rules
| :-)   The Squashfs directory design was fast for the original expected
| directory size (ideally <= 64K, maximum 512K) seen on embedded
| systems.  The next release of Squashfs has considerably improved
| indexed directories which are O(1) for large directories.  To be
| released sometime soon, if anyone's interested...
|

hm.  If I ever get a basic design off the ground (within the next month,
if ever), would you be willing to work with me on putting on polish and
possibly coding it?  Preferably I'd like to find some time to learn how
to code an FS myself-- though my goal is to make "the perfet file
system," so I can't imagine what use that'd have ;) (well, I could fail
the second time around-- I sure fucked up my first attempt last year).
Maybe you could give me guidance when I get to that point, if you don't
have time/will to do (what will inevitably become the bulk of) the work?

Of course, you don't HAVE to, and don't have to commit to this now; but
if you want, I'll poke you later about it.

| Phillip Lougher
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrVKPhDd4aOud5P8RAsO0AJ9LWWR2EItEl7HrcMlt0SZl+PjMEACeMnBQ
Rmhzqz+M8NXQZoYiVoaUbHU=
=6Roh
-----END PGP SIGNATURE-----
