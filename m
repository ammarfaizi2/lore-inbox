Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWAWBDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWAWBDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWAWBDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:03:38 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:16595 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932409AbWAWBDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:03:38 -0500
Message-ID: <43D42B25.3010706@comcast.net>
Date: Sun, 22 Jan 2006 20:02:29 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
In-Reply-To: <20060122210238.GA28980@thunk.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Theodore Ts'o wrote:
> On Sun, Jan 22, 2006 at 01:54:23PM -0500, John Richard Moser wrote:
> 
>>>Whenever you want to extend a filesystem to add some new feature, such
>>>as online resizing, for example, it's not enough to just add that
>>
>>Online resizing is ever safe?  I mean, with on-disk filesystem layout
>>support I could somewhat believe it for growing; for shrinking you'd
>>need a way to move files around without damaging them (possible).  I
>>guess it would be.
>>
>>So how does this work?  Move files -> alter file system superblocks?
> 
> 
> The online resizing support in ext3 only grows the filesystems; it
> doesn't shrink it.  What is currently supported in 2.6 requires you to
> reserve space in advance.  There is also a slight modification to the
> ext2/3 filesystem format which is only supported by Linux 2.6 which
> allows you to grow the filesystem without needing to move filesystem
> data structures around; the kernel patches for actualling doing this
> new style of online resizing aren't yet in mainline yet, although they
> have been posted to ext2-devel for evaluation.
> 
> 
>>A passive-active approach could passively generate a list of inodes from
>>dentries as they're accessed; and actively walk the directory tree when
>>the disk is idle.  Then a quick allocation check between inodes and
>>whatever allocation lists or trees there are could be done.
> 
> 
> That doesn't really help, because in order to release the unused disk
> blocks, you have to walk every single inode and keep track of the
> block allocation bitmaps for the entire filesystem.  If you have a
> really big filesystem, it may require hundreds of megabytes of
> non-swappable kernel memory.  And if you try to do this in userspace,
> it becomes an unholy mess trying to keep the userspace and in-kernel
> mounted filesystem data structures in sync.
> 

Yeah I figured that you couldn't take action until everything was seen;
I can see how you could have problems with all that kernel memory ;)
FUSE driver, anyone?  :>

(I've actually looked into FUSE for the rootfs, via loading a fuser
driver from an init.d and then replacing bash with init on the rootfs;
haven't found an ext2 or xfs fuse driver to test with)
> 						- Ted
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1CskhDd4aOud5P8RArmJAJ9mgLjkxUcg5GW1o4q88Cb6ESmdCACZAS00
M1R+7biZpmOCCCBkEXVQL7w=
=060w
-----END PGP SIGNATURE-----
