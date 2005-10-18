Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVJRTkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVJRTkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVJRTkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:40:40 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59568 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751480AbVJRTkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:40:39 -0400
Message-ID: <43554F1C.9090901@comcast.net>
Date: Tue, 18 Oct 2005 15:38:04 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: Keep initrd tasks running?
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain>
In-Reply-To: <1129663759.18784.98.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jeff Bailey wrote:
> Le mardi 18 octobre 2005 à 15:13 -0400, John Richard Moser a écrit :
> 
>>I have no idea who's the best to ask for this.
>>
>>I want to start a task in an initrd and have it stay running after init
>>is started.  Pretty much:
> 
> 
>>What's the feasibility of this without the system balking and vomiting
>>chunks everywhere?  I'm pretty sure 'exec /sbin/init' from linuxrc
>>(PID=1) will replace the process image of sh (linuxrc) with init,
>>keeping PID=1; but I'm worried this may terminate children too.  Haven't
>>tried.
> 
> 
> This is much more easily supported in Breezy.  usplash is started at the
> top of the initramfs (from the init-top hook) and lives until we start
> gdm.
> 

So in short it's possible?

> The biggest constraint is that you don't have write access to the target
> root filesystem (since it's mounted readonly).  However, /dev is a tmpfs
> that is move mounted to the new root system.  If you need to have
> sockets open or store data, you can use that.  usplash does this for its
> socket.
> 

That's not much of a problem for me.  What I'm contemplating is a FUSE
file system driver that gets started in the initrd, and a kernel that
has a file system driver built-in for something stupid like cramfs or MINIX.

The idea is that (as proof of concept) it should be possible to supply
something like ext3 as a FUSE driver, and boot off it as the rootfs
without building ext3 into the kernel or ever modprobing it.  Besides
just being damn cool, and a show of quasi-hybrid microkernelism at work
(uh oh now Linus is going to remove FUSE from mainline :), it'd allow
some real visible macro-benchmarking of FUSE.

> Note that the initramfs startup sequence isn't at all similar to the old
> initrd startups.  It should be easy for you to cleanly add what you want
> under /etc/mkinitramfs/scripts and not have to modify the
> initramfs-tools package.  /usr/share/doc/initramfs-tools/HACKING
> contains some starter information.
> 
> Hope this helps!
> 
> Tks,
> Jeff Bailey
> 
> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVU8bhDd4aOud5P8RAoFSAJwImO0TNH5tJKyrhZ7mSs8zUWDMUwCfYCT6
0IaiHMCZxglMNnlVTvLHm8o=
=+0g0
-----END PGP SIGNATURE-----
