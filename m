Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSE2SwV>; Wed, 29 May 2002 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSE2SwU>; Wed, 29 May 2002 14:52:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315245AbSE2SwS>; Wed, 29 May 2002 14:52:18 -0400
Date: Wed, 29 May 2002 11:50:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.19
Message-ID: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More VM/FS interaction updates from Andrew Morton. Block layer (and 
IDE) updates.  USB and driverfs stuff (the driverfs thing is starting to 
slowly add flesh on its original promise).

In short, all over the map.

		Linus

-----

Summary of changes from v2.5.18 to v2.5.19
============================================

<Andries.Brouwer@cwi.nl>
	o usb-storage

<acher@in.tum.de>
	o small fixes for usb-uhci-hcd

<acme@conectiva.com.br>
	o drivers/char/rio/rio_linux.c

Andrew Morton <akpm@zip.com.au>
	o enable direct-to-BIO readahead for ext3
	o factor common code in page_alloc.c
	o relax nr_to_write requirements
	o ext3 set_page_dirty fix
	o small fixes in buffer.c
	o fix loop driver for large BIOs
	o block_truncate_page fix
	o mark swapout pages PageWriteback()
	o direct-to-BIO writeback
	o remove mem_map_t
	o rename writeback_mapping to writepages
	o move BH_JBD out of buffer_head.h
	o generic_file_write() cleanup
	o fix ext3 __FUNCTION__ warnings
	o direct-to-BIO readahead
	o move nr_active and nr_inactive into per-CPU page
	o dirsync
	o avoid sys_sync livelocks

<amunoz@vmware.com>
	o ia64: Don't assume out registers are preserved across call to

<anton@samba.org>
	o TLB shootdown infrastructure in 2.5

Jens Axboe <axboe@suse.de>
	o block documentation updates
	o a few ll_rw_blk exports missing
	o block plugging reworked
	o block plugging reworked/fixed

Brian Gerst <bgerst@didntduck.org>
	o fix thermal_interrupt
	o i386 mm init cleanup part 2
	o i386 head.S cleanup
	o i386 mm init cleanup part 1

Martin Dalecki <dalecki@evision-ventures.com>
	o 2.5.18 IDE 71-75
	o airo
	o 2.5.18 QUEUE_EMPTY and the unpleasant friends.

<david-b@pacbell.net>
	o ehci split interrupt transactions

<davidm@tiger.hpl.hp.com>
	o ia64: Fix misc. merge errors and typos.
	o ia64: Change local_irq_restore() to restore only psr.i, so that it
	o ia64: Misc. fixes.
	o ia64: Make pci_dma_supported() a platform-specific function.  
	o ia64: Various small fixes.
	o ia64: Update pte macros for new pfn-based versions.
	o ia64: Sync up with 2.5.17 tree.
	o ia64: Sync up with 2.5.18.

<davidm@wailua.hpl.hp.com>
	o ia64: Force bitkeeper update.
	o ia64: Rename McKinley to Itanium 2.  Fix some compilation issues.  Fix alignment

<eranian@hpl.hp.com>
	o ia64: Perfmon update.

<fdavis@si.rr.com>
	o net/ipv4/ipconfig.c minor fix

<greg@kroah.com>
	o USB irda driver
	o USB SL811HS host controller driver.

<hirofumi@mail.parknet.co.jp>
	o Fix the handling of dentry on msdos_lookup() (1/4)
	o Fix the utf8 option of vfat (again)

<ink@jurassic.park.msu.ru>
	o 2.5.18: unnamed PCI bus resources
	o 2.5.18 pci/setup-bus.c: incorrect BUG() calls

<jack@suse.cz>
	o Quota update

<jbglaw@lug-owl.de>
	o Trivial compile fix to fs/binfmt_em86.c
	o SRM cleanup for generic Alpha kernels

<johann.deneux@laposte.net>
	o Documentation in usb.c

James Simmons <jsimmons@heisenberg.transvirtual.com>
	o Moved VESA framebuffer driver over to new fbdev api
	o Moved VESA framebuffer over to new fbdev api
	o More porting to new api.
	o Forgot to include removal of using fbcon-cfb* for the new drivers ported over.
	o A new new drivers. Also several bug fixes and a few drivers ported over to new fbdev api.
	o Added in support for new drivers.
	o More drivers ported over to new API.
	o More drivers ported over to the new api. Also a bug fix in the software drawing image routine.
	o More changes for new fbdev subsytem.
	o Ported Voodoo3+ cards over to new api.

<kai@tp1.ruhr-uni-bochum.de>
	o kbuild: Figure out flags independently from pass
	o ISDN/CAPI: Move methods from capi_driver to capi_ctr
	o kbuild: Simplify rule for just building one subdir
	o kbuild: Use consistently FORCE instead of dummy
	o drivers/video/matrox/matroxfb_accel.c: Explicitly export symbols.
	o ISDN/CAPI: Cleanup /proc/capi
	o ISDN: CAPI: Remove unused capi_driver::driver_read_proc
	o ISDN/CAPI: Have hardware driver alloc struct capi_drv
	o ISDN/CAPI: Export callbacks for CAPI drivers directly
	o ISDN/CAPI: Remove struct capi_driver
	o kbuild: built-in and modules in one pass
	o kbuild: Normal sources should not include <linux/compile.h>
	o kbuild: Add EXTRA_TARGETS variable
	o kbuild: Remove remaining O_TARGET in drivers/*/Makefile
	o kbuild: Don't overwrite Rules.make's first_rule
	o kbuild: beautify Makefile / Rules.make...
	o kbuild: Group together descending/linking in drivers/*
	o kbuild: Build targets locally
	o kbuild: Provide correct 'make some/dir/file.[iso]'
	o kbuild: Hand merge link order change form driverfs update.

<ldb@ldb.ods.org>
	o [2.4] [2.5] Fix PPPoATM crash on disconnection

<mdharm-usb@one-eyed-alien.net>
	o Additional comments for usb-storage

<mdharm@one-eyed-alien.net>
	o usb-storage abort path cleanup

<mochel@geena.pdx.osdl.net>
	o Introduce struct bus_type for describing types of buses
	o Device Model: do better cleanup on device removal
	o deivce model: actually compile and use bus drivers
	o PCI: define pci_bus_type and register it on startup 
	o driverfs: add and export driverfs_create_symlink for general kernel use
	o device model: Create symlinks in bus's 'devices' dir for a device when its registered
	o device model: Need to back up one more directory when creating the symlink between the bus's 'devices' dir and the device's physical dir.
	o PCI: start to use common fields of struct device_driver more
	o Beef up centralized driver mgmt:

Paul Mackerras <paulus@samba.org>
	o PPC32: trivial whitespace fix, from Rusty Russell
	o PPC32: add definitions for fls(), pmd_free_tlb() and pte_free_tlb(),
	o PPC32: Updates for PPC405 processors.  A lot of stuff that was under
	o PPC32: two warning fixes from Rusty Russell, plus fix the PPC603
	o PPC32: remove some compile warnings in the CHRP and powermac boot
	o PPC32: Use copy_siginfo_to_user to copy the siginfo stuff to
	o PPC32: use the standard kernel min macro in a couple of places.

<pavel@suse.cz>
	o swsusp: cleanup

Russell King <rmk@arm.linux.org.uk>
	o 2.5.18: Fix ramdisk

<rml@tech9.net>
	o trivial: no "error" on preempt_count notice
	o set_cpus_allowed optimization
	o documentation for the new scheduler
	o preempt-safe net/ code
	o real-time info in /proc/<pid>/stats
	o Robert Love likes leather and chains
	o O(1) count_active_tasks

<rusty@rustcorp.com.au>
	o dcache.c spelling
	o autofs_wqt_t for ppc64
	o xconfig fix
	o MAINTAINERS file addition: Al Viro
	o ppc chrp/start.c warnings removal
	o do_mounts warning removal
	o vmscan.c tidy up
	o CREDITS sort order
	o semctl SUSv2 compliance
	o ppc spinlock warning removal
	o Alpha macro standardize
	o jiffies.h includes asm/param.h
	o exit path cleanup in drivers/cdrom/sonycd535.c
	o irq.h comment fix
	o check_region cleanup from drivers/char/ip2main.c
	o DIE "Russel", DIE!

<sfr@canb.auug.org.au>
	o consolidate errno definitions
	o consolidate generic peices of the siginfo structures and associated stuff
	o consolidate arch specific copy_siginfo_to_user
	o consolidate do_signal

<torvalds@home.transmeta.com>
	o Fix mmap cornercase with wrong return value for invalid "len".
	o Merge Keith Whitwell's radeon ring-buffer updates
	o More drm updates from Keith Whitwell
	o Add missing thermal interrupt prototype.
	o Remove re-use of "struct mm_struct" at execve() time.
	o Allocate new mm_struct for execve() early, so that we have
	o Fix IDE Makefile typo
	o Kernel version 2.5.19

<trini@bill-the-cat.bloom.county>
	o PPC32: Numerous minor platform updates and cleanups.
	o PPC32: Cleanup the i8259 code slightly.  Allow for polling of interrupts again
	o PPC32: In the bootwrapper/loader, rename setup_legacy to serial_fixups to
	o PPC32: Forward-port the /proc/residual stuffs from 2.4.  This is

<trond.myklebust@fys.uio.no>
	o Clean out routines that were obsoleted by previous
	o Teach RPC client to send pages rather than iovecs.
	o RPC client receive deadlock removal on HIGHMEM systems


