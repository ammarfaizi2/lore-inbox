Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSGXVLC>; Wed, 24 Jul 2002 17:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSGXVLC>; Wed, 24 Jul 2002 17:11:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31756 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317576AbSGXVKx>; Wed, 24 Jul 2002 17:10:53 -0400
Date: Wed, 24 Jul 2002 14:13:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.28
Message-ID: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The most fundamental part of this has already been discussed a lot and
posted to the kernel list, including a lot of fixes (all hopefully 
integrated). That's obviously the removal of the global irq lock. In the 
short term (famous last words) that breaks a number of SMP configurations, 
but fixing them should not be horribly hard.

A lot of other stuff here too - the regular USB updates, fbdev updates,
m68k and ppc64 updates, IDE fix, and a sync-up with Al. Serial lawyer all 
shook up (the irq lock kind of forced that one, but it's certainly been 
pending long enough..)

Go wild,

		Linus

---

Summary of changes from v2.5.27 to v2.5.28
============================================

<dalecki@evision.ag>:
  o IDE-101

<jb@jblache.org>:
  o drivers/usb/misc/tiglusb.c v1.04

<jsimmons@maxwell.earthlink.net>:
  o Added help for the Toshbia and Permedia3 framebuffer devices. Small
    fixes for the ATI 128 card and the logo drawing code in fbcon.c.
    Proper handling of data for pci handling
  o Added VBI support to VESA. ATY 128 compiles now :-)
  o Removed all old fbgen code. Small cleanups
  o Synced up to m68k changes

<levon@movementarian.org>:
  o consolidate task->mm code + fix

<petkan@users.sourceforge.net>:
  o USB: rtl8150 updated

Alexander Viro <viro@math.psu.edu>:
  o make hfs use regular semaphores
  o Use wipe_partitions() where appropriate
  o partition parsing cleanup
  o block device size cleanups
  o partition handling locking cleanups
  o blk_ioctl() not exported anymore
  o paride cleanup and fixes
  o SCSI ->bios_param() switched to struct block_device *
  o removal of dead prototypes
  o jffs kdev_t cleanups
  o fix for nfs_unlink and vfs_unlink
  o Fix dcache deadlock introduced by previous fix

Andrew Morton <akpm@zip.com.au>:
  o disable highpte in rmap kernels
  o page-writeback.c compile warning fix

Anton Blanchard <anton@samba.org>:
  o ppc64: enable eeh on non-LPAR
  o ppc64: copy_user_page and clear_user_page now take a page * ppc64:
    updates for mmu gather code
  o ppc64: Use non context synchronising mtmsrd. Cleanup init.c
  o ppc64: 64 and 32 bit signal cleanups from Stephen Rothwell
  o ppc64: Implement copy_siginfo_to_user32 from Stephen Rothwell
  o ppc64: Remove POWER4 special case for cache_decay_ticks
  o ppc64: Initial DISCONTIGMEM and NUMA support
  o ppc64: Only use irq balancing on openpic for the moment
  o ppc64: update ppc64 tlb batch code
  o ppc64: Add fls
  o ppc64: POWER4 lazy icache flushing
  o ppc64: add missing gcc barrier in softirq code
  o ppc64: export timebase frequency in /proc/cpuinfo
  o pSeries HVC console: Fix hang up race - from Dave Engebretsen
  o pSeries HVC console: Add SYSRQ and handle errors better from Dave
    Engebretsen
  o pSeries firmware flash support from Todd Inglett
  o ppc64: iSeries updates
  o ppc64: increase IRQ_KMALLOC_ENTRIES
  o ppc64: ptrace cleanup from Stephen Rothwell
  o ppc64: ptrace32 fix when tracing 64bit tasks from Will Schmidt
  o ppc64: config.h resync and remove some stale code ppc64: turn off
    STRICT_MM_TYPECHECKS
  o pSeries HVC console: fix hvc_hangup definition
  o ppc64: remove __openfirmware and __chrp
  o ppc64: include/asm/md.h is not used any more
  o ppc64: remove some stale code
  o ppc64: updates for 2.5.21
  o ppc64: Makefile updates
  o ppc64: non linear cpu support
  o ppc64: define new scheduler hooks
  o ppc64: update for recent 32/64bit binutils
  o ppc64: Fix warnings
  o ppc64: Fix for 32 bit ELF timeval handling, from sparc64
  o ppc64: define SMP_CACHE_BYTES and cleanup HZ handling
  o ppc64: use symbolic names for fault types
  o ppc64: _switch_to -> __switch_to
  o ppc64: defconfig update
  o ppc64: exception should be 0x480 for instruction SLB miss - jimix
  o ppc64: misc cleanups
  o ppc64: __clear_user should return number of bytes not copied
  o ppc64: iSeries update - from 2.4
  o ppc64: add comment and missing include
  o ppc64: Add northstar CPU
  o ppc64: Add winnipeg support
  o ppc64: UP fix for irq affinity
  o ppc64: add POWER4+ (GQ) support
  o ppc64: add rmap.h
  o ppc64: workaround for gcc 3.1, otherwise we busy loop in
    pte_chain_lock()
  o ppc64: fix test_bit and remove workaround in cpu_relax
  o ppc64: big IRQ lock removal
  o ppc64: Fix for spurious interrupts in LPAR without ISA
  o ppc64: merge some 2.4 fixes
  o ppc64: missed during last merge
  o ppc64: Designated initializers from Rusty
  o ppc64: add Config.help
  o ppc64: Optimise for 630 by default
  o ppc64: put paca in r13 and fix non zero boot cpu
  o flags must be unsigned long]
  o Make tlb_remove_tlb_entry take ptep]
  o Fix token ring compile]

Christopher Hoover <ch@hpl.hp.com>:
  o for ohci on SA-1111
  o set_device_description oops fixage mk2

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Clean up Documentation/filesystems/jfs.txt
  o JFS: Use cond_resched()
  o JFS: cosmetic syncup with 2.4 code
  o JFS: Replace depreciated initializer syntax with C99 style

David Brownell <david-b@pacbell.net>:
  o usb_set_interface() doc
  o hid_ff_init could not find initializer

Geert Uytterhoeven <geert@linux-m68k.org>:
  o M68k update (1-49)

Greg Kroah-Hartman <greg@kroah.com>:
  o PCI Hotplug: fix i_nlink for root inode in pcihpfs
  o PCI Hotplug: fix the dbg() macro to work properly on older versions
    of gcc
  o USB pl2303: new device support added
  o USB: rio500.c bugfix
  o USB: usb-serial.h cleanups
  o USB: changed the interface name to be a bit more unique

Hugh Dickins <hugh@veritas.com>:
  o shm_destroy lock hang
  o shmem_link duplicated test
  o shmem_file_write double kunmap
  o shmem_getpage_locked missing unlock

Ingo Molnar <mingo@elte.hu>:
  o "big IRQ lock" removal, IRQ cleanups
  o "big IRQ lock" removal docs
  o Re: [patch] cli()/sti() cleanup
  o irqlock patch 2.5.27-H6
  o scheduler fixes

James Simmons <jsimmons@heisenberg.transvirtual.com>:
  o Removal of nonexistant iplan16 support. Compile fix for aty128fb
    driver. Proper handling of PCI private data for fbdev drivers
  o Removed old FB_COMPAT_XPMAC stuff. Ported over the Riva framebuffer
    driver over to the new api. Updated the Voodoo 1 driver
  o Added Help info for Permedia 3 and Toshiba TX3912 graphics card
    support
  o Updated Voodoo 1 documentation
  o Finished the NVIDIA driver port to the new api. Killed a strtok in
    sstfb
  o Added VBI support to VESA
  o Supports more NVIDIA cards
  o NVIDIA fixes to handle HSYNC and VSYNC flags. Set the registers to
    read the image data as big endian. Handle the different smem_len
    for different kinds of cards
  o Cleanusp for the 3Dfx driver
  o Finally touchs to the New mac framebuffer driver. Started the port
    of the ATI 128 driver to the new api. A few small optimizations and
    a bug fix for SUN 12x22 fonts with the new accel code
  o M68K updates for there framebuffer devices
  o More changes to port over teh ATI 128 driver to new api.
    Optimizations for fbgen and small bug fix for gen_update_var
  o Ported over ATI 128 Rage driver to new api. A few config mistakes
    where fixed
  o Ported SA1100 framebuffer over to new fbdev api
  o Fixed bug for large logos. Also had to make a patch to handle X
    server reversing the image order programming verses how the riva
    fbdev driver does it
  o Removed fbcon-vga.c and the old fbgen code. Ported over the SgiVW,
    OpenFirmware fbdev driver and started the Mach64 fbdev driver to
    the new api. A few simple typos as well
  o Port step some changes at authors request
  o Reversed so more changes
  o Permiedia 2 support on PowerPC platform
  o Updates to SIS framebuffer driver
  o Porting Mach 64 drive over to new api

Jan Harkes <jaharkes@cs.cmu.edu>:
  o uhci-hcd suspend fix

Jens Axboe <axboe@burns.home.kernel.dk>:
  o add __blk_stop_queue() as locked variant of blk_stop_queue() and
    make cpqarray and cciss use these

kai.makisara@kolumbus.fi <Kai.Makisara@kolumbus.fi>:
  o SCSI tape driver fixes for 2.5.27

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix incoherent LDT at mmap exit
  o Update ensoniq sound driver to new irq serialization
  o Remove extraneous dget/dput pair in vfs_unlink() that confused the
    NFS client code wrt the exclusiveness of a dentry getting removed.
  o Remove unused variable
  o Fix up irqlock removal patch, avoid compiler warnings
  o Fixups for previous changesets, avoid warnings etc

Neil Brown <neilb@cse.unsw.edu.au>:
  o type safe(r) list_entry repacement: container_of
  o MD - Fix two bugs that would cause sync_sbs to Oops
  o MD - Convert struct initialised in md to "the new way"
  o MD - Remove get_spare declaration and associated warning
  o NFSD - new struct initialisers for nfsd

Richard Gooch <rgooch@atnf.csiro.au>:
  o Switched to ISO C structure field initialisers

Rik van Riel <riel@conectiva.com.br>:
  o urgent rmap bugfix

Robert Love <rml@tech9.net>:
  o Re: "big IRQ lock" removal docs

Russell King <rmk@arm.linux.org.uk>:
  o Serial driver stuff
  o [SERIAL] Rename files to remove serial_ prefix
  o [SERIAL] Fix up various filenames, etc, from Ingo's merge of serial
  o [SERIAL] Fix another SMP deadlock with modem status signal changes
    The original fix sent to Ingo for stop_tx didn't take account that
    the start_tx and stop_tx methods can be called from the device
    specific code under the port spinlock.  Consequently, we move the
    spinlock to the callers of these methods.  Documentation updated to
    reflect the change.
  o [SERIAL] Fix deadlock in __uart_start introduced in previous cset
    Thanks to Zwane Mwaikambo for finding this.
  o [SERIAL] Fix sa1100 serial driver stop function parameters

Rusty Russell <rusty@rustcorp.com.au>:
  o AGP designated initializer update
  o drivers/hotplug designated initializers

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o 2.5.27 fix potential spinlocking race


