Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTH2QFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTH2QFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:05:08 -0400
Received: from tmi.comex.ru ([217.10.33.92]:12693 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261322AbTH2QFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:05:01 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 29 Aug 2003 20:10:29 +0400
In-Reply-To: <3F4F76A5.6020000@wmich.edu> (Ed Sweetman's message of "Fri, 29
 Aug 2003 11:52:05 -0400")
Message-ID: <m3r834phqi.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:

 ES> in the kernels that would boot (for some reason test4's videodev
 ES> driver is borked so i used the mm patchset) passed the serio drivers,
 ES> init was unable to be found, no matter what even though it mounted the
 ES> root fs and the root fs is not as far as i can tell when booting on
 ES> older kernels, corrupted.   I'm writing now in mozilla from the very
 ES> system but with extents turned off.  I'm somewhat afraid though that
 ES> even though i didn't mount the partitions with the extents option,
 ES> that the patch may still be having an adverse effect.  Right now
 ES> things seem pretty stable but last night apt was hanging while
 ES> generating locales reproducably causing the entire kernel to lose the
 ES> ability to do anything to the fs. This was all being tested on
 ES> test3-mm1.  I am aware that mm does have some patches to ext3 that
 ES> aren't in the main kernel i believe. perhaps the xattr stuff is
 ES> conflicting in some way?  I really have no way of testing the linus
 ES> tree directly because the drivers i use wont compile.

first of all, once fs gets mounted with extents support any newly created
files/dirs will be stored in extents-format. thus, if you remount that fs
w/o extents support you won't be able to access those files/dirs.

I really propose you don't use extents on a partitions you care about for a while.

 ES> All in all though, when it was enabled, i saw really no difference
 ES> from when it was not enabled. dbench 16 gave me ~140MB/sec either
 ES> way. md5summing large files resulted in equal performance as well.  I
 ES> got nothing even close to the kind of performance increases you showed
 ES> in the first mail.

quite interesting result. could you help me to investigate that?
it would be great to go through following steps:
1) create fresh ext3 fs
2) mount it w/o extents option
3) run dbench 16 for few times (say, 4)
   make sure it performs on that filesystem (cd <mntpoint>; dbench -c ... 16)
4) unmount fs
5) recreate that fs
6) mount it with extents option
   'EXT3-fs: file extents enabled' should be printed in logs
7) run dbench 16 for few times
8) unmount that fs and take a look in logs, you should see stats info about
   extents usage

thank you!

