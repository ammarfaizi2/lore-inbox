Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTCEDkm>; Tue, 4 Mar 2003 22:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTCEDkm>; Tue, 4 Mar 2003 22:40:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267048AbTCEDkd>; Tue, 4 Mar 2003 22:40:33 -0500
Date: Tue, 4 Mar 2003 19:48:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.64
Message-ID: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Stuff all over, and a lot of spelling fixes. But there's a fair 
number of "real" things here too, merges with Andrew, Dave etc.

As already reported on linux-kernel, this should fix the htree problems 
(apart from some potential NFS export issues, apparently), and it also has 
the nicer hash chain code from Andi (no actual changes in the hash 
algorithms themselves, just the list changes).

Sparc, USB, networking updates.

Ans as I've been a bit snowed under by a lot of email, if you sent me 
stuff and it isn't here, double-check and re-send (but even better, try to 
see if you can find one of my "merge points" and check with them too)

		Linus

Summary of changes from v2.5.63 to v2.5.64
============================================

Andrew Wood <andrew.wood@ivarch.com>:
  o USB: USB-MIDI support for Roland SC8820

<bde@nwlink.com>:
  o [SPARC64]: Fix SMP boot failures

<bwa@us.ibm.com>:
  o [IPV6]: Export in6addr_{any,loopback} to modules

<bzzz@tmi.comex.ru>:
  o Fix ext3/VFS double freeing warning

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Use skb_pull instead of direct skb mangling
  o [ATM]: Get minimum frame size right in lec.c
  o [ATM]: Let upper layer k now lec supports multicast
  o [ATM FORE200E]: Fix build
  o [ATM SUNI]: suni_init should not be __init and remove mod inc/dec

<corryk@us.ibm.com>:
  o dm: prevent possible buffer overflow in ioctl interface
  o fix recent dm breakage

<dwmw2@dwmw2.baythorne.internal>:
  o Allow uart drivers to calculate divisors differently
  o Support high-speed serial modes of National Semiconductor and SMSC
    Super-IO chips
  o Complain about setting custom speed or divisor on serial ports

<eike-kernel@sf-tec.de>:
  o Hex numbers in NCR53c406a.c

<harald@gnumonks.org>:
  o [NETFILTER]: Fix icmp-type all problem in iptables

<joel.buckley@sun.com>:
  o Sun StorEdge[tm] array SparseLUN support

<josh@joshisanerd.com>:
  o USB: KB Gear USB Tablet Drivers

<laforge@netfilter.org>:
  o [NETFILTER]: fix NAT ICMP reply translation of inner packet
  o [NETFILTER]: Fix conntrack bug introduced by list_del change
  o [NETFILTER]: Fix typo in ftp conntrack helper
  o [NETFILTER]: Add new ip6tables matches

<latten@austin.ibm.com>:
  o [IPSEC]: Make sure ESP output pads Null Encryption properly

<mike@aiinc.ca>:
  o Numerous spelling fixes

<mikpe@user.it.uu.se>:
  o APIC ID fixes

Adrian Bunk <bunk@fs.tum.de>:
  o small drivers/atm/* cleanup
  o fix compilation of g_NCR5380.c
  o fix the compilation of sym53c416.c

Alan Stern <stern@rowland.harvard.edu>:
  o Trivial patch for usb.h
  o Fix USB address setting

Andi Kleen <ak@muc.de>:
  o dcache/inode hlist patchkit

Andrew Morton <akpm@digeo.com>:
  o make jiffies wrap 5 min after boot
  o Fix user time accounting's handling of jiffies wrap
  o hugetlb put_page speedup
  o Fix slab batchcount limiting code
  o crc32 optimizations
  o flush_tlb_all preempt safety for voyager
  o Early ioremap support for ia32
  o x440 SRAT parsing
  o use find_get_page() in do_generic_mapping_read()
  o Make kIrDAd us interruptible sleep
  o Check for zero d_count in dget()
  o Remove redundant check in pte_alloc_map()
  o SARD accounting fix
  o Fix race between umount and inode pruning
  o fix bug in slab.c debugging
  o ext3: fix htree memory leaks
  o fix IRQ balancing disable controls
  o don't let OOM killer kill same process repeatedly
  o add some missing gloabl_flush_tlb() calls
  o ext3: speed up O_SYNC writes
  o remove MAX_BLKDEV from genhd.c
  o fix md /proc oops
  o spelling fixes
  o fix e100 for big-endian machines
  o deadline IO scheduler dispatching fix
  o loop: Fix OOM and oops
  o fix presto_get_sb() return value and oops
  o fix preempt-issues with smp_call_function()
  o Don't panic if TSC is enabled and notsc is used
  o clean up redundant code for alloc_pages
  o ext2: clear ext3 htree flag on directories
  o fix typo in arch/i386/kernel/mpparse.c in printk
  o allow CONFIG_SWAP=n for i386
  o remove dead hugetlb_key forward decl
  o hugetlbpage documentation update
  o hugetlb: fix MAP_FIXED handling
  o cciss: fix unlikely startup problem
  o cciss: retry bus resets
  o cciss: add cmd_type to sendcmd parameters
  o cciss: add CCISS_GETLUNINFO ioctl
  o cciss: add passthrough ioctl
  o sysfs build fix

Andy Grover <agrover@groveronline.com>:
  o ACPI: Do not count processor objects for non-present CPUs (Thanks
    to Dominik Brodowski)
  o ACPI: Revert a change that allowed P_BLK lengths to be 4 or 5. This
    is causing us to think that some systems support C2 when they
    really don't.
  o ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)
  o ACPI: Never use ACPI on VISWS
  o ACPI: Expand the mem= cmdline to allow the specification of
    reserved and ACPI DATA blocks (Pavel Machek)
  o ACPI: Map in entire table before performing checksum (John Stultz)
  o ACPI: Add S4BIOS support (Pavel Machek)
  o ACPI: Add new file for GPE code
  o ACPI: Interpreter update
  o ACPI: Modify drivers to use new acpi_walk_resource API (Bjorn
    Helgaas)
  o ACPI: Add S4BIOS support (Pavel Machek)
  o ACPI: Update ACPI PHP driver with to use new acpi_walk_resource API
    (Bjorn Helgaas)
  o ACPI: S3 fixes (Ole Rohne)
  o ACPI: Update version to 20030228

Art Haas <ahaas@airmail.net>:
  o Fix initializers on drivers/ide/pci/trident.h
  o C99 initializers for include/linux/net.h
  o Trivial C99 changes for kernel/posix-timers.c
  o C99 initializers for drivers/mtd files
  o C99 initializers for drivers/mtd/chips
  o C99 initializers for drivers/mtd/maps
  o C99 initializer for drivers/mtd/nand/spia.c
  o C99 initializers for alpha/thread-info.h
  o [BRIDGE]: C99 patches for net/bridge/netfilter

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: hardirq.h needs linux/cache.h
  o IEEE1394 updates
  o IEEE1394 ioctl allocation documentation
  o More IEEE1394 updates

Christoph Hellwig <hch@sgi.com>:
  o Add PC-9800 bios parameter support in SCSI
  o wd33c93 updates
  o fix some Kconfig typos
  o some scsi_scan.c restructuring for ieee1394 hotplugging
  o PCI: remove check_region abuse (and code duplication) from pci hp
    code
  o scsi_add_host/scsi_Remove_host for aic7xxx/aic79xx
  o update nsp_cs to use scsi_add_host / scsi_remove_host
  o [NET]: Move fc_type_trans into generic code
  o [NET]: Remove 2.0/2.2 compat code from netfilter, approved by Rusty
  o [XFS] spin_lock_irqsave must take an ulong, not int.  Spotted by
    Anton Blanchard <anton@samba.org>
  o [XFS] fix compilation with CONFIG_SYSCTL=n
  o [XFS] shut up gcc warnings about _lsn_cmp
  o [XFS] Remove flags argument from xattr inode operations again
  o remove kdevname abuse from reiserfs
  o remove unused variables from the i2c core
  o remove an unused function from the i2c core
  o remove kdevname abuse from init/do_mount.c
  o i2c-dev cleanup
  o remove unused last argument to i2c_register_entry
  o small i2c-amd8111 updates
  o remove unused file include/linux/ghash.h

Dave Jones <davej@codemonkey.org.uk>:
  o [AGPGART] compile fix for alpha
  o [WATCHDOG] SuperH 5 support for SH watchdog driver
  o pnp_activate_dev API changes
  o C99 struct initialisers for aacraid
  o aacraid extra devices
  o increase aha152x timeouts
  o dpt_i2o bits from 2.4
  o fdomain isa_ API conversion
  o fdomain pcmcia update from 2.4
  o Put sgiwd93.c back in sync with 2.4
  o sun3 updates from 2.4
  o Erroneous colon in sym53c8xx.c
  o important bits
  o copy-paste ; breakage in sym_2
  o wd33c93 sync up with 2.4
  o Remove redundant aligns
  o Extraneous ; in cris eeprom code
  o Allow booting from 21 sector floppies
  o Missing acpi include
  o Enable SSE on newer Athlons
  o VIA Nehemiah cache workaround
  o Fix ambiguous else in generic serial
  o Handle empty E820 regions correctly
  o [WATCHDOG] Remove unnecessary llseek function
  o [WATCHDOG] Merge AMD 766/768 TCO Timer/Watchdog driver from 2.4
  o [WATCHDOG] missed C99 named initialiser conversion
  o [WATCHDOG] Use symbolic PCI names instead of hardcoded values
  o [AGPGART] Add support for Intel 852GM / 855GM and 865G
  o [AGPGART] Move PCI device IDs to pci_ids.h
  o [WATCHDOG] Remove old unneeded borken module locking
  o [WATCHDOG] return code checking and various cleanups for ib700wdt
  o [WATCHDOG] remove remainder of the old broken module locking scheme

David Brownell <david-b@pacbell.net>:
  o USB: sync with some 2.4 ohci fixes, prepare for backport
  o USB: ohci-hcd, more portable diagnostics
  o USB: ohci-hcd fewer diagnostics
  o USB: usbtest checks for in-order completions
  o USB ohci:  "registers" sysfs file
  o USB: ehci-hcd, partial VIA workaround
  o USB: kerneldoc/pdf

David S. Miller <davem@nuts.ninka.net>:
  o [FRAMEBUFFER]: Use u32 not long in cfbimgblt
  o [FRAMEBUFFER]: cfbcopyarea accesses fb without using
    FB_{READ,WRITE}L
  o [FRAMEBUFFER]: Convert creatorfb to new APIs
  o [SPARC64]: GPL export syscall table for solaris module
  o [FRAMEBUFFER]: Convert bw2, cg6, and cg3 drivers to new APIs
  o [FRAMEBUFFER]: Convert cg14 driver to new APIs
  o [FRAMEBUFFER]: Convert P9100 driver to new APIs
  o [FRAMEBUFFER]: Convert TCX driver to new APIs
  o [SPARC64]: Update defconfig
  o [SPARC64]: Solaris module asm needs asm/thread_info.h
  o [SPARC64]: Use EXTRA_CFLAGS instead of mangling CFLAGS directly
  o [ATM]: Fix mispatch
  o [SCTP]: net/sctp/proc.c needs linux/init.h
  o [SYSFS]: fs/sysfs/mount.c needs linux/init.h
  o [HOTPLUG]: drivers/base/hotplug.c needs linux/sched.h and
    linux/string.h

Dominik Brodowski <linux@brodo.de>:
  o cpufreq (1/5): x86 driver updates #1 (elanfreq, gx-suspmod,
    powernow-k6)
  o cpufreq (2/5): x86 driver updates #2 (acpi, longhaul)
  o cpufreq (3/5): "userspace" governor
  o cpufreq (4/5): update x86 drivers to compile with new "userspace"
    governor
  o cpufreq (5/5): update documentation
  o [SPARC64]: update us3_cpufreq to support userspace governor

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: take ref to USB device
  o USB speedtouch: use USB dbg macro
  o USB speedtouch: better proc info
  o USB speedtouch: don't race the tasklets
  o USB speedtouch: be firm when disconnected
  o USB speedtouch: handle usb_string failure

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Allow the pagebuf daemon to suspend

Ganesh Varadarajan <ganesh@vxindia.veritas.com>:
  o USB ipaq.c: add ids for fujitsu loox

Greg Kroah-Hartman <greg@kroah.com>:
  o USB visor: fixed the driver_info cast to the proper type
  o USB visor: cleanup the close() logic
  o USB pl2303: add locking now that the usb-serial core doesn't
    protect us
  o IBM PCI Hotplug: Clean up the error handling logic for a number of
    functions, and fix a locking mess
  o IBM PCI Hotplug: fix typo in previous patch
  o IBM PCI Hotplug: get rid of unneeded ops structure and surrounding
    logic
  o PCI Hotplug: remove the list_lock, as we rely on sysfs to detect
    any duplicate slot names
  o Compaq PCI Hotplug: move /proc files to sysfs
  o Compaq PCI Hotplug: rename cpqphp_proc.c to cpqphp_sysfs.c
  o Compaq PCI Hotplug: convert to use pci_remove_bus_device instead of
    custom code
  o Compaq PCI Hotplug: remove unused walk of the device on insertion
  o ACPI PCI hotplug: convert to use pci_remove_bus_device()
  o IBM PCI Hotplug: convert driver to use pci_bus_remove_device()
  o PCI: export pci_scan_bus_parented which is needed by the IBM pci
    hotplug driver
  o CPCI core: remove unneeded visit device on unconfigure
  o USB: fix potential races in mct_u232 now that there's no locks in
    the usb-serial core
  o USB: fixed potential races in belkin_sa.c now that there's no locks
    in the usb-serial core
  o USB: fixed potential races in kl5kusb105.c now that there's no
    locks in the usb-serial core
  o USB: add the rest of the interface descriptor info to sysfs
  o USB: fix bug that prevented usbcore from shutting down
  o USB: add support for two new keyspan drivers

Greg Ungerer <gerg@snapgear.com>:
  o include unistd.h in m68knommu syscalltable.S
  o switch m68knommu to using asm-generic/siginfo.h
  o define struct for m68knommu/ColdFire timer registers
  o define timer_t and clockid_t for m68k archiecture
  o include unistd.h in m68knommu vectors.c
  o create NR_syscalls for m68knommu architecture
  o include unistd.h in m68knommu entry.S

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB: New vendor/product ids for scanner driver
  o USB: Fixed generation of devfs names in scanner driver

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Make sure temporary addresses are regenerated properly
  o [IPV6]: More C99 initializers

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: context switch fixes
  o alpha: remove ali ide quirk

James Bottomley <jejb@mulgrave.(none)>:
  o clean up wd33c93 data direction code

Jean Tourrilhes <jt@hpl.hp.com>:
  o [wireless] cleanup after recent shuffle

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr] Update Doc/networking/netdevices.txt with more locking
    rules
  o [netdrvr tg3] disable 5701 h/w bug workaround during core clock
    reset
  o [netdrvr tg3] fix NAPI deadlock
  o [netdrvr tg3] bump version to 1.4c / Feb 18
  o [netdrvr tg3] properly synchronize with TX, in tg3_netif_stop
  o [netdrvr tg3] fix TX race in previous code, and another buglet

Joe Thornber <joe@fib011235813.fsnet.co.uk>:
  o dm: ioctl interface wasn't dropping a table reference
  o dm: __LOW macro fix no. 1
  o dm: bug in error path for unknown target type
  o dm: allow slashes in dm device names
  o dm: __LOW macro fix no. 2
  o dm: return correct error codes from dm_table_add_target()
  o dm: deregister the misc device before removing /dev/mapper

John Levon <levon@movementarian.org>:
  o IPS driver typo
  o sun3_NCR typo
  o aix7xxx_old typo
  o FlashPoint typo
  o NCR5380 typos
  o AM53C974 typo
  o [SUNHME]: Fix bit testing typo
  o usbcld typo
  o rio500 typo
  o Another bitop on boolean in pnpbios

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o [SCTP]  Minor surgery on ulpevent & related cleanups
  o [SCTP]  SET_DEFAULT_SEND_PARAM sockopt.   (ardelle.fan)
  o [SCTP] Partial Data Delivery
  o [SCTP] MSG_ADDR_OVER support.  (ardelle.fan)
  o [SCTP]  Minor cleanup on tsnmap
  o [SCTP] C99 Initializer cleanup  (Art Haas)
  o [SCTP] Renege to make room for CTSN+1 chunk
  o Add getsockopt for DEFAULT_SEND_PARAM.  (ardelle.fan)

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Remove scripts/elfconfig.h with "make clean"
  o kbuild: Fix a race with module postprocessing
  o kbuild: Handle MODULE_SYMBOL_PREFIX in module postprocessing
  o kbuild: typo fix
  o kbuild: [PATCH] eliminate warnings in generated module files
  o kbuild: [PATCH] Remove checkhelp.pl and header.tk
  o kbuild: [PATCH] put genksyms in scripts dir
  o kbuild: [PATCH] adapt genksyms for current kbuild
  o kbuild: Fix genksyms __typeof__ handling
  o do_mounts: Move devfs into own file
  o do_mounts: __init* cleanup
  o do_mounts: move early MD setup into own file
  o do_mounts: fix device name recognition for md= command line option
  o do_mounts: Remove unneeded check for initrd_start
  o do_mounts: initrd_load() is never called w/o CONFIG_BLK_DEV_INITRD
  o do_mount: Move more of the initrd load logic into initrd_load()
  o do_mounts: Simplify logic for ramdisk from floppy
  o do_mounts: mount_initrd is now only needed w/CONFIG_BLK_DEV_INITRD
  o do_mounts: Move CONFIG_BLK_DEV_RAM stuff into own file
  o do_mounts: Separate out common root mounting code into
    do_mount_root()
  o do_mounts: create_dev() before mounting
  o kbuild: make -j race fix, cosmetics
  o kbuild: Module postprocessing needs include/linux/compile.h
  o kbuild: Silence some warnings when building vmlinux
  o do_mounts: Fix CONFIG_BLK_DEV_MD=m case
  o kbuild: remove dependency on compile.h

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix up kernel/module.c breakage. Bad Rusty!
  o d_validate() needs to use "__dget_locked()" since it's holding the
    dcache lock.
  o Avoid memory leak on fork() failure path
  o pnp interface.c needs <linux/slab.h> for 'kfree()'
  o Make ACPI dmi fixup properly depend on CONFIG_ACPI_SLEEP
  o Fix up sunrpc for the dentry hash list changes

Marc Zyngier <mzyngier@freesurf.fr>:
  o Fix scsi_probe_and_add_lun

Martin J. Bligh <mbligh@aracnet.com>:
  o Move node pgdat into node's own memory
  o Fix potential NULL pointer
  o Move pfn_to_nid inline
  o provide pcibus_to_cpumask from topology
  o Fix kirq_balance up so I can disable it
  o need PIT timer available for NUMA-Q
  o Fix error bounds checking for NUMA-Q

Matthew Dharm <mdharm@one-eyed-alien.net>:
  o USB: Small patch

Mike Anderson <andmike@us.ibm.com>:
  o scsi_set_device_offline lock fix

Muli Ben-Yehuda <mulix@mulix.org>:
  o trident 1/3 fix "did not come out of reset"
  o trident 2/3 make me the maintainer
  o trident 3/3 use pr_debug instead of TRDBG
  o AD1848 OSS driver build fix
  o trident 1/1 fix operator precedence bug

Nathan Scott <nathans@sgi.com>:
  o [XFS] Remove some off_t abuse in pagebuf_offset and the page_io
    routine, after some careful analysis.
  o [XFS] Fix some comments, remove an unused variable from the stack,
    fix missing clear of pb_locking field if IO completion handled in
    pagebuf_iorequest.
  o [XFS] Revert the recent hashing change, performance seemed to go
    way down in certain benchmarks.  This is reverted to how it was,
    except the number
  o [XFS] Transition from xfsroot attribute namespace to the more
    generic trusted namespace which other filesystems are also
    supporting.

Nicolas Pitre <nico@cam.org>:
  o small tty irq race fix

Patrick Mochel <mochel@osdl.org>:
  o sysfs: add sysfs_update_file()
  o sysfs: split up inode.c into different files for different purposes
  o sysfs: further localize file creation
  o sysfs: add initial support for binary files
  o sysfs: fix oops in directory removal
  o driver model: remove <linux/sched.h> from include/linux/device.h
  o kobject: fix oops in to_kset()
  o driver model: fix device interfaces
  o cpufreq: convert to use new interface code
  o sysfs: fix more merge breakage
  o sysfs: fix warning
  o driver model: Make initialization explicit
  o sysfs: initialize from fs/namespace.c::mnt_init()
  o driver model: implement platform_match()
  o sysfs: Register filesystems with sysfs

Pavel Machek <pavel@ucw.cz>:
  o swsusp and S3 fixes

Pete Zaitcev <zaitcev@redhat.com>:
  o USB: Yet another unusual_devs.h member
  o [SPARC]: Kill GFP_DMA in iommu code
  o [SPARC]: Fix Kconfig typo
  o [SPARC32/64]: Expand ioctl size field in backwards-compatible way

Richard Henderson <rth@are.twiddle.net>:
  o [ALPHA] Fix Jensen -Werror failures

Roger Luethi <rl@hellgate.ch>:
  o via-rhine: reset logic
  o via-rhine: fix races
  o via-rhine: fixing the reset fix
  o via-rhine: 1.17 release

Russell King <rmk@arm.linux.org.uk>:
  o PCI: Make hot unplugging of PCI buses work
  o Fix cardbus build problem
  o [SERIAL] 64bit warning in serial/core.c
  o [ARM PATCH] 1406/1: Enable mtd partitions via mtdparts in dc21285
    map driver
  o [ARM PATCH] 1426/1: Remove rambase from head.S
  o [ARM PATCH] 1389/1: update iop3xx support for 2.5 (patch 2 of 4)
  o [ARM PATCH] 1404/1: basic Lubbock/PXA250 updates
  o [ARM] SA11x0 PCMCIA 1-8

Rusty Russell <rusty@rustcorp.com.au>:
  o Modules race fix
  o Modules code tidy up
  o [NETFILTER]: Switch over to new-style module refcounting, help from
    Christoph Hellwig

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: Small updates in top-level makefile
  o kbuild: do not run split-include for all compilations
  o kbuild: Top-level Makefile, trivial tidy up

Sam Ravnborg <sam@ravnborg.org>:
  o fix make rpm

Sridhar Samudrala <sri@us.ibm.com>:
  o [SCTP] sctp mib statistics update/display support
  o [SCTP] Update retransmission path in a round-robin fashion when a
    retransmission timer expires instead of using the same path until
    the path error count reaches its threshold value.

Steven Cole <elenstev@mesatop.com>:
  o Spelling fixes handel -> handle
  o 2.5.63 loose pedantry; loose -> lose where appropriate
  o Spelling fixes for relevent -> relevant
  o Spelling fixes for negotation -> negotiation and others
  o Spelling fixes for shold -> should and others
  o Spelling fixes for paticular -> particular and others
  o replace it's with its where appropriate
  o replace its with it's where appropriate
  o fix Coverted -> Converted
  o Spelling fixes from spell-fix.pl


