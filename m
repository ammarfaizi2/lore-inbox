Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTJQWbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTJQWbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:31:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:20385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263627AbTJQWbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:31:19 -0400
Date: Fri, 17 Oct 2003 15:31:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test8
Message-ID: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More changes than I would have liked, but most of them are fairly small. 
The most noticeable changes:

 - fix the /proc/PID/stat oops that multiple people reported
 - workaround for Athlon prefetch bug (occasional spurious page faults)
 - fix serverworks PIO autotuning
 - fix some cpufrequency calculations
 - make NFS O_DIRECT work

The rest are some architecture and driver updates, mostly stuff that
people had queued up and convinced me I wanted to merge before freezing
down totally. 

I've flamed a number of people who flaunted the freeze (I cursed a lot
more than I usually do ;), and they won't have any excuse to do so for
test9.  So expect the patches to shrink considerably in the coming
weeks. 

		Linus



Summary of changes from v2.6.0-test7 to v2.6.0-test8
============================================

<davis_g:com.rmk.(none)>:
  o [ARM PATCH] 1684/1: Add uImage build target rule
  o [ARM PATCH] 1685/1: Fix bootpImage build target
  o [ARM PATCH] 1686/1: Fix params-phys typos
  o [ARM PATCH] 1687/1: Add {params,initrd}_phys vars to enable
    bootpImage support on SA1100

<shep:alum.mit.edu>:
  o [TCP]: Fix missing connections in /proc/net/tcp
  o [TCP]: Fix numbering of lines in /proc/net/tcp

Albert Cahalan:
  o number of threads in /proc

Alexander Malysh:
  o I2C: i2c-sis630 driver fixes

Alexander Viro:
  o reiserfs/procfs.c fix

Alexey Dobriyan:
  o USB: Correct module names in drivers/usb/*/Kconfig
  o USB: Fix two typos in drivers/usb/README

Andi Kleen:
  o APIC fixes for x86-64
  o Fix x86-64 build with separate object tree
  o Disable non 64bit clean drivers for x86-64
  o Fix 64bit bug in trident frame buffer driver
  o Prefetch workaround for Athlon/Opteron
  o [ATM]: Mark unclean drivers as not-64BIT
  o Fix software suspend compilation on x86-64
  o Fixing mlockall & PROT_NONE
  o Mark non 64bit clean network drivers
  o Fix warnings in hp100
  o Fix warnings in defxx.c
  o Enable interrupts in faults from VM86 mode

Andreas Schwab:
  o ia64: fix misnamed syscalls

Andrew Morton:
  o drivers/block/initrd.c removal
  o Add missing sjcd uaccess checks
  o Fix early __might_sleep() calls
  o SELINUX: add policyvers to selinuxfs
  o Correct case sensitivity in make mandocs
  o Don't swap to files which do not implement readpage
  o reiserfs documentation URL fixes
  o silence smp_read_mpc_oem() declared static but never defined
    warning
  o ext3: i_disksize locking fix
  o applicom: fix LEAK, unwind on errors
  o ext2/ext3 acl signedness fixes
  o saa7134-core.c compile fix for old gcc
  o current_is_kswapd() is a function

Anton Blanchard:
  o ppc64: siginfo fix from Stephen Rothwell
  o ppc64: remove some old irq balance related code
  o ppc64: Fix for empty memory nodes when NUMA is enabled
  o ppc64: IDE fixes from Linas Vepstas
  o ppc64: Add paca export, from Sridhar Samudrala
  o ppc64: slabify ppc64 pagetables, from Bill Irwin
  o ppc64: add in hugetlb quota fixes
  o ppc64: add missing include
  o ppc64: merge some changes from the ameslab tree
  o ppc64: remove last bits of traceback tables
  o ppc64: disable_irq fix from x86
  o ppc64: clear IRQ_INPROGRESS in setup_irq and enable_irq
  o merge some irq.c fixes from x86
  o ppc64: Fix for sym2 problem (first place that checked pci_set_mwi
    return code)
  o ppc64: nuke a bunch of warnings, from akpm
  o ppc64: Use kmalloc for kernel stacks, like x86 (makes usage easy to
    track via slabinfo)
  o ppc64: remove old comment, copy_tofrom_user zeros destination on a
    load fault
  o ppc64: arguments to mlockall and msync dont need sign extending

Armin Schindler:
  o Eicon ISDN driver: use work_struct instead of tasklet for dpc

Arnaldo Carvalho de Melo:
  o [TCP/IPV4]: Fix tcp_tw_bucket accessed as a sock in
    tcp_bind_conflict()

Arun Sharma:
  o ia64: fix ia32 epoll emulation warnings
  o ia64: Fix unaligned faults in IA-32 putstat64

Bart De Schuymer:
  o [EBTABLES]: Add ebt_among match

Bartlomiej Zolnierkiewicz:
  o fix support for PIO modes w/o IORDY flow control
  o fix ServerWorks PIO auto-tuning
  o remove "biostimings" boot options

Benjamin Herrenschmidt:
  o add insert_resource() helper function
  o Fix call to Open Firmware "map" call, parameters were flipped
    causing the coff image to randomly fail
  o coff images bootloader reserves more memory for the kernel, allow
    booting
  o Export mol_trampoline and mmu_hash_lock for MOL (missing from a
    previous cset)
  o Export init_mm, some modules need that
  o The POWER4 support merged previously was incomplete, add the
    missing bits so that the kernel boots at least on POWER4 and G5
    CPUs
  o Fix RAMDAC detection on some IMS TwinTurbo video cards ("Mac" cards
    only), without this, you get no display on machines with those
    cards
  o Move definition of TimeBase registers from reg_booke.h to reg.h,
    those registers exist on common CPUs and without those definitions,
    SMP won't build
  o Fix timebase hardware sync on SMP PowerMacs (both oldworld dual
    604s and core99 dual G4s).
  o Fix VIA-based TB/Decrementer calibration , previously it wouldn't
    work properly with HZ != 100, causing tb_to_us to be wrong and
    gettimeofday() to return strangely "off" results
  o Fix a crash on sleep in the OF platform core where we would use a
    NULL "driver" pointer and actually try to call it after casting it!
  o Fix repeat delays in adbhit, they didn't make the transition to
    jiffies based values to ms. This fix crazy key repeat on ADB based
    PowerMacs
  o USB: Conflicting definitions in keyspan driver

Bjorn Helgaas:
  o [SERIAL] ACPI serial fix
  o ia64: fix serial port naming

Chas Williams:
  o [ATM]: sdh should be off by default
  o [ATM]: Change ifdef in lanai_ioctl
  o [ATM]: Remove vcc reference on outstanding SKBs
  o [ATM]: Minor cleanup for vcc_hash conversion

Corey Minyard:
  o IPMI fixes for 2.6.0-test7

Dave Jones:
  o [CPUFREQ] Make VIA longhaul work on Samuel2 & Ezra again
  o [CPUFREQ] refix EBLCR FSB only works on Samuel1
  o [CPUFREQ] Fix longhauls speed calculations
  o [CPUFREQ] Kill longhaul warnings (Blah about unused variables).

Dave Kleikamp:
  o JFS: Make sure journal records get flushed to disk
  o JFS: Improved error handing

David Brownell:
  o USB: minor net2280 cleanup
  o USB: make more driver names match module names
  o USB: ehci-hcd, misc bugfixes
  o USB: ohci-hcd PM fixes

David Gibson:
  o [NET]: Fix initialization sequence in SunGEM driver

David Mosberger:
  o ia64: Patch by Jesse Barnes
  o ia64: Fix __delay() to do The Right Thing.  In practice, this may
    cause BogoMIPS to drop to half the clock-speed with current
    versions of GCC, but this just shows that GCC doesn't generate very
    good code for single-cycle loops.  Perhaps it will motivate someone
    to improve GCC in this area (though it's hardly of practical value,
    other than for producing large BogoMIPS values).
  o ia64: Fix __delay() even more: it's just not safe to inline the
    delay- loop because, e.g., the compiler might decide to unroll the
    loop when passed a constant, etc.
  o ia64: Important security fix for fsyscalls.  Without this patch,
    the McKinley E9 workaround caused fsyscalls to return with the
    wrong privilege level.

David S. Miller:
  o [VLAN]: kfree(skb) --> kfree_skb(skb)
  o [SPARC64]: Squelch bogus gcc warning in unaligned.c due to bad flow
    analysis
  o [NET]: Delete skb_shared() checks from loopback driver transmit
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix __bzero_noasi declaration
  o [SPARC64]: Fix mixed declarations and code in flush_dcache_page_all
  o [ATM]: Kill PROC_FS ifdef around includes
  o [EBTABLES]: Print size_t type properly in ebt_among.c
  o [SPARC]: Audit inline asm
  o [SPARC64]: Update defconfig
  o [SPARC]: Fix types in ext2/minix bitops
  o [SPARC]: Provide foo_p aliases for I/O port ops
  o [SPARC]: Fix IRQ op build problems
  o [SPARC]: Make io.h macros more resiliant
  o [IPV6]: Fix typo in addrconf.c
  o [NET]: Convert sunlance away from init_etherdev
  o [NET]: Convert sunbmac away from init_etherdev
  o [NET]: Delete bogus unregister_netdev() call in sunbmac
  o [NET]: Convert myri_sbus away from init_etherdev
  o [NET]: Delete comment reference to init_etherdev which the driver
    does not even use
  o [NET]: Convert sk98lin away from init_etherdev

David Woodhouse:
  o JFFS2 update; completed support for NAND flash
  o Fix jffs2 memory leak on mount error
  o Kernel thread signal handling

Dax Kelson:
  o USB: Handspring Treo 600 id

Geert Uytterhoeven:
  o M68k export csum_partial
  o Sun-3 compile fix

Greg Kroah-Hartman:
  o I2C: fix i2c-dev class release function bug
  o PCI: fix up probe functions for agp drivers
  o PCI: fix up probe functions for synclink drivers
  o PCI: fix up probe functions for OSS drivers
  o I2C: remove unneeded MOD_INC and MOD_DEC calls
  o CHAR: Remove unneeded MOD_INC and MOD_DEC calls
  o OSS: fix up MOD_INC and MOD_DEC usages to remove compiler warnings
  o USB: fix visor driver to work with Palm OS 4+ devices
  o I2C: fix more define problems in w83781d driver

Herbert Xu:
  o [IPIP]: Decapsulate after checking policy
  o [IPV4/IPV6]: Clear security path for tunnel packets

Ian Wienand:
  o ia64: drop bogus "now < last_tick" message
  o ia64: a little more documentation in fsys.txt

Jamie Lokier:
  o set sigio target to current->pid and only if not already set
  o futex bug fixes

Janet Morgan:
  o ia64: sys_ia32.c fix for epoll

Jaroslav Kysela:
  o ALSA CVS update D:2003/09/26 15:29:05 C:USB generic driver
    A:Takashi Iwai <tiwai@suse.de> F:usb/usbmixer.c:1.23->1.24  L:probe
    units even under a selector unit which is marked as ignored or has
    L:only a single selector.
  o ALSA CVS update D:2003/09/29 08:31:25 C:PCI drivers A:Jaroslav
    Kysela <perex@suse.cz> F:pci/Kconfig:1.8->1.9  L:Removed GAMEPORT
    dependency (already handled in drivers)
  o ALSA CVS update D:2003/09/29 19:16:18 C:ALSA<-OSS emulation
    A:Jaroslav Kysela <perex@suse.cz> F:core/oss/pcm_oss.c:1.50->1.51 
    F:include/pcm_oss.h:1.7->1.8  L:Fixed oops in oss_sync() routine.
  o ALSA CVS update D:2003/09/30 08:54:19 C:ALSA<-OSS emulation
    A:Jaroslav Kysela <perex@suse.cz> F:core/oss/pcm_oss.c:1.51->1.52 
    L:Fixed compilation for the sync code commited by mistake.
  o ALSA CVS update D:2003/09/30 09:58:53 C:Generic drivers A:Jaroslav
    Kysela <perex@suse.cz> F:drivers/dummy.c:1.25->1.26  L:Added
    emu10k1 emulation by Takashi
  o ALSA CVS update D:2003/09/30 10:28:26 C:Control Midlevel,HWDEP
    Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel C:Timer
    Midlevel,ALSA<-OSS emulation,ALSA sequencer,EMU8000 driver
    C:Digigram VX222 driver,USB generic driver A:Jaroslav Kysela
    <perex@suse.cz> F:core/control.c:1.37->1.38 
    F:core/hwdep.c:1.21->1.22  F:core/init.c:1.38->1.39 
    F:core/pcm_lib.c:1.43->1.44  F:core/pcm_native.c:1.81->1.82 
    F:core/rawmidi.c:1.37->1.38  F:core/timer.c:1.46->1.47 
    F:core/oss/pcm_oss.c:1.52->1.53  F:core/seq/seq_lock.c:1.7->1.8 
    F:include/rawmidi.h:1.10->1.11  F:isa/sb/emu8000_patch.c:1.6->1.7 
    F:isa/sb/emu8000_pcm.c:1.10->1.11  F:pci/vx222/vx222_ops.c:1.2->1.3
     F:usb/usbaudio.c:1.65->1.66  L:Revised schedule() and
    set_current_state() calls.
  o ALSA CVS update D:2003/09/30 11:12:09 C:VIA82xx driver A:Takashi
    Iwai <tiwai@suse.de> F:pci/via82xx.c:1.52->1.53  L:- fixed the
    detection of VIA8233A (it was overridden by dxs_support L: 
    option).
  o ALSA CVS update D:2003/09/30 11:15:44 C:RawMidi Midlevel A:Takashi
    Iwai <tiwai@suse.de> F:core/rawmidi.c:1.38->1.39  L:fixed typos
    (open_lock -> open_mutex).

Jean Delvare:
  o I2C: Chip driver initialization fixes
  o I2C: correct some errors in i2c/chips/Kconfig

Jeff Garzik:
  o [netdrvr 8139too] add pci id
  o [netdrvr 8139too] another new PCI ID
  o [netdrvr tulip] add pci id

Jens Axboe:
  o ide-floppy IOMEGA ZIP fix
  o fix ide-floppy IOMEGA logic

Jeroen Vreeken:
  o [hamradio scc] fix probe function
  o [hamradio bpqether] fix ancient debug line

Jesse Barnes:
  o ia64: fix NUMA page table allocation to get memory from the right
    node
  o ia64: fix SN2 code for GENERIC builds
  o ia64: fix is_headless_node() for systems w/<64p
  o ia64: early SN setup fix
  o ia64: deal with lack of SRAT in GENERIC kernels
  o ia64: fix SN2 interrupt allocation
  o ia64: 2nd step to fix GENERIC builds: split contig and discontig
    paging_init functions
  o ia64: fix NUMA boot
  o ia64: nable SN2 in generic builds
  o ia64: SN2 module fix
  o ia64: force on appropriate generic options

John Levon:
  o USB: default input core support to y

Julian Anastasov:
  o [IPV4]: ip_copy_metadata must copy the nfcache field
  o [IPV4]: ip_fragment should not reassemble if all frags do not have
    owner

Kenneth W. Chen:
  o ia64: fix NUMA hugetlb support

Krzysztof Halasa:
  o [WAN]: Fix transmitted headers with generic HDLC + Cisco encap

Len Brown:
  o [ACPI] Summary of changes for ACPICA version 20031002
  o [ACPI] fix acpi_asus module build (Stephen Hemminger)

Linus Torvalds:
  o disable_irq() should synchronize with irq handler only if one
    exists
  o Revert floppy driver dependence on CONFIG_ISA. The thing exists
  o Revert the process group accessor functions. They are buggy, and
    cause NULL pointer references in /proc.
  o Make kernel stack dumps handle unaligned kernel stacks more
    gracefully
  o Clear IRQ_INPROGRESS as part of "enable_irq()"
  o Revert recent SMP timer changes - they cause deadlocks
  o Mark timer as running in the timer base _before_ we clear the
    pending flag (and order it on SMP), so that del_timer_sync() always
    sees the timer either pending or running if it is active.
  o Avoid unnecessary floating point usage in av7110 DVB driver
  o Avoid unnecessary floating point calculations in amd8111e net
    driver
  o Make x86 do_div() macro evaluate its "base" argument only once
  o Fix APIC address handling at bootup and restore
  o Allow Turtle Beach sound drivers to be compiled modular when
    STANDALONE is set, since the firmware is only required for the
    built-in case.

Luca Tettamanti:
  o I2C: sensors/w83781d.c creates useless sysfs entries

Madarasz Gergely:
  o [NET]: Fix get_random_bytes() call in
    sunhme.c:get_hme_mac_nonsparc()

Manfred Spraul:
  o avoid crashes due to unaligned stacks
  o [netdrvr natsemi] fix ring clean

Matt Domsch:
  o EDD: reads to raw_data return binary data, not hexdump

Matthew Dharm:
  o problems with USB memory pen

Matthew Wilcox:
  o Build fixes for zoran on PA-RISC

Michael Hunold:
  o New DVB frontend driver ves1x93 (obsoletes alps_bsrv2)
  o Fix vbi handling in saa7146 core driver
  o Add private data pointer to DVB frontends
  o Fix DVB network device handling
  o Misc. fixes for ALPS TDLB7 DVB frontend driver
  o Misc. fixes for AT76C651 DVB frontend driver
  o Update the AV7110 DVB driver
  o Fix dvb_net network subsystem usage

Mikael Pettersson:
  o ftape linkage error

Nathan Scott:
  o ia64: correct ino_t to be 64 bits wide

Noah J. Misch:
  o USB: Make ISD-200 USB/ATA Bridge depend on BLK_DEV_IDE
  o USB: Make Ethernet Gadget depend on CONFIG_NET
  o [IPX]: ipx_proc.c needs linux/init.h even when PROC_FS is not
    enabled

Oliver Neukum:
  o USB: remove stupid check for NULL in devio.c

Patrick Mochel:
  o [kobject] export kset syms for module use
  o [driver model] Add device_unregister_wait()
  o [kobject] Fix memory leak in kobject_set_name()
  o [power] Clean up ACPI STR assembly
  o [driver model] Remove unneeded error check
  o [power] Fix some typos
  o [power] swsusp Update
  o [swsusp] Don't free buffer when going to sleep

Paul Mackerras:
  o PPC32: Export a couple of symbols (csum_partial and init_task)
  o Fix compile on PPC
  o USB: Fix USB suspend in 2.6.0-test6

Paul Mundt:
  o net/sunrpc/clnt.c compile fix

Pekka Pietikäinen:
  o b44 enable interrupts after tx timeout (2.6-test version)

Peter Chubb:
  o ia64: drop stale check for GAS_HAS_LOCAL_TAGS

Petr Vandrovec:
  o [NET]: Fix socket test in dev_queue_xmit_nit()

Randy Dunlap:
  o [NET]: Grab RTNL semaphore in init_netdev() if we call
    dev_alloc_name()

Russell Cattelan:
  o [XFS] Fix remount,ro path

Russell King:
  o [ARM] Update LART default configuration
  o [ARM] Clean generated files in "clean" rather than "mrproper"
  o [ARM] Add ARM specific ignores to BK ignore file
  o [ARM] Remove no_action function from CLPS7500 code
  o [ARM] Add missing exports for Integrator logic module drivers
  o [ARM] Add missing csum_partial export
  o Fix pcnet_cs network hotplug
  o [ARM] Fix div64 implementation

Rusty Lynch:
  o ia64: fix perfmon typo that broke Itanium build

Rusty Russell:
  o Fix pcmcia_tcic.c if PCMCIA_DEBUG is defined
  o ipt_limit fix for HZ=1000
  o More barriers in module code

Scott Feldman:
  o ethtool_ops eeprom stuff
  o hang on ZEROCOPY/TSO when hitting no-Tx-resources

Shirley Ma:
  o [IPV6]: MIB fix, provide timestamps in ifa_cacheinfo

Simon Kelley:
  o atmel wireless driver

Stephen Hemminger:
  o [IRDA]: Fix memory leak in sa1100_ir.c
  o [WAN]: Incorrect comparison for register_netdev in cosa.c
  o [WAN]: Fix register_netdev() return value check in hostess_sv11.c
  o [NET]: Fix register_netdev() return value check in synclink_cs.c
  o [NET]: Fix syncppp wan device regression
  o [NET]: Fix sealevel regression
  o [NET]: Resolve device probe difference
  o [netdrvr xircom_cb] fix race in statistics pointer setting by
    converting to use alloc_etherdev.
  o [NET]: Mark dev_alloc as deprecated
  o [NET]: Mark init_etherdev() as deprecated
  o [NET]: Catch buggy net drivers changing getstats op after registry

Stephen Lord:
  o [XFS] Implement deletion of inode clusters in XFS
  o [XFS] Document ikeep mount option
  o [XFS] switch xfs to use linux imode flags internally
  o [XFS] Match up minor formatting changes between SGI and Linus trees
  o Revert from using __kernel_fsid_t to fsid_t since ia64 now defines
    this correctly
  o Change the way XFS implements the invisible I/O mechanism used by
    the online backup tools.
  o More uio changes, add code attribution

Stéphane Eranian:
  o ia64: perfmon-2 fixes

Tigran Aivazian:
  o update to microcode update driver

Tom Rini:
  o PPC32: Always print the processor number in /proc/cpuinfo
  o PPC32: Remove CONFIG_DCACHE_DISABLE, as it's not all that useful
  o PPC32: Fix a typo
  o PPC: Change how we export some Openfirmware device nodes
  o PPC32: Fix the ns1655x uart driver in the bootwrapper
  o PPC32: Update 'make help'

Tony Luck:
  o ia64: fix register numbers in MCA save/restore
  o ia64: infinite loop in ia64_mca_wakeup_ipi_wait
  o ia64: cannot convert region 5 address to physical by clearing bits
    63:61
  o ia64: Another MCA fix
  o ia64: MCA min_state area must be uncacheable

Trond Myklebust:
  o NFS: fix the synchronous READ/WRITE bugs
  o NFS: remove broken O_DIRECT wait code
  o NFS: synchronous NFSv3/v4 COMMIT
  o NFS: Fix O_DIRECT code
  o NFS: Enable NFS_DIRECTIO support

Venkatesh Pallipadi:
  o Bug in timer_tsc cpufreq callback

Wensong Zhang:
  o [IPVS]: Fix IPVS sync state check
  o [IPVS]: Fix to set the statistics of dest zero when bound to a new
    service

Yoshinori Sato:
  o H8/300 support update

Yves Rutschle:
  o [ARM] Fix LART build


