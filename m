Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTI1B2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 21:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTI1B2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 21:28:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:2256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262290AbTI1B15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 21:27:57 -0400
Date: Sat, 27 Sep 2003 18:27:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test6
Message-ID: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, too long between test5 and test6 again, so the patch is pretty big.  
Lots of driver updates and architectures fixed, but also lots of merges
from Andrew Morton. Most notably perhaps Con's scheduler changes that have
been discussed extensively and made it into the -mm tree for testing.

This also finally gets one of the last "must-fix" things for 2.6.0: the 
extended 32-bit dev_t support. Courtesy of Al Viro (with a lot of 
prodding and input over the years from Andries). 

arm, s390, ia64, x86-64, and ppc64 updates. USB, pcmcia and i2c stuff. And 
a fair amount of janitorial.

		Linus

----

Summary of changes from v2.6.0-test5 to v2.6.0-test6
============================================

Adam Belay:
  o [PNPBIOS] compilation fix for pnpbios without proc support
  o [PNP] release card devices on probe failure
  o [PNPBIOS] move detection code into core.c
  o [PNP] remove DMA 0 restrictions
  o janitor: remove unneeded includes (isapnp)
  o [ISAPNP] remove unused isapnp_allow_dma0 modparam
  o [PNPBIOS] return proper error codes on init failure
  o [PNPBIOS] move some more functions to local include file

Adam Radford:
  o 3ware driver update

Adrian Bunk:
  o ATM Ambassador no longer BROKEN_ON_SMP
  o input: Fix Kconfig KEYBOARD_ATKBD when SERIO is modular
  o fix sbni.c compile with gcc 3.3
  o USB: fix USB_MOUSE help text
  o select MII
  o select ZLIB_{IN,DE}FLATE

Alan Stern:
  o USB: Use num_altsetting in usbnet and usbtest
  o USB: Changes to core/config.c (1 - 9)
  o USB: improve debugging logging during suspend and resume
  o (as84) Small fixup for SCSI proc code

Albert Cahalan:
  o fix for hidden-task problem
  o fix CONFIG_SECURE trouble in thread-aware procfs
  o use CLONE_KERNEL
  o shared signals require shared VM

Alexander Viro:
  o ps2esdi broken
  o prepare for 32-bit dev_t: reiserfs/procfs.c
  o prepare for 32-bit dev_t: drm debugging printks
  o prepare for 32-bit dev_t: XFS
  o prepare for 32-bit dev_t: tty usage
  o prepare for 32-bit dev_t: NFS
  o prepare for 32-bit dev_t: JFS
  o prepare for 32-bit dev_t: jffs2 cleanups
  o prepare for 32-bit dev_t: md.c cleanups
  o prepare for 32-bit dev_t: dm-ioctl-*.c
  o prepare for 32-bit dev_t: misc cleanups
  o prepare for 32-bit dev_t: mknod()/ustat()
  o prepare for 32-bit dev_t: loop.c
  o prepare for 32-bit dev_t: CODA
  o prepare for 32-bit dev_t: stat()
  o 32-bit dev_t: internal use
  o 32-bit dev_t: switch-over
  o 32-bit dev_t fixups
  o 32-bit dev_t fallout: mips/kernel/sysirix.c
  o 32-bit dev_t: md fallout
  o Avoid /proc/{ioports,iomem} truncation
  o ppc64 typo fix (kudos to Anton)

Alexey Dobriyan:
  o USB: Remove setting TASK_RUNNING after schedule_timeout in
    /drivers/usb/

Amir Noam:
  o [bonding 2.6] fix 802.3ad long fail over with high UDP Tx stress
  o [bonding 2.6] fix load balance problem with high UDP Tx stress
  o [bonding 2.6] fix ARP monitoring bug
  o [bonding 2.6] fix kernel panic when optional feature used
  o [bonding 2.6] fix change active command
  o [bonding 2.6] fix OOPS in bonding driver, when removing primary
  o [bonding 2.6] embed stats struct inside bonding private struct
  o [bonding 2.6] fix error handling in init code
  o [bonding 2.6] make each bond device use its own /proc entry
  o [bonding 2.6] misc fixes: missing include, typos, comments
  o [bonding 2.6] consolidate change_active operations
  o [bonding 2.6] fix assign_current_slave
  o [bonding 2.6] Decouple promiscuous handling from multicast mode
    setting
  o [bonding 2.6] Add support for changing HW address and MTU
  o [bonding 2.6] Add support for changing HW address in ALB/TLB modes
  o [bonding 2.6] Consolidate /proc code, add CHANGENAME handler
  o [bonding 2.6] Enhance netdev notification handling
  o [bonding 2.6] Add missing free_netdev()
  o [bonding 2.6] Fix ipx_hdr compile error
  o [bonding] Convert /proc to seq_file

Andi Kleen:
  o x86-64 merge
  o Minor K8 fix for oprofile
  o Pad statvfs in compat layer
  o Generalize 32bit emulation support in MPT fusion
  o Another x86-64 merge - make it boot again
  o Another small x86-64 merge

Andrej Borsenkow:
  o I2C: sysfs sensor nameing inconsistency

Andrew Morton:
  o [PCMCIA] RL5C4XX_16BIT_MEM_0 was wrong
  o s/spin_lock_irqrestore/spin_unlock_irqrestore
  o calibrate_tsc() fix and consolidation
  o Initialise devfs_name in various block drivers
  o monolitic_clock, timer_{tsc,hpet} and CPUFREQ
  o dac960 devfs_name initialisation fix
  o compiler warning fixes for DAC960 on alpha
  o Move ikconfig to /proc/config.gz
  o reiserfs direct-IO support
  o Fix imm.c again
  o make selinux enable param config option, enabled by
  o sound: remove duplicate includes
  o remove duplicate includes in kernel/
  o Handle NR_CPUS overflow
  o ppp devfs oops fix
  o d_delete-d_lookup race fix
  o ia32 idle using PNI monitor/mwait
  o remap file pages MAP_NONBLOCK fix
  o install_page pte use-after-unmap fix
  o really use english date in version string
  o tidy up lib/inflate.c error messages
  o ext3: remove debug code
  o mwave locking fixes
  o fix Summit srat.h includes
  o Reduce random driver lock contention
  o sys_fadvise needs asmlinkage
  o CPU scheduler CAN_MIGRATE fix
  o [NET]: Remove spurious TASK_RUNNING setting after
    schedule_timeout()
  o Fix imm.c again
  o e1000 bug
  o procfs build fix for older gcc
  o ECC support
  o real-time enhanced page allocator and throttling
  o Fix setpgid and threads
  o reiserfs: large file 32/64-bit truncation fix
  o Overflow check for i386 assign_irq_vector
  o mtrr warning fix w/o proc_fs
  o NLS: Remove the nls modules for only alias
  o NLS: remove emacs metadata
  o scheduler infrastructure
  o sched_clock() for ppc, ppc64, x86_64 and sparc64
  o CPU scheduler balancing fix
  o CPU scheduler interactivity changes
  o might_sleep diagnostics
  o Move slab objects to the end of the real allocation
  o Remove Documentation/smp.tex
  o AGP warning fix
  o mwave char/Kconfig fix
  o any_online_cpu fix
  o allow x86 NUMA architecture detection to fail
  o misc fixes
  o reiserfs: add checks from 2.4 into 2.5
  o remove duplicate SOUND_RME96XX option
  o istallion: use schedule_work
  o file locking memory leak
  o fix incorrect argv[0] for init
  o ens1370 PCI driver naming fix
  o Summit sub-arch: Make logical IDs independent of BIOS numbering
    scheme
  o wanXL serial card driver
  o floppy cleanup timers/resources on unload
  o remove /proc/config_build_info
  o access_ok is likely
  o Update Documentation/block/biodoc.txt
  o Fix typo in scripts/postmod.c
  o Export new char dev functions
  o hangcheck compile fix
  o NCR5380 timeout fix
  o Incorrect value for SIGRTMAX
  o x445: setup_ioapic_ids_from_mpc fix
  o deadline insert_here fix
  o bio_dirty_fn() page leak fix
  o Speed up direct-io hugetlbpage handling
  o Handle init_new_context failures
  o Fix sem_lock deadlock
  o zoran driver documentation fix
  o AS oops fix
  o kill superflous kdev_t.h inclusions
  o move some more initializations out of drivers/char/mem.c
  o rio.c: remove TWO_ZERO
  o mlock error handling fix
  o fix cciss memory leaks
  o ia64 sched_clock() implementation
  o misc fixes
  o smbfs NLS fix
  o slab: hexdump structures when things go wrong
  o Try harder in IRQ context before falling back to ksoftirqd
  o mark devfs obsolete
  o kill some leftovers from the big sysrq syncing rewrite
  o add -Wdeclaration-after-statement
  o disallow utime{s}() on immutable or append-only files
  o switch remaining serial drivers to initcalls
  o misc fixes
  o Hugetlb FS quota accounting problem
  o make CONFIG_HUGETLB_PAGE mirror CONFIG_HUGETLBFS
  o setuid clearing fix
  o remove CONFIG_SERIAL_21285_OLD
  o DAC960: remove redundant (and uninitialized)
  o wanxl compile and warning fixes
  o use "normalized" syntax for lgdt/lidt
  o asm/softirq.h is dead
  o SELinux leak fixes
  o do_brk() bounds checking
  o fix MD "bio too big" errors

Andries E. Brouwer:
  o compilation fix ufs
  o sparse fix sysctl, eventpoll, cpufreq, xattr, kcore,
    ext2_readlink, reboot, proc/misc, fat/file.c, kmsg,
    proc/generic
  o another keyboard problem solved
  o fix keycode for rctrl in scancode set 3
  o input: Fix Set3 keycode for right control in atkbd.c

Andy Grover:
  o ACPI maintainer change

Angelo Dell'Aera:
  o saa9730 (minor revision)

Anton Altaparmakov:
  o Adrian Bunk: Postfix an NTFS constant that is too big for an int
    with ULL
  o NTFS: Update documentation for Linux kernel 2.6

Anton Blanchard:
  o ppc64: make install target from Dave Hansen
  o ppc64: Remove find_pci_device_OFnode prototype, from Nathan Lynch
  o ppc64: iseries soft disable and do_page_fault fixes from Ben
    Herrenschmidt
  o ppc64: xics fix for I/O slot deconfigure, from Linda Xie
  o ppc64: fixes for pci_name() changes
  o ppc64: Fix NUMA compile after cpu bitmasks merge
  o ppc64: remove broken xmon h option
  o ppc64: semaphore fixes based on report by ever watchful Olaf Hering
  o ppc64: remove interrupt stacks which broke when the thread info
    stuff went in
  o ppc64: defconfig update
  o ppc64: remove some unused entries in the paca
  o ppc64: make install fixes from Dave Hansen
  o ppc64: fix gcc 3.3 compile
  o ppc64: Fix 3rd and 4th serial port from Olof Johansson
  o ppc64: add missing IPC_64 mask, from sparc64 and add some compat
    types
  o ppc64: Fix some error return paths in sys_ipc
  o ppc64: add might_sleep() to uaccess functions
  o ppc64: register_ioctl32_conversion defined twice, fix from Olaf
    Hering
  o ppc64: rtas rtc fixes from Todd Inglett
  o ppc64: export node_data and numa_memory_lookup_table
  o ppc64: defconfig changes
  o ppc64: discard exit sections
  o ppc64: fix bogus NR_CPUS*2 struct in xics.c
  o ppc64: Update unhandled irq code to match x86
  o ppc64: start using kallsyms now its compiled in by default
  o ppc64: convert xmon to use kallsyms now its compiled in by default
  o ppc64: ppc64 Hugepage support from David Gibson
  o ppc64: forgot to add the guts of hugetlb support
  o ppc64: hugetlb fixes for LPAR and numa hugetlb support
  o ppc64: catch bad ioctl size at compile time, from x86
  o ppc64: Give us a generic local.h until we have atomic64
  o fix oops in hvc_console
  o Fix initramfs permissions on directories and special files
  o quieten initramfs and fix /dev permissions
  o serialize bus scanning

Armin Schindler:
  o eicon ISDN driver: memory attach
  o eicon ISDN driver: capi code fix
  o eicon ISDN driver: debug
  o eicon ISDN driver: list handling
  o eicon ISDN driver: endianess
  o eicon ISDN driver: Kernelconfig
  o eicon ISDN driver: C comments
  o eicon ISDN driver: update
  o Eicon ISDN driver: removed __devinitdata from pci_device_id
  o Eicon ISDN driver: remove old devfs_handle

Arnaldo Carvalho de Melo:
  o [NETFILTER]: Fix typo in recent ip_input.c changes
  o LLC: introduce llc_type_handlers
  o LLC: move llc_decode_pdu_type to llc_mac
  o LLC: move llc_conn_handler and llc_sap_handler out of llc_mac
  o LLC: remove another silly net 4.0 banner
  o LLC: move the connection related functions to llc_conn
  o LLC: move sap functions to llc_sap
  o LLC: move the sockets release function outside of llc_sap_close
  o LLC: move llc_build_and_send_ui_pkt to llc_sap
  o LLC: move llc_lookup_dgram to llc_sap
  o LLC: move the pdu routines needed by the upcoming llc_core to
    llc_pdu.h
  o LLC: implement llc_add_pack/llc_remove_pack
  o LLC: split llc into llc_core and llc2 modules
  o LLC: add some unlikely wrappings in llc_mac
  o LLC: create llc_output and move lan_hdrs_init to it
  o LLC: create a register interface for llc_station_rcv
  o LLC: rename llc_mac.c to llc_input.c, net/llc_mac.h to net/llc.h
  o LLC: trim down llc_core to the very basic support needed by IPX
    et all
  o LLC: rename llc_main.[ch] to llc_station.[ch]
  o LLC: reorganize llc_station.c to kill useless static prototypes
  o LLC: consolidate the LLC station component into llc_station.c
  o LLC: llc_station.h is not useful anymore, kill it
  o LLC: use list_for_each_entry in llc_sap_find
  o LLC: remove unneeded EXPORT_SYMBOLs from llc_sap

Arun Sharma:
  o ia64: MINSIGSTKSZ on ia32

Bart De Schuymer:
  o [NETFILTER]: Fix parisc64 alignment problems in ipt_physdev.c

Benjamin Herrenschmidt:
  o IDE: Fix request handling with ide-default & ATAPI
  o IDE: Fix Power Management request race on resume
  o dmasound update from Christoph Hellwig
  o Support for POWER4 & GPUL (G5) CPUs
  o Fix cputable.c build (missing commas)

Bernardo Innocenti:
  o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h

Bjorn Helgaas:
  o ia64: clean up acpi_boot_init()
  o ia64: trivial sba_iommu patch
  o ia64: bail out of sba_init() if no hardware found

Brian Gerst:
  o lp.c module alias
  o select CRC32

Chas Williams:
  o [ATM]: Remove unnecessary GFP_ATOMIC allocation
  o [ATM]: Fix build failure with ATM_BR2684_IPFILTER enabled
  o [ATM]: seq_file for /proc/net/atm (devices)
  o [ATM]: exporting llc_oui[] isn't worth it
  o [ATM]: Fix race between modifying entry->vccs and
    clip_start_xmit()
  o [ATM]: Correct way to prevent module unload
  o [ATM]: [firestream] Allow module refcounting
  o [ATM]: [idt77252] Get rid of MOD_INC/MOD_DEC
  o [ATM]: [lanai] Get rid of MOD_INC/MOD_DEC
  o [ATM]: [uPD98402] Convert to new-style module
  o [ATM]: [uPD98402] Exported symbols should not be marked __init
  o [ATM]: If CLIP is not enabled, try_atm_clp_ops() should always fail
  o [ATM]: [ioctl][1/8] Move vcc_ioctl() to ioctl.c
  o [ATM]: [ioctl][2/8] Add registration functions
  o [ATM]: [ioctl][3/8] Use new code for pppoatm and br2684
  o [ATM]: [ioctl][4/8] Use new code for mpoa
  o [ATM]: [ioctl][5/8] Change ncc clip info handling
  o [ATM]: [ioctl][6/8] Move clip seq_file ops to clip.c
  o [ATM]: [ioctl][7/8] Use new code for clip
  o [ATM]: [ioctl][8/8] Use new code for atmtcp
  o [ATM]: Move lan seq_file ops to lec.c
  o [ATM]: Use dev_get_by_name() instea of atm_lane_ops->get_lec()
  o [ATM]: Use new ioctl code for lane

Chris Wright:
  o update credits
  o Add LSM maintainer entry
  o LSM comment fixup
  o root_plug fixup
  o [IPV4]: Use cpu_relax() in ipconfig.c
  o [netdrvr] use cpu_relax() in busy loop, or mdelay instead of busy loop
  o Memory leak in ixj_pcmcia driver
  o USB: Memory Leaks on Error Paths of usb-midi

Christoph Hellwig:
  o [PCMCIA] kill flush_stale_links
  o [PCMCIA] kill dead DEV_STALE_* codepathes in non-networking drivers
  o [NET]: Kill a dead extern in net/core/dev.c
  o change sdev.access_count to an atomic_t
  o kill highmem_io leftover
  o kill use_blk_tcq template flag
  o kill scsi_cmnd.flags
  o bring lost 2.5 changes to qla1280 back
  o tiny zalon cleanups
  o helper for device list traversal
  o kill last users of the ScsiLun typedef
  o small lasi700 update
  o move some constants around
  o add back the missing ->slave_destroy call
  o handle failure when starting the eh thread
  o switch command completion queue to per-cpu data
  o [NET]: Consolidate ax25/isdn/bluetooth Kconfig inclusion
  o fix qla1280 compiles
  o ia64: kill SN kdba_io.c
  o ia64: kill sn2 inventory stubs
  o ia64: kill dead SN code from ml_iograph.c
  o ia64: kill snia_pciio_*
  o ia64: simplify and speedup SN2 dma mapping
  o ia64: sn_ML_intr.c is a freakin mess
  o ia64: simplify SN2 interrupt allocation
  o ia64: remove CONFIG_PCI ifdefs in SN2 code

Daniel A. Nobuto:
  o USB: make pdfdocs problem

Daniel Drake:
  o USB: Debug code fixes for vicam
  o USB: Debug code fixes for usblp
  o USB: Debug code fixes for dabusb

Daniele Bellucci:
  o USB: Minor cleanups in usb_serial_probe

Dave Jones:
  o [AGPGART] Mention Intel 875 support in Kconfig
  o [AGPGART] Fix ATI GART for IGP9100/R300 From the folks at ATI. Some
    chips hang with this flush.
  o [AGPGART] Remove unreferenced extern
  o [CPUFREQ] Merge speedstep-smi driver
  o [CPUFREQ] remove $Id$ tags, update filenames
  o [CPUFREQ] add cpufreq_update_policy()
  o [IPV6]: Fix non-CONFIG_PROC_FS build
  o [CPUFREQ] CodingStyle fixes for speedstep-smi
  o [CPUFREQ] Don't print out speedstep stuff on non-Intel CPUs
  o [CPUFREQ] use PFX macro in common printk's
  o [CPUFREQ] Fix up debug printk formatting string in speedstep-smi
  o [AGPGART] Fix silly logic bug in modular AMD64 GART driver
  o [AGPGART] Missing prefixes in printk's
  o [AGPGART] Fix missing/bogus includes
  o [CPUFREQ] Add missing config.h includes
  o [AGPGART] Add HP AGP 8x bridge and fix ACPI claim The following
    patch to the HP ZX1 GART driver
  o [AGPGART] Fix module alias
  o [CPUFREQ] Read MSRs before trying to use them in powernow-k7 Very
    silly bug spotted by Ducrot Bruno
  o [CPUFREQ] We need to set SGTC when we change powernow-k7 voltage
  o [CPUFREQ] Work around buggy powernow-k7 BIOSes with low settling
    times
  o [CPUFREQ] Powernow-k7 latency timer needs to be in values of 10ns
  o [CPUFREQ] Explicitly disable scaling we don't need in powernow-k7
    The VIDC/FIDC controls could have been left at 1 from a previous
    call to

Dave Kleikamp:
  o JFS: Fix rampant data corruption

David Brownell:
  o USB: usb/gadget/Kconfig, use right PXA2xx symbols
  o USB: psdocs fails for usbgadget
  o USB: usb "ether" net gadget
  o USB: usb gadgetfs updates
  o USB: usb_set_configuration() rework (v2)

David Howells:
  o RxRPC update
  o AFS update

David Mosberger:
  o ia64: Drop unnecessary fadvise64_64() bloat (it isn't needed on
    64-bit platforms).
  o ia64: Document the typo that made it into the definition of
    MINSTKSZ (last two numbers got transposed).  Thanks to Arun Sharma
    for finding this.  New glibc's will have the value corrected, but
    we leave the kernel at the old (bogus) value to retain backwards-
    compatibility (and while a strange value, the old value works just
    fine).
  o ia64: Finnish adding ECC support.  Based on patch by Suresh Siddah
  o ia64: Fix asm-ia64/acpi.h typo & name-collision
  o ia64: Direct sys_fadvise64() to sys_fadvise64_64()
  o ia64: Fix things so that they compile with the latest GCC 3.4,
    which optimize away static variables with no compiler-visible use.
  o ia64: Drop unnecessary version check in sba_iommu.c
  o ia64: Re-enable /proc/sal support.  Bug reported by Stephane
    Eranian, patch by Jesse Barnes.
  o ia64: In <asm-ia64/param.h>, do not include <linux/config.h>
    outside the #ifdef __KERNEL__ bracket.  Doing so pollutes the user-
    level namespace.  Bug report & proposed fix by GOTO Masanori.
  o ia64: Control /proc/bus/mckinley/zx1 via separate SBA_PROC_FS macro
    and turn SBA_PROC_FS off by default (it's too much of a scalability
    bottleneck).
  o ia64: Based on patch by Jess Barnes: split up memory-initialization
    from kernel/setup.c into two separate files: mm/{dis,contig}.c to
    handle contiguous vs. discontiguous memory layouts.
  o ia64: Improve comment for reserve_memory()
  o ia64: Mark access_ok() as likely to succeed (as is done in x86
    tree)
  o ia64: Patch by Christoph Hellwig: Kill two SN headers never
    references in the current tree.
  o ia64: Patch by Christoph Hellwig: None of the exported symbols is
    referenced by a module, even more the file doesn't compile when
    CONFIG_IA64_SGI_SN_DEBUG is set.
  o ia64: Patch by Christoph Hellwig: SN2 stopped abusing devfs in 2.5,
    clean up the leftovers.
  o ia64: Patch by Christoph Hellwig: kill .hcl entry in SN hwgfs

David S. Miller:
  o [SPARC64]: Update defconfig
  o [SPARC64]: Make sure cpu_data[0].udelay_val gets setup on non-SMP
    (found by bde@nwlink.com)
  o [UDP]: In udp_{v6_}flush_pending_frames, reset up->len too
  o [NET]: Increase ethernet tx_queue_len to 1000
  o [IPV4]: Fix skb leak in igmp.c
  o [LLC]: llc_core.c needs linux/init.h
  o [I2C]: Several drivers forget to include asm/io.h
  o [NET]: Unlink qdiscs in qdisc_destroy even when CONFIG_NET_SCHED is
    not enabled
  o [SPARC64]: Update defconfig
  o [SPARC64]: Handle WDISP19 relocations in modules
  o [ATM]: atmtcp.c needs linux/init.h
  o [ATM]: Add struct net_bridge decl to net/atm/common.c
  o [ATM]: Fix atm_mpoa_disp_qos() second arg to be ssize_t
  o [IPV4]: Use correct ptrdiff_t printf format in ipmr.c
  o [IPVS]: Print out __u64 properly in ip_vs_ctl.c

David T. Hollis:
  o USB: ethtool_ops and ax8817x fixes for usbnet
  o USB: Remove ax8817x driver

David Woodhouse:
  o [BLUETOOTH]: Fix bug in set_sk_owner() changes
  o [BLUETOOTH]: Add missing owner to bnep_sock_family_ops

Dean Roehrich:
  o [XFS] Change dm_send_namesp_event to take vnode ptrs rather than
    bhv ptrs

Dennis Jørgensen:
  o [IPV4]: Fix wrong IP address in icmp.c error message

Dmitry Torokhov:
  o serio.c
  o input: Fix multibutton handling in Synaptics.c (nExtBtn > 8 case)
  o input: Synaptics code cleanups

Duncan Sands:
  o USB speedtouch: use multiple urbs by default
  o USB: New email address for duncan
  o USB speedtouch: neater sanity check
  o USB speedtouch: bump the version number

Eric Sandeen:
  o [XFS] remove doubly-included header files
  o [XFS] Re-work xfs stats macros to support per-cpu data
  o [XFS] Update sysctls - use ints, not ulongs, and show pagebuf
    values in jiffies like everybody else

Erlend Aasland:
  o [CRYPTO]: Add alg. type to /proc/crypto output

Eyal Lebedinsky:
  o wl3501 with old compiler

Felipe Damasio:
  o slip.c: current state cleanup
  o [NET]: Kill unneded version.h in net/sched
  o Unneeded memory barrier in net/irda code
  o Memory leak in scsi_debug found by checker
  o Memory leak in NCR_Q720 found by checker

François Romieu:
  o (1/4) sdla - move out of Space.c

Geert Uytterhoeven:
  o in2000 warning

Greg Kroah-Hartman:
  o PCI hotplug: fix up a bunch of copyrights that were incorrectly
    declared
  o I2C: added new id for Radeon driver
  o PCI: remove compiler warning from previous new_id patch
  o PCI: fix up some pci drivers that had marked their probe functions
    with __init
  o I2C: remove some usages of i2c_adapter.id as they are not used
  o I2C: add the i2c-sis5595 i2c bus driver
  o I2C: add the i2c-sis630 i2c bus driver
  o I2C: add the i2c-via i2c bus driver
  o I2C: clean up the i2c bus Kconfig menu and help texts
  o I2C: turn off debugging on the new sis i2c bus drivers
  o USB: fix oops when trying to suspend and resume
  o USB: fix oops in ipaq driver
  o USB: fix up missing </para> in usb documentation
  o USB: make sure we never reference a usbserial port after it has
    been unregistered
  o USB: unusual device fixup for the Y-E floppy drive
  o I2C: add the i2c-i810 i2c bus driver
  o I2C: add the i2c-savage4 i2c bus driver
  o I2C: add the i2c-voodoo3 i2c bus driver
  o I2C: clean up the i2c chips Kconfig logic and help information
  o I2C: clean up the drivers/i2c/Kconfig file
  o I2C: move i2c-prosavage.c driver to drivers/i2c/busses where it
    belongs
  o I2C: clean up i2c-prosavage.c driver
  o I2C: fix up dependancies in the i2c/busses/Kconfig file
  o I2C: move the i2c-philips-par driver to drivers/i2c/busses
  o I2C: clean up i2c-philips-par.c driver a bit
  o I2C: move i2c-elv.c driver to drivers/i2c/busses
  o I2C: clean up the i2c-elv.c driver a bit
  o I2C: move i2c-elektor.c driver to drivers/i2c/busses/
  o I2C: move i2c-velleman driver to drivers/i2c/busses
  o I2C: move the scx200* drivers to drivers/i2c/busses
  o I2C: move the remaining i2c bus drivers to drivers/i2c/busses
  o I2C: remove check_region usage and warning from i2c-sensor
  o I2C: remove I2C_VERSION and I2C_DATE as they make no sense in the
    kernel tree
  o I2C: remove the isa address check alltogether
  o I2C: move the i2c algorithm drivers to drivers/i2c/algos
  o I2C: add eeprom i2c chip driver
  o I2C: remove unneeded #defines in the eeprom chip driver
  o USB: remove misleading FIXME comment added by previous patch
  o USB: i was wrong, clean up some extra refcounts that are no longer
    needed

Guillaume Morin:
  o fix cpu_test_and_set() on UP

Harald Welte:
  o [NETFILTER]: Clear nf_debug in ipsec tunnel case
  o [NETFILTER]: Use u16 for port numbers

Henning Meier-Geinitz:
  o USB scanner driver: use static declarations
  o USB scanner driver: report back return codes
  o USB scanner driver: balancing usb_register_dev/usb_deregister_dev
  o USB scanner driver: new device ids
  o USB scanner driver: added USB_CLASS_CDC_DATA

Herbert Xu:
  o [XFRM]: Fix ALLOC_SPI for IPCOMP

Hideaki Yoshifuji:
  o [NET]: Various /proc/net/* files may drop some data
  o [NET]: /proc/net/if_inet6 may drop some data
  o [NET]: Clean up /proc/net/{anycast6/igmp6}
  o [NET]: Use proc_net_fops_create() and proc_net_remove() in net/core
  o [NET]: Use proc_net_fops_create() and proc_net_remove() in net/ipv4
  o [NET]: Use proc_net_fops_create() and proc_net_remove() in net/ipv6
  o [IPV4]: Convert /proc/net/pnp to seq_file
  o [NET]: Use proc_net_fops_create() for /proc/net/wireless

Hirofumi Ogawa:
  o DEVICE_NAME_SIZE/_HALF removal (I2C stuff)
  o DEVICE_NAME_SIZE/_HALF removal (I2C related, but v4l stuff)
  o DEVICE_NAME_SIZE/_HALF removal (I2C related, but fb stuff)
  o [NETFILTER]: Fix typoe in ip_nat_tftp.c

Holger Freyther:
  o [ARM PATCH] 1653/1: Simpad Flash Partition resubmit
  o [ARM PATCH] 1654/1: Simpad PCMCIA resubmit
  o [ARM PATCH] 1656/1: Simpad board update to make it work

Holger Schurig:
  o [ARM] Add sched_clock()

Ian Abbott:
  o USB: ftdi_sio - new vid/pid for OCT US101 USB to RS-232 converter

Jamal Hadi Salim:
  o [NET]: Make pfifo_fast actually report statistics

James Bottomley:
  o .del-sym53c8xx.c~180cda83f20a4355
  o fix smc-mca cleanup breakage
  o Remove killed SCSI_IOCTL_TAGGED_{ENABLE|DISABLE} from
    compat_ioctl.h
  o scsi_mid_low_api.txt update

Jan Harkes:
  o Coda updates

Jaroslav Kysela:
  o ALSA CVS updates
    - clean up the usage of the size variable and removes size1.
    - define AD198x bits.
    - add descriptions for whole-frag and no-silence commands.
    - use dxs_support=3 (48k fixed) as default, since there are so many problems
      with dxs_support=0.
    - add the support for stereo mute switches on AD198x.
    - initialize tumbler/snapper audio via gpio before i2c initialization.
    - add check of DXS supports (so far, empty).
    - add detection of revision of ALC650 chip
    - get_page() fix
    - fix the SPDIF bit on aureon boards.
    - set 48k only for the sample rate of SPDIF on nForce.
    - kill of not-required version.h inclusion
    - Remove duplicated include
    - fix buffer overlap on FX8010 PCM.
    - Fix hwdep hotplug problem
    - Use try_module_get() and module_put() to block the toplevel module
    - Fix returned error code in the release() callback
    etc

Javier Achirica:
  o [wireless airo] fix PCI probe
  o [wireless airo] Fix MIC support with CryptoAPI

Jeff Garzik:
  o Fix netdev close
  o [sound/oss i810_audio] sync with 2.4
  o [docbook] fix embedded filename in kernel-api docbook doc
  o [docbook] fix docbook build, by closing several unclosed tags
  o [BK] "bk ignore" a ton of docbook-generated output
  o [BK] "bk ignore" generated files that appeared during "make
    allyesconfig"

Jens Axboe:
  o Fix blk_stop_queue bug
  o get rid of warning in gscd
  o blk API update (and bug fix) to CDU535 cdrom driver
  o ide-cd capacity "bug"
  o shared block queue tag map
  o io scheduler barrier fix
  o ide-cd cgc command bug
  o cdrom memory leaks

Jes Sorensen:
  o ia64: remove unused sn2 header files
  o ia64: small sn2 cleanup
  o ia64: sn2 header file cleanup
  o ia64: include/asm-ia64/sn/router.h cleanup
  o ia64: fix for include/asm-ia64/acpi.h

Jesse Barnes:
  o ia64: misc. sn2 updates
  o ia64: fix current usage in sn2 code
  o ia64: cpumask_t fixes
  o ia64: update Kconfig comment for NR_CPUS
  o ia64: turn off SLIT debugging
  o ia64: protect PAL mapping printk with EFI_DEBUG

Jochen Friedrich:
  o [tokenring] fix breakage in proteon, skisa

Joe Perches:
  o Add SEQ_START_TOKEN #define to seq_file.h
  o Use SEQ_START_TOKEN in drivers/net/* [1/3]
  o Use SEQ_START_TOKEN in include/net/* [2/3]
  o Use SEQ_START_TOKEN in include/net/* [3/3]
  o Fix SEQ_START_TOKEN typo
  o [NET]: Add and use PKT_CAN_SHARE_SKB instead of (void *) 1

John Levon:
  o [NET]: SEQ_START_TOKEN for af_netlink.c

Jun Komuro:
  o [netdrvr] build fixes
  o [netdrvr smc91c92_cs] select proper bank for MII registers

Keith M. Wesolowski:
  o [SPARC32]: Ignore btfixups in .text.exit

Kevin Corry:
  o dm: Use new format_dev_t macro
  o dm: Drop extra table ref-count
  o dm: Move retrieve_status function
  o dm: Return table status for dev_wait
  o dm: Message fix in dm-linear
  o dm: Support arbitrary number of target params

Kevin P. Fleming:
  o [NET]: Make netdevice.h more userspace friendly

Krishna Kumar:
  o [IPV6]: Export devconf device settings via netlink

Kumar Gala:
  o Added "user64" versions of the user access functions that allow
    modification of 64-bit data.
  o PPC32; Added "user64" versions of the user access functions that
    allow modification of 64-bit data.

Leonard Norrgard:
  o Kconfig

Linus Torvalds:
  o Fix CONFIG_PCMCIA_WL3501 with older compilers
  o Make rxrpc use SEQ_START_TOKEN
  o From Stephen Hemminger: we were trying to cast an "unsigned short"
    to a pointer. That was a typo.
  o Fix ray_cs for new interrupt handling
  o Avoid type warning for bit operation in atkbd.c
  o Don't ask about SERIO selection - let Kconfig select it
    automatically as needed.
  o Disable forced keyrelease in atkbd driver. It breaks modifier keys
  o Remove incorrect and unnecessary definition of "errno" that causes
    link-time duplicate symbol errors.
  o sd.c: be more cautious in asking for mode page 8 data,
    sanity-checking the information more carefully. 
  o DRI CVS merge: add DRM(calloc)() function, and remove unnecessary
    TLB flush after vmap.
  o DRI CVS merge: whitespace cleanups for i810_dma.c
  o DRI CVS merge: r128 driver private function cleanup
  o DRI CVS merge: radeon driver update
  o DRI CVS merge: SiS driver updates from Eric Anholt
  o DRI CVS merge: portability defines
  o Avoid warning about non-newline whitespace at end of file
  o Include proper <linux/device.h> for chrdev alias
  o Fix up DRI CVS merge of sis driver with CONFIG_FB_SIS
  o Avoid compiler warning by using the proper types in "min()"
  o Mark PM_DISK_PARTITION as depending on PM_DISK, so as to avoid an
    annoying nonsense configuration question.
  o Revert NDEBUG move in NCR5380 - g_NCR5380 includes the file (ugh)
    and wants 'phases'

Luiz Capitulino:
  o input: Fix a warning in input.c when CONFIG_PROC_FS is not set
  o input: Remove a not necessary #ifdef CONFIG_PROC_FS/#endif in
    input.c

Maksim Krasnyanskiy:
  o Bluetooth: RFCOMM must send MSC when DLC was opened by SABM
  o [Bluetooth] Fix RFCOMM C/R and Direction bits handling
  o [Bluetooth] Add support for SO_LINGER to L2CAP, RFCOMM and SCO
    sockets
  o [Bluetooth] L2CAP qualification spec mandates sending additional
    config request if we receive config response with unacceptable
    parameters error code. 
  o [Bluetooth] Convert BNEP protocol to dynamic allocation of network
    devices

Maneesh Soni:
  o [NET]: Remove attribute group when unregistering netdev from sysfs

Marc Zyngier:
  o depca update

Marcel Holtmann:
  o [Bluetooth] Send correct RPN response for accepted values
  o [Bluetooth] Set EA bit for V.24 signals parameter
  o [Bluetooth] Handle bit rate in remote port negotiation
  o [Bluetooth] Quirk for devices with no ISOC endpoints
  o [Bluetooth] Make READ_TRANSMIT_POWER_LEVEL available for normal
    users
  o [Bluetooth] Support for inquiry with unlimited responses
  o [Bluetooth] Handle command complete event for inquiry cancel
  o [Bluetooth] Update the maintainer entries for the Bluetooth
    subsystem
  o [Bluetooth] Add tiocmget() and tiocmset() routines to RFCOMM TTY
  o [Bluetooth] Add support for FCon and FCoff flow control commands

Marcelo Tosatti:
  o WM9712 suspend/resume nopop

Mark Studebaker:
  o I2C: i2c-isa functionality

Martin Schlemmer:
  o I2C: Fix conversion from milli volts in store_in_reg() for
    w83781d.c

Martin Schwidefsky:
  o s390: arch fixes
  o s390: common i/o layer
  o s390: 31 bit compat
  o s390: micro optimizations
  o s390: system tick misaccounting
  o s390: system call restart bug
  o s390: sysfs_create_group
  o s390: Kconfig
  o s390: xpram driver
  o s390: dasd driver
  o s390: dasd partitions
  o s390: tape driver
  o s390: ctc driver
  o s390: iucv driver
  o s390: lcs driver
  o s390: qeth driver
  o s390: vt220 console
  o s390: documentation
  o s390: remove outdated code

Matt Domsch:
  o PCI: make new_id rely on CONFIG_HOTPLUG
  o s/Dell Computer Corporation/Dell Inc./

Matt Mackall:
  o [netdrvr tlan] netif_carrier_* support

Matt Porter:
  o I2C: New PPC4xx I2C driver

Matthew Chapman:
  o ia64: Fix "nosmp" breakage from cpumask patch

Matthew Wilcox:
  o sym53c8xx driver 2.1.18
  o PA-RISC update for 2.6.0-test5
  o Fill in ELF OSABI in ELF headers
  o 1GB stack size limit on PA-RISC
  o fs/exec.c whitespace cleanups
  o interrupt.h needs kernel.h
  o sym53c8xx 2.1.18b
  o zalon & ncr53c8xx cleanups
  o Move EISA_bus
  o [NETFILTER]: Use net/checksum.h instead of asm/checksum.h
  o Kill off sym1

Maximilian Attems:
  o [NETFILTER]: Eliminate duplicate definition in ip_nat.h

Meelis Roos:
  o [SPARC64]: BUG on positive addresses in vga.h

Michal Ludvig:
  o [IPV4]: Fix GRE tunnel device init

Mike Christie:
  o fixes an ide-scsi oops in 2.6-test5

Mirko Lindner:
  o [netdrvr sk98lin] Remove useless configure options
  o [netdrvr sk98lin] small updates
  o [netdrvr sk98lin] update readme, remove old changelog
  o [netdrvr sk98lin] small fixes
  o [netdrvr sk98lin] bump version number
  o [netdrvr sk98lin] fix leaks on error, and related cleanups

Mitchell Blank Jr.:
  o [NET]: Tiny af_packet.c cleanup
  o [SPARC]: Make atomic_read() take const

Nathan Scott:
  o [XFS] Fix a case where we could issue an unwritten extent buffer
    for IO without it being locked, an instant BUG trigger in the block
    layer
  o [XFS] Fix a harmless typo - we were using a pagebuf flag not a bmap
    flag here; fortunately they have the same value (2).
  o [XFS] Tweak last dabuf fix, suggested by Steve, no longer uses
    bitfields but uchars instead
  o [XFS] Use the rounded down size value for all growfs calculations,
    else the last AG can be updated incorrectly
  o [XFS] Implement several additional inode flags - immutable,
    append-only, etc; contributed by Ethan Benson
  o [XFS] Add inode64 mount option; fix case where growfs can push 32
    bit inodes into 64 bit space accidentally - both changes originally
    from IRIX
  o [XFS] Separate the big filesystems macro out into separate big
    inums and blknos macros; fix the check for too-large filesystems in
    the process
  o [XFS] Alternate, cleaner fix for the ENOSPC/ACL lookup problem
  o [XFS] Automatically set logbsize for larger stripe units
  o [XFS] Fix some compile warnings and errors from some long-forgotten
    2.4 mods

Neil Brown:
  o md: Don't setup make_request_fn for md array until *after* it has
    been started
  o md: MODULE_ALIAS for md
  o md: change 'or' to 'plus' in raid1
  o knfsd: Fix cmsg setup for sock_sendmsg in svc_sendto
  o knfsd: NFS4XDR get rid of warning
  o knfsd: idempotent replay cache for OPEN state
  o knfsd: nfsdv4 byte range locking - prepatation
  o knfsd: nfsd byte range locking - LOCK
  o knfsd: nfsdv4 byte range locking - LOCKT
  o knfsd: nfsdv4 byte range locking - LOCKU
  o Fix up initialisation of md devices

Nick Piggin:
  o Badness in as_completed_request warning
  o AS documentation
  o fix AS hangs
  o fix AS crappy performance

Nicolas Kaiser:
  o USB: Remove modules.txt referencea

Nicolas Pitre:
  o [ARM PATCH] 1528/1: big endian support for io-readsb/io-writesb

Oliver Neukum:
  o iforce-usb.c, iforce-packets.c

Patrick Mansfield:
  o don't set underflow for REQ_BLOCK_PC

Patrick Mochel:
  o [power] Fix sysfs state reporting
  o [power] Make sure console level is high when suspending
  o [power] Fix up sysfs state handling
  o [power] Move i386-specific swsusp code to arch/i386/power/
  o [power] swsusp Cleanups
  o [power] Fix device suspend handling
  o [power] Fix handling of pm_users
  o [power] Separate suspend-to-disk from other suspend sequences
  o [power] Make sure devices get added to the PM lists before
    bus_add_device()
  o [acpi] Move register save closer to call to enter sleep state
  o [swsusp] Minor cleanups in read_suspend_image()
  o [swsusp] Use BIO interface when reading from swap
  o [swsusp] Restore software_suspend() call
  o [acpi] Replace /proc/acpi/sleep
  o [power] Whitespace fixes
  o [power] Simplify error handling in pm_suspend_prepare()
  o [power] Make sure we restore interrupts if device_power_down()
    fails
  o [power] Add support for refrigerator to the migration_thread
  o [swsusp] Make sure we call restore_processor_state() when
    suspending
  o [power] Fix swsusp with preempt and clean up
  o [power] Fork swsusp
  o [power] Move PM options into kernel/power/Kconfig
  o [power] Make pmdisk compilable and usable
  o [power] Make pmdisk compile when CONFIG_SOFTWARE_SUSPEND=n
  o [power] Revert swsusp to 2.6.0-test3 state
  o [swsusp] Fix software_suspend() inline return value when
    SOFTWARE_SUSPEND=n
  o [power] Fix ACPI sleep handling with swsusp
  o [power] pmdisk cleanups
  o [power] pmdisk write path cleanups
  o [power] Fix platform devices
  o [power] Remove last panic() from pmdisk
  o [power] Clean up snapshot path in pmdisk
  o [power] Clean up pmdisk page freeing
  o [power] Clean up pmdisk image reading code
  o [power] Get rid of unneeded variables
  o [power] Optimize pmdisk assembly
  o [power] Cleanup pdmisk header
  o [power] Cleanup pmdisk header info
  o [power] Clean up pmdisk pagedir "linking"
  o [power] pmdisk Cleanups
  o [power] Remove unused structure in pmdisk
  o sysfs dput crash fix

Paul Gortmaker:
  o ne2k-pci full duplex with RealTek
  o ne2k_cbus tidy up
  o Remove emacs cruft from 8390 drivers

Paul Mackerras:
  o PPC32: Rework signal code and add a swapcontext system call
  o PPC32: Provide proper siginfo information on various exceptions
  o PPC32: Bitmap operands to find_first/next_bit functions are const
  o PPC32: Fix for highmem on PPC 440
  o PPC32: Update the alignment exception handler for POWER4 processors
  o PPC32: Adjust ucontext to conform with historical practice and with
    glibc
  o PPC32: Fix up the CPU frequency scaling questions in
    arch/ppc/Kconfig
  o PPC32: Fix the definition of PMU_IOC_GRAB_BACKLIGHT
  o PPC32: Make scripts/mkuboot.sh executable

Pete Zaitcev:
  o USB: Drop debounce printout for 2.6
  o [SPARC]: One more multi-line string, from Rob Radez
  o [SPARC]: Down with P3's in srmmu.c

Peter Chubb:
  o ia64: unwind.c fix for spinlock-debug compilation

Peter Osterlund:
  o synaptics.c, psmouse-base.c
  o Input: Big Synaptics update
  o psmouse-base.c
  o input: Tidy up events reported by a Synaptics pad, add touchpad
    support to mousedev.
  o input: Fix broken handling of rotated Synaptics touchpads

Randy Dunlap:
  o tr/olympic probe: remove #warning, improve error handling
  o enable aha152x to build when AHA152X_DEBUG is defined
  o [WAN]: Remove multi-line string literal
  o [WAN]: Convert taskqueues to workqueues
  o [WAN]: Use module_exit() in sdladrv
  o [NET]: Remove unneeded includes (tokenring)
  o [NET]: Remove unneeded includes (skfp)
  o [NET]: Remove unneeded includes (sk98lin)
  o [NET]: Remove unneeded includes (wan, from Randy Hron)
  o [NET]: Remove unneeded includes (hamradio, from Randy Hron)
  o [NET]: Remove unneeded includes (wireless, from Randy Hron)
  o [NET]: Remove unneeded includes (wanrouter, from Randy Hron)
  o [SPARC]: Remove unneeded includes (from Randy Hron)
  o janitor: remove unneeded includes (tokenring)
  o janitor: remove unneeded includes (sk98lin)
  o janitor: remove (or add) unneeded includes
  o janitor: remove unneeded includes (skfp)
  o janitor: remove (or add) unneeded includes (wireless)
  o janitor: remove unneeded includes (hamradio)
  o janitor: remove (or add) unneeded includes (drivers/net/)
  o janitor: insert a missing iounmap()
  o janitor: ns83820 error handling
  o floppy I/O error handling => Oops
  o janitor: remove unneeded includes (/scsi/)
  o janitor: sg_register error handling
  o [BLUETOOTH]: Remove unneeded verify_area call (from
    domen@coderock.org)
  o janitor: cleanup includes in dpt_i2o
  o janitor: cleanup includes in in2000
  o jantior: sx: use get/put_user (remove verify_area)
  o janitor: scsi/a3000: cleanup includes
  o janitor: isdn: remove unneeded verify_area calls
  o janitor: cleanup includes in fs/
  o janitor: rio_linux: user get/put_user for errors (not
  o janitor: clean up newlines
  o jantior: coda: userspace error handling
  o janitor: h8300: put_user for error handling
  o janitor: cleanup includes in tc/zs
  o janitor: isdn: remove verify_area calls
  o janitor: intermezzo: clean up #includes
  o janitor: serial/tx3912: remove unneeded verify_area calls
  o janitor: cleanup includes in megaraid
  o janitor: cleanup includes in osst
  o janitor: cleanup includes in sym53c416
  o janitor: hermes: delete verify_area call
  o janitor: e100: cleanup #includes

Randy Hron:
  o I2C: drivers/i2c version.h cleanup
  o [PATCH] drivers/usb version/include cleanup

Ricky Beam:
  o [SPARC64]: Fix VT/VT_CONSOLE Kconfig for headless operation

Rob Radez:
  o [SPARC32]: Non-controversial gcc-3.3 build fixes

Roland McGrath:
  o PROT_GROWSDOWN/PROT_GROWSUP flags for mprotect

Rolf Eike Beer:
  o Fix typo in fs/Kconfig

Russell Cattelan:
  o [XFS] IRIX sets KM_SLEEP to 0 but the support routines sets
    KM_SLEEP to 1
  o [XFS] Fix from Christoph

Russell King:
  o [SERIAL] Add new port numbers
  o [SERIAL] Rename core.o and 8250_cs.o
  o [PCMCIA] Remove SS_DEBOUNCED
  o [PCMCIA] Remove a set of unused definitions
  o [PCMCIA] Drop level argument from pcmcia_socket_dev_* calls
  o [PCMCIA] Remove incorrect/misleading/old comments from cardbus.c
  o [PCMCIA] Remove editor droppings
  o [SERIAL] Drop "level" argument from serial PM calls
  o [SERIAL] Convert serial config deps to select statements
  o [SERIAL] Fix another missing irqreturn_t (clps711x.c)
  o [SERIAL] Introduce per-port capabilities
  o stable AGP pci_device_id tables
  o More buggy pci drivers
  o [ARM] Update SA1111
  o [ARM] Remove compiler warning in sa1111-pcipool.c
  o [ARM] Update ARM CPU support
  o [ARM] Detect and fix up CPUs with non-coherent write buffers
  o [ARM] Provide __HAVE_ARCH_BCOPY
  o [ARM] Add newly discovered CR register function
  o [ARM] Fix gcc3 multi-line string literal build error
  o [ARM] Remove CONFIG_KBDMOUSE from arch/arm/Kconfig
  o [ARM] Kill gcc preprocessor warning
  o [ARM] Fix name of "cache format" cpuinfo description
  o [ARM] Provide bus type and support for logic modules
  o [ARM] Clean up PCI error reporting
  o [ARM] Dynamically allocate SA1111 component devices
  o [ARM] Update machine types list
  o [ARM] Ensure that MM initialisation warnings are reported as bugs
  o [PCMCIA] Fix bug in PCMCIA resource management memory probing
  o Make /proc/kcore configurable
  o [ARM] Massive rename of default configuration files
  o [ARM] Remove private %_config makefile rule
  o [ARM] Correct comments for abort handler parameters
  o [ARM] Fix abort handler typo affecting Xscale CPUs
  o [ARM] Place initial data/code in assembly into the correct section
  o [ARM] Optimise io-readsb for CPUs with delay slots after ldr
  o [ARM] Optimise io-writesl for cpus with ldr result delays
  o [ARM] Fix AMBA keyboard/mouse driver
  o [ARM] Update mach-types with latest version
  o [ARM] Update bootp kernel+initrd loader
  o [ARM] Fix up includes
  o [ARM] Avoid using clone syscall from kernel_thread()
  o [PCMCIA] Fix deadlocks caused between PCMCIA card fix and device
    model
  o [ARM] Fix page table spinlocking
  o [ARM] Remove CONFIG_PCI_INTEGRATOR
  o [ARM] Don't use pci_find_device in interrupt context

Rusty Russell:
  o Remove modules.txt
  o [NETFILTER]: MASQUERADE target for mostly-static IP addresses
  o [NETFILTER]: REJECT nonlinear fixes after sync with 2.4
  o Kconfig fixes for modules.txt
  o Futex lock division
  o Futex hash improv and minor cleanups
  o Remove modules.txt references
  o [PATCH 2.6.0-test1] remove check_region from drivers_net_3c509.c

Sam Ravnborg:
  o kbuild: Save relevant parts of modules.txt
  o bk: Ignore scripts/bin2c
  o kconfig: Allow architectures to select board specific configs
  o kbuild: Build minimum in scripts/ when changing configuration
  o kbuild: Remove cscope.out during make mrproper
  o kbuild/ppc*: Remove obsolete _config support
  o kbuild: Separate output directory
  o kbuild: Escape "'" in cmd macro
  o kbuild/rpm: Fix 'make rpm' and enable use of 'make O=dir rpm'
  o kbuild: modpost, corrected check of mmap()

Scott Feldman:
  o [e1000] new 82541/5/6/7 hardware support
  o [e1000] 82544 PCI-X hang fix + TSO updates
  o [e1000] Turn off ASF support on Fiber nics
  o [e1000] read correct bit from EEPROM for getting WoL settings
  o [e1000] add ethtool flow control support
  o [e1000] make function our of setting media type
  o [e1000] cleanup error return codes
  o [e1000] move static to table from .h to .c
  o [e1000] Add PHY master/slave #define override
  o [e1000] misc whitespace cleanup, changelog
  o [e1000] flow control updates
  o [e1000] force 1000/full on SERDES connected to back-plane
  o [e1000] better propagation of error codes
  o [e1000] misc
  o [e100] PRO/10+ not configured properly
  o [e100] h/w can't do IPv6 checksum offloading
  o [e100] trying to pci_alloc before pci_enable

Simon Kelley:
  o atmel wireless driver

Stephen Hemminger:
  o Get rid of Intermezzo warning
  o Fix modularization of Siemens line discipline
  o fix build of cosa
  o (1/4) sdla - move out of Space.c
  o (2/4) get rid of register_frad
  o (3/4) dlci locking and registration changes
  o (4/4) dlci netdevice event handling
  o (5/4) dlci netdevice event handling
  o [NET]: Remove some unnecessary proc_fs.h includes
  o [NET]: Convert packet scheduler API to seq_file
  o [BRIDGE]: Clear hw checksum flags when bridging
  o [NET]: Better proc_net macros for non-procfs case
  o [IPVS]: Convert to seq_file
  o use seq_lock for monotonic time
  o drivers/char/misc -- use list() macros
  o drivers/char/misc -- seq_file
  o [IPV4]: In tcp_diag.c, use static, const, and void *, as
    appropriate
  o [IRDA]: Eliminate skb_linearize() from irda
  o [IRDA]: proc/net/irda files using seq_file
  o [IRDA]: Convert ircomm to seq_file
  o [NET]: More const in skbuff.h
  o [IPVS]: Get rid of register declarations
  o [IPVS]: Get rid of SEQ_START_TOKEN define
  o [IPVS]: Use list_for_each_entry macro
  o [IPVS]: Use time_before/after
  o [NET]: Deprecate dev_get()
  o [NET]: Fix bug in dev_get() deprecation patch
  o replace sppp_of macro with inline
  o get rid of old IRDA drivers
  o [IrDA] irda-usb -- dev_alloc cleanout
  o [IrDA] w83977af -- dev_alloc cleanout
  o [IrDA] donahoboe -- dev_alloc cleanout
  o [IrDA] nsc-ircc -- dev_alloc cleanout
  o [IrDA] via-ircc -- dev_alloc cleanout
  o [IrDA] ali-ircc -- dev_alloc cleanout
  o sealevel wan driver
  o update arcnet/pcmcia driver
  o hamradio/scc -
  o Road Runner HIPPI driver (rrunner)
  o [IPVS]: Fix errors in list_for_each changes
  o [NET]: rtnetlink -- rtattr_strcmp const args
  o [NET]: rtnetlink -- RTA_PUT unlikely
  o [NET]: rtnetlink -- ASSERT_RTNL and BUG_TRAP
  o [NET]: No need for alloc_divert_blk in Space.c
  o [NET]: Fix inaccurate comments in Space.c
  o [NET]: Fix boot param string setup in Space.c
  o [LLC]: llc_output.c needs linux/trdevice.h
  o (1/8) arlan -- merge arlan-proc with main code
  o (2/8) arlan -- get rid of some dead wood
  o (3/8) arlan -- get rid of unnecessary casts
  o (4/8) arlan -- trailing semicolons
  o (5/8) arlan -- more set never used elements
  o (6/8) arlan -- add spinlock
  o (7/8) arlan -- more dead wood removal
  o (8/8) arlan -- proper jiffies usage
  o (1/4) Update baycom drivers for 2.6
  o (2/4) baycom c99 initializers
  o (3/4) baycom/hdlcdrv unregister
  o [IPV4]: Convert ipmr to seq_file
  o [netdrvr sk98lin] build on smp fix
  o [netdrvr skge] handle proc_fs errors
  o [netdrvr sk98lin] use seq_file for /proc
  o sealevel -- syncppp startup fix
  o wan/z8530 deadlocks

Stephen Lord:
  o [XFS] fix up xfs_lowbit's use of ffs
  o [XFS] Some tweaks to the additional inode flags, suggested by Ethan
    Benson
  o [XFS] fix build for gcc 3.2
  o [XFS] Fix initialization of inode flags from xfs inode fields
  o [XFS] Make xfs_ichgtime call mark_inode_dirty_sync instead of
    mark_inode_dirty makes the just the inode look dirty, and not the
    inode and the data.

Steven Dake:
  o fix kernel BUG using multipath

Stéphane Eranian:
  o ia64: perfmon2 update
  o ia64: perfmon2 update
  o ia64: minor perfmon2 patch
  o ia64: pass si_isr for a few more signal sources

Suresh B. Siddha:
  o ia64: fix typo in spinlock.h

Timothy Shimmin:
  o [XFS]  Change xlog_verify_iclog() to use idx as zero based instead

Tom Rini:
  o PPC32: Add _IO{R,W,WR}_BAD and update _IO{R,W,WR}
  o PPC32: Allow for boards to flush / disable L2 / L3 in the
    bootwrapper
  o PPC32: Remove trailing blanks from PPC32 files
  o PPC32: Two minor bootwrapper fixes on PReP, from Hollis Blanchard
    <hollisb@us.ibm.com>
  o PPC32: Merge MPC8260 board selection with other 'classic PPC'
    boards
  o PPC32: Fix the udelay implementation in the bootwrapper
  o PPC32: Make include/asm-ppc/processor.h more readable
  o PPC32: Fix the dependancies on CONFIG_ISA
  o PPC32: Fix another incorrect asm statement
  o PPC32: Move all register definitions to include/asm-ppc/reg.h
  o PPC32: Audit <asm/processor.h> uses
  o PPC32: Fix a rounding error in the bootwrapper udelay
  o PPC32: Re-arrange arch/ppc/Kconfig, from Hollis Blanchard
    <hollis@penguinppc.org>
  o PPC32: Make the IBM 4xx options menu depend on 4xx, from Hollis
    Blanchard <hollis@penguinppc.org>
  o PPC32: Make CONFIG_DEBUG_INFO default to n, always
  o PPC32: Minor cleanups
  o PPC32: Move PowerPC Book E (and IBM 40x) register definitions to
    their own fil e.
  o PPC32: Cleanup of SPR handling in ppc_htab.c
  o PPC32: Further cleanups to the ppc_htab code
  o PPC32: Add a uImage boot target

Tony Luck:
  o ia64: fix PM config option
  o ia64: trim.bottom trims the wrong entry

Urban Widmark:
  o smbfs module unload and highuid

Vinay K. Nallamothu:
  o [NETROM]: Timer code cleanup

Vojtech Pavlik:
  o input.c
  o db9.c
  o psmouse-base.c
  o psmouse-base.c
  o input.h, keyboard.c, evdev.c
  o psmouse-base.c
  o input: Fix memory leak in hiddev.c found by Stanford Checker
  o Fix a warning in input.c when CONFIG_PROC_FS is not set
  o Remove a not necessary #ifdef CONFIG_PROC_FS/#endif in input.c
  o Fix memory leak in hiddev.c found by Stanford Checker
  o input: Revert synaptics->pktcnt change. New synaptics driver
    actually uses the variable.
  o input: Change AT keyboard to use hardware autorepeat and move
    untranslating to the AT keyboard driver as well. Lower PS/2 mouse
    default report rate. Fix repeat rate adjustment ioctls accordingly,
    and update other files to reflect the changes. This should fix most
    known keyboard problems in 2.6.
  o input: Add BTN_TOUCH to Synaptics pad driver. This fixes the joydev
    grabbing of the pads, as well as simplifies the mousedev driver.

Wensong Zhang:
  o [IPVS]: Make __ip_vs_svc_lock local and use __user tags

Will Cohen:
  o ia64: oprofile support


