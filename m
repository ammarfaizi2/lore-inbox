Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317953AbSGPX6E>; Tue, 16 Jul 2002 19:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318156AbSGPX6D>; Tue, 16 Jul 2002 19:58:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317953AbSGPX57>; Tue, 16 Jul 2002 19:57:59 -0400
Date: Tue, 16 Jul 2002 16:57:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.5.26
Message-ID: <Pine.LNX.4.33.0207161655001.1440-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Catching up with emails after having been off-line for a week.

I probably missed a number of emails, so anybody who feels left out, just 
re-send, please.

This one is all over the map, with input, USB etc updates, mixed with lots 
of fixes from Rusty's trivial patchbot, and NFS client updates.

		Linus

----

Summary of changes from v2.5.25 to v2.5.26
============================================

<agrover@acpi3.(none)>:
  o Toshiba laptops enable special functionality via an ACPI device.
    This driver handles that, and will be maintained by John Belmonte.
  o ACPI interpreter update
  o Allow things to compile with UP, local APIC, no IO APIC
  o Removed no longer needed acpi_evaluate (a wrapper function) Use
    acpi_os_free instead of kfree directly Fix possible memory leaks
    Fix possible divide by 0 (Dominik Brodowski)
  o The ECDT is a table which contains information about the Embedded
    Controller that allows use of the EC and EC opregions before we
    actually parse the namespace.
  o Fix possible memory leak Rewrite acpi_bus_init to be merely nasty,
    instead of unspeakably nasty Add call to acpi_ec_ecdt_probe()
  o remove #ifdef HANE_NEW_DEVICE_MODEL because we always have it
  o Change some IA64 stuff as requested by Matthew Wilcox Implement fix
    for keyboard hang when getting battery readings on some systems
    (Stephen White)
  o Change idle policy a little Use acpi_os_free instead of kfree
    directly Eliminate CONFIG_SMP ifdef and simplify errata.smp code
  o Add a warning Fix a typo Use the default bios-given IRQ if ACPI
    can't find one at all (Dominik B)

<asl@launay.org>:
  o Warning fix for i386 io apic

<ctindel@cup.hp.com>:
  o drivers/net/bonding.c: Check ethtool then mii ioctl to determine
    link status

<dent@cosy.sbg.ac.at>:
  o remove redundant declarations 
  o [PATCH] duplicate declarations #2

<gnb@alphalink.com.au>:
  o 2.5: kconfig fixes
  o 2.5: update CREDITS

<ica2_ts@csv.ica.uni-stuttgart.de>:
  o Use proper ____cacheline_aligned define in netfilter_ip_tables.c

<james@cobaltmountain.com>:
  o Typo fixes

<jdike@karaya.com>:
  o pass panic message to panic notifier chain

<kiran@in.ibm.com>:
  o net/core/dst.c: dst_total only needs to exist if RT_CACHE_DEBUG >= 2

<maalanen@ra.abo.fi>:
  o [patch, 2.5] sound_oss_ad1848.c doesn't release region on error

<mulix@actcom.co.il>:
  o fix 'implicit declaration of function memset' in ppp modules

<petri.koistinen@iki.fi>:
  o Maxium inline patch is 40 kilobytes, not kilobits

<schwidefsky@de.ibm.com>:
  o s390 LOG_BUF_LEN

<vs@tribesman.namesys.com>:
  o do not require for exclusive access to buffer
  o Delete: fs/reiserfs/buffer2.c

<wa@almesberger.net>:
  o include/net/dsfield.h: Remove dead code

<willy@debian.org>:
  o make ips driver compile

Alexander Viro <viro@math.psu.edu>:
  o futex filesystem handling

alexander.riesen@synopsys.com <Alexander.Riesen@synopsys.com>:
  o [PATCH 2.5.20] typo in quotas config

Andi Kleen <ak@muc.de>:
  o fix iounmap for non page aligned addresses

Andreas Dilger <adilger@clusterfs.com>:
  o 2.5 i_size_high fixup

Andrew Morton <akpm@zip.com.au>:
  o direct-to-BIO for O_DIRECT
  o fix O_DIRECT oops

Andrey Panin <pazke@orbita1.ru>:
  o missing static in lib_vsprinf.c

Andy Grover <agrover@groveronline.com>:
  o change Intel cache-detection code to use a table

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: 2.0.15 - Fake inodes based attribute i/o via the pagecache,
    fixes, cleanups
  o NTFS: 2.0.16 - Convert access to $MFT/$BITMAP to attribute inode
    API
  o NTFS: Fix debugging check in fs/ntfs/aops.c::ntfs_read_block()
  o NTFS: 2.0.17 - Cleanups and optimizations - shrinking the ToDo list
  o NTFS: 2.0.18 - Fix race condition in reading of compressed files
  o NTFS: 2.0.19 - Fix race condition, improvements, and optimizations
    in i/o interface
  o NTFS: 2.0.20 - Support non-resident directory index bitmaps, fix
    page leak in readdir
  o drivers/char/serial.c compile fix
  o Fix&improve debugging checks in async io completion handlers
  o NTFS: 2.0.21 - Check for, and refuse to work with too large
    files/directories/volumes

Anton Blanchard <anton@samba.org>:
  o Allow non zero boot cpu

Ben Collins <bcollins@debian.org>:
  o IEEE1394 updates

Bob Miller <rem@osdl.org>:
  o 2.5.25 remove global semaphore_lock spin lock

Brad Hards <bhards@bigpond.net.au>:
  o Typo fixes in input code
  o joydump driver
  o USB: printk janitorial fixes
  o USB: printk janitorial fixes

Dave Hansen <haveblue@us.ibm.com>:
  o HPFS fix return without releasing BKL
  o AFFS fix return without releasing BKL

Dave Jones <davej@suse.de>:
  o bluesmoke fixes take 2

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o procfs entries should be created when CONFIG_JFS_STATISTICS is set
  o JFS: set s_maxbytes to 1 byte lower
  o JFS: Remove extraneous bdput calls

David Brownell <david-b@pacbell.net>:
  o usb driverfs, +misc
  o urb->transfer_flags updates
  o ohci misc

David S. Miller <davem@nuts.ninka.net>:
  o Tigon3: On 32-bit just wrap low 32bits of stats if we overflow
  o SunHME: Register IRQ with netdev->name as string
  o Add netif_receive_skb-like interface for VLAN hw accel
  o Tigon3: Add NAPI support
  o Sparc: Update for HZ changes
  o Netlink: Pid check changes need to use 2.5.x style sock private
    accessing
  o Sparc build fixes
  o AIC7XXX_OLD: cmd->request is a pointer, not the struct itself
  o fs/partitions/check.c: Fix 64-bit platform warnings
  o fs/quota_v2.c: Use proper printk format for ssize_t
  o Sparc64: Update defconfig

Douglas Gilbert <dougg@torque.net>:
  o sg driver against lk 2.5.25

Gerd Knorr <kraxel@bytesex.org>:
  o v4l: tuner module update
  o btaudio driver update
  o video4linux i2c modules
  o bttv documentation update
  o bttv driver update
  o msp3400 fix

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added product, manufacturer, and serial driverfs files for a
    device
  o USB: removed the uhci.c driver from the tree
  o USB: removed the usb-uhci.o driver
  o USB: removed the usb-uhci-hcd.o driver
  o fix i_nlink for root inode in usbfs
  o USB HID: remove some compiler warnings
  o USB: fix for oops at shutdown when uhci-hcd is compiled into the
    kernel
  o USB: fix flag name in ohci driver due to previous patch

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o error code for msync()
  o error code for mprotect()

James Morris <jmorris@intercode.com.au>:
  o NETLINK: Add unicast release notifier
  o 3c509.c compile fix for 2.5

James Simmons <jsimmons@heisenberg.transvirtual.com>:
  o Removed passing around struct kbd_struct for sysrq. Only two calls
    use it
  o Initialization cleanup. The ultimate idea is seperate out the video
    display and input device intialization into there own functions.
    Also to seperate out teh console and tty intializtions. In theory
    we could have a light weight VT console by itself
  o Started to enforce a one to one relationship between struct
    tty_struct and struct vc_data. It will make it easier to handle
    things
  o Dropped a important bug fix. Now it works :-)
  o Updates against input CVS. Lots of typo fixs and new info. Added in
    Q40 keyboard controller for m68k platform
  o Add Q40 keyboard controller

Keith Owens <kaos@ocs.com.au>:
  o 2.5.24 Documentation_DocBook_kernel-api.tmpl
  o 2.5.24 drivers_usb_core_hcd.c for DocBook
  o 2.5.24 mm_slab.c for DocBook

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix i_nlink for root inode in ramfs/driverfs
  o Avoid taking i_shared lock while already holding the page table
    lock
  o Only allow sendfile() on destination descriptors that know about
    the "sendpage()" callback. Don't try to fall back on a write with
    the page kmap'ed
  o Mark the dentry referenced at dput time
  o Remove BKL from affs_rmdir() as per Roman Zippel
  o Remove duplicated function declaration

Martin Dalecki <dalecki@evision-ventures.com>:
  o IDE 98
  o 2.5.25 end_request trivia

martin.bligh@us.ibm.com <Martin.Bligh@us.ibm.com>:
  o fix timer interrupts on NUMA-Q

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: merge bitfields into a unified system
  o usb-storage: consolidate, cleanup, etc
  o usb-storage: consolidate, cleanup, etc
  o usb-storage: catch bad commands

Mikael Pettersson <mikpe@csd.uu.se>:
  o sound_oss_sb_audio.c copy_from_user buglets

Pavel Machek <pavel@ucw.cz>:
  o suspend-to-disk: cleanup printks(), rearrange reading
  o Kill warning I introduces in eepro100

Robert Kuebel <kuebelr@email.uc.edu>:
  o namespace.c - compiler warning

Robert Love <rml@tech9.net>:
  o use new list macro in sched.c
  o type typo in do_softirq

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Ensure we clear the PSR flags when calling signal handlers
  o [ARM] Don't pass PC address into per-processor abort handlers in r0
    We no longer need to pass the address in to the per-processor abort
    handlers in r0 (since it's already passed in r2).  r0 was preserved
    while each abort handler was fixed up.
  o [ARM] Fix up include/asm-arm/param.h (and sub-architecture param.h)
    for 2.5.25 HZ/USER_HZ changes.
  o [ARM] Fix include/asm-arm/system.h for 2.5.22 so sched.c builds
  o [ARM] Clean up __cli(), __sti(), cli() to use local_irq_*
  o [ARM] Make IRQ probing more reliable; ensure that IRQ edge
    detection is set correctly.  Remove couple of debugging printk()s.
  o [ARM] cpufreq updates - new, more flexible initialisation handling
  o [ARM] FP emulation IRQ handling cleanup
  o [ARM] General update of various ARM related files
  o [ARM] Fix ELF "HWCAP" flags for the various CPU types
  o [ARM] ptrace cleanups
  o [ARM] page fault handling updates
  o [ARM] StrongARM SA1111 cleanups
  o [ARM] Miscellaneous updates

Rusty Russell <rusty@rustcorp.com.au>:
  o A fix for futex

Stephen Rothwell <sfr@canb.auug.org.au>:
  o cs46xx.c needs init.h
  o Make CRIS use generic copy_siginfo_to_user
  o make Alpha use generic copy_siginfo_to_user
  o ipc_ statics

Tom Rini <trini@kernel.crashing.org>:
  o Don't always ask about Intel RNGs

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS attribute caching bug
  o 2.5.25 Clean up RPC receive code
  o Fix bug in xdr_kunmap()
  o RPC over UDP congestion control updates 

Urban Widmark <urban@teststation.com>:
  o smbfs - smbiod

Vojtech Pavlik <vojtech@suse.cz>:
  o Big HID update
  o Re: [bk patch] Big HID update
  o New driver for the X-Box gamepads
  o Make USB HID ForceFeedback experimental
  o Updates for hiddev by Paul Stewart
  o Reintroduce proper returning of -EFAULT to hiddev.c
  o A cleanup of Paul's 2.5 hiddev update

Vojtech Pavlik <vojtech@twilight.ucw.cz>:
  o Cleanups by Russell King <rmk@arm.linux.org.uk>, char signedness
    and removal of extra \n.
  o Move delayed rescanning of the ports to serio.c, add a kernel
    thread for that, so that hotplug events happen in process context.
  o Fixes (to make it compile), cleanups (in comments) for Amiga and
    Acorn RiscPC mice.
  o INPUT_EMU10K1 should be GAMEPORT_EMU10K1, fixed in
    drivers/input/gameport Config.in and Config.help
  o Change rpcmouse.c to use BUS_HOST instead of BUS_ISA
  o Fix a typo in drivers/input/gameport/Config.help
  o Use Johann Deneux's own i-force configuration and build code
  o Updates and fixes for sound drivers to handle gameports better
  o Remove mouse drivers no longer needed, because these mice are now
    handled by the input subsystem.
  o Don't depend on CONFIG_ISA for drivers that handle hardware that's
    on the mainboard - not in an ISA slot.
  o Fix make menuconfig crash on entering "Char devices" caused by
    removing too much when removing old mouse drivers.
  o Only initialize pc_keyb when i8042.c isn't selected
  o Fix a hang in serio code and a possible oops in input
  o Add a wrapper function for serio ->interrupt callback
  o This cset implements automatic detection of PS/2 mice and AT
    keyboards even when they were not connected at boot time. This is
    done by polling the i8042 chip when its interrupts are not enabled.
  o Unregister an AUX/KBD port if the interrupt cannot be ever claimed
  o Updated Config.in from Johann Deneux, which should fix
  o Remove number member from struct gameport. Not needed
  o Add a driver for the Bitsy touchscreen
  o Update the HID drivers to latest version
  o Fix pid.c build when built as a module
  o Add a driver for X-Box gamepads. While they have quite normal data
    format, they cannot be handled by HID, because they lack the
    descriptors and have completely nonstandard interface class.
  o Make USB HID/PID force feedback an experimental option
  o This cset adds uinput the userspace input driver by Aristeu Sergio
    Rozanski Filho.
  o This cset adds the Newton keyboard driver
  o Franz Sirl's ADB/PPC keyboard handling update - move fully to using
    the input core
  o Add key definitions for set-top boxes
  o Modify i8042.c to be able to support non-isa based archs which use
    i8042-alike keyboard controllers, namely PPC. Patch by Franz Sirl.


