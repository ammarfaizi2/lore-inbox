Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbSI0VzT>; Fri, 27 Sep 2002 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSI0VzS>; Fri, 27 Sep 2002 17:55:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51728 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262606AbSI0VzN>; Fri, 27 Sep 2002 17:55:13 -0400
Date: Fri, 27 Sep 2002 15:02:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.39
Message-ID: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes all over the map.

The most noticeable one may well be the new and much improved elevator by 
Jens Axboe, this one makes a big difference at least to me.

And Andrew found a nasty SMP deadlock on the tasklist lock.

And Ingo's been busy again, fixing some more threading issues he found 
(including the much-talked-about futex thing).

Other stuff all over the map: USB, JFS, XFS, networking, debugging etc.

		Linus

---

Summary of changes from v2.5.38 to v2.5.39
============================================

Albert Cranford <ac9410@attbi.com>:
  o i2c core/dev/proc cleanups, and a proc-related fix

<adam@nmt.edu>:
  o 3ware driver update for 2.5.35

<brihall@pcisys.net>:
  o Update for JMTek USBDrive

<devik@cdi.cz>:
  o net/sched/sch_htb.c: Verify classid and direct_qlen properly

<frival@zk3.dec.com>:
  o Compile fixes for alpha arch

<glee@gnupilgrims.org>:
  o MODULE_LICENSE for i82092 pcmcia

<green@angband.namesys.com>:
  o Reiserfs: Fix alloc= mount option parser

Christoph Hellwig <hch@sgi.com>:
  o XFS: XFS: Use do_gettimeofday() instead of racy direct access to
    xtime
  o XFS: Small comment corrections/updates
  o XFS: Don't include <asm/softirq.h> in page_buf.c
  o XFS: XFS: Make pagebuf use the generic xfs ASSERT() instead of it's
    own assert()
  o XFS: XFS: Sanitize some names in xfs_aops.c, especially a less
    offending name for linvfs_pb_bmap
  o XFS: XFS: Simplify xfs_dir_lookup_int
  o XFS: XFS: Remove some dead prototypes in pagebuf
  o XFS: Switch to mpage_readpage
  o XFS: More mount code cleanups
  o XFS: Fix the mount-cleanup for single-subvolume filesystems
  o XFS: Implement readv/writev

<info@usblcd.de>:
  o USBLCD updates

<jdthood@yahoo.co.uk>:
  o PnP BIOS ESCD sanity check

<jgrimm@jgrimm.austin.ibm.com>:
  o SCTP:  Resync with LKSCTP tree

Stephen Lord <lord@sgi.com>:
  o XFS: Fold some code paths together in the xfs fsync implementation
  o XFS: Avoid writing data out to disk twice!

<luc.vanoostenryck@easynet.be>:
  o #include <linux/version.h> missing in drivers/usb/host/ohci-hcd.c

<perex@pnote.perex-int.cz>:
  o ISA PnP change Jens Thoms Toerring
    <Jens.Toerring@physik.fu-berlin.de>

<rgcrettol@datacomm.ch>:
  o USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix

<stern@rowland.org>:
  o usb-storage: fix return codes

<stuartm@connecttech.com>:
  o USB: clean up the error logic for open() in the usb-serial driver
  o usb whiteheat driver update

Ted Ts'o <tytso@mit.edu>:
  o loop device broken in 2.5.38

Matthew Wilcox <willy@debian.org>:
  o flock_lock_file livelock fix
  o fix file_lock_cache leak
  o Remove NetNews.html

<yoshfuji@linux-ipv6.org>:
  o [IPv6]: Verify ND options properly

<yuri@acronis.com>:
  o USB storage: Another (!) patch for the abort handler

Adrian Bunk <bunk@fs.tum.de>:
  o gendisk typo fixes

Alexander Viro <viro@math.psu.edu>:
  o Re: Linux 2.5.38
  o tapeblock blk_size removal
  o kills CURRENT in floppy.c
  o Lindent pd.c
  o cleanup of pd.c
  o gendisk for amiflop
  o gendisk for ataflop
  o gendisk for z2ram
  o gendisk for mtdblock
  o compile fixes for ftl
  o blk_size[] is gone

Andi Kleen <ak@muc.de>:
  o Minor ACPI changes for x86-64
  o Fix ELF name for x86-64
  o Hammer aperture driver for 2.5.38
  o PCI ID for AMD 8151 AMD bridge
  o disable early console in console_init

Andrew Morton <akpm@digeo.com>:
  o 64-bit type correctness in filemap.c
  o fix ext3 in data=writeback mode
  o don't hold mapping->private_lock while marking a page dirty
  o infrastructure for monitoring queue congestion state
  o use the queue congestion API in ext2_preread_inode()
  o use the congestion APIs in pdflush
  o low-latency page reclaim
  o direct-io bandaid
  o hugetlb fix
  o mprotect_fixup fix
  o prepare_to_wait/finish_wait sleep/wakeup API
  o use prepare_to_wait in VM/VFS
  o slab reclaim balancing
  o increase traffic on linux-kernel
  o speed up sys_sync()
  o tighter locking in pdflush
  o export test_clear_page_dirty() to modules

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o [LLC] remove not needed functions, use llc_sap_find in llc_sock
  o [LLC] kill llc_ui_bh_find_sk_by_addr
  o [UDPv6] fix udp_v6_get_port introduced by the sock splitup
  o [LLC] use sk->state_change when p_flag is cleared or core state
    changes
  o [LLC] use the core lists to get info for /proc/net/llc
  o [LLC] Make llc_save_primitive ready for dataunit/xid/test DGRAM
    packets
  o [LLC] move reason to the {station,sap,conn}_ev structs
  o [LLC] kill sap->{ind,conf}, finally!
  o [LLC] clean up the ui sending routines and core
  o [LLC] use struct sock list members
  o [LLC] remove sap->mac_pdu_q, not used at all
  o [LLC] keep the skb in llc_sap_state_process
  o [LLC] move sap->rcv_func call to llc_rcv
  o [SNAP] make SNAP work again
  o [X25] remove unneeded typedef x25_address
  o [X25] make search functions that grab locks have just one exit
  o [LLC] stop using the BKL
  o [X25] handle return codes and code reoganization to have only one
    exit in functions
  o [X25] assorted code cleanup
  o [X25] convert sysctl_net_x25 to use designated initializers
  o [X25] code reorganization, eliminate duplicated code

Ben Collins <bcollins@debian.org>:
  o RCS files exclusion (and add subversion)

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix off-by-one error in dbNextAG
  o JFS: Fix problems with NFS
  o JFS: detect and fix invalid directory index values
  o JFS: Remove assert(i < MAX_ACTIVE)

David Brownell <david-b@pacbell.net>:
  o ohci-hcd, queue fault recovery + rm DEBUG
  o ehci-hcd: update
  o USB shutdown oopser

David Gibson <david@gibson.dropbear.id.au>:
  o Orinoco driver update

David S. Miller <davem@nuts.ninka.net>:
  o [BRIDGE]: Missing headers from ebtables merge
  o net/ipv4/netfilter/ip_conntrack_proto_tcp.c: Include linux/string.h

Eric Sandeen <sandeen@sgi.com>:
  o XFS: Remove unused function xfs_vn_iget()

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix for ezusb firmware download
  o USB:  made port_softint global for other usb-serial drivers to use
  o USB: convert the usb-skeleton.c driver to work with the latest USB
    core changes
  o USB: fix ifnum usage that was missed in the previous irda-usb patch
  o add hotplug support to the driver core for devices, if their bus
    type supports it
  o converted USB to use the driver core's hotplug call
  o converted PCI to use the driver core's hotplug call

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: Trivial fixes

Ingo Molnar <mingo@elte.hu>:
  o pidhash cleanups, tgid-2.5.38-F3
  o de-xchg fork.c
  o pgrp-fix-2.5.38-A2
  o thread-flock-2.5.38-A3
  o pidhash-2.5.38-A0
  o exit-fix-2.5.38-E3
  o exit-fix-2.5.38-F0
  o kksymoops-2.5.38-C9
  o virtual => physical page mapping cache

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o Re: 2.5.36 IDE fixes
  o another alpha update
  o ALi and Cypress IDE fixes

James Morris <jmorris@intercode.com.au>:
  o net/ipv4/netfilter/ipchains_core.c: Use GFP_ATOMIC under ip_fw_lock

Javier Achirica <achirica@ttd.net>:
  o airo wireless: use ETH_ALEN constant where appropriate
  o airo wireless: disable card while prom flashing is in progress
    [note - more work needs to be done here, but this is better than
    nothing -jgarzik]
  o airo wireless: more verbose MAC-enable errors
  o airo wireless: power down on if down, define local 'ai' to fix
    build
  o airo wireless: fix "non-probe mode" setup
  o airo wireless: Fixes signal level retrieval in SPY mode (releases
    memory block after read out)

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o USB: convert the irda-usb driver to work properly with the new USB
    core changes

Jean Tourrilhes <jt@hpl.hp.com>:
  o More IrDA __FUNCTION__ cleanups, merged from -ac
  o More IrDA __FUNCTION__ cleanups (contributed by Philipp Matthias
    Hahn)
  o 64-bitness fixes for IrDA irlan protocol code (fixing the new
    hashbin code)
  o Minor Wavelan wireless net driver fixes

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o s/schedule_timeout(0)/yield/ in cdu31a, sonycd535, sb1000, and
    sis900 drivers

Jens Axboe <axboe@suse.de>:
  o more bio updates
  o trm compile
  o pdc4030
  o bio_get_nr_vecs
  o ide io scheduler thing
  o deadline scheduler
  o remove elevator_linus
  o deadline ioscheduler cleanups
  o io scheduler update
  o more io scheduler updates

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: per net device auto hangup function
  o ISDN: Switch isdn_net_hangup() to work on isdn_net_local *
  o kbuild: clean up i386 subarch build
  o kbuild: Fix modversions generation glitch
  o ISDN: per-interface hangup timer
  o kbuild: Clean up tags/TAGS targets
  o kbuild: arch/alpha cleanup / O_TARGET removal
  o kbuild: arch/arm cleanup / O_TARGET removal
  o kbuild: arch/cris cleanup / O_TARGET removal
  o kbuild: arch/ia64 cleanup / O_TARGET removal
  o kbuild: arch/m68k cleanup / O_TARGET removal
  o kbuild: arch/mips cleanup / O_TARGET removal
  o kbuild: arch/mips64 cleanup / O_TARGET removal
  o kbuild: arch/parisc cleanup / O_TARGET removal
  o kbuild: arch/ppc cleanup / O_TARGET removal
  o kbuild: arch/ppc64 cleanup / O_TARGET removal
  o kbuild: arch/s390 cleanup / O_TARGET removal
  o kbuild: arch/s390x cleanup / O_TARGET removal
  o kbuild: arch/sh cleanup / O_TARGET removal
  o kbuild: arch/sparc cleanup / O_TARGET removal
  o kbuild: arch/sparc64 cleanup / O_TARGET removal
  o kbuild: arch/um cleanup / O_TARGET removal
  o ISDN: PPP cleanups
  o ISDN: Kill isdn_net_autohup()
  o ISDN: ISDN_GLOBAL_STOPPED cleanup
  o ISDN: Use <linux/list.h> for list of phone numbers
  o ISDN: Lock list of phone numbers appropriately
  o kbuild: Convert missed L_TARGET references
  o ISDN: Fix build when CONFIG_ISDN_TTY_FAX is not set

Linus Torvalds <torvalds@home.transmeta.com>:
  o IDE: Try to use PCI dma_mask only if the device actually _is_ PCI
  o Terminate a failed IO properly
  o Merge with DRI CVS tree
  o Avoid possibly busy-looping in mouse read
  o Remove busy-wait for short RT nanosleeps. It's a random special
    case and does the wrong thing for higher HZ values anyway.
  o Make the ACPI SCI interrupt get the right polarity when it is
    explicitly overridden in the MADT
  o Avoid NULL ptr dereference on module names by always having a valid
    name (base kernel: "").
  o Update x86 defconfig to reflect new config options
  o Add CVS files to the list of files ignored by "find".and make the
    same ignore rules for "tar" as well.
  o Simplify elevator algorithm, make it prefer reads heavily

martin.bligh@us.ibm.com <Martin.Bligh@us.ibm.com>:
  o NUMA-Q fixes

Mikael Pettersson <mikpe@csd.uu.se>:
  o fix UP_APIC linkage problem in 2.5.3[78]

Nathan Scott <nathans@sgi.com>:
  o XFS: XFS: Cleanup mount argument manipulation, sanitize
    xfs_cmountfs and move the

Patrick Mochel <mochel@osdl.org>:
  o Driver model: improve support for system devices
  o Driver model: handle devices registered with ->driver set
  o USB: fixup handling of generic USB driver
  o driver model: add support for CPUs
  o driver model: add support for multi-board systems
  o driver model: add better platform device support
  o add disk device class

Paul Mackerras <paulus@samba.org>:
  o fix null dereference in sys_mprotect

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o [NCPFS]: 32->64bit sparc64 conversions
  o Fix matroxfb compile when G450 support is not selected
  o Fix matroxfb compile on m68k

Robert Love <rml@tech9.net>:
  o s/preempt_count()/in_atomic() in do_exit()
  o remove preempt workaround in slab.c
  o per-cpu data preempt-safing

Rusty Russell <rusty@rustcorp.com.au>:
  o UP cpu_possible
  o export cpu_callout_map for SMP modules

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o sb1000 net driver: kill float constant, time_after_eq() jiffies
    cleanup
  o trivial typo in drivers/ide/pci/sl82c105.c
  o fix compares of jiffies


