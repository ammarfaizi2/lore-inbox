Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276215AbSIVE0d>; Sun, 22 Sep 2002 00:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276234AbSIVE0c>; Sun, 22 Sep 2002 00:26:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36612 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276215AbSIVE0b> convert rfc822-to-8bit; Sun, 22 Sep 2002 00:26:31 -0400
Date: Sat, 21 Sep 2002 21:34:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.38
Message-ID: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g8M4VMA18703
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to be a bit more timely about releases, especially since some 
people couldn't use 2.5.37 due to the X lockup that should hopefully
be fixed (no idea _why_ that old bug only started to matter recently, the 
bug itself was several months old).

ia64 updates, a vm86 mode bug that bit XFree86 startup (and must have
bitten dosemu too, but maybe people aren't using DOS much any more), PCI 
driver attach fixes, JFS, ACPI, net drivers etc.

		Linus

---

Summary of changes from v2.5.37 to v2.5.38
============================================

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Minor cleanups
  o ia64: First draft of perfmon sampling-interval randomization
    support
  o ia64: Make sure register-backing store gets mapped with the right
    PTE protection bits
  o ia64: Fix return path of signal delivery for sigaltstack() case
  o ia64: Fix narrow window during which signal could be delivered with
    only the memory stack switched over to the alternate signal stack.
  o Fix edge-triggered IRQ handling.  See Linus's cset 1.611 for
    details
  o ia64: Fix comment in arch/ia64/kernel/signal.c
  o ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix
    proposed by Dave Miller).
  o ia64: Preserve f11-f15 around calls into firmware.  Patch by John
    Marvin
  o ia64: Dont execute srlz.d needlessly (reported by Chris Ruemmler)
  o ia64: Fix typo in perfmon.c.  (Patch by Stephane Eranian.)
  o ia64: Sync up with 2.5.35+.  Add ia64-specific huge page support
    (by Rohit Seth)
  o ia64: Make include/asm-ia64/suspend.h non-empty (suggested by Keith
    Owens)
  o ia64: Add arch/ia64/mm/hugetlbpage.c by Rohit Seth
  o ia64: A few huge page fixes (patch by Rohit Seth)
  o ia64: Fix zx1-platform support
  o ia64: Sync with 2.5.37
  o ia64: Reorganize initialization sequence a bit
  o ia64: Switch over to using ACPI PCI support routines.  This gets
    rid of much of the code-duplication that existed between ACPI and
    the ia64 IOSAPIC code.

<felipewd@terra.com.br>:
  o Add support for get-MII-data ioctls in 8139cp net driver

<fenghua.yu@intel.com>:
  o Optimize __ia64_save_fpu() and __ia64_load_fpu() for Itanium 2

<fletch@aracnet.com>:
  o free_area_init_node fix (for non discontigmem direct use)

Alexander Viro <viro@math.psu.edu>:
  o gendisk for pcd, cdu31a, cm206, mcd, mcdx, sbpcd, jsflash, mtdblock_ro,
    pf, swim3, loop, aztcd, gscd, optcd, sjcd, sonycd, stram, rd, nbd, xpram,
    acorn floppy, swim_iop
  o devfs handling for cdroms moved to register_disk()
  o misc cleanups
  o crapectomy and Lindent pf.c
  o switch to add_disk()
  o removal of bogus exports
  o beginning of probe_disk() and gendisks for floppy

Andy Grover <agrover@groveronline.com>:
  o ACPI: change a non-critical debug message to a lower output level
  o ACPI: Add include to provide PREFIX (Adrian Bunk)
  o ACPI: Re-enable compilation of ACPI subordinate drivers as modules
    (Bjoern A. Zeeb)

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Avoid parallel allocations within the same allocation group
  o JFS: Slightly relax allocation group reservation
  o JFS: swsusp support
  o JFS: Put legacy OS/2 extended attributes in "os2." namespace
  o JFS: Fix compiler errors in xattr.c

David S. Miller <davem@redhat.com>:
  o missing unlock_kernel

Erich Focht <efocht@ess.nec.de>:
  o Remove global semaphore_lock for ia64, similar to i386 change for
    2.5.25

Jean Tourrilhes <jt@hpl.hp.com>:
  o Fix wavelan_cs net driver build
  o update irda nsc-ircc driver
  o More __FUNCTION__ cleanups for IrDA

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add new MII lib functions mii_check_link, mii_check_media
  o Fix more IrDA __FUNCTION__ breakage.  It now builds, yay

Jens Axboe <axboe@suse.de>:
  o IDE fixes

Linus Torvalds <torvalds@home.transmeta.com>:
  o Don't try to attach a driver to a pci device that already has one
  o Don't do a 64-bit divide when a simple shift will do
  o Avoid confusion "mount" and "fsck" - don't show things like
    floppies and CD's in /proc/partitions.
  o Fix vm86 system call interface to entry.S. This has been broken
    since the thread_info support went in (early July), and can cause
    lockups at X startup etc.

Patrick Mochel <mochel@osdl.org>:
  o Adding driver model support in IDE

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix NCP_IOC_SETOBJECTNAME ioctl in ncpfs
  o Fix bigendian problems in ncpfs
  o Add support for text mount option string to ncpfs
  o ncpfs: Proper handling of watchdog packets
  o ncpfs: Verify packet signatures on replies
  o ncpfs: Pass unknown packets from server to userspace daemon. Now we
    can deliver server messages to logged-in users even with UDP or TCP
    transport.

Robert Love <rml@tech9.net>:
  o schedule() in_atomic() check

Steven Cole <elenstev@mesatop.com>:
  o Link eepro100 net driver with mii module, fixing static build

Stéphane Eranian <eranian@hpl.hp.com>:
  o ia64: perfmon update
  o perfmon cleanup patch
  o Fix bug in pfm_write_pmds()


