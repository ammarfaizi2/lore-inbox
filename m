Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVCUV>; Wed, 21 Feb 2001 21:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBVCUL>; Wed, 21 Feb 2001 21:20:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36612 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129170AbRBVCTu>; Wed, 21 Feb 2001 21:19:50 -0500
Date: Wed, 21 Feb 2001 18:19:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.2
Message-ID: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the patch looks huge (it's a meg and a half compressed, 6+ megs
uncompressed), but most of the patch by far is S/390 updates and the new
Cris architecture. 

The biggest real changes that impact normal users are the two bugs that
could corrupt your harddisk. The IDE driver bug that Russell found has, to
my knowledge, never been shown to happen on anything but his ARM machine,
but for all we know it could be quite bad even on x86. Similarly, the
elevator bug could cause corruption, but probably has not actually bit
people in practice. But both are definitely deadly at least in theory even
on bog-standard common PC hardware.

The reiserfs fix should hopefully make the "null bytes in log-files"
problem a non-issue, and along with the smbfs/HIGHMEM thing it is
certainly important for those that it can affect.

		Linus

----

final:
 - sync up more with Alan
 - Urban Widmark: smbfs and HIGHMEM fix
 - Chris Mason: reiserfs tail unpacking fix ("null bytes in reiserfs files")
 - Adan Richter: new cpia usb ID
 - Hugh Dickins: misc small sysv ipc fixes
 - Andries Brouwer: remove overly restrictive sector size check for
   SCSI cd-roms

-pre4:
 - big S/390x 64-bit merge
 - typos and license name fixes. doc updates.
 - more include file cleanups (phase out "malloc.h")
 - even more elevator corner cases.. When not merging, find the best insertion point.
 - pmac ide update
 - network fixes (netif_wake_queue on tx timeout)
 - USB printer select() fix
 - NFS client missed initialization, deamon fixed client address check

-pre3:
 - Jens: better ordering of requests when unable to merge
 - Neil Brown: make md work as a module again (we cannot autodetect
   in modules, not enough background information)
 - Neil Brown: raid5 SMP locking cleanups
 - Neil Brown: nfsd: handle Irix NFS clients named pipe behavior and
   dentry leak fix
 - maestro3 shutdown fix
 - fix dcache hash calculation that could cause bad hashes under certain
   circumstances (Dean Gaudet)
 - David Miller: networking and sparc updates
 - Jeff Garzik: include file cleanups
 - Andy Grover: ACPI update
 - Coda-fs error return fixes
 - rth: alpha Jensen update

-pre2:
 - driver sync up with Alan
 - Andrew Morton: wakeup cleanup and race fix
 - Paul Mackerras: macintosh driver updates.
 - don't trust "page_count()" on reserved pages!
 - Russell King: fix serious IDE multimode write bug!
 - me, Jens, others: fix elevator problem
 - ARM, MIPS and cris architecture updates
 - alpha updates: better page clear/copy, avoid kernel lock in execve
 - USB and firewire updates
 - ISDN updates
 - Irda updates

-pre1:
 - XMM: don't allow illegal mxcsr values
 - ACPI: handle non-existent battery strings gracefully
 - Compaq Smart Array driver update
 - Kanoj Sarcar: serial console hardware flow control support
 - ide-cs: revert toc-valid cache checking in 2.4.1
 - Vojtech Pavlik: update via82cxxx driver to handle the vt82c686
 - raid5 graceful failure handling fix
 - ne2k-pci: enable device before asking the irq number
 - sis900 driver update
 - riva FB driver update
 - fix silly inode hashing pessimization
 - add SO_ACCEPTCONN for SuS
 - remove modinfo hack workaround, all newer modutils do it correctly
 - datagram socket shutdown fix
 - mark process as running when it takes a page-fault

