Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265057AbSJaAun>; Wed, 30 Oct 2002 19:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbSJaAun>; Wed, 30 Oct 2002 19:50:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14340 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265057AbSJaAuO> convert rfc822-to-8bit; Wed, 30 Oct 2002 19:50:14 -0500
Date: Wed, 30 Oct 2002 16:56:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.45
Message-ID: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g9V0uaR23746
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Big changes, lots of merges. A number of the merges are fairly
substantial too. 

Device mapper (LVM2), crypto/ipsec stuff for networking, epoll and giving
the new kernel configurator a chance. Big things.

And a _lot_ of maintenance, from various architecture updates to USB and
ISDN and ALSA. Merges with Andrew & Alan etc.. Go out and test, 

		Linus

---

Summary of changes from v2.5.44 to v2.5.45
============================================

<akropel1@rochester.rr.com>:
  o The following patch adds support for ethtool to the ewrk3 driver.
    It is against 2.5-BK but should apply to any recent 2.5 and 2.4 as
    well. In addition to adding ethtool support, it also removes the
    cli/sti fixup attribution from the changelog since that didn't
    actually go in yet and fixes a small style issue I introduced in
    the multi-card support patch.
  o This patch adds some locking fixups to the ewrk3 ioctl routine.
    None of these are critical since the ioctls AFAIK are used only by
    the EEPROM config utility.
  o Last ewrk3 update for now. Updates the changelog to cover previous
    patches, bumps the revision number, and replaces the horrific
    EthwrkSignature function with something (slightly) less horrific.
  o sd.c major number off-by-one

<ambx1@neo.rr.com>:
  o PnP Rewrite Fixes - 2.5.44
  o PnP cleanups and resource changes - 2.5.44 (1/4)
  o PnPBIOS changes - 2.5.44 (2/4)
  o Convert CS4236B driver - 2.5.44 (3/4)
  o update PnP layer to driver model changes - 2.5.44 (4/4)

<arnaud.quette@mgeups.com>:
  o drivers/usb/input/hiddev.c: fix hiddev_connect issue when

<dbrownell@users.sourceforge.net>:
  o ohci-hcd, longer bios handshake timeout
  o usbnet, preliminary zaurus support
  o usb: problem clearing halts

<dipankar@in.ibm.com>:
  o include/asm-sparc64/system.h: Add read_barrier_depends defines

<fw@deneb.enyo.de>:
  o [TCP]: In TCP_LISTEN state, ignore SYNs with RST set

<jbm@joshisanerd.com>:
  o Eliminate Old Prototypes from 2.5.44
  o [PATCH] fix a FIXME in usb.h

<jgarzik@redhat.com>:
  o Remove cli/sti from ewrk3 net driver
  o Fix tulip net driver multi-port board irq assignment
  o Add description of files in Documentation/BK-usage directory
  o Small clarification in BK kernel howto
  o Fix IO API breakage: Make inl() return unsigned int on x86 again
  o Update my email address
  o [IA32] Use -march=pentium{-mmx,3,4} in CFLAGS when available

<johnf@whitsunday.net.au>:
  o In patch-2.5.44 Mike Anderson <andmike@us.ibm.com> made a cleanup
    to the Scsi Host setup.

<jtyner@cs.ucr.edu>:
  o drivers/usb/media/vicam.c: simplify vicam_read
  o drivers/usb/media/vicam.c: simplify vicam_read

<jung-ik.lee@intel.com>:
  o ia64: PCI hotplug changes for 2.5.39 or later

<komujun@nifty.com>:
  o Add PCI id to tulip net driver

<mashirle@us.ibm.com>:
  o [IPV6]: Fix bugs in PMTU handling

<mhopf@innominate.com>:
  o [EBTABLES]: Add tcp/udp port checking

<n0ano@n0ano.com>:
  o ia64: Implement ia32 emulation for SG_IO

<niv@us.ibm.com>:
  o [IPV{4,6}]: Clean up SNMP counter bumping
  o [IPV4]: Add missing IpInUnknownProtos bump

<oliver@oenone.homelinux.org>:
  o USB: microtek driver - remove dead code
  o USB: hpusbscsi - kill wrong error case

<rohit.seth@intel.com>:
  o ia64: protect hugepage-check with mmap_sem

<shaggy@shaggy.austin.ibm.com>:
  o JFS: Add missing byte-swapping macros in xattr.c

<tony.luck@intel.com>:
  o ia64: make kcore work

<venkatesh.pallipadi@intel.com>:
  o ia64: Save/Restore of IA32 fpstate in sigcontext
  o ia64: Clearing of exception status before calling IA32 user signal
    handler

<willy@fc.hp.com>:
  o Simplify MCA date/time printing

Adam J. Richter <adam@yggdrasil.com>:
  o Use pci_[gs]et_drvdata instead of directly referenced ->driver_data
    in struct pci_dev.

Adrian Bunk <bunk@fs.tum.de>:
  o kbuild: Fix soundmodem/Makefile

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o MCA bus basic cleanups
  o small scsi compile fixes
  o move 53c7,8xx to pci_ not pcibios
  o ressurect the aha1740 driver
  o move advansys from pcibios to pci_
  o fix aic7xxx on gcc 3.2 warning spew
  o initial eata driver updates
  o fix all the IRQ breakage on the in2000
  o inia100 just has to lose a next: NULL
  o ncr53c8xxx needs updating for scsi_hn_get
  o resurrect the NCR53c406a
  o nsp32 needs updating for scsi_hn_get
  o fix scsi irq errors on seagate
  o nsp_cs update from maintainer
  o finish updating sym53c416
  o u14-34f update from maintainer
  o next NCR5380 updates
  o SCSI configure help
  o correct notes on scsi generic release
  o update qlogicfas driver
  o get the right thing out of se401 on gcc 3.2
  o merge befs file system from 2.4 (no core changes)
  o fix umem driver to use pci_get/set
  o xd_open is gone
  o make gscd compile again
  o kill tqueue in dz
  o make bluetooth compile again
  o update i810 tco to C99
  o move ip2 to workqueues
  o kill tqueue in specialix
  o stallion workqueue
  o move stallion to workqueue
  o update the qic02 tape driver to 2.5.44
  o remove tqueue.h from vme_sc
  o move hpt366 to pci_get
  o move siimage to pci_get/set
  o fix IDE compile with SIS5513
  o IDE floppy must be marked removable
  o ARM ide driver updates
  o remove dead ide suspend code
  o make the firewire layer build again
  o fix gcc warnings in eicon
  o kill tqueue in macintosh adb
  o update adv7175 to new i2c bus code
  o cpia driver update from maintainer
  o other minor video updates
  o mpt fusion updates for scsi changes
  o bring i2o_block/i2o_scsi back to life
  o ressurrect the 3c515 driver
  o bring the cops appletalk driver back
  o de620 resurrection
  o depca fix from maintainer
  o dl2k warning fix
  o fix hamradio netdriver builds
  o resurrect the 3c589_cs pcmcia
  o fix up the smc9194 - the extra locks arent needed
  o znet can go from space.c now
  o znet ethernet, back from the dead
  o update APM to match 2.4 features
  o core voyager arch/i386/machine support
  o Documentation for befs
  o remove acorn mfm tqueue.h
  o documentation for voyager
  o fix atm firestream warnings with new gcc
  o drag ATM into the 21st century , part 1
  o Device Mapper, with updates
  o Digital TV framework
  o update wan drivers to new saner ioctls
  o IDE - Andre can't count 8)
  o mempool helpers used by device mapper
  o updated ver_linux
  o DVB drivers AV7110 (Fujitsu, Nova etc)
  o Remove dead code in axnet_cs net driver

Alexander Viro <viro@math.psu.edu>:
  o A couple of compile fixes
  o rd
  o z2ram
  o xpram
  o ps2esdi
  o nftl
  o mtdblock (based on a patch from rmk)
  o hd.c
  o xd.c
  o ftl.c fix
  o dasd.c
  o swim3.c cleanup
  o mtdblock_ro fixes (based on patch from rmk)
  o blk_dev[] is gone
  o removed a bunch of gratuitous ->rq_dev uses
  o randomness made per-disk
  o r/o state moved to gendisks
  o presto cache keyed by superblock instead of kdev_t
  o removed a bunch of gratuitous kdev_t uses
  o saner initialization order in IDE (gendisks allocated slightly
    earlier)
  o block_device_operations always picked from gendisk
  o dasd fixes
  o IO counters - per-partition part
  o IO counters - per-disk part
  o ide-taskfile ioctls prototype cleanup
  o ide-{disk,cd,...} got separate block_device_operations
  o gendisk fixes
  o removal of root_dev_names[]
  o loop/shmfs fixes
  o compile fixes
  o more shm/loop updates
  o loop breakage fix

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV4]: Kill ip_send, use dst_output instead
  o [NET]: Kill reroute from DST ops, unused
  o [IPV4]: Missing ip_rt_put in ip_route_newports
  o include/linux/ip.h: Define AH/ESP header layout
  o [NET]: Fix rtnetlink metric type, should be u32
  o [NET]: Cleanup DST metrics and abstract MSS/PMTU further
  o [NET]: Add DST_NOXFRM and DST_NOPOLICY flags
  o net/ipv4/route.c: Create compare_keys to compare flowi identities
  o [IPV4]: Rework key route lookup interface slightly
  o [IPSEC]: Add transform engine and AH implementation
  o [UDP]: Delete buggy assertion

Andi Kleen <ak@muc.de>:
  o x86-64 updates for 2.5.44

Andrew Morton <akpm@digeo.com>:
  o fix failure to write ext2 indirects under load
  o RCU idle detection fix
  o sparc64 read_barrier_depends fix
  o fid dmi compile warning
  o blkdev_get_block fix
  o move ramfs a_ops into libfs
  o libfs a_ops correctnes
  o invalidate_inode_pages fixes
  o restructure direct-io to suit bio_add_page
  o permit direct IO with finer-than-fs-blocksize alignments
  o add a file_ra_state init function
  o less buslocked operations in the page allocator
  o radix_tree_gang_lookup fix
  o export nr_running and nr_iowait tasks in /proc
  o faster copy_*_user for bad alignments on intel ia32
  o uninline the ia32 copy_*_user functions
  o shrink_slab arith overflow fix
  o thread-aware oom-killer
  o don't invalidate pagecache after direct-IO reads
  o much miscellany
  o tmpfs: shmem_getpage unlock_page
  o tmpfs: shmem_getpage beyond eof
  o tmpfs: shmem_getpage reading holes
  o tmpfs: shmem fs cleanup
  o tmpfs: shmem_file_sendfile
  o tmpfs: shmem_file_write update
  o tmpfs: shmem_getpage missing flush_dcache_page
  o tmpfs: support loopback
  o slab: extended cpu notifiers
  o slab: add_timer_on: add a timer on a particular CPU
  o slab: cleanup: rename static functions
  o slab: enable the cpu arrays on uniprocessor
  o slab: reduce internal fragmentation
  o slab: take the spinlock in the drain function
  o slab: remove spaces from /proc identifiers
  o slab: cleanups and speedups
  o slab: uninline poisoning checks
  o slab: reap timers
  o slab: Rework the slab timer code to use add_timer_on
  o slab: Remove cache_chain_lock
  o slab: additional code cleanup
  o slab: Use CPU notifiers
  o percpu: balance_dirty_pages ratelimit counters
  o percpu: fix compile warning for UP builds
  o percpu: convert RCU
  o percpu: convert timers
  o percpu: convert softirqs
  o percpu: convert buffer.c
  o percpu: create an EXPORT_PER_CPU_SYMBOL() macro
  o percpu: convert global page accounting
  o hot-n-cold pages: bulk page allocator
  o hot-n-cold pages: bulk page freeing
  o hot-n-cold pages: page allocator core
  o hot-n-cold pages: use cold pages for readahead
  o hot-n-cold pages: free and allocate hints

Andy Grover <agrover@groveronline.com>:
  o ACPI: Update to interpreter 20021022
  o ACPI: EC update
  o ACPI: Enable compilation using Intel compiler
  o ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)
  o ACPI: Restore ARB_DIS bit on resume from S1 (Eric Brunet)
  o ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)
  o ACPI: Remove too-broad blacklist entries
  o ACPI: Use dev->devfn instead of bridge->devfn to determine the pin
    when trying to derive a device's irq from its parent (Ville
    Syrjala)
  o ACPI: Add support for GPE1 block defined with no GPE0 block
  o ACPI: eliminate duplicate lines of code
  o ACPI: implement support for cpufreq interface (Dominik Brodowski)
  o ACPI: Try #2 at fixing the PCI IRQ bridge swizzle (Kai
    Germaschewski)

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o o ipv4: only produce one record per fib_seq_sholl call
  o o ipv4: move /proc/net/udp support back to net/ipv4/udp.c
  o o ipv4: move /proc/net/arp seq_file support back to arp.c
  o ipv4: move proc stuff from net/ipv4/af_inet.c to net/ipv4/proc.c
  o o llc: fix seq_file support

Art Haas <ahaas@neosoft.com>:
  o ia64: C99 designated initializer for include/asm-ia64/thread_info.h

Bart De Schuymer <bart.de.schuymer@pandora.be>:
  o [EBTABLES]: Add byte counter support, plus header cleanup
  o [BRIDGE]: bridge-nf, map IPv4 hooks onto bridge hooks
  o [BRIDGE]: Add ipt_physdev netfilter module

Brian Gerst <bgerst@didntduck.org>:
  o make x86 ptrace use init_fpu()
  o remove __verify_write from sh arch
  o i386 __verify_write fixes
  o factor common GCC options check

Christoph Hellwig <hch@lst.de>:
  o remove dead EH methods
  o Re: [PATCH] fix scsi device/driver model integration
  o get rid of ->finish method for highlevel drivers
  o remove scsi_merge.c
  o sanitize ->bios_param prototype
  o back out bogus init.h change
  o merge sd.h into sd.c and some cleanup
  o remove sd_disks global array from sd.c
  o fix sector_div use in scsicam.c
  o Re: [PATCH] fix sector_div use in scsicam.c
  o misc cleanups for sr
  o remove unused variable in scsi.c
  o get rid of global arrays in sd
  o remove LVM1 leftovers from the tree
  o sanitize intel movsl selection
  o fix xfs build after lvm removal

dan.zink@hp.com <Dan.Zink@hp.com>:
  o Compaq PCI Hotplug bug fix

David Brownell <david-b@pacbell.net>:
  o ehci enumerating full speed devices
  o rm "automagic resubmit" for usb interrupt transfers
  o Zaurus support for usbnet
  o create <linux/usb_ch9.h>
  o USB: clean up usb structures some more
  o ohci td error cleanup
  o usbtest mentions url

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Incorporate no-flush-needed optimization from Andrew's
    asm-generic/tlb.h
  o ia64: Fix copy_siginfo() to copy all relevant bytes
  o ia64: Fix EFI runtime callbacks so they cannot corrupt fp regs.  A
    few minor
  o ia64: Sync with 2.5.39
  o ia64: Fix 2.5.39 Makefile breakage
  o ia64: Update defconfig
  o ia64: Remove duplicate make targets
  o ia64: Some formatting cleanups
  o ia64: Fix formatting a bit and issue #error when attempting to use
    CONFIG_NUMA without CONFIG_ACPI_NUMA.
  o ia64: Fix up/clean NUMA discontigmem patch
  o ia64: Sync with 2.5.44
  o ia64: Clean up ia64 version of topology.h
  o ia64: Make kernel profiling work again (patch by Peter Chubb)
  o ia64: Minor Makefile cleanup.  Mention CONFIG_NUMA option in
    defconfig
  o ia64: Create dummy offsets.h if it doesn't exist yet.  Patch by
    Keith Owens
  o ia64: Fix Keith's Makefile fix so it actually works

David Mosberger <davidm@wailua.hpl.hp.com>:
  o ia64: Fix perfmon initialization bug (patch by Stephane Eranian)

David S. Miller <davem@nuts.ninka.net>:
  o [IPV4]: Provide full proto/ports in flowi route lookups
  o net/ipv4/af_inet.c: Include net/ip_fib.h
  o net/ipv4/ip_proc.c: Include linux/ax25.h and handle modular AX25
  o arch/sparc64/kernel/ioctl32.c: Handle HDIO_GETGEO_BIG{,_RAW}
  o [IPV4]: When advmss of route is zero, report it as zero not 40
  o [CRYPTO]: Fix compiler warnings and build failures
  o [CRYPTO]: Forgotten file add in previous commit
  o [ip-sysctl.txt]: Clarify conf/*/ behavior
  o [PNP]: Fix build when CONFIG_PNP is not set
  o [SPARC64]: Only HDIO_GETGEO_BIG_RAW exists in 2.5
  o [SPARC64]: Remove silly rule to remove -pg from cflags
  o [SPARC64]: Update defconfig
  o [SPARC]: Bring ESP driver in line with modern EH handling
  o [SPARC]: Bring QlogicPTI driver in line with modern EH handling
  o [FC4]: Kill all references to fcp_old_abort
  o [ESP]: Fix abort return values
  o [CRYPTO]: kunmap does not return a value
  o [CRYPTO]: Build/warning fixups
  o [IPSEC]: Remove debugging code
  o [CRYPTO]: Clean up header file usage
  o include/linux/crypto.h: Include linux/string.h

Davide Libenzi <davidel@xmailserver.org>:
  o sys_epoll 0.15

david_jeffery@adaptec.com <David_Jeffery@adaptec.com>:
  o ips queue depths 2.5.44

Doug Ledford <dledford@aladin.rdu.redhat.com>:
  o Update for new TCQ scheme
  o Fix for scsi host struct change
  o host struct cleanups
  o Compile fixes needed due to host struct change

Erich Focht <efocht@ess.nec.de>:
  o acpi-numa for ia64
  o ia64: topology for ia64

Greg Kroah-Hartman <greg@kroah.com>:
  o IBM PCI Hotplug: fix typos in previous patch
  o USB: added support for Clie NX60 device
  o driver core: add support for calling /sbin/hotplug when classes are
    found and removed from the system
  o USB: fix the usb serial drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb input drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb class drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o fix the usb image drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb media drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb misc drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb net drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o fix the usb storage drivers due to interrupt urb no automatic
    resubmission change to the usb core
  o USB: fix the usb drivers outside the drivers/usb tree due to
    interrupt urb no automatic resubmission change to the usb core
  o USB: fix GFP flags for usb audio driver
  o USB: Fixes for previous USB_* flag patch
  o USB: usb serial driver fixes due to USB structure changes
  o USB: drivers/usb fixups due to USB structure changes
  o USB: sound/usb fixups due to USB structure changes
  o USB: drivers/usb fixups due to USB structure changes
  o USB: drivers/isdn/hisax fixups due to USB structure changes
  o USB: drivers/net/irda fixups due to USB structure changes
  o USB: fix usbmidi driver for no automatic resubmission of interrupt
    urbs

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER] Add IP unused bit check to ipt_unclean.c, from Maciej
    Soltysiak

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Add IPV6_V6ONLY socket option support
  o [IPV6]: Add ICMP6 rate limit sysctl
  o [IPV6]: Split ndisc_rcv into helper functions
  o [IPV6]: Avoid garbage sin6_scope_id for MSG_ERRQUEUE messages
  o [IPV6]: Fix for refined IPV6 address validation timer

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o remove the conv option of fat (1/3)
  o remove the fat_cvf stuff (2/3)
  o small cleanup of fat  (3/3)

Irene Zubarev <zubarev@us.ibm.com>:
  o IBM PCI Hotplug: small patch

James Bottomley <jejb@mulgrave.(none)>:
  o [SCSI] remove duplicate device registration
  o [SCSI] move build commandblocks to before attach so attach can send
    I/O
  o [PATCH scsi] use sector_div in scsicam.c
  o [SCSI] replace max_host_blocked initialisation lost in hosts rework
  o [SCSI] fix memory etc. leak caused by double preparing requeued
    commands
  o [SCSI] documentation tidy ups and an interface fix in
    mlqueue_insert
  o Merge by hand: recover axboe scsi_init_io() changes
  o Correct sd.c compile by adding } lost in merge
  o patch up scsi mismerge

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Add initial crypto api subsystem
  o [CRYPTO]: Add in 3des implementation
  o [CRYPTO]: Cleanups based upon feedback from Rusty and jgarzik
  o [CRYPTO]: Use try_inc_mod_count and semaphore for alg list
  o [CRYPTO]: Use kmod to try to autoload modules
  o [CRYPTO]: Bug fixes and cleanups
  o [CRYPTO]: More bug fixes and cleanups
  o [CRYPTO]: Add MD4
  o [CRYPTO]: Algorithm lookup API change plus bug fixes
  o [NET]: Backport netlink_set_nonroot changes by Andi Kleen
  o [CRYPTO]: Run tcrypt through lindent, plus doc update
  o [CRYPTO]: Assert that interfaces are called on correct cipher type
  o [CRYPTO]: Cleanups and more consistency checks
  o [CRYPTO]: Update to IV get/set interface
  o [CRYPTO]: Add some documentation
  o [CRYPTO]: Fix some credits
  o [CRYPTO]: Cleanups based upon suggestions by Jeff Garzik
  o [CRYPTO]: Uninline some functions to save some bloat

Jaroslav Kysela <perex@suse.cz>:
  o ALSA updates

Jens Axboe <axboe@suse.de>:
  o scsi patches
  o make deadline_merge prefetch next entry
  o end_io bouncing
  o sr_ioctl must return -EIO, not -EINVAL
  o elv_add_request cleanups
  o make blk_dump_rq_flags a bit more useful
  o make queue prep_rq_fn() a bit more powerful
  o queue dma alignment
  o queue last_merge hint cleanup
  o request references and list deletion/insertion checking
  o add end_request helpers that deal in bytes, not sectors
  o various ide fixes and cleanups
  o queue merge_bvec_fn() changes
  o make bio->bi_end_io() optional
  o bio_map_user() infrastructure
  o misc scsi bits
  o small block bits
  o finally, sgio updates
  o ide-cd updates
  o missed elv_add_request() update
  o bad scsi merge
  o scsi_command_size[] only known when SCSI is enabled
  o remember to export scsi_command_size[]
  o arrange request fiels sanely

John Levon <levon@movementarian.org>:
  o add oprofile to MAINTAINERS
  o fix oprofile multiple counters

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN/PPP: Separate out VJ header compression
  o ISDN: Remove reference to eth_header
  o ISDN: isdn_netif_rx() helper
  o ISDN/PPP: Separate out and rewrite MPPP code
  o kbuild: Split Rules.make
  o kbuild: Remove some compatibility code, $(echo_target)
  o kbuild: Shut up "make clean" in non-verbose mode
  o kbuild: Switch "make modules_install" to fast mode ;)
  o kbuild: Convert build and modversion phases
  o kbuild: Convert drivers/isdn to be "Rules.make-less"
  o kbuild: Allow for <mod>-y as well as <mod>-objs for multipart
    objects
  o kbuild: Allow UTS_MACHINE to be different from $(ARCH)
  o kbuild: Fix a "make -j<N>" warning
  o ISDN: Move HiSax to spinlocks instead of cli()
  o ISDN: Fix up the introduced spinlocks
  o ISDN: Fix the workqueue changes for the HiSax driver
  o ISDN/PPP: Remove random frame drop
  o ISDN: header cosmetics
  o ISDN: Remove CVS $Revision
  o ISDN/PPP: Pass frame including header to MPPP
  o ISDN: Move drivers/isdn/i4l/isdn_fsm.h include/linux/isdn/fsm.h
  o ISDN: Move ISDN net lib interface related definitions into
    isdn_net_lib.h
  o ISDN: Make raw-IP, CISCO HDLC, ... support optional
  o ISDN: Move isdn_net_lib specific definitions out of linux/isdn.h
  o ISDN: Add missed isdn_net_lib.h
  o ISDN: alloc CISCO HDLC info dynamically
  o ISDN: Convert ISDN/X.25 to inl_priv / ind_priv
  o ISDN: Convert ISDN/PPP to inl_priv / ind_priv
  o ISDN: Remove rcv_waitq/snd_waitq
  o ISDN: Fix AT+FREV command
  o ISDN: improve /dev/isdnctrl read()/write()
  o ISDN: Make array of drivers private to isdn_common.c
  o ISDN: Use a spinlock to protect the list of drivers
  o ISDN: Get rid of global drivers count
  o ISDN: Kill drvid[] array
  o ISDN: State machines for the link layer
  o ISDN: Remove ISDN_STAT_NODCH
  o ISDN: Move driver unload into the state machine
  o ISDN: Remove ISDN_STAT_L1ERR
  o ISDN: STAT_FAXIND and STAT_AUDIO handled by state machine
  o ISDN: Remove isdn_driver::online flags
  o ISDN: Signal incoming calls to ttyI's again
  o ISDN: Remove ttyI specific from global "dev" variable
  o ISDN: Route all driver callbacks through the driver state machine
  o ISDN: Move the tty receive queue out of generic code
  o ISDN: Assorted cleanups
  o ISDN: Make V.110 support less intrusive
  o ISDN: Fix isdnloop for transparent/V.110
  o ISDN: Remove isdn_dc2minor(), isdn_slot_all_eaz()
  o ISDN: stat_callback() and recv_callback() -> event_callback()
  o ISDN: Pass around struct isdn_slot directly
  o ISDN: New timer handling for "+++" escape sequence
  o ISDN: New timer handling for ttyI RING response
  o ISDN: New timer handling for ttyI NO CARRIER response
  o ISDN: Remove delayed ttyI xmit
  o ISDN: New timer handling for read timer
  o ISDN: ttyI cleanups
  o ISDN: lock only used driver
  o kbuild: Fix menuconfig/xconfig and a modversions problem

Kent Yoder <key@austin.ibm.com>:
  o update lanstreamer tokenring driver
  o Check link status in pcnet32 net driver

Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>:
  o ia64: ACPI NUMA bugfix
  o ia64: discontigmem patch for 2.5 ia64
  o ia64: allocate all per-CPU pages at BSP-initialization time

Linus Torvalds <torvalds@home.transmeta.com>:
  o Delete old-style config files
  o ia-64 kcore changes broke i386. Guess who gets the shaft?
  o Fix ACPI frequency states to not play games with the configuration
    system, and instead just cleanly show the dependency.
  o Fix up horribly wrong test in new copy-to-user() implementation.
    The optimized versions only work for large areas, make sure we
    don't use them for anything else.

Manfred Spraul <manfred@colorfullife.com>:
  o use correct wakeups in fs/pipe.c

Matt Domsch <Matt_Domsch@dell.com>:
  o EDD: add comments, magic value defines, use snprintf always
  o EDD: cleanups
  o EDD: remove list_head from edd_device, don't delete symlinks
  o EDD: moved attr_test to edd_attribute ->test(), comments

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: fix error code
  o USB storage: use scatter-gather core primitives

Matthew Dobson <colpatch@us.ibm.com>:
  o Remove sole CONFIG_MULIQUAD in kernel source

Matthew Wilcox <willy@debian.org>:
  o [NET]: Move more ioctls to top level
  o Update lasi_82596 net driver to replace cli/sti with spinlock
  o PA-RISC math emu
  o include/asm-parisc
  o arch/parisc/mm
  o arch/parisc/kernel
  o perf monitor for PA-RISC
  o parisc64
  o misc PA updates

Mike Anderson <andmike@us.ibm.com>:
  o fix module unload of sg
  o scsi_error device offline fix
  o scsi sync caches w/ dev offline

Neil Brown <neilb@cse.unsw.edu.au>:
  o Define domain_release handle for AUTH_UNIX domains
  o md: factor out MD superblock handling code
  o kNFSd: Fix nfs shutdown problem
  o kNFSd: Make sure export_open cleans up on failure
  o kNFSd: Fix problem with buffer length with rpc/tcp
  o kNFSd: nfsd_readdir changes
  o kNFSd: Convert nfsd to use a list of pages instead of one big
    buffer

Patrick Mochel <mochel@osdl.org>:
  o introduce struct kobject: simple, generic object for embedding in
    other structures
  o sysfs: convert sysfs to use more functions from fs/libfs.c
  o sysfs: marry api with struct kobject
  o sysfs: make symlinks easier
  o Introduce struct subsystem
  o sysfs: kill struct sysfs_dir
  o kobjects: add array of default attributes to subsystems, and create
    on registration

Pavel Machek <pavel@ucw.cz>:
  o swsusp -- small fixes
  o swsusp updates

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: More -ffunction-sections followups
  o [SPARC]: Some forgotten asm_offsets.h includes

Peter Chubb <peter@chubb.wattle.id.au>:
  o ia64: Fix RAW dependency introduced by HUGETLB patch

Randy Dunlap <rddunlap@osdl.org>:
  o Convert /proc/swaps to use seq_file API
  o remove double-init in /proc/ksyms

Rob Radez <rob@osinvestor.com>:
  o [SPARC32]: Fix build in several spots

Robert Love <rml@tech9.net>:
  o overcommit-accounting doc fix

Roman Zippel <zippel@linux-m68k.org>:
  o new kernel configuration 1-7
  o kconfig update
  o kconfig "choice" fixes

Rusty Russell <rusty@rustcorp.com.au>:
  o Get rid of check_resource() before it becomes a problem

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: Removed unused definitions
  o kbuild: scrits/Makefile.lib Moved generic definitions to
    Makefile.lib, This allows us to share all generic definitions
    between the different Makefiles.
  o kbuild: Use Makefile.lib for modversion and modules_install Most
    definitions required were present in Makefile.lib, so delete the
    definitions and include Makefile.lib.
  o kbuild: Got rid of $(call descend ...) in top-level Makefile
    Replaced by the more readable $(Q)$(MAKE) construct
  o kbuild: Added Descend to top-level Makefile again It is used by
    arch specific Makefiles

Skip Ford <skip.ford@verizon.net>:
  o net/ipv4/raw.c: Include netfilter_ipv4.h

Stelian Pop <stelian.pop@fr.alcove.com>:
  o sonypi driver update

Stuart MacDonald <stuartm@connecttech.com>:
  o More wh patches

Stéphane Eranian <eranian@hpl.hp.com>:
  o 2.5.35 perfmon update

Takayoshi Koshi <t-kouchi@mvf.biglobe.ne.jp>:
  o ACPI PCI hotplug driver for 2.5
  o ia64: fix fpswa version printing

Tim Hockin <thockin@freakshow.cobalt.com>:
  o drivers/net/eepro100.c: cleanup messages since netif_msg_xxx()
    change
  o drivers/net/eepro100.c: set the PHY ID correctly
  o drivers/net/mii.c: fix flipped logic
  o drivers/net/eepro100.c: set phy_id_mask and reg_num_mask in mii_if

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o fix compares of jiffies


