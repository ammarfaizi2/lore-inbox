Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSBMWiz>; Wed, 13 Feb 2002 17:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSBMWir>; Wed, 13 Feb 2002 17:38:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12301 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289046AbSBMWib>; Wed, 13 Feb 2002 17:38:31 -0500
Date: Wed, 13 Feb 2002 14:38:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.5.5-pre1
Message-ID: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a _huge_ patch, mainly because it includes three big pending
things: the ALSA merge (which is much smaller in the BK tree than in the
patch, because a lot of them are due to renames), merging most of x86_64,
and merging some PPC patches.

Full changelog appended.

		Linus

----

Summary of changes from v2.5.4 to v2.5.5-pre1
============================================

<paulus@tango.paulus.ozlabs.org> (02/02/10 1.248.5.1)
	Import arch/ppc and include/asm-ppc changes from linuxppc_2_5 tree

<reality@delusion.de> (02/02/10 1.263)
	[PATCH] 2.5.4-pre6 apm compile fix

	Make apm compile properly and without warnings.

<reality@delusion.de> (02/02/10 1.264)
	[PATCH] 2.5.4-pre6 compile fix for i386/kernel/signal.c

	Fixe a compiler warning in signal.c due to a missing prototype for
	"do_coredump".

<torvalds@home.transmeta.com> (02/02/10 1.262.1.1)
	Remove warning in /proc inode conversions.

<davem@pizda.ninka.net> (02/02/10 1.262.2.1)
	Clean up sparc64 build.

<davem@pizda.ninka.net> (02/02/10 1.262.2.2)
	Split protocol specific information out from struct sock.
	Work done by Arnaldo Carvalho de Melo.

<davem@pizda.ninka.net> (02/02/10 1.262.2.3)
	Netfilter bugfixes from Harald and Paul Russell.

<davem@pizda.ninka.net> (02/02/10 1.262.2.4)
	Add writev support to TUN driver.
	From Eddie C. Dost

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.1)
	This patch fixes a bug that appears when you have more than 16 physical
	LUNs attached to a cciss controller, and a tape drive is beyond the 16th
	LUN.  In such a case, the tape drive would not be accessible without this
	patch.  Applies to 2.5.4-pre3.  -- steve.cameron@compaq.com

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.2)
	setup_str[] only used in modular builds.

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.3)
	add more build config files to ignore list

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.4)
	Fix for cciss driver where I had passed the wrong
	first parameter to grok_partitions in the ioctl for
	registering a new disk.

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.5)
	Replace awful schedule_timeout polling code with
	completions.  Applies to 2.5.4-pre3
	-- steve.cameron@compaq.com

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.6)
	Replace calls to suser() with capable().  Move those checks to be
	as late as possible to avoid accounting overcharging processes with
	privilege usage.  Applies to 2.5.4-pre3
	-- steve.cameron@compaq.com

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.7)
	Make cciss driver contribute to entropy pool.
	Applies to 2.5.4-pre3
	-- steve.cameron@compaq.com

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.8)
	change cciss driver version number.  Applies to 2.5.4-pre3
	-- steve.cameron@compaq.com

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.9)
	Small batch of IDE code cleanups from Pavel Machek

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.10)
	thread_saved_pc fix from akpm

<paulus@tango.paulus.ozlabs.org> (02/02/11 1.257.2.2)
	Update PPC for recent generic changes; in particular adapt to
	having the thread_info struct at the base of the stack and
	the task_struct elsewhere.

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.11)
	Remove nr_sectors from bio_end_io end I/O callback. It was a relic
	from when completion was potentially called more than once to indicate
	partial end I/O. These days bio->bi_end_io is _only_ called when I/O
	has completed on the entire bio.

<axboe@burns.home.kernel.dk> (02/02/11 1.262.3.12)
	bio_endio doesn't take nr_sectors argument anymore.

<rth@fidel.sfbay.redhat.com> (02/02/11 1.262.4.1)
	Update Alpha UP for thread_info and scheduler changes.

<rth@fidel.sfbay.redhat.com> (02/02/11 1.262.4.2)
	Fixes for premature thread_info changeset.
	Minor warning removal.

<mingo@earth2.(none)> (02/02/11 1.262.6.1)
	merge to the -K3 scheduler.

<greg@soap.kroah.net> (02/02/11 1.262.7.1)
	patch from Peter Osterlund <petero2@telia.com> to fix usb-storage debug code
	compile problem.

<greg@soap.kroah.net> (02/02/11 1.262.7.2)
	patch from David Probnell, updating the USB error-codes.txt file

<greg@soap.kroah.net> (02/02/11 1.262.7.3)
	patch by Simon Evans <spse@secret.org.uk> that adds a Konica USB webcam driver

<greg@soap.kroah.net> (02/02/11 1.262.7.4)
	removed 'typedef' from the Digi Acceleport usb-serial driver.

<greg@soap.kroah.net> (02/02/11 1.262.7.5)
	removed 'typedef' from the ftdi_sio usb-serial driver.

<greg@soap.kroah.net> (02/02/11 1.262.7.6)
	removed 'typedef' from the IO Networks Edgeport usb-serial driver.

<greg@soap.kroah.net> (02/02/11 1.262.7.7)
	removed 'typedef' from the Keyspan usb-serial drivers.

<greg@soap.kroah.net> (02/02/11 1.262.7.8)
	removed 'typedef' from the kl5kusb105 usb-serial driver.

<rth@fidel.sfbay.redhat.com> (02/02/11 1.262.4.3)
	Update Alpha SMP for the new scheduler and preempt api change.

<jgarzik@rum.normnet.org> (02/02/11 1.262.5.2)
	Add a couple #includes to fix the alpha build.

<sfr@canb.auug.org.au> (02/02/11 1.262.8.1)
	[PATCH] 2.5.4-pre6 apm compile fix

	Here is the patch against 2.5.4.  I have compiled this patch under
	2.5.3, so it should still be OK.

	This patch just resyncs the driver with 2.4.18-pre (which is what is
	being testd by others).  The only outstanding known problem is some
	very strange interaction with VMWARE.  But otherwise people seem
	happy with the changes.

	Original announcement to Dave Jones and Marcelo:

		Update a couple of email addresses
		Fix the idle handling (this is an improved version of the fix
			that Alan Cox has in his -ac tree)
		Notify user mode of suspend events before drivers (fix)
		Make the idling percentage boot time configurable
		Rename kapm-idled to kapmd

	Credit to Andreas Steinmetz, Russell King, Thomas Hood and me.

	More small updates to come.
	--
	Cheers,
	Stephen Rothwell                    sfr@canb.auug.org.au
	http://www.canb.auug.org.au/~sfr/

<rml@tech9.net> (02/02/11 1.271)
	[PATCH] Optimized UP preempt fix

	I previously sent a patch by Mikael Pettersson to fix the UP+preempt
	problem.  It seems from your BK repository you have not yet merged it;
	if so, this patch takes a different approach which is optimal, removing
	the unneeded conditional altogether in the UP case.  I have verified UP
	and SMP are now correct.  Patch is against 2.5.4, please apply.

		Robert Love

<viro@math.psu.edu> (02/02/11 1.272)
	[PATCH] (2.5.4) death of ->i_zombie

		Rediffed to 2.5.4, documentation added.  This variant grabs
	->s_vfs_rename_sem only for cross-directory renames.

<davidm@hpl.hp.com> (02/02/11 1.276)
	[PATCH] updated version of VM_DATA_DEFAULT_FLAGS patch

	Here is the latest version of the VM_DATA_DEFAULT_FLAGS patch
	(relative to 2.5.4).

		--david

<rob@osinvestor.com> (02/02/11 1.277)
	[PATCH] drivers/char/pcwd.c

	This patch to drivers/char/pcwd.c against 2.5.4 does two things:
	a) Makes one code snippet more consistent with the rest of the code, and
	b) Makes it possible for this code to actually work

	Nearly the same patch against 2.4 was reviewed by Alan, and, well, the
	maintainer seems to have disappeared.  It's also looking like no one uses
	this driver much either.

	Regards,
	Rob Radez

<davidm@hpl.hp.com> (02/02/11 1.278)
	[PATCH] dma64_addr_t fix ups

	This patch fixes up two places whre dma64_addr_t is used incorrectly.
	Note that pci_dev->dma_mask and the second argument to
	blk_queue_bounce_limit() are both u64, so the old types clearly are
	wrong (besides, dma64_addr_t is supposed to be used only with the
	pci_dac_*() routines, as per DaveM's earlier mail).

		--david

<davidm@hpl.hp.com> (02/02/11 1.279)
	[PATCH] fix for elf coredump deadlock

	This patch fixes a deadlock condition in the elf core dump that shows
	on ia64 because ELF_CORE_COPY_REGS() needs to access user space (to
	get a hold of the backing store of the stacked registers).  Marcelo
	already accepted this into 2.4.17.

		--david

<davidm@hpl.hp.com> (02/02/11 1.280)
	[PATCH] video console fix up

	Here is the last patch for today: it enables writecombined mappings
	for ia64 in fbmem.c and gets rid of an ugly ia64 simulator workaround
	in vgacon.c which isn't needed anymore.

		--david

<rth@twiddle.net> (02/02/11 1.281)
	[PATCH] discarded section problem

	What should be happening with the references to the discarded .text.exit
	section?  I see a __devexit_p mentioned in Documentation/pci.txt, but it
	hasn't been implemented except for down inside ieee1394.

	In any case, I need something like the following in order to build with
	pre-release binutils 2.12.  If this sort of thing is acceptible I can
	prepare a more comprehensive patch.

<reiser@namesys.com> (02/02/11 1.282)
	[PATCH] 01-ioerrors-checks-2.diff

	    Make sure all reiserfs_find_entry users correctly understand IO_ERROR retval.

<reiser@namesys.com> (02/02/11 1.283)
	[PATCH] 02-savelink_nospace_nowarning.diff

	   Do not print a warning if savelink was not created due to lack of space.

<reiser@namesys.com> (02/02/11 1.284)
	[PATCH] 03-savelink_dir_truncate.diff

	   Do not panic on incorrect savelink entries (truncate on directory).
	   Currently we suppose these can be created if switching between kernels
	   with and without savelinks support.

<reiser@namesys.com> (02/02/11 1.285)
	[PATCH] 04-hash_autodetect_fix.diff

	   Correctly detect and print hash values, when manual hash detection is used.

<reiser@namesys.com> (02/02/11 1.286)
	[PATCH] 05-corrupt_items_checks.diff

	   Do not panic when encountered item of unknown type, just print a warning.

<reiser@namesys.com> (02/02/11 1.287)
	[PATCH] 06-kmalloc_cleanup.diff

	   Convert all the code to use reiserfs_{kmalloc,kfree}. Remove all extra
	   reiserfs_{kmalloc,kfree} overhead if CONFIG_REISERFS_CHECK is not set.

<reiser@namesys.com> (02/02/11 1.288)
	[PATCH] 07-reiserfs-bitmap-journal-read-ahead.diff

	   Speed up reading of journal bitmaps. RAID users should notice significant
	   speedup when mounting reiserfs over self-rebuilding RAID arays.

<reiser@namesys.com> (02/02/11 1.289)
	[PATCH] 08-truncate_update_mtime.diff

	   truncate now correctly sets mtime always. Before this fix, mtime was not
	   updated if truncated file was of zero length or if new filesize was bigger
	   then old.
	   Problem was noticed by Matthias Andree <ma@dt.e-technik.uni-dortmund.de>

<viro@math.psu.edu> (02/02/11 1.290)
	[PATCH] BKL-free ext2_get_block()

		Linus, I've got the first of BKL-removal ext2 patches ready to
	go.  It removes BKL from ext2_get_block() and guts of ext2_truncate().
	The only place where we hold BKL on these paths is in dquot.c - probably
	can be easily dealt with, but threading quota is a separate story.

		Inode metadata (pointers to blocks, both in inode itself and in
	indirect blocks, preallocation data and allocation goal) are protected
	by rwlock - EXT2_I(inode)->i_meta_lock.

		Next steps will involve threading the group descriptors and bitmaps
	handling - lock_super() uses in ext2 are going to die.  However, that's
	a separate story - let's do that step-by-step.

		I suspect that patch below will take care of almost all BKL contention
	from ext2 - we still have BKL held over directory operations, but for regular
	files that's it.

<vandrove@vc.cvut.cz> (02/02/11 1.292)
	[PATCH] zisofs compilation error

	* zisofs_cleanup cannot be __exit, as it is invoked from __init
	  section when register_filesystem() fails.

			Petr Vandrovec

<vandrove@vc.cvut.cz> (02/02/11 1.293)
	[PATCH] 2.5.4-pre5 and ncpfs fill_super changes

	* fs/ncpfs/inode.c: Return reasonable error codes instead of universal
	     -EINVAL. Remove printk() as reasonable code is returned.
	     Set maximum file size limit on ncpfs to 4GB-1.

	* fs/ncpfs/sock.c: Return correct error code when send() fails.

		Petr Vandrovec

<jgarzik@rum.normnet.org> (02/02/12 1.294)
	Various minor documentation / comment typo fixes
	for net drivers 3c509, acenic, ni52, and skfp.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.295)
	request_region cleanups from 2.4 and the kernel janitors.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.296)
	Remove deprecated SIOCDEVPRIVATE ioctls in net drivers
	3c59x, eepro100, sis900, and tulip.

	Also, update eepro100 Becker URL.

	Contributor: Dave Jones

<jgarzik@rum.normnet.org> (02/02/12 1.297)
	Merge basic ethtool ioctl support from 2.4.x for 3c505 and sis900
	net drivers.  Merge two sis900 bug fixes from 2.4.x.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.298)
	Fix typo in aironet4500 net driver return value, s/NODEV/-ENODEV/,
	which prevented the driver from building.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.299)
	Merge cosmetic cleanup and driver version increment
	for dmfe net driver from 2.4.x.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.300)
	Add new ISAPNP card id to 'ne' net driver.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.301)
	Merge 8139too net driver oops fix from 2.4.x.

	Fix originally by Andreas Dilger IIRC, merged by Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.302)
	Merge ns83820 GigE net driver changes from 2.4.x kernel:
	0.13a - optical transceiver support added
		by Michael Clark <michael@metaparadigm.com>
	0.13b - call register_netdev earlier in initialization
		suppress duplicate link status messages
	0.15	get ppc (big endian) working

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.303)
	Merge ethtool support and PPC fix into pcnet32 net driver,
	from 2.4.x.
	Also, remove deprecated SIOCDEVPRIVATE ioctl calls.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.304)
	Merge changes from yellowfin GigE net driver version LK1.1.6:
	* Only print warning on truly "oversized" packets
	* Fix theoretical bug on gigabit cards - return to 1.1.3 behavior

	Contributor: Val Henson

<jgarzik@rum.normnet.org> (02/02/12 1.305)
	A minor patch to remove the last isa_read/isa_write function in
	the ibmtr token ring net driver.

	Contributor:
	Mike Phillips
	Linux Token Ring Project

<davem@pizda.ninka.net> (02/02/11 1.262.2.5)
	Fix recalc_sigpending handling.

<jgarzik@rum.normnet.org> (02/02/12 1.306)
	Cleanup and fixes to sleeping/scheduling in the olympic token ring
	net driver.  Also included are a couple of minor error reporting
	updates and the proper detection for cardbus removal.

	Contributor:
	Mike Phillips
	Linux Token Ring Project

<torvalds@home.transmeta.com> (02/02/11 1.293.1.1)
	Fix up typo from Al's ext2 balloc cleanups.

<cyeoh@samba.org> (02/02/11 1.293.1.2)
	[PATCH] mmap can return incorrect errno

	mmap currently sets errno to EINVAL when it should be ENOMEM.
	SUS/POSIX states that ENOMEM should be returned when:

	"MAP_FIXED was specified, and the range [addr, addr + len) exceeds
	that allowed for the address space of a process; or if MAP_FIXED was
	not specified and there is insufficient room in the address space to
	effect the mapping."

	The following patch (against 2.4.17) fixes this behaviour:

<jgarzik@rum.normnet.org> (02/02/12 1.307)
	Add new pci id to via-rhine net driver.

<pmanolov@Lnxw.COM> (02/02/11 1.293.2.1)
	[PATCH] pegasus.h

	this patch somehow didn't get applied to 2.5.4
	so i resend it.  It is pretty harmless - only
	adds 3 more devices and 2 vendor ids into pegasus.h :-)

<vojtech@suse.cz> (02/02/11 1.293.2.2)
	[PATCH] Update of USB input drivers to the latest versions

	Now that the input core changes have made it into 2.5 I can finally
	update the USB input drivers to their latest versions.

	Here is a patch that does that.

	In detail:

		HID driver:
			Fix a bug in descriptor parsing (array/variable),
				namely visible with Logitech new joysticks and mice
			Fix bugs in logical/physical min/max parsing
			Fix bugs in exponent parsing
			Remove workaround for low-speed devices with >8 byte
				reports, fix this in a correct way (bigger irq
				request)
			Untangle some code (fetc_item())
			Implement asynchronous input/output/feature report
				reading and writing
			Implement (hopefully) proper locking in the above
			Implement support for devices with an output endpoint
			Add some support functions for force feedback support
				currently in development
			Add entries to the debug dump code, including FF and
				exponents
			Add more mappings into the hid-input interface
			Cleanups here and there

		usbkbd driver:

			Make LED URBS use GFP_ATOMIC, they'll be called from a
				completion handler
			Remove dependency on hid.h

		usbmouse driver:

			Just conversion to the new input core, minor cleanups

		wacom driver:

			Just conversion to the new input core.

<viro@math.psu.edu> (02/02/12 1.281.1.1)
	[PATCH] BKL shifted into ->lookup()

		OK, here comes: ->lookup() had lost BKL, all in-tree instances of
	->lookup() converted.

		I'm adding Documentation/filesystems/porting - with the list of
	API changes since 2.4.  Are you OK with that format?

	(and yes, this sucker is *post*-compile ;-)

<viro@math.psu.edu> (02/02/12 1.311)
	[PATCH] BKL shifted into ->truncate()

		BKL shifted into all instances of ->truncate().  Callers updated.

<jgarzik@rum.normnet.org> (02/02/12 1.307.1.1)
	Remove GMAC net driver, with the ok of the PPC folks.
	'sungem' which DaveM is maintaining is the replacement.

<jgarzik@rum.normnet.org> (02/02/12 1.307.1.2)
	Merge bug fixes and PPC-specific feature additions from 2.4.x
	into bmac and mace net drivers.

	Via Dave Jones.

<jgarzik@rum.normnet.org> (02/02/12 1.307.1.3)
	Add new pci id to 8139too net driver, for Allied Telesyn cardbus cards.

	Contributor: Go Taniguchi

<jgarzik@rum.normnet.org> (02/02/12 1.293.3.1)
	Add Macrolink board PCI ids to pci.ids and pci_ids.h.

	Contributor: Ed Vance @ Macrolink

<mingo@elte.hu> (02/02/12 1.293.4.1)
	optimization, cleanup: switch_to(3 parameter) => switch_to(2 parameter).

<mingo@elte.hu> (02/02/12 1.293.4.2)
	move sched_find_first_bit() from mmu_context.h to bitops.h, it belongs there.

<mingo@elte.hu> (02/02/12 1.293.4.3)
	a cleanup and a bugfix in the preemptive kernel:

	- the PREEMPT_ACTIVE trick is not needed

	- schedule() should check for need_resched, we might miss a
	  reschedule otherwise.

	the cleanup also fixes the bug. The only reason why i kept
	preempt_schedule() was to fix up p->state to TASK_RUNNING,
	to make it possible to preempt from places that mark the
	task TASK_UNINTERRUPTIBLE before adding the task to a waitqueue,
	and thus a preemption in that small window could cause the
	task to be removed from the runqueue erroneously.

<mingo@elte.hu> (02/02/13 1.293.4.4)
	do not unlock irqs before calling schedule() - besides being a small exit() speedup, this also
	fixes a preemption race that was introduced by my removal of PREEMPT_ACTIVE.

<vojtech@suse.cz> (02/02/12 1.293.2.3)
	usb hid driver:
		- patch to fix bug where urbs were freed too soon.

<mdiehl@mdiehl.de> (02/02/12 1.293.2.4)
	[PATCH] usb_set_interface: correct toggle reset

	this is a patch to prevent usb_set_interface() from erroneously resetting
	the toggles for all endpoints instead of only the affected ones from the
	requested interface/altsetting. I've also added some missing parentheses
	to related macros in usb.h as I prefered not to take special care for
	nasty side-effects ;-)

	Patch below was created against 2.4.18-pre9 (with some lines of offset it
	applies to 2.5.4-pre5 as well).

	Tested in multi-interface configuration to provide evidence it:
	* correctly identifies the affected endpoints and resets the toggles
	* doesn't touch endpoints from other interfaces
	* provides correct handling of shared EP0
	* solves an issue I had with 2.4.18-pre9 where setting one interface
	  occasionally caused transfers on other interface to hang due to lost
	  toggle synchronisation

	Despite being a pure bugfix, well localized and (IMHO) pretty obviously
	correct wrt. USB-spec, I'd like to suggest including this in early
	2.4.19-pre. Just in case some existing driver would somehow workaround
	the currently wrong behavior and might break with this fix. And it's
	not very urgent right now, as we are probably close to 2.4.18-rc1.

	Regards,
	Martin

<mingo@elte.hu> (02/02/13 1.293.4.5)
	this is a fragile piece of the ptrace code, the code relies on a single wakeup coming from the parent.
	This fix is necessery after the preempt_schedule() cleanups, it unbreaks 'strace strace ...'.

<mingo@elte.hu> (02/02/13 1.293.4.6)
	- make the preempt-enable test cheaper - only test for the (very rare) TIF_NEED_RESCHED
	  condition, we test the preemption count in preempt_schedule(). This reduces the icache
	  footprint and the overhead of preemption.

	- plus optimize the irq-path preemption check a bit.

<mingo@elte.hu> (02/02/13 1.293.4.7)
	cleanups.

<perex@perex.cz> (02/02/13 1.262.9.1)
	[PATCH] ALSA patch for 2.5.4

	Integrate ALSA into v2.5.4

	            Jaroslav

<elenstev@mesatop.com> (02/02/13 1.316)
	[PATCH] 2.5.4, add help texts to drivers/net/pcmcia/Config.help

	Add help texts for CONFIG_PCMCIA_AXNET and CONFIG_PCMCIA_XIRCOM

<torvalds@home.transmeta.com> (02/02/13 1.317)
	Make Jaroslav the sound maintainer, remove Alan on his request.

<jgarzik@rum.normnet.org> (02/02/13 1.318)
	Include linux/compiler.h in include/asm-i386/bitops.h,
	for the definition of unlikely().

<mec@shout.net> (02/02/13 1.317.1.1)
	[PATCH] menuconfig: fix error exit if awk fails

	This one-liner fixes an error case in Menuconfig when awk fails.
	Written by Andrew Church (achurch@achurch.org).
	Reviewed and tested by Michael Elizabeth Chastain (mec@shout.net).

	Michael Elizabeth Chastain

	===

<paulus@samba.org> (02/02/13 1.317.1.3)
	[PATCH] fix sd_find_target (v2.5.4)

	This patch fixes a compile error on PPC.  It's in sd_find_target, a
	function that returns a kdev_t.

<paulus@samba.org> (02/02/13 1.317.1.4)
	[PATCH] flush_icache_user_range (v2.5.4)

	The patch below changes access_process_vm to use a new architecture
	hook, flush_icache_user_range, instead of flush_icache_page, and adds
	a definition of flush_icache_user_range which does the same thing as
	flush_icache_page for all architectures except PPC.  (The PPC update
	that is in Linus' BK tree already includes a suitable definition of
	flush_icache_user_range.)

	The reason for doing this is that when flush_icache_page is called
	from do_no_page or do_swap_page, I want to be able to do the flush
	conditionally, based on the state of the page.  In contrast,
	access_process_vm needs to do the flush unconditionally since it has
	just modified the page.  In the access_process_vm case it is useful to
	have the information about the user address and length that have been
	modified since then we can just flush the affected cache lines rather
	than the whole page.

	This patch should make it easy to improve performance on alpha, since
	there (as I understand it) the icache flush is not needed at all in
	do_no_page or do_swap_page, but is needed in access_process_vm.  All
	that is needed is to make flush_icache_page a noop on alpha.  The
	patch below doesn't do this, I'll let the alpha maintainers push that
	change if they want.

<torvalds@home.transmeta.com> (02/02/13 1.320)
	update version

<torvalds@home.transmeta.com> (02/02/13 1.321)
	Avoid pci driver warnings on 64-bit hosts

<ak@muc.de> (02/02/13 1.322)
	[PATCH] x86_64-merge file.c warning

	Just an gcc 3.1 warning fix. It now warns about __FUNCTION__ string
	concatenation. Also remove the check because it does not seem to trigger
	ever.

	-Andi

<ak@muc.de> (02/02/13 1.323)
	[PATCH] x86_64 merge: arch + asm

	This adds the x86_64 arch and asm directories and a Documentation/x86_64.

	It took a bit longer because I first had to make preemption and thread_info
	work and also found some other bugs while doing this. The port has been
	tested for a long time on UP.

	I'm not sure what I should describe.  A lot is based on i386 with
	a lot of cleanups. I wrote a paper about it for last year's OLS that describes
	most of the changes (ftp://ftp.firstfloor.org/pub/ak/x86_64.ps.gz). It is
	a bit outdated now, but should give a good overview.

	It currently has a completely cut'n'pasted from others+hacked 32bit
	emulation. I hope to clean that up in the future by merging the generic
	core of this with other 64bit archs.

	Thanks,
	-Andi

<ak@muc.de> (02/02/13 1.324)
	[PATCH] x86-64 MAINTAINERS

	Add Andi Kleen as x86-64 maintainer.

<ak@muc.de> (02/02/13 1.325)
	[PATCH] x86_64 merge: fs/proc/inode.c #include fix

	fs/proc/inode.c is using __init, but for some reason missing an
	#include <linux/init.h>. Add this.


