Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143810AbRA1Sc1>; Sun, 28 Jan 2001 13:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143811AbRA1ScR>; Sun, 28 Jan 2001 13:32:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S143810AbRA1ScF>; Sun, 28 Jan 2001 13:32:05 -0500
Date: Sun, 28 Jan 2001 10:31:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.1-pre11
Message-ID: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just uploaded it to kernel.org, and I expect that I'll do the final
2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
pre-kernel works for you..

The main noticeable things in pre11 are fixing some bugs that crept in
after 2.4.0 - the block device queuing improvements could lose wakeups
under extreme load by multiple clients, and the vmscanning "get rid of
special return codes for shared memory" thing had missed a bit.

This should also fix the VIA IDE driver issues (if you want safe, do NOT
enable auto-dma), and the reported problems with hpt366 controllers and
IBM drives. Hopefully these were the last major IDE issues for a while.

Also, can people who have had unhappy relationships with their eepro100
please try to cuddle and make up again? The eepro100 changes should fix
the problem of having posted writes that basically made some of the timing
not work out.

		Linus

-----
pre11:
 - Trond Myklebust: NFS/RPC client SMP fixes
 - rth: alpha pyxis and cabriolet fixes
 - remove broken sys_wait4() declarations
 - disable radeon debugging code
 - VIA IDE driver should not enable autodma unless asked for
 - Andrey Savochkin: eepro100 update. Should fix the resource timing problems.
 - Jeff Garzik: via82cxxx_audio update
 - YMF7xx PCI audio update: get rid of old broken driver, make new
   driver handle legacy control too. 
 - fix missed wakeup on block device request list
 - hpt366 controller doesn't play nice with some IBM harddisks
 - remove inode pages from the page cache only after having removed them
   from the page tables.
 - shared memory out-of-swap writepage() fixup (no more magic return)

pre10:
 - got a few too-new R128 #defines in the Radeon merge. Fix.
 - tulip driver update from Jeff Garzik
 - more cpq and DAC elevator fixes from Jens. Looks good.
 - Petr Vandrovec: nicer ncpfs behaviour
 - Andy Grover: APCI update
 - Cort Dougan: PPC update
 - David Miller: sparc updates
 - David Miller: networking updates
 - Neil Brown: RAID5 fixes

pre9:
 - cpq array driver elevator fixes 
 - merge radeon driver from X CVS tree
 - ispnp cleanups
 - emu10k unlock on error fixes
 - hpfs doesn't allow truncate to larger

pre8:
 - Don't drop a megabyte off the old-style memory size detection
 - remember to UnlockPage() in ramfs_writepage()
 - 3c59x driver update from Andrew Morton
 - egcs-1.1.2 miscompiles depca: workaround by Andrew Morton
 - dmfe.c module init fix: Andrew Morton
 - dynamic XMM support. Andrea Arkangeli.
 - ReiserFS merge
 - USB hotplug updates/fixes
 - boots on real i386 machines
 - blk-14 from Jens Axboe
 - fix DRM R128/AGP dependency
 - fix n_tty "canon" mode SMP race
 - ISDN fixes
 - ppp UP deadlock attack fix
 - FAT fat_cache SMP race fix
 - VM balancing tuning
 - Locked SHM segment deadlock fix
 - fork() page table copy race fix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
