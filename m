Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSEOV1v>; Wed, 15 May 2002 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316493AbSEOV1u>; Wed, 15 May 2002 17:27:50 -0400
Received: from [195.223.140.120] ([195.223.140.120]:42792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316488AbSEOV1t>; Wed, 15 May 2002 17:27:49 -0400
Date: Wed, 15 May 2002 23:27:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre8aa3
Message-ID: <20020515212733.GA1025@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main differences with the previous aa2 are:

o	sparc64 should work now (untested)
o	merged NUMA-Q NUMA arch support from IBM
o	various other fixes also from -ac
o	minor bdflush tuning difference to avoid char-writer in bonnie
	to stall and to slowdown too much (can make a difference in real
	life)
o	latest UML (also fixed initrd loading)
o	really release initrd ram0 memory

URL full -aa patchkit:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa3/

Only the VM changes in the -aa patchkit against vanilla 2.4.19pre8
(ready for inclusion in mainline):

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre8/vm-35.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre8/vm-35/

Diff between 2.4.19pre8aa2 and 2.4.19pre8aa3:

Only in 2.4.19pre8aa3: 00_bdflush-tuning-1

	Put the mid watermark at 50% (near the high watermark so we don't stall
	too much).

Only in 2.4.19pre8aa3: 00_dnotify-cleanup-1

	Dnotify cleanups (minor improvements actually) from 2.4.19pre8ac2.

Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1

	Make sure to always try mounting with ext3 before ext2 (otherwise
	it's impossible to mount the real rootfs with ext3 if ext3 is a module
	loaded by an initrd and ext2 is linked into the kernel).

Only in 2.4.19pre8aa2: 00_initrd-free-1
Only in 2.4.19pre8aa3: 00_initrd-free-2

	Backout wrong patch and insert the printk fix. However the unmount in
	/old keeps returning -EINVAL of course, that's at the very least
	misleading, it would also be nice some documentation on the exact
	semantics of MS_MOVE, tested mount --move under UML but it's not at all
	clear what's going on with the "/", ".", ".." and didn't had the time
	to reverse engeneer the semantics from the code in do_move_mount yet
	(started and I will continue in the next days, but interpreting the code
	with some basic lines of what I should expect would be faster).  Printk
	fix from Al.

Only in 2.4.19pre8aa3: 00_reaper-thread-race-1

	SMP race fix that avoids losing reference of zombies with threads exits
	from 2.4.19pre8ac2.

Only in 2.4.19pre8aa3: 00_ufs-compile-1
Only in 2.4.19pre8aa3: 00_umem-compile-1

	Compile fixes (ufs from Hubert Mantel).

Only in 2.4.19pre8aa2: 05_vm_10_read_write_tweaks-1
Only in 2.4.19pre8aa3: 05_vm_10_read_write_tweaks-2

	Avoid backing out the flush_page_to_ram in this vm patch,
	the one on the pagecache is still needed before the memcpy
	on the pagecache during the early cow (would be cleaner
	to move it up, if Hugh wants to clean it up that's welcome,
	it will be an orthogonal patch, so far I just avoid to
	change that area in my changes, not high prio to clean it up
	as DaveM side it's more high prio to conver the users of
	flush_page_to_ram API to flush_dcache_page/icache new API during 2.5).

Only in 2.4.19pre8aa3: 21_pte-highmem-24-sparc64

	Now -aa is suposed to work fine with sparc64 (still untested though).

Only in 2.4.19pre8aa2: 50_uml-patch-2.4.18-22.gz
Only in 2.4.19pre8aa3: 50_uml-patch-2.4.18-25.gz
Only in 2.4.19pre8aa3: 52_uml-sys-read-write-1
Only in 2.4.19pre8aa2: 59_uml-compat-2.5-1
Only in 2.4.19pre8aa3: 59_uml-compat-2.5-2
Only in 2.4.19pre8aa2: 62_tux-uml-1
Only in 2.4.19pre8aa3: 62_tux-uml-2

	UML updates (in particular fixes initrd loading, in previous version
	read/write/lseek was calling glibc read/write/lseek on the host instead
	of sys_read/sys_write/sys_lseek :).

Only in 2.4.19pre8aa2: 91_zone_start_pfn-2
Only in 2.4.19pre8aa3: 91_zone_start_pfn-3

	Convert all archs to the new API (including sparc64, guess why :).

Only in 2.4.19pre8aa3: 93_NUMAQ-1

	NUMA-Q support from Patricia Gaughen (very clean integration, I liked
	it).

Andrea

PS. Leaving in a few minutes to go watch the attack of the clones :)
