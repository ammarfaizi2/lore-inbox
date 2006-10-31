Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161574AbWJaDmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161574AbWJaDmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161576AbWJaDmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:42:51 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:39383 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1161574AbWJaDmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:42:50 -0500
Message-ID: <4546C637.5080504@comcast.net>
Date: Mon, 30 Oct 2006 22:42:47 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspend to disk:  do we HAVE to use swap?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Something dumb came into my head, and the question is thus brought up
here:  Do we HAVE to use swap for suspend to disk? How about the file
system?

   [ Another thought I had here was where the word 'we' comes from; it
     seems habitual.  I'm not writing any of this code! ]

The first thought that came to my mind was:  The file system may not be
in a stable state.  If we don't use swap we're obviously using the FS;
so it has to be safe to mount.  Simple solution:  suspend to disk should
trigger the FS drivers to flush their state to disk and tie things off.
 Thus when we begin suspend things are suspended; the drivers know that
the only files to be created are the ones the kernel will make; and it's
safe for us to allocate space and make files, because we can read them
later.

This brings another thought:  If we use files, we have to do the above
so the disk can be mounted and read later.  This means the disk can be
mounted read-write by a LiveCD or other OS or whatever between--safely.
  So then, what do we do about changing files?  Files open and mmap()'d
are a huge problem if someone messes with them; solutions for this I do
not have, perhaps store the page cache as well.

So another thought:  What happens if we use the file system?  The kernel
goes and gets.. what?  Do we come up with the FS in read-only mode (from
an initrd or booting, either way) and have userspace tools tell the
kernel to resume from a given file?

And further, what if you change kernel versions?  Can we embed the
kernel version in the suspend image and get the kexec framework to load
that?  Have it bootstrap itself in and get to work resuming?

How about compressed images?  Can the suspend image be compressed as
it's stored, decompressed as it's read?

And, of course, WHY would you use a file on the file system instead of
swap?  This is probably the easiest and most straightforward question.
If you have 4 gigs of RAM, you might not want 4 gigs of swap.  Maybe you
have 256M of swap and 1 gig of ram.  Not much choice here.

Anyway, just random thoughts rolled out there in case anyone needs a
random seed.
- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUbGNgs1xW0HCTEFAQLaog//Z6c1KdRQxlc0B2GpRJSuyblVLBNmwK9n
IPMN+HA6c7u3EAiKq2PVVFUA1mhL/cyfnabG/p23sBKjdwZTodBDxMFw9y/SXa4k
g36mXsXOopZrUXmOJi0y0T/L96+iEzwr5Z++sMaybB5E9tsXKJiXmMwtEjc+HbEj
MW+ZGHTKcGqtei8OunvLkKSlCt3aaqwMWc5j3CM1gRODyShfY/NOeJTbGZG3fERB
25Gfa/KbCQVrgnhbyAyX+BggBkKHaw4tl6ari529JidkE1eie1O1zO8TlMi+rRmb
BgO6uZDWtZUTgKN662uamVHN5RvYW0QC1AqCDljKibQYZrtkoMN6AHZv+rp0z0G/
CcIld8ywgMOjcKK+8jKtYi9UUqkxgqIRH1IidRGgI7GKZqAqt357b6HTA2UxL59D
Gp0Z3/GgJqZBnb71wZLob/eTDC6hRzEmj7LJYZS//dYEkgD5aSA1NLulYuFoDEp5
eIOctN5GsHw0Gq90m/Oy24qPdgrm9J9wTE4eAEPLam3WKjZa9yo5Woq4lALwOda9
exsYDWzXD/EXekVM648673igfnZvcqN9lGavpfwOJaAIaMYKPX55suk1Kp9ZbFVQ
Wl1cBGmQ1Dpnlf6M0BVLi3jyUsUJy2AH/hRGhIYL+r8DzlffNI5ibLuCyMfoKwge
jMx6FuzqBKk=
=hpQy
-----END PGP SIGNATURE-----
