Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTG0Qxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTG0Qxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:53:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:39917 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270859AbTG0Qx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:53:27 -0400
Date: Sun, 27 Jul 2003 10:08:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.0-test2
Message-ID: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of small updates and fixes all over the map (diffstat shows a flat
profile, except for the DVB merge, the new wl3501 driver, and the new
sound drivers from Alan).

An example: Alexander Atanasov fixed an UP APIC handling bug, which in
turn explained the IDE problems with irq disabling, and allowed IDE to
be fixed up. Yah!

Alan started doing forward-porting of 2.4.x driver updates, and Andrew is
merging the fixes from his tree. And janitorial cleanups.

Various architectures are congealing: sparc64, ia64, alpha, m68k, ppc32,
v850 and s390 all had updates. 

Network (and network driver) fixes, ISDN slowly getting there, ACPI, DVB
and USB updates.

And a number of people worked on (and fixed) SCSI queue handling issues
with the anticipatory scheduler. 

		Linus

----

Summary of changes from v2.6.0-test1 to v2.6.0-test2
============================================

Adrian Bunk:
  o remove all #include <blk.h>'s

Alan Cox:
  o alpha illegal->invalid
  o mtrr printk levels
  o mtrr fixes
  o fix visws pci (visws specific code)
  o another batch of "invalid" not "illegal" fixes
  o POSIX doesnt guarantee head -2, only head -n 2
  o head -n 2 for ppc64
  o updated magic number tables
  o pnp layer seems to document wrong file name
  o first cut ftape conversion
  o clean up ip2 glue (not yet ported tho)
  o move watchdogs to __module_get now it exists
  o fix all the paths in ide Kconfig docs
  o convert ewrk3 for new locking etc
  o clarify AXNET kconfig as per 2.4
  o use cpu_relax in seq8005
  o re-enable seq8005
  o forward port 2.4 Zoom video support
  o make isapnp request its port properly
  o function is long gone, kill prototype
  o pas16 build fix
  o fix qlogicfas build warning
  o undefined shifts in qla1280
  o sym53c8xxx wasnt updated to new irq code etc
  o serial proc gives info on keycounts which can sometiems be abused
  o xjack pcmcia needs .. pcmcia
  o restore console log level when jbd raises it
  o fix jffs2 build
  o fix a doc error and misleading printk
  o remove a now false comment
  o fix a copy_user return
  o fix failed sethostname corrupting the data
  o correct author of ad1980 plugin
  o fix make rpm versioning
  o fix ver_linux for 2.6
  o fix unused symbol in ad1889
  o btaudio uses memset so should be strlcpy
  o illegal->invalid for dmasound
  o emu10k further updates/bug fixes
  o Add HAL2 driver
  o Add Harmony OSS driver
  o Kahlua audio driver
  o Makefile bits for audio resync

Alan Stern:
  o USB: More unusual_devs.h entry updates
  o USB: I/O buffering for sddr09
  o USB: Make sddr55 use proper I/O buffering
  o USB: Handle over current inputs on all Intel controllers

Alberto Bertogli:
  o [IPVS]: Fix typo in Kconfig file

Alexander Atanasov:
  o Fix irq handling of IO-APIC edge IRQs on UP

Alexey Kuznetsov:
  o [TCP/IPV6]: Another anycast check
  o [IPV6]: Fix anycast usage
  o [NET]: Make IFLA_STATS arch independent

Andi Kleen:
  o [NET]: Turn softnet_data into per-cpu data

Andrew Morton:
  o aha152X oops fixes
  o Allow LBD on architectures that support it
  o misc fixes
  o parport_pc.c compile warning
  o ext3 extended attribute fixes
  o Ext3 xattr credits fix for quotas
  o ioctl(BLKBSZSET) fix and cleanup
  o pass regs into dump_fpu() in elf coredump
  o is_devfsd_or_child() deadlock fix
  o remove task_cache entirely
  o use kmalloc for ia32 stacks
  o fix removable partitioned media with devfs
  o fix return of compat_sys_sched_getaffinity
  o Fix two bugs with process limits (RLIMIT_NPROC)
  o unline most of put_namespace()
  o CONFIG_BLK_DEV_CRYPTOLOOP needs CONFIG_CRYPTO
  o slab: print stuff when the wrong cache is used
  o settimeofday() fixes
  o visws: fix PCI breakage
  o vesafb fix
  o watchdog: i810-tco support
  o CLONE_STOPPED
  o dm: 'wait for event' race
  o dm: v4 ioctl interface
  o fix bootmem allocator on machines with holes in
  o Update Documentation/magic-numbers.txt
  o fix as-iosched do_div()
  o "Fix" AS i/o hang with aacraid driver

Andy Grover:
  o ACPI: make it so acpismp=force works (reported by Andrew Morton)
  o ACPI: Correctly handle NMI watchdog during long stalls (Andrew Morton)
  o ACPI: proc function return value cleanups (Andi Kleen)
  o ACPI: Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
    Klausner, Nate Lawson)
  o ACPI: Parse SSDTs in order discovered, as opposed to reverse order
    (Hrvoje Habjanic)
  o ACPI: Dynamically allocate SDT list (suggested by Andi Kleen)
  o ACPI: Update version, and other trivialities

Angelo Dell'Aera:
  o sk_mca

Anton Blanchard:
  o sym2 error handler sleeps with irqs off

Arnaldo Carvalho de Melo:
  o wl3501: new wireless driver for Planet WL 3501 802.11 PCMCIA card

Bart De Schuymer:
  o [BRIDGE/EBTABLES]: Add stp packet matching
  o [EBTABLES]: Copy skb when shared
  o [EBTABLES]: Make it work on 32-on-64 platforms

Bartlomiej Zolnierkiewicz:
  o fix IDE irq disable logic
  o Fix dma timeout bugs
  o ide: fix PCI modules oops

Ben Collins:
  o [SPARC64]: Fix OBP 4.6+ PCI probing, use pcic_present() consistently
  o [SPARC64]: Clear all IRQs at probe time in PCI sabre driver
  o [SPARC64]: In pci_common.c:find_device_prom_node() recognize
    PCI_DEVICE_ID_SUN_TOMATILLO
  o [SPARC64]: In clock_probe(), treat m5819p just like m5819
  o Update IEEE1394 (r1014)

Bernardo Innocenti:
  o Make I/O schedulers optional

Bob Miller:
  o ISDN: Remove un-needed MOD___USE_COUNT from init fuctions

Chas Williams:
  o [ATM]: Cleanup pppoatm_ioctl_hook
  o [ATM]: Cleanup br2684_ioctl_hook
  o [ATM]: Use sk_state_change() and eliminate vcc->callback()
  o [ATM]: Eliminate vcc->sleep in favor of sk->sk_sleep
  o [ATM]: Use sk_data_ready and sk_change_state instead of wake_up
  o [ATM]: Replace vcc->reply with sk->sk_err; implement sk_write_space
  o [ATM]: Make sigd_sleep conditional with WAIT_FOR_DEMON
  o [ATM]: Return ENODEV if !dev
  o [ATM]: If !IFF_UP drop the frames
  o [ATM]: Timer cleanup in lec.c

Chen Yang:
  o unresolved symbol with moduled intermezzo

Christoph Hellwig:
  o consistant names for device model related struct members
  o rework shost/sdev attribute handling
  o pull scsi_scan_host out of scsi_add_host
  o Use before initialisation in devfs_mk_cdev()
  o [ARCNET]: Fix module refcounting

Daniel Ritz:
  o fix ne2k-pci memleak

David Brownell:
  o USB: ohci minor tweaks
  o USB: usb net drivers SET_NETDEV_DEV
  o USB: ethernet gadget learns about pxa2xx udc
  o USB: usbtest, autoconfigure from descriptors
  o USB: gadget zero learns about pxa2xx udc
  o USB: ethernet gadget, another pxa update
  o USB: better locking in hcd_endpoint_disable()

David Glance:
  o USB: Adding DSS-20 SyncStation to ftdi_sio

David Mosberger:
  o ia64: Move local per-CPU area to the last page of the address space
  o ia64: Performance-tune itc_get_offset() a bit
  o ia64: Force assembly name of init_task_mem so the aliasing
    directive works with all compilers.
  o ia64: Set the PRT entry's irq member in iosapic_parse_prt()
  o ia64: Small fixes for 2.6.0-test1 merge
  o ia64: Change per-CPU implementation so that __get_cpu_var() returns
    the canonical address (l-value).  To get the virtually mapped alias
    (which is more efficient), use __ia64_per_cpu_var().  The latter is
    safe only if the address of the l-value is never passed to another
    CPU (i.e., not stored in any global place).
  o Fix patch breakage
  o ia64: Patch by Arun Sharma: Make execve()ing of ia32 tasks work
    again
  o ia64: Put per-CPU data into .data.percpu section both for UP and MP
  o ia64: If the compiler supports it, use attribute (model (small)) to
    tell the compiler that per-CPU variables can be addressed with
    "addl".
  o ia64: Drop ".bias" in spinlocks as it caused more harm than good. 
    Pointed
  o ia64: Fix atomic64 interface to use __s64 instead of int where
    appropriate
  o ia64: Take advantage of <asm/sections.h>
  o ia64: Turn BIO-level virtual merging off again, so we can turn I/O
    MMU bypassing on again, which is more beneficial, performance-wise.
  o ia64: Fix check for "model(small)" attribute

David S. Miller:
  o [TCP/IPV6]: Check for anycast where we check for multicast
  o [SPARC64]: Fix pbus->sysdata interpretation in pci_domain_nr()
  o [SPARC64]: Fix assumptions about data section ordering and objects
    ending up in .data vs .bss
  o [SPARC64]: Do not break out of PCI controller probing loop too
    early
  o [TCP/IPV6]: Revert previous anycast changes
  o [SERIAL]: rev in sunsu.c uart port info needs to be a short
  o [SPARC64]: Update defconfig
  o [SPARC64]: Add Ultra-IIIi/Jalapeno support
  o [SPARC64]: Add JIO/Tomatillo PCI controller support
  o [SPARC64]: Now the brlocks are gone, the udelay garbage in
    cpu_relax() can go
  o [SPARC64]: Read processor number correctly on Ultra-IIIi/Jalapeno
  o [SPARC]: Do not include asm-generic/dma-mapping.h if !CONFIG_PCI
  o [SPARC64]: Remove PCI ifdef from lib/PeeCeeI.c
  o [SPARC64]: Handle !CONFIG_PCI properly in sparc i8042 support
  o [SPARC64]: Always export I/O string ops
  o [SPARC64]: Make sparc speaker driver depend upon PCI
  o [SPARC64]: Make BBC I2C driver require PCI
  o [SPARC64]: If SPARC64, make parport_pc need PCI
  o [SPARC64]: Remove extraneous copy of atomic_dec_and_lock in
    debuglocks.c
  o [SPARC]: Fix compile warnings in flash driver when !PCI
  o [SPARC64]: In ISA support, is interrupt-map exists use it
  o [SPARC64]: Finalize TOMATILLO/JIO support, help from
    bcollins@debian.org
  o [TG3]: Support OBP firmware mac-addresses on sparc64
  o [SPARC64]: Remove unused local var in isa_dev_get_resource
  o [SPARC64]: Use __s64 for atomic64_t implementation
  o [NET]: Print statistics using unsigned format in sysfs
  o [SPARC64]: Do not renumber PCI buses anymore
  o [SPARC64]: Use domain in naming PCI buses
  o [SPARC64]: Sanitize PCI controller handling to support Tomatillo better
  o [SPARC64]: Pass correct args to data_access_exception() in unaligned.c
  o [SPARC]: __builtin_trap() is bug-free in 3.3.1 and later
  o [TG3]: Fix typo in pci_ids.h change

Frank Cusack:
  o rpcsec_gss compatibility
  o Fix rpc_setbufsize() usage
  o Allow unattended nfs3/krb5 mounts

François Romieu:
  o Fix error path in kahlua driver
  o Unchecked copy_to_user disturb harmony
  o add new sound drivers to Makefile/Kconfig
  o uninitialized spinlock in drivers/net/sk_mca.c

Ganesh Varadarajan:
  o USB: more ids for ipaq

Geert Uytterhoeven:
  o Amiga serial warning
  o m68k flush_icache_page()
  o Ns558 gameport warning
  o M68k floppy warnings
  o M68k module
  o wd33c93 compile fix
  o Kill zorro_check_device
  o M68k irq_cpustat_t
  o M68k ret_from_fork
  o Atari ACSI SLM Laser Printer
  o Valkyriefb link fix
  o M68k wd33c93 locking
  o M68k #include <linux/config.h>
  o Atari pamsnet
  o Mac/m68k ADB HID
  o Atari ST-RAM
  o dmasound re-resurrection
  o Mac/m68k sonic updates
  o M68k inline
  o My contact info
  o Mac8390 typo
  o Apollo compile fixes
  o Sun-3 pte_file
  o M68k mm cleanup
  o Atari ksyms
  o lmc_proto.c includes <asm/smp.h>
  o Sun-3 SCSI warning
  o M68k show_stack() portability and cleanup patch
  o m68k dma-mapping
  o m68k do_fork()
  o M68k IPV6
  o Macfb compile fixes
  o NCR53C9x unused SCp.have_data_in
  o m68k page
  o M68k IRQ API updates
  o m68k FPU emulator
  o MIPS DEC/SGI Linux logo
  o dmasound SOUND_PCM_READ_RATE
  o m68k irqs_disabled()
  o M68k RTC updates
  o m68k cache
  o Rename ariadne2 to zorro8390
  o Update valkyriefb driver

Greg Kroah-Hartman:
  o PCI: fix up error for when CONFIG_PCI=n and scsi.h is included
  o USB: fixed up pci slot_name accesses in usb code
  o USB: fixed up pci slot_name accesses in usb gadget code
  o PCI: remove usages of pci slot_name from the pci core code
  o PCI: remove usages of pci slot_name from acpi pci hotplug driver
  o PCI: fix problem with pci remove functions not being built if
    CONFIG_HOTPLUG was not set
  o USB: remove some warnings when building the documentation
  o USB: flush all in-flight urbs _before_ disconnect() is called
  o USB: fix up bluetty driver's tty and devfs names
  o USB: fix up cdc-acm driver's tty and devfs names
  o USB: fix a nasty use-after-free bug in the usb-serial core
  o USB: fix memory leak in the visor driver

Harald Welte:
  o [NETFILTER]: Fix ip_nat_ftp in 2.6.0-test1
  o [NETFILTER]: Re-sync ipt_REJECT with 2.4.x
  o [NETFILTER]: Fix a bug in the IRC DCC command parser of
    ip_conntrack_irc
  o [NETFILTER]: Fix typo in ipt_MIRROR.c

Henning Meier-Geinitz:
  o USB: fix open/probe race in scanner driver
  o USB: New vendor/product ids for scanner driver
  o USB: unlink interrupt URBs in scanner driver

Herbert Xu:
  o [IPV6]: Fix device leaks in privacy extension code
  o [IPSEC]: Make reqids 32-bits

Hideaki Yoshifuji:
  o [IPV6]: Get reference to neigh/dev when building ndisc DST

Hirofumi Ogawa:
  o more VFAT_IOCTL_READDIR_BOTH/_SHORT ioctl fixes (1/11)
  o fat_cluster_flush() fixes (2/11)
  o vfat dentry handling fix (3/11)
  o fat_access cleanup (4/11)
  o fat_access cleanup (5/11)
  o fat_access cleanup (6/11)
  o adds fat_get_cluster (7/11)
  o use new fat_get_cluster (8/11)
  o more use new fat_get_cluster (9/11)
  o signed char cleanup/fixes (10/11)
  o >cluster_size cleanup (11/11)

James Bottomley:
  o Fix scsi_lib MODE SENSE(6) bug
  o Fix up syntax error in aha1740
  o Put the requeue hack back into as-iosched.c
  o make AS work nicely with SCSI

Jamie Lokier:
  o [TCP]: Fix SOCK_DONE setting when TCP receives FIN (bug introduced
    by ChangeSet 1.889.291.25)

Jan Zuchhold:
  o [TG3]: Recognize Altima AC1001 device IDs

Jasper Spaans:
  o Fix up unattended nfs3/krb5 mounts

Javier Achirica:
  o [wireless airo] Simplify dynamic buffer code in Cisco extensions
  o [wireless airo] Update structs with the new fields in latest
    firmwares
  o [wireless airo] Make locking "per thread" so it's fully preemptive
  o [wireless airo] Don't sleep when the stats are requested
  o [wireless airo] Don't call MIC functions if the card doesn't
    support them
  o [wireless airo] Fix small endianness bug
  o [wireless airo] Returns proper status in case of transmission error
  o [wireless airo] Checks for small packets before transmitting them
  o [wireless airo] Return channel in infrastructure mode
  o [wireless airo] Update to wireless extensions 15 (add monitor mode)
  o [wireless airo] Update to wireless extensions 16 (new spy API)

Jeff Garzik:
  o scsi_debug mode sense bug
  o [bonding] sync ifenslave with 2.4 (pulls in several bug fixes)
  o [wireless airo] fix 2.4-isms that break build

Jens Axboe:
  o Consolidate SCSI requeueing and add blk elevator hook
  o ide tcq enable
  o mark James as SCSI maintainer
  o read-ahead and failfast
  o Fix block layer bug handling of partial bvec completion

Jesse Barnes:
  o ia64: fix GENERIC compile

Jim Howard:
  o IDE driver VIA support (obscure bug)

Jon Grimm:
  o [SCTP] Move rwnd accounting and I/O redrive off of the skb
    destructor
  o [SCTP] Support v4-mapped-v6 addresses (Ardelle Fan)
  o [SCTP] Fix v6 linklocal address send not getting routed to correct
    i/f

Julian Anastasov:
  o [IPV4/IPV6]: Fix use-after-free bugs in tunneling drivers

Kai Germaschewski:
  o ISDN: Fix i4l subsystem crash
  o ISDN: Fix avm_pci driver for irqreturn_t changes
  o ISDN: FsmNew() can't be __init
  o ISDN: Fix mem leak in ST5481 driver
  o ISDN/HiSax: Move registering of a card out of line
  o ISDN/HiSax: Move some init code out of line
  o ISDN/HiSax: Fix up dynamic registration
  o ISDN: Export "kstat"

Kambo Lohan:
  o [NET]: Fix hang/memleak in pktgen

Krishna Kumar:
  o [IPV6]: Reporting of prefix routes via rtnetlink

Krzysztof Halasa:
  o HDLC update

Kunihiro Ishiguro:
  o [IPSEC/IPV6]: Add missing email address to my copyrights

Linus Torvalds:
  o Revert PCI bus number size increase - it isn't even needed
  o Add "clock_t_to_jiffies()" conversion function with some rather
    minimal overflow protection. 
  o Fix vfat shortname character logic that had wrong signedness tests.
  o Fix compile problem with suspend due to a missed incorrect
    re-declaration of the internal linker symbols.
  o Revert toshiba_acpi strlcpy'fication as per John Belmonte
  o When zapping the thread list due to an execve(), make sure to also
    detach the threads.

Maciej Soltysiak:
  o [NETFILTER]: Make REJECT target compliant with RFC 1812

Madarasz Gergely:
  o [netdrvr wan] update comx maintainer, by request

Maneesh Soni:
  o vfsmount_lock-fix

Marc Zyngier:
  o aha1740 update

Martin Schwidefsky:
  o s390: arch update
  o s390: irq stats
  o s390: dasd driver
  o s390: common i/o layer
  o s390: qeth network driver
  o s390: siginfo_t for s390x

Mathieu Chouquet-Stringer:
  o [SPARC64]: Fix floppy irq handler return types

Matthew Dharm:
  o USB: convert ISD200 and Jumpshot to DMA-safe buffer
  o USB: remove now-dead mode-translation code

Matthew Wilcox:
  o ia64: Add some devinits to pci.c
  o ia64: use has_8259 in acpi_register_irq()

Michael Hunold:
  o Update the saa7146 driver core
  o Various small fixes in dvb-core
  o Major dvb net code cleanup, many fixes
  o Update dvb frontend drivers
  o Add Zarlink MT312 DVB-T frontend driver
  o Update the DVB budget drivers
  o Update the DVB av7110 driver
  o More saa7146 driver core updates
  o Various kconfig and Makefile updates
  o Add a driver for the Technisat Skystar2 DVB card
  o Add two drivers for Hexium frame grabber cards
  o More updates for the dvb core
  o Add TDA14500x DVB-T frontend driver
  o Update various other frontend drivers
  o Update the av7110 DVB driver
  o Add two drivers for USB based DVB-T adapters
  o Update Technisat Skystar2 DVB driver

Mikael Pettersson:
  o make clean should remove usr/initramfs_data.S

Miles Bader:
  o Rename `nb85e' to `v850e' on v850
  o Refactor v850 UART driver
  o Cleanup v850 cache-flushing code a bit
  o Add another layer of indirection for irq numbering with v850 `gbus'
    irqs
  o Add v850 RTE-V850E/ME2-CB port
  o Add v850 `sim85e2s' port, and cleanup v850e2 code
  o Update v850 config/makefile
  o v850 miscellanea
  o Rename config option CONFIG_V850E_MA1_HIGHRES_TIMER on v850
  o Update AS85EP1 port on v850
  o On v850, use a long jump to start_kernel
  o Remove <asm-v850/setup.h>
  o Update v850 README file

Mitchell Blank Jr.:
  o [SPARC64]: Make HAVE_DEC_LOCK depend upon DEBUG_SPINLOCK

Neil Brown:
  o Only set ->sk_reuse for tcp sockets, not udp

Norbert Kiesel:
  o PCI: fixup for compile error in pci/legacy.c

Oliver Neukum:
  o USB: fix race between open() and probe()
  o USB: fix layering violation in usblp
  o USB: fix irq urb in hpusbscsi
  o USB: fix race between probe and open in skeleton
  o USB: usblcd: race between open and read/write
  o USB: fix race between probe and open in dabusb

Patrick Mansfield:
  o fix scsi_mode_data length result

Patrick McHardy:
  o [NET]: Fix no_cong_thresh sysctl
  o [NET]: Fix signnedness test in socket filter code
  o [NETFILTER]: Fix various problems with MIRROR target
  o [NETFILTER]: Fix issues with REJECT and MIRROR targets wrt. policy
    routing
  o [NETFILTER]: Fix locking of ipt_helper
  o [NETFILTER]: Drop reference to conntrack after removing confirmed
    expectation

Paul Mackerras:
  o PPC32: use kstat_this_cpu in arch/ppc/kernel/irq.c
  o PPC32: Add some more system calls - tgkill, utimes, [f]statfs64
  o PPC32: Add SEMTIMEDOP.  Patch from Anton Blanchard
  o PPC32: Eliminate duplicate variable declarations in
    arch/ppc/kernel/time.c
  o PPC32: Fix compilation of powermac CPU frequency switching support
  o PPC32: Remove unused fields from irq_cpustat_t
  o PPC32: PCI mapping fixes for non-cache-coherent PPC machines
  o PPC32: Make FP exceptions enabled by default
  o PPC32: Change mm_segment_t definitions to simplify the code
  o PPC32: Use char[] consistently with __bss_start, _end, etc
  o PPC32: Add asm-ppc/local.h
  o PPC32: Fix compilation of arch/ppc/mm/mem_pieces.c

Paul Mundt:
  o pvr2fb update
  o PCMCIA: Update hd64465 driver
  o shwdt update

Pekka Pietikäinen:
  o [netdrvr b44] tons of fixes. should work now

Peter Chubb:
  o ia64: simeth driver fix

Peter Osterlund:
  o Incorrect timeout in CDROM_SEND_PACKET ioctl
  o Software suspend and RTL 8139too in 2.6.0-test1

Randy Dunlap:
  o syncppp: incomplete function prototype
  o reduce stack usage in wanrouter
  o unchecked return code of copy_to_user in read_profile
  o busmouse: fix memory leak and misc_register failure
  o janitor: drivers/telephony/ixj
  o janitor: audit misc_register in wdt977
  o janitor: copy_to_user in media/video/pms
  o janitor: copy_to_user in net/irda/vlsi_ir
  o janitor: copy_to_user in wireless/ray_cs ioctl
  o janitor: unchecked copy/put_user in umsdos ioctl
  o janitor: unchecked copy_to_user in drivers/sbus/char/envctrl
  o janitor: unchecked copy_from_user in ieee1394/amdtp
  o janitor: unchecked copy_from_user in parisc/led.c
  o janitor: mem leak and copy_from_user in wan/comx driver
  o [NET]: Audit copy_from_user checks in pktgen

Richard Henderson:
  o [ALPHA] Do ISO C90 strncpy buffer zeroing
  o [ALPHA] Add asm/sections.h
  o [ALPHA] Add atomic64_t
  o [ALPHA] Finish adding asm/local.h

Ricky Beam:
  o [SUNKBD]: Mark reset/layout as volatile

Rob Radez:
  o [SERIAL]: Do not use serio->private to track serio open status in
    sun drivers

Robert Olsson:
  o [NET]: Remove some debugging from pktgen

Roger Luethi:
  o via-rhine 1.19-2.5: One more Rhine-I fix

Roman Zippel:
  o gconf menuconfig fixes
  o qconf menuconfig fix
  o generate dependency again
  o Optional choice values get reset

Rudo Thomas:
  o fix emu10k1 removal oops

Rusty Russell:
  o Allow struct members inside percpu macros
  o Centralize Linker Symbols
  o introduce "local_t" - cpu-local atomic variables
  o Resolve module local_t conflict
  o Sparc64 local_t support
  o Make rmmod -f taint kernel
  o module_put_and_exit
  o Delete init/cleanup_module prototypes in obscure places
  o Make percpu_modcopy a macro

Sam Ravnborg:
  o [NET]: Makefile cleanups for net/
  o fs/ Makefile cleanup
  o usr/: Updated .incbin support

Scott Feldman:
  o add ethtool TSO get/set
  o Add ethtool TSO, Rx/Tx csum, SG Get/Set support

Scott Murray:
  o [CPCI] Fix potential deadlock on extract found by Rusty Lynch
  o [CPCI] Kconfig tweak
  o [CPCI] Minimal fixes to restore CPCI hotplug to working order

Sean Neakums:
  o [IPSEC] correct 'discvovery' typo

Simon Evans:
  o 3c574_cs initialise spinlock

Sridhar Samudrala:
  o [SCTP] Fix for panic on recvmsg() with MSG_PEEK flag and some
    ulpevent cleanup.
  o [SCTP] Send SHUTDOWNs through the same path as the received DATA in
    SHUTDOWN-SENT state. (Ryan Layer)
  o [SCTP] Update API names to be compatible with
    draft-ietf-tsvwg-sctpsocket-07.txt
  o [SCTP] Reduce the size of struct sctp_ulpevent so that it fits in
    skb->cb even on 64-bit systems. 
  o [SCTP] Support for IPV6_V6ONLY socket option. (Ardelle.fan)
  o [SCTP]: Update MAINTAINERS entry

Stephen Hemminger:
  o [NET]: Dynamic net_device for serial eql balancer
  o mark comx obsolete, by request
  o [NET]: remove MOD_* from LAPB
  o [NET]: Allow LAPB to be unloaded
  o [NET]: Eliminate MOD_* from wanrouter
  o [BRIDGE]: Cleanup kernel messages, use C99 initializers
  o [BRIDGE]: Fix several startup/shutdown timer races
  o [IPV4]: Fix build with multicast but not procfs enabled

Steve French:
  o Fix inverted kmalloc parm ordering (noticed by Zwane) that caused
    oops on mounts of long server names (reported on bugzilla).  Fix
    multiuser mount option

Steven Whitehouse:
  o [DECNET]: Fix missing module refs in DECnet

Thorsten Knabe:
  o sound/oss/ad1816.c update

Ville Herva:
  o NMI watchdog documentation

Wensong Zhang:
  o [IPV4]: Add the defense timer for IPVS
  o [IPV4]: Remove the unnecessay del_timer_sync call in IPVS
    connection expire
  o [IPV4]: Do not use proto for route output in IPVS
  o [IPV4/IPVS]: Deactivate the timer in connection expire if it is
    activated by other users


