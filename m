Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUE3Uzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUE3Uzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUE3Uzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:55:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264382AbUE3UzG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:55:06 -0400
Date: Sun, 30 May 2004 17:56:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre4
Message-ID: <20040530205602.GA18637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes 2.4.27-pre4. 

It contains a TCP update (backporting some 2.6.x work), XFS/JFS updates, 
some architecture updates, driver fixes, the usual...

Please read the detailed changelog for details

Summary of changes from v2.4.27-pre3 to v2.4.27-pre4
============================================

<akepner:sgi.com>:
  o [TG3]: Fix ethtool -S
  o [TG3]: Make sure RX/TX flow control settings actually get set

<felixb:sgi.com>:
  o [XFS] Remove speculative preallocation from linvfs_get_block_core

<fsgqa:sgi.com>:
  o [XFS] Remove the 128K limitation on pagebuf_get_no_daddr() and allow the kmem_alloc() to fail.

<gnb:melbourne.sgi.com>:
  o [TG3]: Count rx_discards in rx_errors
  o [TG3]: Add more ethtool -S stats

<joshk:triplehelix.org>:
  o [SPARC64]: Pull in drivers/i2c/Config.in
  o [SPARC64]: Use $(CC) in check for egcs/gcc3
  o [SPARC64]: Backport some lvalue warning fixes from 2.6.x
  o [SPARC32]: Use $(LD) -V for NEW_GAS check

<jpk:sgi.com>:
  o [XFS] xfs_iomap_write_delay() was doing speculative allocations without checking if there were any real blocks already in the speculative allocation area. This could result in an allocation that overlaps pre-allocated space. This would result in an ASSERT failure in debug kernels, or invalid output from xfs_bmap.
  o [XFS] Add support for allocating additional file space in stripe width sized chunks. A new fstab/mount option, "swalloc" has been defined. If specified when mounting a striped file system, allocation requests will be rounded up to a stripe width if the file size is >= stripe width, and the data is being appended to eof. The 'swalloc' option is "off" by default.

<linux-kernel:vortech.net>:
  o [VLAN]: Use KERN_INFO for VLAN_INF

<mhuth:mvista.com>:
  o [IPV6]: Fix sock identity checking bug in tcp_ipv6_check_established

<michael.waychison:sun.com>:
  o cramfs use pagecache

<tony.cureington:hp.com>:
  o [TG3]: Add eeprom dump support

<zli4:cs.uiuc.edu>:
  o [SPARC]: Fix prom_prom_taken[].theres_more setting

Adrian Bunk:
  o [ATALK]: Fix modular build
  o [NET]: Missing MODULE_LICENSE in p8022 and psnap
  o SCSI ips compile error

Andi Kleen:
  o Fix pageattr cache flushing on P4 (thanks to Terence Ripperda)

Andrew Morton:
  o use-before-uninitialized value in ext3(2)_find_ goal

Christoph Hellwig:
  o [XFS] fix direct user memory dereference in bulkstat
  o [XFS] Use macros instead of inlines for spinlock wrappers to aid debugging.

Christophe Saout:
  o [CRYPTO]: Fix two scatterwalk problems

Dave Kleikamp:
  o JFS: error in __get_metapage caused by invalid size from ea_get
  o JFS: Don't return -EPERM for system xattrs
  o JFS: Make sizes of tid_t & lid_t consistent
  o JFS: [CHECKER] Memory leak on commonly executed path
  o JFS: [CHECKER] Dereference of NULL pointer if alloc_metapage fails
  o JFS: [CHECKER] if txCommit fails, don't call d_instantiate
  o JFS: fix hang in __get_metapage

David S. Miller:
  o [TG3]: Add 572x/575x PCI IDs
  o [TG3]: Add 5750 chip and PHY IDs
  o [TG3]: Prepare for 5750 support plus minor fixes
  o [TIGON3]: Detect and record PCI Express
  o [TG3]: PCI Express 5750_A0 chips need 5701_REG_WRITE_BUG treatment
  o [TG3]: Fix chiprev test in previous change
  o [TG3]: Do not set CLOCK_CTRL_DELAY_PCI_GRANT on PCI Express
  o [TG3]: Double delay after writing MAC_MI_MODE reg
  o [TG3]: Correct RDMAC/WDMAC mode settings on 5705/5750
  o [TG3]: Do not write stats coalescing ticks reg on 5705/5750
  o [TG3]: Update to 5788 capable 5705 TSO firmware, version 1.2.0
  o [TG3]: Update to non-5705 TSO firmware version 1.6.0
  o [TG3]: If asked to load TSO firmware on 5750, just return success
  o [TG3]: Add 5750 NVRAM programming plus 5704 MAC offset bug fix
  o [TG3]: Update LED programming to support 5750
  o [TG3]: Updated ASF handling for 5750
  o [TG3]: Include mss in every txd, not just the first, on 5750
  o [TG3]: On 5750 with TSO, need to set some special reg bits
  o [TG3]: Full chip reset tweaks for 5750
  o [TG3]: More 5750 chip reset tweaks
  o [TG3]: Do not enable slow clocks on 5750 with ASF
  o [TG3]: Rewrite dma_rwctrl settings to handle PCIX/PCIE
  o [TG3]: Add 572x/575x PCI IDs to driver table, update vers/reldate
  o [SPARC64]: Update defconfig
  o [TG3]: Update driver version and reldate
  o [NET]: Fix common typo, using NODEV when we mean ENODEV
  o [TG3]: Fix phantom spaces added to pci.ids file
  o [TCP]: Kill distance enforcement between tcp_mem[] elements
  o [TCP]: Abstract out all settings of tcp_opt->ca_state into a function
  o [TCP]: Backport Vegas support from 2.6.x
  o [TCP]: Backport BIC TCP from 2.6.x
  o [TCP]: Add tcp_default_win_scale sysctl
  o [TCP]: Add receiver side RTT estimation
  o [TCP]: Grow socket receive buffer based upon estimated sender window
  o [TCP]: More sysctl tweakings for rcvbuf stuff

Dean Roehrich:
  o [XFS] Dmapi preunmount event references null pointer

Dely Sy:
  o Documentation for new PCI hotplug drivers

Dmitry Torokhov:
  o [NET_SCHED]: Do not oops when user tries to attach a filter to a TBF qdisc

Eric Dean Moore:
  o MPT Fusion driver 2.05.16 update

Eric Sandeen:
  o [XFS] guard against unused var in new mutex_spinunlock #define

François Romieu:
  o CPUID Pentium-4E update and missing new line

Hideaki Yoshifuji:
  o [IPV6] ensure to evaluate the checksum for sockets with the IPV6_CHECKSUM option
  o [NET]: Prevent future missed updates of FOO_MAX macros

Hugh Dickins:
  o tmpfs surplus page miscounted

Jakub Bogusz:
  o missing include in drivers/sound/kahlua.c

Jeff Garzik:
  o [netdrvr tg3] netdev_priv
  o [netdrvr tg3] sync with 2.6.x

Len Brown:
  o [ACPI] delete IOAPIC-disable workaround on x86_64/VIA BTW. looks like 2.6 has an IOMMU disable workaround here that may be needed or VIA in 2.4.
  o [ACPI] revert button module unload fix (OSDL 2281) Cset exclude: len.brown@intel.com|ChangeSet|20040504154434|56458 Cset exclude: len.brown@intel.com|ChangeSet|20040428081912|57065 Cset exclude: len.brown@intel.com|ChangeSet|20040428054017|55837
  o [ACPI] remove /proc files before unloading modules from Sau Dan Lee, Zhenyu Wang http://bugzilla.kernel.org/show_bug.cgi?id=2705
  o [ACPI] x86_64 + ACPI + IOAPIC + PCI Interrupt Link -> IRQ 0 from Andy Currid

Marcelo Tosatti:
  o ext3_read_super: remove [un]lock_super  (Andrew Morton)
  o Changed EXTRAVERSION to -pre4

Nathan Scott:
  o Fix an incorrect email address in XFS maintainers section
  o [XFS] Remove unused transaction pointer from bulkstat
  o [XFS] Bump the kmalloc/vmalloc cutoff up to 128k
  o [XFS] Make uses of extended inode flags consistent, remove duplicated code
  o [XFS] Fix some compiler warnings, mark cmn_err as printflike
  o [XFS] Fixup a couple of incorrect xfs_trans_commit calls (bad flags/casts).
  o [XFS] Export/import tunable time intervals as centisecs not jiffies
  o [XFS] Switch all XFSDEBUG to DEBUG
  o [XFS] Fix a use-after-free during transaction commit when the log is in error state.
  o [XFS] Use set_current_state instead of direct current->state assignment
  o [XFS] Remove xfs_swappable code, its not useful on Linux
  o [XFS] Remove no-longer-used variable in log write code, and a dated comment.
  o [XFS] Remove unused xfs_trans_bhold_until_committed and related macros
  o [XFS] Rename a subdirectory to make life easier for people (esp

Oleg Drokin:
  o Fix possible memleaks in VIA IrDA driver

Patrick McHardy:
  o [IPV4]: Fix skb leak in igmpv3_newpack

Paul Mackerras:
  o Fix incorrect PT_FPSCR definition

Sridhar Samudrala:
  o [SCTP] Fix memset() parameter ordering
  o [SCTP] Fix accessing Gap Ack blocks array with a -ve index in sctp_outq_sack()
  o [SCTP]: Fix multihomed connection failures on 64-bit systems

Stephen Hemminger:
  o [BRIDGE]: Update bridge.txt
  o [TCP]: Add sysctl to turn off metrics caching
  o [TCP]: Add vegas sysctl docs

Timothy Shimmin:
  o [XFS] Change xfs_contig_bits to work on 32/64 and both endian styles

Trond Myklebust:
  o NFS client: Fix sillydelete()

