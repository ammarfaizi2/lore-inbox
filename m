Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGEX4S>; Fri, 5 Jul 2002 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGEX4R>; Fri, 5 Jul 2002 19:56:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315440AbSGEX4P>; Fri, 5 Jul 2002 19:56:15 -0400
Date: Fri, 5 Jul 2002 16:54:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.5.25
Message-ID: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More merges all over the map - ppc, scsi, USB, kbuild, input drivers etc.

And both Al and Andrew have been busy again.

This also introduces the support for non-100 Hz internal kernel times on
x86, while still exporting the old interface to user space (ie anybody who
exported raw jiffies before should be exporting "clock_t", which on x86
continues to be a 100 Hz clock, regardless of whatever the internal kernel
frequency is).

Right now the x86 timer frequency is set to 1kHz, but that's just another 
random number. It could be a config option if people really care, but I'd 
rather just have people argue for or against specific internal frequencies 
and we'll find something most people are happy with. It's easy to change 
without user space even noticing now.

The other thing that we should sort out eventually is the unified naming
for disk devices, now that both IDE and SCSI are starting to have some
support for driverfs.  Let's make sure that we _can_ have sane ways of
accessing a disk, without having to care whether it is IDE or SCSI or
anything else.

		Linus

----

Summary of changes from v2.5.24 to v2.5.25
============================================

<bheilbrun@paypal.com>:
  o APM compile fix, "stime" update broke it

<dgibson@samba.org>:
  o PPC32: Fixes and cleanups for PPC40x processors
  o PPC32: Update handling of the interrupt controller on the PPC405
  o PPC32: more PPC40x cleanup (remove CONFIG_PIN_TLB, add comments)

<dledford@aladin.rdu.redhat.com>:
  o Initial initio a100 driver DMA mapping changes + selected cleanups
  o inia100.c
  o i60uscsi.c

<jejb@mulgrave.(none)>:
  o [SCSI 53c700] add specimen block layer tcq
  o make Scsi_Cmnd and Scsi_Request.request be a pointer to the block
    layer request instead of a copy.
  o Initial support (mid-layer) for generic TCQ
  o [SCSI mid-layer]
  o [SCSI mid-layer]  bug fix two missing blk_queue_end_tag()s
  o export open_softirq

<kai@chaos.tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix warnings and other buglets

<kettenis@gnu.org>:
  o Fix note sections in ELF core dumps

<orjan.friberg@axis.com>:
  o USB: bluetty.c allocation bug fix

<petkan@users.sourceforge.net>:
  o pegasus & rtl8150

<sam@mars.ravnborg.org>:
  o kbuild: Add "make help" support

<sullivan@austin.ibm.com>:
  o linux-2.5.22-driverfs.patch

<willy@debian.org>:
  o softscsi patch
  o rewrite find_vma_prev

Alexander Viro <viro@math.psu.edu>:
  o devpts cleanup
  o (md.c) block device size cleanups
  o cdrom.c cleanups
  o kdev_t crapectomy
  o raid kdev_t cleanups (part 1)
  o raid ->diskop() splitup
  o raid kdev_t cleanups - part 2
  o md_import_device() cleanup
  o raid kdev_t cleanups - part 3
  o ex_dev switched to dev_t
  o assorted kdev_t cleanups in filesystems
  o >i_dev switched to dev_t

Andrew Morton <akpm@zip.com.au>:
  o handle BIO allocation failures in swap_writepage()
  o Fix 3c59x driver for some 3c566B's
  o per-cpu buffer_head cache
  o Remove ext2's buffer_head cache
  o Remove ext3's buffer_head cache
  o debug check for leaked blockdev buffers
  o misc cleanups and fixes
  o pdflush cleanup
  o remove swap_get_block()
  o shmem fixes
  o add new list_splice_init()
  o set TASK_RUNNING in cond_resched()
  o set TASK_RUNNING in yield()
  o check for O_DIRECT capability in open(), not write()
  o set_page_dirty() in mark_dirty_kiobuf()
  o resurrect __GFP_HIGH
  o Use __GFP_HIGH in mpage_writepages()
  o always update page->flags atomically
  o suppress more allocation failure warnings
  o fix a writeback race
  o combine generic_writepages() and mpage_writepages()
  o ext3 truncate fix
  o JBD commit callback capability
  o fix invalidate_inode_pages2() race
  o debug: check page refcount in __free_pages_ok()
  o reduce lock contention in try_to_free_buffers()
  o Use names, not numbers for pagefault types

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: 2.0.11 - Initial preparations for fake inode based attribute
    i/o
  o NTFS: 2.0.12 - Initial cleanup of address space operations
    following 2.0.11 changes
  o NTFS: 2.0.13 - Use iget5_locked() in preparation for fake inodes
    and small cleanups
  o NTFS: 2.0.14 - Run list merging code cleanup, minor locking
    changes, typo fixes

David Brownell <david-b@pacbell.net>:
  o ohci-hcd cardbus unplug
  o Re: [linux-usb-devel] unending timeouts (patch for 2.5.22 oops)

Greg Kroah-Hartman <greg@kroah.com>:
  o USB:  picked a uhci driver to go forward with
  o USB:  removed unused Config.help entries from the host controller
    file
  o USB: removed file ops from usb device structure Moved the file ops
    and minor number stuff out of the usb structure, Now
    usb_register_dev() and usb_deregister_dev() must be called if  you
    want to use the USB major number.
  o USB: added drivers/usb/core/file.c to the kernel-api documentation
  o USB: Fixups due to the changes in struct usb_device for
    file_operations and minor number handling

james.bottomley@steeleye.com <James.Bottomley@steeleye.com>:
  o fix SCSI driverfs for IDE panic on boot

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Assorted cleanups
  o kbuild: Prepare LDFLAGS for general use
  o kbuild: Rename ld flags for vmlinux to LDFLAGS_vmlinux
  o kbuild: Put flags for ld into LDFLAGS
  o kbuild: Put flags for objcopy into OBJCOPYFLAGS
  o kbuild: clean up arch/i386/boot, part 1
  o kbuild: clean up arch/i386/boot, part 2
  o kbuild: clean up arch/i386/boot, part 3
  o kbuild: clean up arch/i386/boot, part 4
  o kbuild: Fix calling of make_times_h and gentbl
  o kbuild: Provide shipped versions of the keymap files

Linus Torvalds <torvalds@home.transmeta.com>:
  o DRI CVS merge: separate out driver-ioctl's into driver headers
  o Make in-kernel HZ be 1000 on x86, retaining user-level 100 HZ
    clock_t
  o Make ramfs/driverfs maintain directory nlink counts
  o Fix more places where we exported our internal time to user space.
    Convert to standard clock_t.
  o Radeon DRI merge
  o x86 "make clean" missed some new targets
  o Disable ReiserFS bh usage count testing for now

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: code cleanup, small fixes
  o usb-storage: Code consolidation of error paths
  o usb-storage: remove timer

Paul Mackerras <paulus@samba.org>:
  o PPC32: add CONFIG_DEBUG_SPINLOCK
  o PPC32: Fixes for bugs in exception handling in copy_to_user and
    clear_user
  o PPC32: Add struct page * argument to copy/clear_user_page
  o PPC32: fixes for I/O mappings on CHRP machines
  o PPC32: update for scheduler changes (switch_to,
    prepare/finish_arch_*)
  o PPC32: translate addresses in the Open Firmware device tree
    correctly
  o PPC32 compile fix: add missing parenthesis
  o PPC32: fix compilation with current binutils
  o PPC32: work around the fact that the PPC601 doesn't implement the
    MSR.RI bit
  o PPC32: fix some minor compile warnings
  o PPC32: fix handling of machine checks
  o PPC32: eliminate some compile warnings on the EP405 board
  o PPC32: define USER_HZ to be 100 (HZ is still 100 for now)
  o PPC32: fix compile error by removing extraneous declarations
    (ppc_ksyms.c)

Paul Menage <pmenage@ensim.com>:
  o Shift BKL into ->statfs()

Pavel Machek <pavel@ucw.cz>:
  o suspend-to-disk documentation updates

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o 2.5.24 matroxfb memory corruption
  o 2.5.24 matroxfb off by one error
  o drivers/ide/probe.c leaks memory

samuel.thibault@ens-lyon.fr <Samuel.Thibault@ens-lyon.fr>:
  o sound/oss/maestro.c

Tom Rini <trini@bill-the-cat.bloom.county>:
  o PPC32: Fix building of most of the zImage targets
  o PPC32: Fix the rule for using config files from arch/ppc/configs/
    To accommodate the change to scripts/Configure which made it look
    in /boot/config-`uname -r` before looking at
    arch/$(ARCH)/defconfig, change the rule for using a config from
    arch/ppc/configs to copy to .config instead of
    arch/$(ARCH)/defconfig
  o PPC32: Minor PReP OpenPIC fixes from Troy Benjegerdes and Leigh
    Brown
  o Allow the data cache to be turned off on MPC8260 systems
  o PPC32: Move per-board MPC8xx ethernet defines to their respective
    board header
  o PPC32: Fix dependancies in arch/ppc/boot
  o PPC32: Minor fixes with respect to the MPC7450 and MPC7455

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Update the OpenPIC code to only require a 'linux_irq_offset'
    param
  o PPC32: check the binutils version and make sure it is new enough
  o PPC32: use the proper instruction mnemonics for altivec
    instructions

Vojtech Pavlik <vojtech@twilight.ucw.cz>:
  o Update the gameport drivers to Dave Jones's tree
  o Update the iforce driver to the latest revision (it now lives in a
    separate directory), add twiddler and guillemot drivers.
  o Add new serio modules for PS/2 AUX/KBD
  o Add keyboard, mouse and touchscreen drivers
  o Update the input handler modules to latest versions
  o Makefile/config.in changes to reflect the new drivers
  o Fix button assignments for Saturn and PSX pads
  o Handle input-only keyboard interfaces
  o Handle slowly responding PS/2 mice
  o Use time_after() where applicable
  o Minor cleanup in evdev.c
  o Minor fixes to make the whole thing compile on latest 2.5 and
    kbuild2
  o Add vortex anf fm801 gameport drivers, remove obsolete pcigame
    driver
  o Fix psmouse.c - it needs tqueue.h


