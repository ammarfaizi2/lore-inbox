Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313843AbSDFBCP>; Fri, 5 Apr 2002 20:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313847AbSDFBCJ>; Fri, 5 Apr 2002 20:02:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62473 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313843AbSDFBCB>; Fri, 5 Apr 2002 20:02:01 -0500
Date: Fri, 5 Apr 2002 17:01:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.8-pre2
Message-ID: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More merging with various people, USB+ARM+more network drivers etc.

The actual patch is pretty huge, because the USB changes moves USB files
around a lot. The BK diffs (and actual "real changes") are smaller than 
the patch would imply (here Larry pipes up with number of deltas ;)

		Linus

---

Summary of changes from v2.5.8-pre1 to v2.5.8-pre2
============================================

<ch@hpl.hp.com> (02/03/13 1.384.11.1)
	[PATCH] 1054/1: Fixes security problem with static i/o mapping.
	
	
	For 2.5.x only.  (Patch 1042/1 is for 2.4.x)
	
	(replaces patch 1041/1.)
	
	Christopher Hoover
	mailto:ch@murgatroid.com
	mailto:ch@hpl.hp.com
	

<trevor.pering@intel.com> (02/03/13 1.384.11.2)
	[PATCH] 964/1: Consus led patches
	
	+++ linux/arch/arm/mach-sa1100/leds.c   Wed Feb 13 13:55:33 2002
	+++ linux/arch/arm/mach-sa1100/leds.h   Wed Feb 13 13:55:52 2002
	+++ linux/include/asm-arm/leds.h        Wed Feb 13 13:01:31 2002
	
	Additions for consus_leds_event (parallels assabet_leds_event).
	Added led_start_time_mode and led_stop_timer_mode for heartbeat led.
	Added led_blue_on and led_blue_off for Blue led support.
	

<rmk@flint.arm.linux.org.uk> (02/03/13 1.388.3.2)
	Miscellaneous compiler warning fixes, other small fixes and
	cleanups for ARM.

<rmk@flint.arm.linux.org.uk> (02/03/13 1.388.3.4)
	Fix scope of init/exit functions in ds1620.c
	NetWinder flash driver should use ioremap, not the private __ioremap.

<rmk@flint.arm.linux.org.uk> (02/03/13 1.388.3.5)
	Update ARM related video drivers:
	 - cyber2000fb
	 - sa1100fb
	Add new ARM video drivers:
	 - anakinfb
	 - clps711xfb

<rmk@flint.arm.linux.org.uk> (02/03/17 1.526)
	SA1100 IrDA driver updates.

<rmk@flint.arm.linux.org.uk> (02/03/19 1.528)
	Convert ARM92x/ARM1020 specific configuration symbols to generic CPU
	symbols.  Remove unused flush_page_to_ram in ARM code.

<nico@cam.org> (02/03/22 1.384.11.3)
	[PATCH] 1079/1: recognize PXA250 revision B0 and hier
	
	

<nico@cam.org> (02/03/22 1.384.11.4)
	[PATCH] 1080/1: Addition of new files for the Intel PXA250/210 architecture
	
	This only populates the linux/arch/arm/mach-pxa directory.
	

<nico@cam.org> (02/03/22 1.384.11.5)
	[PATCH] 1081/1: addition of new header files for the Intel PXA250/210 architecture
	
	This patch populates the linux/include/asm-arm/arch-pxa directory.
	

<nico@cam.org> (02/03/22 1.384.11.6)
	[PATCH] 1082/1: changes to linux/arch/arm/kernel/* for PXA architecture
	Actually only debug.S and entry-armv.S
	

<abraham@2d3d.co.za> (02/03/22 1.384.11.7)
	[PATCH] 1083/1: 64-bit unsigned modulo arithmetic support
	I've added support for 64-bit modulo arithmetic on ARM. This is needed for
	the video4linux API to function properly and since there's already support
	for 64-bit divides, I think there shouldn't be any reason for the absence of
	this.
	

<xkaspa06@stud.fee.vutbr.cz> (02/03/23 1.384.11.8)
	[PATCH] 1092/1: Avoid unbalanced IRQ from LCD on SA1100
	
	Remove "enable_irq(IRQ_LCD)" call from video/sa1100fb.c

<gilbertd@treblig.org> (02/03/24 1.384.11.9)
	[PATCH] 1094/1: 2.4.18-rmk3: fix for build failure with no video
	2.4.18-rmk3 fails to build on the EBSA285 if there is no video stuff
	enabled with a missing symbol.  For me the linker lied and told me it
	was in irq.c but it was actually in the previous file in the link,
	mach-footbridge/arch.c ; the symbol is screen_info which is what the
	ORIG_* macros use.
	
	Note I haven't yet tested this booting, just building.
	

<rmk@flint.arm.linux.org.uk> (02/03/24 1.529)
	Miscellaneous build corrections/warning fixes.

<rth@are.twiddle.net> (02/03/25 1.524.11.1)
	Break an include loop by moving cache flushing routines from
	asm/pgtable.h and/or asm/pgalloc.h to asm/cacheflush.h, and
	tlb flushing routines to asm/tlbflush.h.

<mochel@segfault.osdl.org> (02/03/26 1.524.12.1)
	Add concept of system bus, so system devices (CPUs, PICs, etc) can have a common home in the device tree.
	Add helper functions for {un,}registering.

<mochel@segfault.osdl.org> (02/03/26 1.524.12.2)
	Ok, really add drivers/base/sys.c

<mochel@segfault.osdl.org> (02/03/26 1.524.12.3)
	Driver model update:
	Create global list in which all devices are inserted. Done by Kai Germaschewski.

<mochel@segfault.osdl.org> (02/03/26 1.524.12.4)
	Add device_{suspend,resume,shutdown} calls.

<rmk@flint.arm.linux.org.uk> (02/03/28 1.531)
	Miscellaneous build/bug fixes.

<kai@tp1.ruhr-uni-bochum.de> (02/04/01 1.524.13.1)
	Fix the kernel build when we have multi-part objects both in $(obj-y)
	and $(obj-m).
	
	Before, we would have built (though not linked) the individual objects
	for multi-part modules even when building vmlinux and vice versa.

<davem@nuts.ninka.net> (02/04/03 1.524.7.39)
	Tigon3 driver pci_unmap_foo changes were half complete,
	fix things up. Noted by Jeff Garzik.

<davem@nuts.ninka.net> (02/04/03 1.524.21.1)
	kernel/time.c needs linux/errno.h

<davem@nuts.ninka.net> (02/04/03 1.524.21.2)
	drivers/usb/hub.c needs linux/errno.h

<davem@nuts.ninka.net> (02/04/03 1.524.21.3)
	drivers/media/video/videodev.c needs linux/slab.h

<davem@nuts.ninka.net> (02/04/03 1.524.22.1)
	sparc64/kernel/semaphore.c needs errno.h
	add forward decl of struct page to asm-sparc64/pgtable.h

<davem@nuts.ninka.net> (02/04/03 1.524.22.2)
	sparc64/kernel/binfmt_elf32.c:ELF_CORE_COPY_REGS needs
	final semi-colon.

<davem@nuts.ninka.net> (02/04/03 1.524.22.3)
	sparc64/math-emu/math.c needs linux/errno.h

<jgarzik@mandrakesoft.com> (02/04/03 1.524.23.1)
	Update pcnet_cs net driver for recent removal of rmem_{start,end}
	from struct net_device.  (actually, for this driver, the functionality
	was simply moved to 8390.h)

<jgarzik@mandrakesoft.com> (02/04/04 1.524.24.2)
	Remove unused references to dev->rmem_{start,end}
	from wavelan_cs net driver.

<davej@suse.de> (02/04/04 1.524.24.3)
	olympic tokenring driver compile fix

<davej@suse.de> (02/04/04 1.524.24.4)
	Add missing MODULE_LICENSE tags to several net drivers.
	
	Also... surprise!  Andrew Morton's aic7xxx build fix
	is also included.  Ah well, 1001 people probably applied
	the same patch by hand, and it's easy to merge, so oh well.

<davej@suse.de> (02/04/04 1.524.24.5)
	Merge ioc3-eth net drvr changes from 2.4.x:
	- Improved MAC address discovery.
	- endian fixes
	

<davej@suse.de> (02/04/04 1.524.24.6)
	Merge gt96100 mips net drvr updates from 2.4.x:
	* Moved to 2.4.14, ppopov@mvista.com.  Modified driver to add
	proper gt96100A support.
	* Moved eth port 0 to irq 3 (mapped to GT_SERINT0 on EV96100A)
	in order for both ports to work. Also cleaned up boot
	option support (mac address string parsing), fleshed out
	gt96100_cleanup_module(), and other general code cleanups
	<stevel@mvista.com>.

<davej@suse.de> (02/04/04 1.524.24.7)
	Merge au1000_eth net drvr updates from 2.4.x:
	* add support for LSI 10/100 phy
	* other minor cleanups

<davej@suse.de> (02/04/04 1.524.24.8)
	com20020 arcnet drvr build fix (add missing comma)

<davej@suse.de> (02/04/04 1.524.24.9)
	Merge ariadne2 net drvr updates from 2.4.x:
	* use Zorro-specific z_{read,write}[bwl] routines
	* remove superfluous include

<davej@suse.de> (02/04/04 1.524.24.10)
	Merge a2065 net drvr update from 2.4.x:
	* make sure to stop chip before enabling interrupt via request_irq

<jt@hpl.hp.com> (02/04/04 1.524.25.1)
	IrDA: Fix w83977af_ir FIR drivers for new DMA API

<jt@hpl.hp.com> (02/04/04 1.524.25.2)
	IrDA trivial fixes:
	o [CORRECT] Handle signals while IrSock is blocked on Tx
	o [CORRECT] Fix race condition in LAP when receiving with pf bit
	o [CRITICA] Prevent queuing Tx data before IrComm is ready
	o [FEATURE] Warn user of common misuse of IrLPT
	

<jt@hpl.hp.com> (02/04/04 1.524.25.3)
	IrDA:  Allow tuning of Max Tx MTU to workaround spec contradiction
	

<jt@hpl.hp.com> (02/04/04 1.524.25.4)
	IrDA: Correct fix for IrNET disconnect indication :
	if socket is not connected, don't hangup, to allow passive operation
	

<jt@hpl.hp.com> (02/04/04 1.524.25.5)
	IrDA discovery fixes:
	o [FEATURE] Propagate mode of discovery to higher protocols
	o [CORRECT] Disable passive discovery in ircomm and irlan
	  Prevent client and server to simultaneously connect to each other
	o [CORRECT] Force expiry of discovery log on LAP disconnect
	

<jt@hpl.hp.com> (02/04/04 1.524.25.6)
	IrDA USB disconnect changes:
	o [CRITICA] Fix race condition between disconnect and the rest
	o [CRITICA] Force synchronous unlink of URBs in disconnect
	o [CRITICA] Cleanup instance if disconnect before close
	        <Following patch from Martin Diehl>
	o [CRITICA] Call usb_submit_urb() with GPF_ATOMIC

<jt@hpl.hp.com> (02/04/04 1.524.25.7)
	IrDA: handle new NSC chip variant

<jt@hpl.hp.com> (02/04/04 1.524.25.8)
	IrDA: Correct location of dev tx stats update

<davej@suse.de> (02/04/04 1.524.24.11)
	Merge hydra net drvr conversion to Zorro-specific
	z_{read,write}[bwl] routines from 2.4.x.

<akpm@zip.com.au> (02/04/04 1.524.26.1)
	This fixes the "i_blocks went wrong when the disk filled up"
	problem.
	
	In ext3_new_block() we increment i_blocks early, so the
	quota operation can be performed outside lock_super().
	But if the block allocation ends up failing, we forget to
	undo the allocation.  
	
	This is not a serious bug, and probably does not warrant
	an upgrade for production machines.  Its effects are:
	
	1) errors are generated from e2fsck and
	
	2) users could appear to be over quota when they really aren't.
	
	The patch undoes the accounting operation if the allocation
	ends up failing.

<arjanv@redhat.com> (02/04/04 1.524.24.12)
	Merge some new PCI ids from e100 to eepro100 net driver.

<akpm@zip.com.au> (02/04/04 1.524.24.13)
	Various minor bug fixes for 3c59x net driver.

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.524.24.14)
	Fix jiffies-comparison timeout bug in arlan net driver.

<jgarzik@mandrakesoft.com> (02/04/04 1.524.26.2)
	Andrew Morton's ext2 sync mount speedup.  Description:
	
	At present, when mounted synchronously or with `chattr +S' in effect,
	ext2 syncs the indirect blocks for every new block when extending a
	file.
	
	This is not necessary, because a sync is performed on the way out of
	generic_file_write().  This will pick up all necessary data from
	inode->i_dirty_buffers and inode->i_dirty_data_buffers, and is
	sufficient.
	
	The patch removes all the syncing of indirect blocks.
	
	On a non-write-caching scsi disk, an untar of the util-linux tarball
	runs three times faster.  Writing a 100 megabyte file in one megabyte
	chunks speeds up ten times.
	
	The patch also removes the intermediate indirect block syncing on the
	truncate() path.  Instead, we sync the indirects at a single place, via
	inode->i_dirty_buffers.  This not only means that the writes (may)
	cluster better.  It means that we perform much, much less actual I/O
	during truncate, because most or all of the indirects will no longer be
	needed for the file, and will be invalidated.
	
	fsync() and msync() still work correctly.  One side effect of this
	patch is that VM-initiated writepage() against a file hole will no
	longer block on writeout of indirect blocks.  This is good.
	

<akpm@zip.com.au> (02/04/04 1.524.26.3)
	ext3 filesystem sync mount speedup:
	Again, we don't need to sync indirects as we dirty them because
	we run a commit if IS_SYNC(inode) prior to returning to the
	caller of write(2).
	
	Writing a 10 meg file in 0.1 meg chunks is sped up by, err,
	a factor of fifty.  That's a best case.
	

<eli.kupermann@intel.com> (02/04/04 1.524.24.15)
	e100 net driver update 1/3:
	The patch separates max busy wait constants making in max of 100 usec for
	wait scb and max of 50 usec for wait cus idle. These constants found
	sufficient using heavy traffic tests.

<eli.kupermann@intel.com> (02/04/04 1.524.24.16)
	e100 net driver update 2/3:
	Adding missing pci write flush to the procedure e100_exec_cmd

<eli.kupermann@intel.com> (02/04/04 1.524.24.17)
	e100 net driver update 3/3:
	Adding proper print level qualifier to the printk calls.

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.1)
	Detect bad JFS directory to avoid infinite loop

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.2)
	JFS include cleanup
	
	Remove redundant include of slab.h
	Submitted by Christoph Hellwig

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.3)
	JFS: remove dead code
	
	Submitted by Christoph Hellwig

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.4)
	Add support for external JFS journal
	
	Submitted by Christoph Hellwig & Dave Kleikamp

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.5)
	JFS: simplify sync_metapage
	
	Submitted by Christoph Hellwig

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.6)
	Remove register keyword from JFS code
	
	Submitted by Christoph Hellwig

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.7)
	No need to handle regular files in jfs_mknod
	Submitted by Christoph Hellwig

<shaggy@kleikamp.austin.ibm.com> (02/04/04 1.524.28.8)
	Make JFS licence boilerplate uniform, update copyright dates
	Submitted by Christoph Hellwig and Dave Kleikamp

<torvalds@penguin.transmeta.com> (02/04/04 1.524.29.1)
	Don't allow preemption to change task state.

<rml@tech9.net> (02/04/04 1.524.29.2)
	[PATCH] kjournald exits with nonzero preempt_count
	
	The preempt_count debug check that went into 2.5.8-pre1 already caught a
	simple case in kjournald.  Specifically, kjournald does not drop the BKL
	when it exits as it knows schedule will do so for it.
	
	For the sake of clarity and exiting with a preempt_count of zero, the
	attached patch explicitly calls unlock_kernel when kjournald is exiting.

<torvalds@penguin.transmeta.com> (02/04/04 1.524.29.4)
	Fix up bad time compare from the -dj merge

<torvalds@penguin.transmeta.com> (02/04/04 1.534)
	Cset exclude: davej@suse.de|ChangeSet|20020403195622

<ak@muc.de> (02/04/04 1.524.7.40)
	In linux/skbuff.h, always use unsigned long for flags.

<davem@nuts.ninka.net> (02/04/04 1.524.22.4)
	On sparc64, flush_thread needs to setup the PGD cache
	for 64-bit apps too.

<greg@kroah.com> (02/04/04 1.524.30.1)
	USB visor driver
	
	Added support for the Sony OS 4.1 devices.  Thanks to Hiroyuki ARAKI
	<hiro@zob.ne.jp> for the information.

<torvalds@penguin.transmeta.com> (02/04/04 1.535)
	Update kernel version

<davej@suse.de> (02/04/04 1.536)
	[PATCH] cleanup list usage in dquot
	
	From the kernel janitor folks

<davej@suse.de> (02/04/04 1.537)
	[PATCH] list_for_each is fs/
	
	From the kernel janitor folks

<davej@suse.de> (02/04/04 1.538)
	[PATCH] Improved allocator for NTFS
	
	Originally by Anton Altaparmakov.
	I think Anton is going to submit his rewritten NTFS soon making this null and void,
	but in the interim, it fixes a known problem with NTFS and large allocations.

<davej@suse.de> (02/04/04 1.539)
	[PATCH] increase number of transaction locks in JFS txnmgr
	
	Original fix from Andi Kleen

<davej@suse.de> (02/04/04 1.540)
	[PATCH] MSDOS fs option parser cleanup
	
	Original from Rene Scharfe
	This fixes a problem where MSDOS fs's ignore their 'check' mount option.

<davej@suse.de> (02/04/04 1.541)
	[PATCH] bss bits for isofs
	
	Originally from the kernel janitor folks

<davej@suse.de> (02/04/04 1.542)
	[PATCH] QNX4fs sync
	
	Brings QNX4FS back in sync with 2.4

<davej@suse.de> (02/04/04 1.543)
	[PATCH] better dquot accounting
	

<davej@suse.de> (02/04/04 1.544)
	[PATCH] ext3 inode generation improvements.
	
	Originally from Andrew Morton

<davej@suse.de> (02/04/04 1.545)
	[PATCH] named structure initialisers for fs/
	
	Originally by Grant R.Guenther
	Has had a quick once over by Al, who weeded out one chunk that was
	unrelated.

<davej@suse.de> (02/04/04 1.546)
	[PATCH] struct super_block cleanup - reiserfs
	
	Original from: Brian Gerst <bgerst@didntduck.org>
	Has had a once over by Chris Mason and Al.
	
	Seperates reiserfs_sb_info from struct super_block.
	
							Brian Gerst

<davej@suse.de> (02/04/04 1.555)
	[PATCH] EFI GUID partition support update.
	
	More bits from Matt Domsch. Fixes GUID printing, and updates
	to what's in the IA64 tree. Other cleanups are mentioned in
	the changelog in the patch.

<greg@kroah.com> (02/04/04 1.524.30.2)
	USB
	
	moved files to different subdirectories to make try to make sense
	of the current mess, and to allow usb client drivers to integrate into
	the tree easier.

<viro@math.psu.edu> (02/04/04 1.556)
	[PATCH] IS_DEADDIR checks (2.5)
	
		2.4 variant will go to Marcelo in a couple of minutes.
	
	Patch moves IS_DEADDIR() checks into may_delete().

<greg@kroah.com> (02/04/04 1.524.30.3)
	usb subsystem now builds as modules.
	dependancies still seem broken.

<torvalds@penguin.transmeta.com> (02/04/04 1.557)
	update x86 defconfig

<torvalds@penguin.transmeta.com> (02/04/04 1.558)
	Fix tlbflush header file dependencies

<torvalds@penguin.transmeta.com> (02/04/04 1.559)
	uhhuh. Fix duplicate merge from -dj tree

<rml@tech9.net> (02/04/04 1.560)
	[PATCH] preemptive kernel behavior change: don't be rude
	
	- do not manually set task->state
	- instead, in preempt_schedule, set a flag in preempt_count that
	  denotes that this task is entering schedule off a kernel preemption.
	- use this flag in schedule to jump to pick_next_task
	- in preempt_schedule, upon return from schedule, unset the flag
	- have entry.S just call preempt_schedule and not duplicate this work,
	  as Linus suggested.  I agree.  Note this makes debugging easier as
	  we keep a single point of entry for kernel preemptions.
	
	The result: we can safely preempt non-TASK_RUNNING tasks.  If one is
	preempted, we can safely survive schedule because we won't handle the
	special casing of non-TASK_RUNNING at the top of schedule.  Thus other
	tasks can run as desired and our non-TASK_RUNNING task will eventually
	be rescheduled, in its original state, and complete happily.
	
	This is the behavior we have in the 2.4 patches and 2.5 until
	~2.5.6-pre.  This works.  It requires no other changes elsewhere (it
	actually removes some special-casing Ingo did in the signal code).

<greg@kroah.com> (02/04/04 1.524.30.4)
	USB
	
	moved lots of the Config.in info into the subdirectories.
	fixed up the makefiles to work nicer.

<torvalds@penguin.transmeta.com> (02/04/04 1.561)
	Scheduler preempt fixes and cleanups

<torvalds@penguin.transmeta.com> (02/04/04 1.562)
	Make the assembly-level code match the preempt_sched
	changes

<torvalds@home.transmeta.com> (02/04/04 1.563)
	More fixups for tlbflush.h header split

<torvalds@home.transmeta.com> (02/04/04 1.564)
	Fix exit_notify() to actually do what the comment
	says it should do - lock out preemption.

<greg@kroah.com> (02/04/04 1.524.30.5)
	USB
	
	moved some files from misc to image
	cleaned up makefile some more.

<greg@kroah.com> (02/04/04 1.524.30.6)
	USB
	
	fixed lib Makefile problem with usb files moving
	moved drivers/usb/scanner/ to drivers/usb/image/

<greg@kroah.com> (02/04/05 1.524.30.7)
	USB
	
	moved the host drivers help to the host directory

<greg@kroah.com> (02/04/05 1.524.30.8)
	USB
	
	more file movement cleanups.  Now handles misc drivers compiled into
	the kernel corectly.

<mochel@segfault.osdl.org> (02/04/05 1.566)
	Add device_shutdown() calls to reboot and power off transitions (and let the user know)

<mochel@segfault.osdl.org> (02/04/05 1.567)
	compile fix for drivers/base/sys.c

<mochel@segfault.osdl.org> (02/04/05 1.568)
	Add platform driver object

<greg@kroah.com> (02/04/05 1.524.30.9)
	USB
	
	moved class/storage/ back to storage/
	created input/
	orderd the makefiles and config.in menus better.

<torvalds@penguin.transmeta.com> (02/04/05 1.570)
	Duh. Use "device_lock", not "device_root" for locking.

<greg@kroah.com> (02/04/05 1.524.30.10)
	USB
	
	added a README file to explain what the different subdirectories are for.

<greg@kroah.com> (02/04/05 1.524.30.11)
	USB
	
	moved the USB_STORAGE Config.help items into the drivers/usb/storage directory.

<axboe@suse.de> (02/04/05 1.572)
	[PATCH] elevator 'buglet'
	
	Lets just kill this check -- it usually only catches drivers queueing
	something in front of a started request on their own (such as shoving a
	request sense in front of a failed packet command, for instance). So
	it's either working around this detection in some drivers, or killing
	it. I vote for the latter, patch attached against 2.5.8-pre1 :-)

<neilb@cse.unsw.edu.au> (02/04/05 1.573)
	[PATCH] PATCH 1 of 4 : knfsd : Use symbols for size calculation for response sizes.
	
	Use symbolic names for some common size components in the response
	size calculation for the NFSD.  This makes it easier to get the
	numbers right and to review them.
	This patch also fixes a few number for nfsv3 that were wrong.

<neilb@cse.unsw.edu.au> (02/04/05 1.574)
	[PATCH] PATCH 2 of 4 : knfsd : Allow exporting of deviceless filesystems if fsid= given
	
	Previously we could only export FS_REQUIRES_DEV filesystems
	as we need a devno to put in the filehandle.
	Now that we have fsid= (NFSEXP_FSID) we don't need a devno
	to put in the filehandle so we can relax this requirement.

<neilb@cse.unsw.edu.au> (02/04/05 1.575)
	[PATCH] PATCH 3 of 4 : knfsd : Store the fsid in the returned attributes instead of the device number
	
	When a filesystem is exported with  fsid=  we should use that
	fsid instead of the i_dev number when returning NFS attributes,
	so that there is no chance of clients that depend on the filesys
	id in the attributes getting confused by device numbers changing.
	
	We only do this if the reference filehandle uses fsid to identify
	the filesystem, so that a server can be converted from non-fsid= to
	using fsid= without confusing active clients.

<neilb@cse.unsw.edu.au> (02/04/05 1.576)
	[PATCH] PATCH 4 of 4 : knfsd : Increase the max block size for NFS replies.
	
	This increases the max read/write size for nfsd from 8K to 32K.
	
	This requires making NFSv2 return the right number in statfs
	requests.  NFSv3 already does that.

<neilb@cse.unsw.edu.au> (02/04/05 1.577)
	[PATCH] PATCH 4a or 4 : knfs : typo...
	
	typo in that last patch, sorry.

<haveblue@us.ibm.com> (02/04/05 1.578)
	[PATCH] shift BKL out of notify_change
	
	Moved i_sem down into notify_change() and out of the UMSDOS
	function. Moved BKL down from notify_change into filesystems.

<torvalds@penguin.transmeta.com> (02/04/05 1.579)
	Make legacy drivers who use "virt_to_bus()" and friends work on x86.
	
	It's up to other architectures to worry about portability for now.

<torvalds@linux.local> (02/04/05 1.581)
	Oops, remove remnants of old attribute lock

<torvalds@linux.local> (02/04/05 1.582)
	Force some semblance of workingness onto qla1280 driver

<torvalds@linux.local> (02/04/05 1.583)
	Clean up do_truncate due notify_change() locking change


