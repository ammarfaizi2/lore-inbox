Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBYEQg>; Sat, 24 Feb 2001 23:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129817AbRBYEQQ>; Sat, 24 Feb 2001 23:16:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50392 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129280AbRBYEQM>;
	Sat, 24 Feb 2001 23:16:12 -0500
Date: Sat, 24 Feb 2001 23:16:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] per-process namespaces for Linux
Message-ID: <Pine.GSO.4.21.0102242253460.24312-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	He's back. And this time he's got a chainsaw.

	Yes, folks. We got per-process namespaces. Working. With proper
behaviour on exit(), yodda, yodda. Enjoy. Help with testing would be more
than welcome.

Current patch is on ftp.math.psu.edu/pub/viro/namespaces-S2.gz
It's against 2.4.2.

Contents:
	* proper refcounting of struct super_block
	* GC for vfsmounts (finally)
	* fix for races between get_super() and umount()
	* SMP-safe lock_super()
	* general cleanup of fs/super.c
	* "lazy" option for umount() (detach from mountpoint now, do the
rest when it will cease to be busy - use MNT_DETACH in 'flags' argument
to get that behaviour).
	* Plan 9 per-process namespaces (sans unions so far)
	* large cleanup of boot process (ramdisk handling, etc.)

Variant without namespaces (they were the last part) is in the same
directory, called s_lock-S2.gz.

rfork.c (in the same place) will copy a namespace and start shell in it.
Use for testing... It's an equivalent of rfork(RFNAMEG) on Plan 9.

One detail - patch requires ramfs built into the kernel (boot process cleanup
part needs that).

It works here (ran for about 12 hours with no problems). It's _NOT_ for
inclusion into 2.4. Some pieces might go (get_super() races have to be
fixed, after all), but most of this stuff is 2.5 fodder. However, it
seems to be working. No doubt there are bugs and it's far from being
a final version. I would call it _very_ early beta. Please, help with
testing.

Comments on the code/design/amount of dope it took to write the thing (zero,
actually) are welcome. I _will_ document it, but it's still not in the
final form. Pretty close to it, hopefully, but...

I'm more than willing to answer questions on the design of the thing - just
ask. So far that's the best I can do - all documentation is a pile of notes
+ CVS log.

							Cheers,
								Al
PS: hopefully - back for good.

