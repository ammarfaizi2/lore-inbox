Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVBCClV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVBCClV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVBCClV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:41:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:35742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVBCCfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:35:41 -0500
Date: Wed, 2 Feb 2005 18:35:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.11-rc3
Message-ID: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has a number of architecture updates (mips, arm, ppc, x86-64, ia64), 
and updates ACPI, DRI, ALSA, SCSI, XFS and InfiniNand.. And a lot of small 
one-liners all over.

I'd _really_ like to calm down for a final 2.6.11 now, so please note 
anything really important I missed, but keep the rest pending. And give 
this a good testing..

Oh, and the automated bitkeeper mirroring to bkbits.net seems slightly
broken right now (hasn't updated in the last 48 hours), but the tar-balls
are all there, and the BK upating mechanism will hopefully be fixed soon.

(I've got a few BK trees in private places, it's only the public
bkbits.net one that hasn't gotten mirrored out yet - many other BK
developers will know where to find my secondary trees and can pull from
them instead).

		Linus


Summary of changes from v2.6.11-rc2 to v2.6.11-rc3
============================================

<krzysztof.h1:wp.pl>:
  o [SPARC]: Fix asm constraints in muldiv.c

Adrian Bunk:
  o i386 voyager_smp.c: remove a duplicate #include
  o i386: reboot.c cleanups
  o SCSI NCR_Q720.c: make some code static
  o [NET]: Remove mandoc reference to deleted file net_init.c

Akinobu Mita:
  o oprofile: falling back on timer interrupt mode
  o ppc32: oprofile timer-mode fallback fix

Alan Stern:
  o Fix reference to deallocated memory in sd.c

Alasdair G. Kergon:
  o device-mapper: fix mirror log type module ref count
  o device-mapper: remove unused bs_bio_init()
  o device-mapper: Add presuspend hook
  o device-mapper: optionally bypass a bdget

Albert Herranz:
  o ppc32: perfctl-ppc: fix duplicate mmcr0 define

Alexander Viro:
  o de2104x: Fixes breakage in getting MAC address
  o idmouse min() fix
  o openpromfs property_read() fix
  o missing include in fore200e.c
  o isp16 missing initcalls
  o wrong include in tda80xx.c
  o matrox_fb trivial compile fix for pmac
  o rme9562 big-endian compile fix (dumb typo)
  o *really* dumb typo in aacraid (cast to pointer to structure that
    doesn't exist ;-)
  o block2mtd 64bit bug
  o missing include in r8169
  o cs461x iomem fixes and annotations
  o 64bit fixes (printks)
  o icom iomem annotations and NULL noise removals
  o pktgen __user annotations
  o missing declaration in firmware.h
  o more missing const in bitops prototypes
  o uaccess.h annotations
  o missing export (_tlbie())
  o shpchprm_legacy.c trivial iomem annotations
  o long constants on amd64
  o misc mtd sparse fixes
  o utter weirdness in drivers/media/dvb/frontends/cx22700.c
  o av7110_hw.c __user annotation
  o amd64 compat annotations
  o sparc64 compat annotations
  o several isdn trivial iomem annotations
  o a couple of trivial sound/pci iomem annotations
  o missing () in macros (alpha pgtable.h)

Andi Kleen:
  o Add compat_ioctl to scsi host structure
  o x86_64: Fix int3 trap
  o x86-64: Fix UP build warning
  o x86: Remove unused function
  o x86_64: remove centaur mtrr support
  o x86_64: remove duplicated includes
  o x86_64: Enlarge northbridge numa scan mask
  o x86_64: Remove earlyprintk help
  o x86_64: Speed up suspend
  o x86-64: Fix missing TLB flushes in change_page_attr
  o x86-64: Fix empty nodes handling with SRAT

Andrea Arcangeli:
  o mm: adjust dirty threshold for lowmem-only mappings
  o mm: truncate SMP race fix
  o mm: oom-killer tunable
  o mm: rework lower-zone protection initialisation
  o mm: fix several oom killer bugs
  o mm: convert memdie to an atomic thread bitflag

Andreas Gruenbacher:
  o ext3/ea: no lock needed when freeing inode
  o ext3/ea: set the EXT3_FEATURE_COMPAT_EXT_ATTR for in-inode xattrs
  o ext3/ea: documentation fix
  o ext3/ea: ix i_extra_isize check
  o ext3/ea: disallow in-inode attributes for reserved inodes
  o ext3: fix ea-in-inode default ACL creation
  o ext2/ext3 ACLs: remove the number of acl entries limit
  o fs/mbcache.c: Remove an unused wait queue variable

Andrew Morton:
  o dib3000mc build fix
  o [TUN/TAP]: Add missing trans_start and last_rx setting
  o alpha: nodemask build fix
  o alpha: pgd_index() warning fix
  o 8250_pnp: 64bit warning fix
  o ext2-quota-leak-fix fix

Andrew Vasquez:
  o MAINTAINERS: add entry for qla2xxx driver

Andries E. Brouwer:
  o document atkbd.softraw
  o input: Document the atkbd.softraw module parameter

Andris Pavenis:
  o Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and
    2.6.9-rc1-bk2

Anton Altaparmakov:
  o NTFS: Add printk rate limiting for ntfs_warning() and ntfs_error()
    when compiled without debug.  This avoids a possible denial of
    service attack.  Thanks to Carl-Daniel Hailfinger from SuSE for
    pointing this

Anton Blanchard:
  o ppc64: limit segment tables on UP kernels
  o ppc64: allow EEH to be disabled
  o ppc64: disable some boot wrapper debug
  o ppc64: problem disabling SYSVIPC
  o ppc64: enable virtual ethernet and virtual scsi
  o Problems disabling SYSCTL
  o genhd: rename device_init
  o ppc64: mask lower bits in tlbie

Antonino Daplas:
  o radeonfb: Set accelerator id
  o vesafb: Change return error id
  o intelfb: Workaround for 830M
  o fbcon: Save blank state last
  o backlight: Fix compile error if CONFIG_FB is unset
  o matroxfb: FB_MATROX_G Kconfig changes
  o fbdev: Fix return code of edid_checksum
  o backlight: Add backlight driver for Sharp Corgi PDAs

Arjan van de Ven:
  o removing bcopy... because it's half broken

Armin Schindler:
  o Eicon driver: add missing uaccess
  o Eicon driver: vfree()
  o Eicon driver: remove unused code

Ben Dooks:
  o [ARM PATCH] 2431/1: Split arch specifics out of
    arch/arm/kernel/debug.S
  o [ARM PATCH] 2432/1: include/asm-arm/bitops.h - missing const from
    find
  o [ARM PATCH] 2433/1: debug-macro.S split - fix header filename
  o [ARM PATCH] 2438/1: S3C2410 - fix IO address calculations
  o [ARM PATCH] 2439/1: S3C2410 - serial driver parity selection
  o [ARM PATCH] 2440/1: S3C2410 - serial auto-flow-control enable

Ben LaHaise:
  o [NET]: Kill excess initializer

Benjamin Herrenschmidt:
  o ppc32: Add support for Pegasos machines
  o ppc64: Missing call to ioremap in pci_iomap()
  o ppc32: (Updated) Pegasos support
  o ppc32: pmac sleep support update
  o ppc32: Fix via IDE driver for pegasos

Bob Picco:
  o [IA64] fix declaration of __find_next_zero_bit, first arg is
    "const"

Brian Gerst:
  o clean up UTS_RELEASE usage

Chas Williams:
  o [ATM]: [fore200e] can't cleap in transmit routine
  o [ATM]: [he] reorder add_wait_queue() and set_current_state()
  o [ATM]: [nicstar] small cleanup for some globals
  o [ATM]: [svc] get accounting right when we remove skb
  o [ATM]: replace schedule_timeout() with msleep()

Chris Wright:
  o compat ioctl security hook fixup
  o fix audit skb leak on congested netlink socket
  o some minor cleanups for audit_log_lost() messages

Christoph Hellwig:
  o [XFS] make sure to always reclaim inodes in xfs_finish_reclaim
  o [XFS] Fix NFS inode data corruption
  o [XFS] Use generic_readlink
  o [XFS] Move support code for NFS exporting to a conditionally built
    file
  o [XFS] Fix compilations for parisc
  o [XFS] Update Makefile for separate export source file
  o Move extern find_exported_dentry declaration into a common header
  o [XFS] Make AIO work again - wait on iocb completion for non-AIO
    only
  o update mips driver Kconfig bits
  o update dec_esp with changes from mips CVS
  o cosmetic jazz_esp updates
  o osst: don't use obsolete SCSI APIs
  o kill softirq_pending()
  o pcmcia: socket->{a,c}region are unused
  o [XFS] Fix NFS exporting with modular nfsd
  o udf deadlock fix

Christoph Lameter:
  o alloc_zeroed_user_highpage() to fix the clear_user_highpage issue

Daniel Drake:
  o Configurable delay before mounting root device

Darrick Wong:
  o Fix BUG in io_destroy

Dave Airlie:
  o drm: add r300 microcode support and radeon chip flags
  o drm: move ioctls to shared file and move interface history to
    correct place
  o drm: fix mga ioctls
  o drm: add drm_pci interface and make i915 use it
  o drm: fix setversion in drm core model
  o drm: add support for radeon flags
  o drm: fix minor bug on X recycling with freeing io buffer
  o drm: add R200_EMIT_TCL_POINT_SPRITE_CNTL
  o drm: radeon hyperz support
  o drm: add radeon framebuffer tiling support and surface management
  o drm: update pci ids
  o drm: fix drm_sysfs lock initializer
  o drm_memory.h doesn't need to #include tlbflush.h

Dave Jiang:
  o [ARM PATCH] 2447/1: IOP3xx PCI resource setup cleanup

David Mosberger:
  o [IA64] uaccess.h: add missing __user annotation for sparse
  o [IA64] domain.c: eliminate warning when compiling CONFIG_NUMA=n
  o [IA64] sys_ia32.c: add missing __user annotation for sparse
  o [IA64] cleanup C uage of global/root-function predicates
  o [IA64] Don't forget to initialize PKStk for kernel-threads
  o [IA64] entry.S: Align rse_clear_invalid to double-bundle boundary
  o [IA64] Resched skip_rbs_switch to run 4 cycles faster on
    McKinley-type cores
  o [IA64] Improve ia64_leave_syscall() for McKinley-type cores
  o [IA64] Use srlz.d instead of srlz.i in ia64_leave_syscall
  o [IA64] entry.S update the copyright year & fix a comment

David S. Miller:
  o Cset exclude:
    davem@nuts.davemloft.net|ChangeSet|20050120063740|10274
  o [SPARC64]: Update defconfig
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Minor memmove refinements
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Set STRICT_MM_TYPECHECKS and kill ctxd/iopgprot
  o [MM]: PTRS_PER_{PUD,PMD} are not necessarily compile time constants
  o [SPARC64]: Covert over to 4 level page tables
  o [TG3]: Update driver version and reldate
  o [MM]: Do not even do the runtime PTRS_PER_{PMD,PUD} checks
  o [NET]: Kill now unused local var from sock_init()
  o [SPARC64]: __atomic_{add,sub}() must sign-extend return value

David Vrabel:
  o [ARM PATCH] 2437/1: ixp4xx: cosmetic change to arch_reset()

Dmitry Torokhov:
  o Input: ACK/NAK processing rules in libps2 were too strict - while
    it is a good idea to discard any character other than ACK/NAK
    during probe it causes missing releases and keys getting "stuck"
    when a command issued on enabled device. The effect is easily
    demonstrated with the following command:
  o Input: libps2 - fix timeout handling in ps2_command, switch to
    using wait_event_timeout instead of
    wait_event_interruptible_timeout now that first form is available.

Domen Puncer:
  o delete unused file dpt_osdutil.h

Dominik Brodowski:
  o pcmcia: use unsigned long for IO port address

Douglas Gilbert:
  o scsi_debug dsense
  o sg descriptor sense cleanup lk 2.6.11-rc1-bk1
  o sense data helpers lk 2.6.11-rc1-bk1
  o streamline block SG_IO error processing
  o streamline block SG_IO error processing in sd
  o sd descriptor sense support
  o fix scsi cdrom problem

Ed L. Cashin:
  o AOE: fix up the block device registration so that it actually works

Eddie C. Dost:
  o [SPARC64]: Missing user access return value checks in
    fs/binfmt_elf.c and fs/compat.c

Geert Uytterhoeven:
  o SCSI NCR53C9x.c: some cleanups
  o m68k csum_partial_copy_* gcc4 warning fixes

George T. Joseph:
  o [ARM PATCH] 2434/1: Adds new machine: ixp4xx based gtwx5715

Georgi Guninski:
  o Fix sign checks in copy_from_read_buf()
  o Fix signed compare in fs/proc/generic.c::proc_file_read()
  o reiserfs: use proper 64-bit clean types

Gerd Knorr:
  o video/arv: remove casts
  o video/w9966: remove casts
  o video/zr36120: remove casts
  o v4l: video-buf update
  o v4l2 tuner api update
  o v4l: tuner update
  o v4l: add tveeprom module
  o v4l: tvaudio update
  o v4l: bttv IR input driver update
  o v4l: bttv update
  o v4l: saa7134 module
  o v4l-saa7134-module fix
  o add i2c adapter id for the cx88 driver

Greg Kroah-Hartman:
  o Modules: Allow sysfs module parameters to be written to

Haroldo Gamal:
  o [libata sata_sil] add another Seagate driver to blacklist

Herbert Pötzl:
  o fix ext3 quota allocation bug on error path
  o assert_spin_locked()

Herbert Xu:
  o [IPV4/IPV6]: In ip_fragment(), reset ip_summed field on SKB
    sub-frags
  o [XFRM]: Probe selected algorithm only
  o [ATM]: Fix IRQ flags type in lec_arp_expire_vcc

Hideaki Yoshifuji:
  o [IPV6]: Fix ip6_copy_metadata potential dst leak too
  o [NET]: Fix kernel oops if base_reachable_time is set to zero

Ingo Molnar:
  o Remove unnecessary ";" in schedstat_ macros
  o rest_init() local irq fix

Jack Steiner:
  o [IA64] Delete duplicate SN2 definition of cpu_logical_id for UP
    build
  o [IA64] Delete: arch/ia64/sn/include/shub.h

Jake Moilanen:
  o ppc64: iSeries buildbreak fix

James Bottomley:
  o dma_release_declared_memory needs iounmap
  o fix use after potential free in scsi_cd_put
  o Add attribute container to generic device model
  o add a generic device transport class
  o move the SCSI transport classes over to the generic transport class
  o SCSI: Fix style nitpicks
  o fix broken cross compiles
  o SCSI Fix oops with faulty DVD
  o SCSI: fix multiple HBA problem with transport classes
  o Fix missed class_remove_file in attribute_container

James Morris:
  o crypto: fix test vectors

Jan Kara:
  o ext2 quota leak fix

Jason Gaston:
  o SATA AHCI support for Intel ICH7R

Jens Axboe:
  o cfq-iosched: in_driver accounting bug

Jes Sorensen:
  o [IA64] fix PAL_PREFETCH_VISIBILITY call

Jesse Barnes:
  o [IA64] new api efi_range_is_wc()
  o [IA64] fix early SAL init for sn2
  o [IA64] remove superfluous layer from sn2 DMA API

Jim Nelson:
  o arm26: new maintainer of Archimedes floppy and hard disk drivers

Johannes Stezenbach:
  o dvb: fix RPS init race
  o dvb: support pinnacle pctv-sat, clean-ups
  o dvb: dibusb refactoring, support Yakumo/HAMA/Typhoon/HanfTek clones
  o dvb: support nxt2002 frontend, misc skystar2 fixes
  o dvb: add ATSC support, misc fixes
  o dvb: dib3000 refactoring
  o dvb: nxt2002: add ATSC support, misc fixes
  o dvb: dvb-ttpci: fix SMP race, budget: fixe init race, misc fixes
  o DVB linkage fix
  o dvb: follow USB __le16 changes
  o dvb: fix access to freed memory
  o dvb: support up to six DVB cards
  o dvb: cleanup firmware loading printks

John W. Linville:
  o i810_audio: offset LVI from CIV to avoid stalled start
  o i810_audio comment fix

Jon Smirl:
  o drm: add drm specific sysfs support

Kazunori Miyazawa:
  o [IPSEC]: Fix processing of error from crypto module

Keith Owens:
  o [IA64] Sanity check unw_unwind_to_user
  o fix module kallsym lookup breakage

Kevin Corry:
  o device-mapper: fix TB stripe data corruption

Kumar Gala:
  o ppc32: Add defconfigs for 85xx boards -- updated
  o ppc32: allow usage of gen550 on platforms that do not define
    SERIAL_PORT_DFNS
  o ppc32: fix PCI2 IO space mapping on CDS
  o netdrv gianfar: Fix usage of gfar_read in debug code
  o ppc32: back out idle patch for non-powersaving CPU's
  o ppc32: use platform device style initialization for 85xx 
    serial8250 ports

Len Brown:
  o [ACPI] Use kernel.h for ARRAY_SIZE() instead of using local
    NUM_OF()
  o [ACPI] Make the bm_activity depend on "jiffies", instead of numbers
  o [ACPI] Add a module parameter to allow tuning how much bus-master
    activity we remember when entering C3 --
    /sys/module/processor/parameters/bm_history Default varies with HZ
    -- 40ms for 25 - 800 HZ, 32ms for 1000 HZ.
  o [ACPI] ACPICA 20050114 from Bob Moore
  o [ACPI] avoid benign AE_TYPE warnings caused by "implicit return"
    BIOS workaround returning unsolicited (and thus mis-typed) AML
    values.
  o [ACPI] ACPICA 20050125 from Bob Moore
  o [ACPI] reduce stack usage
    http://bugzilla.kernel.org/show_bug.cgi?id=2901
  o [ACPI] ACPI_FUTURE_USAGE for acpi_ut_create_pkg_state_and_push()
  o [ACPI] add "pnpacpi=off"
  o [ACPI] tell parse_cmdline_early() that "pnpacpi=off" != "acpi=off"

Linus Torvalds:
  o acpi video device enumeration: fix incorrect device list allocation
  o x86-64: don't crash and loop when the user passes an unknown
    earlyprintk= option
  o Free temporary pipe page after freeing the main buffers
  o Rename "locks_verify_area()" to "rw_verify_area()" and clean up the
    arguments.
  o Add 'f_maxcount' to allow filesystems to set a per-file maximum IO
    size
  o Fix permissions on drivers/scsi/a100u2w.c
  o Linux 2.6.11-rc3

Manish Lachwani:
  o kobject build fix

Marc Singer:
  o [ARM PATCH] 2442/1: Simplifying NODES_SHIFT

Marcel Holtmann:
  o [Bluetooth] Use wait_event_interruptible_timeout()
  o [Bluetooth] Use wait_event_timeout()
  o [Bluetooth] Fix too many keys pressed error
  o [Bluetooth] Fix rfcomm_sock_destruct() deadlock
  o [Bluetooth] Add RFCOMM service level security
  o [Bluetooth] Remove MTU check for the L2CAP raw socket
  o [Bluetooth] Update inquiry cache from clock offset event
  o [Bluetooth] Support raw mode only devices
  o [Bluetooth] Use raw mode for the CSR sniffer device
  o [Bluetooth] Skip raw mode devices when choosing source device

Mark A. Greer:
  o ppc32: mv64x60 updates
  o ppc32: katana update
  o ppc32: ev64260 update
  o ppc32: cpci690 update
  o ppc32: workaround for mpc10x speculative PCI read erratum
  o ppc32: MPC8245 erratum 28 workaround
  o mpsc updates

Mark Goodwin:
  o [IA64] fix SN2 hwperf error handling

Mark Haverkamp:
  o aacraid 2.6: add scsi synchronize cache support

Mark Salyzyn:
  o dpt_i2o: remove schedule_timeout()

Martin Josefsson:
  o [NETFILTER]: Fix SNAT/DNAT target size checks
  o [NETFILTER]: Fix compile errors without NAT
  o [NETFILTER]: Fix compile with NAT but without modules

Martin Schwidefsky:
  o cputime: simplifiy generic cputime_to_secs/secs_to_cputime

Martins Krikis:
  o fix an oops in ata_to_sense_error

Matt Mackall:
  o [NET]: netpoll: Fix NAPI polling race on SMP
  o random: overflow fix

Matt Porter:
  o ppc32: STx GP3 port
  o ppc32: add platform specific machine check output handlers
  o Add Eugene Surovegin to CREDITS

Matthew Wilcox:
  o Minor ext2 speedup
  o Make slab use alloc_pages directly

Michael Chan:
  o [TG3]: add tg3_set_eeprom()
  o [TG3]: Fix TSO for 5750
  o [TG3]: 5750 fixes

Michael Geng:
  o videotext: ioctls changed to use _IO macros

Michael Marineau:
  o Disable Sidewinder debug messages

Michael Opdenacker:
  o [ARM PATCH] 2444/1: GPIO23_SCLK_md now in uppercase in pxa-regs.h

Michael S. Tsirkin:
  o InfiniBand/mthca: don't write ECR in MSI-X mode
  o InfiniBand/mthca: pass full process_mad info to firmware
  o InfiniBand/mthca: optimize event queue handling
  o InfiniBand/mthca: clean up ioremap()/request_region() usage

Michal Ostrowski:
  o [MAINTAINERS]: Fix my email address in PPPOE entry

Mike Waychison:
  o wait_for_completion API extension addition fixes

Nathan Lynch:
  o ppc64: fix use kref for device_node refcounting (fix)
  o unexport register_cpu and unregister_cpu

Nathan Scott:
  o [XFS] Fix a performance and scaling problem in xfs_iget_core. 
    Improved the inode hash table sizing heuristics, and allow these to
    be manually tweaked as well.
  o [XFS] Prevent attempts to mount 512 byte sector filesystems with
    64KB pagesizes, until fixed.
  o [XFS] Move to per-device hash tables (scalability), and use Bill
    Irwins hash (quicker).
  o [XFS] Add sanity checks before use of attr_multi opcount parameter
  o [XFS] Switch to using a separate Kconfig file for XFS
  o [XFS] Switch to managing uptodate state on a region within a page,
    rather than a sector within a page.  Fixes 64K pagesize kernels
    with 512 byte sectors.
  o [XFS] Fix page index to byte calculation result truncation in
    tracing code.
  o [XFS] Remove write congestion check during metadata readahead
  o [XFS] Ensure the cluster hash size does not exceed the inode hash
    size
  o [XFS] Fix mapping gfp_flags used on metadata buffer inode
  o [XFS] Fix preempt-related warnings - based on a Chris Wedgwood
    patch
  o [XFS] Fix selection of EXPORTFS when using XFS to get a good build
    when XFS=y and EXPORTFS=m.

Nicolas Pitre:
  o [ARM PATCH] 2435/1: platform data for audio on Mainstone
  o [ARM PATCH] 2430/3: TLS support for ARM
  o [ARM PATCH] 2443/1: enable iWMMXt on EABI binaries

Nishanth Aravamudan:
  o [IA64] smpboot.c: use msleep(100) instead of inlined equivalent
  o Add a usecs_to_jiffies() function

Olaf Hering:
  o fix architecture names in hugetlbpage.txt

Olof Johansson:
  o ppc64: p615 IOMMU fix

Pablo Neira:
  o [NETLINK]: Move nl_nonroot into netlink_table

Patrick McHardy:
  o [IPV4]: Keep fragment queues private to each user
  o Fix conntrack fragment route cache memory leak
  o [IPV4]: Do not leak dst entries in ip_copy_metadata()
  o [NETFILTER]: Fix TCP header offset used in tcp_manip_pkt()
  o [NETFILTER]: Fix ICMP checksumming in icmp_reply_translation()

Paul Mackerras:
  o ppc64: xmon data breakpoints on partitioned systems
  o ppc64: fix in_be64 definition
  o ppc64: clear MSR_RI earlier in syscall exit path
  o ppc64: replace schedule_timeout in iSeries_pci_reset
  o ppc64: replace schedule_timeout in pSeries_cpu_die
  o ppc64: replace schedule_timeout in __cpu_up
  o ppc64: replace schedule_timeout in die
  o ppc64: trivial cleanup: EEH_REGION
  o ppc64: sparse fixes for cpu feature constants
  o ppc64: use kref for device_node refcounting

Pavel Machek:
  o swsusp: fix buggy comment
  o Enable swsusp on SMP machines

Peter Hagervall:
  o arch/i386/kernel/apic.c Kill a sparse warning

Phil Oester:
  o [NETFILTER]: Add inversion to multiport match

Prasanna Meda:
  o ptrace: last_siginfo also needs tasklist_lock

Ralf Bächle:
  o mips: IRIX 5 compat fixes
  o mips: build script fixes
  o mips: sibyte updates
  o mips: RM200 updates
  o mips: SGI IP27 updates
  o mips: DVH fixes
  o mips: TX49 updates
  o mips: TXX9 serieal driver rewrite
  o mips: aMD Alchemy update
  o mips: ITE 8172 updates
  o mips: AMD Alchemy I2C driver
  o mips: SGI IP32 updates
  o mips: DECstation updates
  o mips: DECstation Turbochannel updates
  o mips: jazz updates
  o mips: mIPS Technologies board updates
  o mips: cobalt updates
  o mips: vR41xx updates
  o mips: VR4181 updates
  o mips: NEC DDB board updates
  o mips: TX39 series updates
  o mips: galileo updates
  o mips: PMC-Sierra updates
  o mips: Momentum updates
  o mips: Lasat updates
  o mips: fix SERIAL_TXX9 dependencies

Randy Dunlap:
  o pcmcia: tcic: eleminate deprecated check_region()
  o pcmcia: i82365: use CONFIG_PNP instead of __ISAPNP__
  o pcmcia: i82092: fix checking of return value from request_region
  o [VLAN]: Eliminate gcc warnings with PROC_FS=n
  o [ATALK]: Remove gcc warning when PROC_FS=n
  o gdth: fix module_param() type for 'irq'
  o irq_affinity: fix build when CONFIG_PROC_FS=n

Randy Vinson:
  o ppc32: missing call to ioremap in pci_iomap()

Richard Purdie:
  o [ARM PATCH] 2429/1: PXA Corgi - Bugfix + Cleanups
  o [ARM PATCH] 2428/1: PXA Corgi - Add Backlight Device Definition

Roland Dreier:
  o [SPARC]: Hook up drivers/infiniband/Kconfig to sparc32
  o InfiniBand/core: compat_ioctl conversion minor fixes
  o InfiniBand/mthca: more Arbel Mem-Free support
  o InfiniBand/mthca: implement modifying port attributes
  o InfiniBand/core: fix port capability enums bit order
  o InfiniBand/mthca: test IRQ routing during initialization
  o InfiniBand/ipoib: remove uses of yield()
  o InfiniBand/core: add IsSM userspace support
  o InfiniBand/mthca: remove x86 SSE pessimization
  o InfiniBand/mthca: initialize mutex  earlier
  o infiniband: use LANANA-assigned major in ib_umad

Roland McGrath:
  o PPC64: fix stack alignment for signal handlers

Russ Anderson:
  o [IA64] contig.c save physical address of MCA save area
  o [IA64] increase limit on #pages to isolate for MCA errors

Russell Cattelan:
  o [XFS] Move xfs configs to xfs directory, different flavors of xfs
    have different configs, this way fs/Kconfig does not have to
    changed if different xfs's are swapped in and out

Russell King:
  o [ARM] msr can take immediate constants
  o [ARM] Add warning about building fiq.c with gcc >= 3.4
  o [ARM] Make vector labels consistent with naming scheme
  o [ARM] Replace duplicate sets of vector code with assembler macro
  o [ARM] [1/4] Introduce svc_entry macro for common entry code
  o [ARM] [2/4] Introduce inv_entry macro to contain common entry code
  o [ARM] [3/4] Introduce usr_entry macro to contain common entry code
  o [ARM] [4/4] Reformat assembly code to be consistent
  o [ARM] Improve commenting in entry-armv.S
  o [ARM] Remove adrsvc macro

Rusty Russell:
  o x86: no interrupts from secondary CPUs until officially online
  o Include type information as module info where possible
  o [NETFILTER]: IRC Zero Port Fix
  o [NETFILTER]: Avoid breaking userspace due to tuple change

Serge Hallyn:
  o ftape syntax error
  o audit: handle loginuid through proc

Steffen Klassert:
  o 3c59x ethtool: provide NIC-specific stats

Stephen Hemminger:
  o (1/2) skfddi: initialization
  o (2/2) skfddi: netdev_priv and cast cleanup

Stephen Rothwell:
  o ppc64 iseries: can't remove viocd module when no cdroms

Steven Rostedt:
  o e100 locking up netconsole

Stone Wang:
  o ext2/ext3: block allocator startup fix

Stéphane Eranian:
  o [IA64] entry.S: perfmon psr.pp fix

Terence Ripperda:
  o i386/x86-64: Fix ioremap off by one

Thomas Gleixner:
  o sched: fix preemption race (Core/i386)
  o sched: make use of preempt_schedule_irq() (PPC)
  o sched: make use of preempt_schedule_irq (ARM)

Thomas Graf:
  o [NET]: Set NLM_F_MULTI for neighbour rtnetlink messages to
    userspace

Tom 'spot' Callaway:
  o A BTFIXUP'd fix for pte_read()

Tony Lindgren:
  o [ARM PATCH] 2445/1: Add OMAP serial registers
  o [ARM PATCH] 2446/1: Add OMAP H2 defconfig

Tony Luck:
  o [IA64] two trivial build fixes for generic uniprocessor
  o [IA64] tiger_defconfig: updated for 2.6.11-rc2
  o [IA64] binfmt_elf32.c: BUG if insert_vm_struct fails
  o [IA64] mca.c: delete unused "return_to_sal" label
  o [IA64] clean up ptrace corner cases
  o [IA64] irq handling cleanup
  o [IA64] clean up loose ends from addition of efi_range_is_wc()

Torben Mathiasen:
  o Devices.txt, update with LANANA

Vojtech Pavlik:
  o input: Add support for H-Wheel on Microsoft Explorer and Logitech
    MX USB HID mice.
  o input: Handle -EILSEQ return code in the HID driver completion
    handlers as unplug.
  o input: Always bring the i8042 multiplexer out of multiplexing mode
    before rebooting.
  o input: Enable scancode event generation in the HID driver. This
    should allow changing HID->event mappings (via EVIOCS*) in the
    future and make  debugging easier now.
  o input: Add missing input_sync() calls to atkbd.c
  o input: Only root should be able to set the N_MOUSE line discipline
  o input: Fix MUX mode disabling
  o input: Ignore non-LED events in hid-input hidinput_event(). This
    gets rid
  o input: Fix HID LED mapping. LEDs were ignored because the usage
    value contains the page code in high 16 bits.

Wim Van Sebroeck:
  o [WATCHDOG] i8xx_tco.c-ICH4/6/7-patch

Yoichi Yuasa:
  o mips: fixed conflicting types
  o make used_math SMP-safe
  o mips: generic MIPS updates
  o mips: iomap

Yoshinori Sato:
  o h8300: fix warning
  o h8300: makefile update

Zdenek Pavlas:
  o initramfs: move inode hash table to __initdata

Zou Nanhai:
  o Fix an error in copy_page_range

Zwane Mwaikambo:
  o OProfile: Use profile_pc in oprofile_add_sample
  o OProfile: Support model 4 P4

