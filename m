Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSK1Xt1>; Thu, 28 Nov 2002 18:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSK1Xt0>; Thu, 28 Nov 2002 18:49:26 -0500
Received: from hera.kernel.org ([63.209.29.2]:31976 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id <S266849AbSK1Xrf>;
	Thu, 28 Nov 2002 18:47:35 -0500
Date: Thu, 28 Nov 2002 15:54:56 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200211282354.gASNsuT10229@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.20 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.20-rc4 was released as 2.4.20 with no changes.


Summary of changes from v2.4.20-rc3 to v2.4.20-rc4
============================================

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc4
  o Cset exclude: ralf@dea.linux-mips.net|ChangeSet|20021030170645|00078

<ralf@dea.linux-mips.net>:
  o The BLKGETSIZE ioctl expects an unsigned long argument

Adrian Bunk <bunk@fs.tum.de>:
  o Fix ips driver .text.exit errors

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix the fix

Oleg Drokin <green@namesys.com>:
  o Do not allow to mount reiserfs with blocksize != 4k

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix arch/ppc/Makefile so it builds on POWER3
  o PPC32: Ignore SIGURG if not caught

Rui Sousa <rui.sousa@laposte.net>:
  o Emu10k1 bugfixes

Summary of changes from v2.4.20-rc2 to v2.4.20-rc3
============================================

<akpm@digeo.com>:
  o Change mark_dirty_kiobuf() to use set_page_dirty() instead of SetPageDirty(). The latter fails to move onto mapping->dirty_pages(), which breaks filemap_fdatasync()
  o Writeout directory blocks synchronously in case of sync mount

<hch@lst.de>:
  o update kbuild/makefiles.txt to match reality

<lee@compucrew.com>:
  o Fix typo in mk712 driver

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc3
  o Fix typo in vmalloc leak fix
  o Fixup pci_alloc_consistent with 64bit DMA masks on i386

Adrian Bunk <bunk@fs.tum.de>:
  o Fix Intermezzo compilation

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o makefiles for 2.4.20-rc* to build amd76x_pm right

Dave Jones <davej@suse.de>:
  o Plug leak in get_vm_area()

David S. Miller <davem@nuts.ninka.net>:
  o [TG3]: Use spin_lock_irq{save,restore} on tx_lock

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 corruption/deadlock fix

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o PCI transparent bridge detection fix

Jens Axboe <axboe@suse.de>:
  o Fix SCSI I/O performance problems introduced in early 2.4.20

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix error path in isdn_ppp.c

Rik van Riel <riel@conectiva.com.br>:
  o Only zero successfully handled blocks in prepare_write()

tmcreynolds@nvidia.com <TMcReynolds@nvidia.com>:
  o Add support for newer nForce chipset

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS client problem






Summary of changes from v2.4.20-rc1 to v2.4.20-rc2
============================================

<trini@kernel.crashing.org>
	[PATCH] Fix a thinko in arch/ppc/kernel/ppc_ksyms.c
	
	The last change to arch/ppc/kernel/ppc_ksyms.c forgot a '||'.
	
	Please apply this to 2.4.20-rc1, thanks.
	
	--
	Tom Rini (TR1265)
	http://gate.crashing.org/~trini/
	
	===== arch/ppc/kernel/ppc_ksyms.c 1.22 vs edited =====

<marcelo@freak.distro.conectiva>
	Undo latest hid-input fixes: they are broken.

<Andries.Brouwer@cwi.nl>
	[TCP] Do not update rcv_nxt until ts_recent is updated.

<davem@nuts.ninka.net>
	[SPARC64]: Translate SO_{SND,RCV}TIMEO socket options.

<davem@nuts.ninka.net>
	[SPARC64]: Handle kernel integer divide by zero properly.

<rth@are.twiddle.net>
	Fix carry ripple in 3 and 4 word addition and subtraction macros.

<trond.myklebust@fys.uio.no>
	[PATCH] another kmap imbalance in 2.4.x/2.5.x RPC
	
	>>>>> Andrew Ryan <andrewr@nam-shub.com> writes:
	     > So far so good on the crashes.  I'm able to get through a
	     > complete run of dbench using TCP mounts on 2.4.20rc1, which I
	     > haven't been able to do before this.
	
	Marcelo, Linus
	
	  We've uncovered yet another kmap imbalance in the new RPC code. This
	looks like it might be the last one (my debugging printks have been
	unable to unearth any more). One line fix + 4 line comment
	appended. Please apply to both 2.4.20-rc1 and 2.5.45...
	
	Cheers,
	  Trond

<cel@citi.umich.edu>
	[PATCH] : sock_writable not appropriate for TCP sockets
	
	hi marcelo-
	
	[ i sent this patch August 30 against 20-pre5, and it appears to have been
	dropped.  this is an important performance fix that should be included in
	2.4.20.  i apologize for not tracking this more closely. ]
	
	
	sock_writeable determines whether there is space in a socket's output
	buffer.  socket write_space callbacks use it to determine whether to wake
	up those that are waiting for more output buffer space.
	
	however, sock_writeable is not appropriate for TCP sockets.  because the
	RPC client's write_space callback uses it for TCP sockets, the RPC layer
	hammers on sock_sendmsg with dozens of write requests that are only a few
	hundred bytes long when it is trying to send a large write RPC request.
	this patch adds logic to the RPC layer's write_space callback that
	properly handles TCP sockets.
	
	patch reviewed by Trond, Alexey, and DaveM, and already accepted in 2.5.

<edward_peng@dlink.com.tw>
	sundance net driver updates:
	- fix crash while unloading driver
	- fix previous fixes to apply only to specific chips
	- new tx scheme, improves high-traffic stability, not racy

<davem@nuts.ninka.net>
	[SPARC64]: Check DRM_NEW not DRM in ioctl32.c

<uzi@uzix.org>
	[SPARC64]: 0x22/0x10 is Ultra-I/spitfire.

<mkp@mkp.net>
	[PATCH] Update credits
	
	Marcelo,
	
	Please apply this trivial patch.
	
	--
	Martin K. Petersen      http://mkp.net/

<VANDROVE@vc.cvut.cz>
	[PATCH] Fix ncpfs file creation issue
	
	This patch fixes longstanding bug in ncpfs: when 'executable' bit
	is set on file creation, it is translated wrong to the server.
	
		Because of this bug is there for years, if it is only problem
	with 2.4.20-rc1, just release 2.4.20, and put this into 2.4.21-pre1...

<jgarzik@redhat.com>
	Use dev_kfree_skb_any not dev_kfree_skb in tg3 net driver
	function tg3_free_rings.
	  
	Spotted by DaveM.

<zaitcev@redhat.com>
	[sparc] Fix off-by-one in s/g handling

<bcollins@debian.org>
	[TG3]: TG3_HW_STATUS_SIZE should be 0x50 not 0x80.

<davem@nuts.ninka.net>
	[SPARC64]: Fix accidental clobbering of register on cheetahplus.

<tytso@think.thunk.org>
	HTREE backwards compatibility patch.
	
	I thought (and assumed) this patch had been applied to both the ext2
	and ext3 filesystems in the 2.4 kernel.  It turns out it had only made
	it into the ext3 filesystem code.   This means that if an 
	HTREE-enabled filesystem is mounted using ext2, it will corrupt 
	the filesystem as far as e2fsck and an ext3 htree-enabled kernel is
	concerned.  (The corruption won't cause any data loss, but it will
	cause e2fsck and an ext3-htree kernel to omit a lot of warning
	messages.)
	 

<alan@lxorguk.ukuu.org.uk>
	[PATCH] Enable the merged AMD pm driver
	

<vojtech@suse.cz>
	[PATCH] Add vt8235 support
	
	Hi!
	
	This patch adds support for the vt8235. Marcelo, please apply it to
	current 2.4.20 rc. It doesn't break anything, basically adds and entry
	to the table of supported devices. Thanks.

<c-d.hailfinger.kernel.2002-Q4@gmx.net>
	[PATCH] restore framebuffer console after suspend
	
	Marcelo,
	
	this patch fixes the case when a laptop was suspended and resumed while a
	framebuffer console was active, the console would not be redrawn.
	
	After a discussion with Benjamin Herrenschmidt, we both agree that this
	patch is the best solution. It is the same as my first patch with this
	subject, just resent because there was some confusion about which patch was
	best.
	
	Please apply for 2.4.20-rc2.
	
	Thanks
	Carl-Daniel
	
	    [ Part 2: "Attached Text" ]

<R.E.Wolff@BitWizard.nl>
	[PATCH] Fix SX driver detection
	
	Ehmm. Typos in your mail address. sssooo ssssoooorrryyyy ... :-)
	
			Roger.

<hch@sgi.com>
	[PATCH] fix file system corruption under load
	
	When QA testing XFS 1.2 we observed in-memory corruption under extreme
	load (fsx, usemem & bash-shared-mapping) when using block size < pagesizes.
	
	In addition to some bugs inside XFS Russell Cattelan found a problem in
	end_buffer_io_async.
	
	The problem is that end_buffer_io_async sets the page uptodate as soon
	as there are no more async or locked buffers, which is wrong if only
	parts of the page are submitted for I/O (i.e. writes not on the page
	boundary, etc..)

<marcelo@freak.distro.conectiva>
	Reverse order of BK config checkout entries

<marcelo@freak.distro.conectiva>
	Changed EXTRAVERSION to -rc2

<davem@redhat.com>
	Fix tg3 net driver to properly disable interrupts during some TX operations

<vandrove@vc.cvut.cz>
	[PATCH] Fix lcall DoS
	
	Hi,
	   your original code just behaved as my old code: run modprobe successfully,
	and then die. Problem is that copy of eflags on stack is totally unimportant
	to us: current value in eflags is what matters. So this is minimal
	patch which works here: NT, DF and TF are now cleared only for kernel,
	and when we return back from lcall, userspace has its old values.
	
	   Optimization left to readed is creating SAVE_ALL_NOCLD, and using this
	one in lcall7 and lcall27.
	
	   With patch below my machine survived test. Unfortunately I do not
	have patched kernel with linux-abi to test whether lcall7 still works
	correctly.
							Best regards,
								Petr Vandrovec
								vandrove@vc.cvut.cz

Summary of changes from v2.4.20-pre11 to v2.4.20-rc1
============================================

<adam@nmt.edu>:
  o 3ware driver update

<akropel1@rochester.rr.com>:
  o The following patch adds support for ethtool to the ewrk3 driver. It is against 2.5-BK but should apply to any recent 2.5 and 2.4 as well. In addition to adding ethtool support, it also removes the cli/sti fixup attribution from the changelog since that didn't actually go in yet and fixes a small style issue I introduced in the multi-card support patch.
  o This patch adds some locking fixups to the ewrk3 ioctl routine. None of these are critical since the ioctls AFAIK are used only by the EEPROM config utility.
  o Last ewrk3 for now. Updates the changelog to cover previous patches, bumps the revision number, and replaces the horrific EthwrkSignature function with something (slightly) less horrific.

<bheilbrun@paypal.com>:
  o Add missing part of DMI update

<dhinds@sonic.net>:
  o Change David Hinds email address
  o axnet_cs update
  o nmclan_cs update: fixed cut-and-paste bug in ethtool ioctl handler
  o pcnet_cs update

<fw@deneb.enyo.de>:
  o [TCP]: In TCP_LISTEN state, ignore SYNs with RST set

<jeb.j.cramer@intel.com>:
  o e1000 1/11
  o e1000 2/11
  o e1000 3/11
  o e1000 4/11
  o e1000 5/11
  o e1000 6/11
  o e1000 7/11
  o e1000 8/11
  o e1000 9/11
  o e1000 10/11
  o e1000 11/11

<jgarzik@redhat.com>:
  o Remove cli/sti from ewrk3 net driver
  o Fix tulip net driver multi-port board irq assignment

<johnstul@us.ibm.com>:
  o Fix compile problems with local APIC enabled

<komujun@nifty.com>:
  o Add PCI id to tulip net driver

<leigh@solinno.co.uk>:
  o PPC32: Minor fix in parsing the BI_CMD_LINE bi_record

<marcelo@freak.distro.conectiva>:
  o Add [davem]checkout:none
  o Fix pSeries Hypervisor console Config.in entry
  o Remove debugging printk in ide code
  o Changed EXTRAVERSION to -rc1

<mashirle@us.ibm.com>:
  o [IPV6]: Fix bugs in PMTU handling

<mgreer@mvista.com>:
  o PPC32: Allow the IBM Spruce board to be compiled with gcc-3.x

<okir@suse.de>:
  o Fix NFS IRIX compatibility braindamage

<shaggy@shaggy.austin.ibm.com>:
  o JFS: Add missing byte-swapping macros in xattr.c

<sparker@sun.com>:
  o drivers/net/eepro100.c: simplify wait_for_cmd_done(), better errors
  o drivers/net/eepro100.c: only set priv->last_rx_time if we did work
  o drivers/net/eepro100.c: mask the interrupt and do a small delay on close()

<thockin@freakshow.cobalt.com>:
  o drivers/net/eepro100.c
  o drivers/net/mii.c: only call netif_carrier_{on,off} if there is a state change
  o drivers/net/eepro100.c
  o drivers/net/natsemi.c: init msg_enable in proper way
  o drivers/net/eepro100.c: compile bugs
  o drivers/net/eepro100.c: eliminate speedo_intrmask
  o drivers/net/eepro100.c: cleanup messages that pop up since netif_msg_xxx change
  o drivers/net/eepro100.c: set the PHY ID correctly
  o drivers/net/mii.c: fix flipped logic
  o drivers/net/eepro100.c: set phy_id_mask and reg_num_mask in mii_if

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o dmi fixes from -ac
  o Update sisfb headers
  o del_timer_sync fixes for fmvj18x_cs net driver

Alexander Viro <viro@math.psu.edu>:
  o Fix devfs root boot option problem

Christoph Hellwig <hch@infradead.org>:
  o Fix bug in /proc/partitions handling code

David S. Miller <davem@nuts.ninka.net>:
  o arch/sparc64/kernel/pci_schizo.c: Enable error interrupts in correct PBM
  o [SPARC]: Set highmem_io in ESP and QLOGICPTI scsi drivers
  o arch/sparc64/defconfig: Update
  o [SPARC]: Fix typo in EBUS/QLOGICPTI highmem_io changes
  o arch/sparc64/mm/init.c: Initialize {min,max}_low_pfn properly
  o arch/sparc64/mm/init.c: Set max_pfn too
  o [ESP/QLOGICPTI]: Only set highmem_io on sparc64
  o arch/sparc64/kernel/ioctl32.c: Block ioctl handling fix
  o [SPARC64]: On broken cheetah, enable p-cache around large copies
  o [sparc64/ppc64/x86_64]: Fix socket fd leak in route ioctl32 translation
  o [SPARC64]: Disable old cheetah pcache optimization
  o arch/sparc64/kernel/ioctl32.c: Handle HDIO_GETGEO_BIG{,_RAW}
  o [IPV4]: When advmss of route is zero, report it as zero not 40

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 / shared-zlib cleanup

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Zorro ID update

Hugh Dickins <hugh@veritas.com>:
  o shmem missing cache flush

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha compile fix

Jens Axboe <axboe@suse.de>:
  o sr wrong return value

Kent Yoder <key@austin.ibm.com>:
  o Add link status checking to pcnet32 net driver

lowekamp@cs.wm.edu <lowekamp@CS.WM.EDU>:
  o Fix reordering of onboard PDC20265

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the compile for POWER3, we had an undefined variable

Scott Feldman <scott.feldman@intel.com>:
  o e100 1/5
  o e100 2/5
  o e100 3/5
  o e100 4/5
  o e100 5/5

Tom Callaway <tcallawa@redhat.com>:
  o arch/sparc64/solaris/misc.c: Add MODULE_LICENSE

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Compile ppc_generic_ide_fix_driveid if CONFIG_USB_STORAGE is not disabled.  This allows the USB Storage drivers which call ide_fix_driveid to be compiled on PPC32.
  o PPC32: On CONFIG_ALL_PPC, always have pmac_nvram around, as this cleans up the code nicely in some places and allows the PPC-specific nvram driver to be a module.

Tomas Szepe <szepe@pinerecords.com>:
  o [SPARC]: Move BTFIXUP-able code from inlined routines to the main kernel image

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Remove unbalanced kunmap() in NFS readdir code


Summary of changes from v2.4.20-pre10 to v2.4.20-pre11
============================================

<barryn@pobox.com>:
  o 2.4.20-pre10: make PL-2303 hack work again

<cel@citi.umich.edu>:
  o allow nfsroot to mount via TCP

<dhinds@sonic.net>:
  o Fixup PCMCIA thinko introduced by kmalloc failure handling patches

<eyal@eyal.emu.id.au>:
  o Fix brlvger driver compilation problem

<fubar@us.ibm.com>:
  o Prevent EFAULT errors when checking link status, in bonding net driver

<jeb.j.cramer@intel.com>:
  o e1000 net driver minor fixes/cleanups

<johnstul@us.ibm.com>:
  o Cleanup clustered APIC code to allow others to use it

<marcelo@freak.distro.conectiva>:
  o Do not state that 2.4 is under active development on "SubmittingDrivers" documentation file
  o Fix misuse of types in brlvger
  o Do not skip Promise ataraid's: they used to work fine with pdcraid
  o Changed EXTRAVERSION to pre11
  o Add PCI ID for SiS 646
  o Undo DMI updates. Its 2.4.21-pre stuff

<mkp@mkp.net>:
  o forte sound driver updates

<paul.mundt@timesys.com>:
  o SH5 support for shwdt

<rth@are.twiddle.net>:
  o Fix missed variable rename in stxncpy glibc conversion
  o Sync stxncpy with 2.5 changes

<shaggy@shaggy.austin.ibm.com>:
  o JFS: return code from sb_bread was incorrectly checked

<thockin@freakshow.cobalt.com>:
  o drivers/net/natsemi.c: sync with 2.5.x
  o drivers/net/natsemi.c: add dp83816 support
  o drivers/net/natsemi.c: janitorial - whitespace, wrap, and indenting cleanup
  o drivers/net/natsemi.c: stop tx/rx and reinit_ring on a PHY reset
  o drivers/net/natsemi.c: cleanup version string, fix compile error
  o drivers/net/natsemi.c: boost some printk() levels to WARN
  o drivers/net/natsemi.c: fix compile error - s/KERN_WARN/KERN_WARNING/

<wg@malloc.de>:
  o usbfs race while mounting/umounting

<zubarev@us.ibm.com>:
  o IBM PCI Hotplug: small patch

<zwane@linuxpower.ca>:
  o Add ethtool media selection to 3c509 net driver
  o Add ethtool media support to smc91c92_cs net driver

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entry for CONFIG_USB_MIDI
  o update address of the emu10k1-devel list

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o better code for C3
  o small parisc bits
  o Update LNZ credits entry
  o update kernel params docs
  o update submitting drivers
  o 2.5 backport for sleep with lock
  o watchdog updates
  o SIS 646 AGP
  o native power management for AMD 76x
  o dont set leds until keyboard tasklet is running
  o fix out of memory oops in sis_ds
  o another watchdog fix
  o add ali5451 joystick to config doc
  o fix missingchecks in hotplug
  o handle hisax init failure right
  o fix types in mac apm emu
  o fix broken comment, gcc 3.1 warning in video
  o atalk bits are ISA
  o gcc warning fixes for ethernet
  o fix ugly irda hack
  o ibm token ring updates
  o fix warning in cycx_x25
  o fixup Geode slave disconnect
  o 82092 missing license tag
  o fix oops with AHA2840 card
  o dont register missing gameports
  o fix maestro3 bug that broken m3 in earlier pre
  o more USB size fixes
  o update intermezzo
  o update ver_linux
  o update the SiS framebuffer

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Handle passive resets correctly in SYN-RECV

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o hid-input: fix find_next_zero_bit usage

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: MESH driver SMP fix

dan.zink@hp.com <Dan.Zink@hp.com>:
  o Compaq PCI Hotplug bug fix
  o Compaq PCI Hotplug bug fix 2

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: change name of get_index() to read_index()

David S. Miller <davem@redhat.com>:
  o Fix 2.4.19 mm performance regression due to P4 TLB fix

David Woodhouse <dwmw2@infradead.org>:
  o Deal with VFS calling clear_inode() and read_inode() simultaneously for the same inode

Greg Kroah-Hartman <greg@kroah.com>:
  o IBM PCI Hotplug driver: typo fix for previous patch
  o USB: fix ctsrts handling in pl2303 driver

Harald Welte <laforge@gnumonks.org>:
  o net/ipv6/netfilter/ip6t_LOG.c: Display ipv4 encapsulation properly
  o net/ipv4/netfilter/ip_conntrack_core.c: Fix ip_conntrack_change_expect locking
  o [NETFILTER]: Avoid nesting readlocks in conntrack code
  o net/ipv4/netfilter/ipt_unclean.c: Source port is allowed to be zero

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o [netdrvr] Use ADVERTISE_FULL in mii lib, to clean up duplex check
  o Merge ewrk3 net driver updates from 2.5.x

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: fix "IP frame delayed" bug
  o ISDN: Update md5sums.asc

Manfred Spraul <manfred@colorfullife.com>:
  o drivers/net/natsemi.c:  create a function for rx refill
  o drivers/net/natsemi.c: combine drain_ring and init_ring
  o drivers/net/natsemi.c: OOM handling
  o drivers/net/natsemi.c: stop abusing netdev_device_{de,a}ttach
  o drivers/net/natsemi.c: write MAC address back to the chip
  o drivers/net/natsemi.c: lengthen EEPROM timeout, and always warn about all timeouts
  o drivers/net/natsemi.c: comments update

Paul Mackerras <paulus@samba.org>:
  o missed drivers/macintosh bits
  o add hypervisor console for ppc64
  o ppc update for Configure.help
  o add Documentation/powerpc/cpu_features.txt

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Missing ncpfs bigendianness fix

Summary of changes from v2.4.20-pre9 to v2.4.20-pre10
============================================

<bjorn.andersson@erc.ericsson.se>:
  o net/8021q/vlan_dev.c: Fix lockup when setting egress priority

<devik@cdi.cz>:
  o net/sched/sch_htb.c: Check that node is really leaf before modifying cl->un.leaf

<hch@sgi.com>:
  o remove a dead extern
  o fix some O_DIRECT read cornercases

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to pre10

<rbh00@utsglobal.com>:
  o Several S390 3270 fixes

<yoshfuji@linux-ipv6.org>:
  o [IPV4/IPV6]: General cleanups

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entries for BeFS
  o trivial Configure.help bits from -ac

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Fusion driver fixes

Ben Collins <bcollins@debian.org>:
  o IEEE1394 updates

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Tweak the way various PPC cpus (750FX, 750CX, 745x) are set up
  o PPC32: Better support for the 750FX and 7455 PPC cpus
  o PPC32: support for new powermacs including the Xserve and eMac
  o PPC32: idle loop improvements for PPC 6xx/7xx/7xxx processors
  o PPC32: PCI fix for PCI-PCI bridges with the I/O window closed
  o PPC32: Fix race in i2c-keywest
  o PPC32: ide-pmac update
  o PPC32: ADB core locking fix
  o PPC32: Update net driver config description

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Releasing LOGGC_LOCK too early

David S. Miller <davem@nuts.ninka.net>:
  o [VLAN]: Accept zero vlan at unregister
  o net/core/dev.c: Print lethal dev/protocol errors with KERN_CRIT
  o net/8021q/vlan.c: Unsigned value may never be < 0

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 updates

Ingo Molnar <mingo@elte.hu>:
  o Fix speed braindamage of mass exit of thread groups

Lennert Buytenhek <buytenh@gnu.org>:
  o [NET]: Remove net_call_rx_atomic
  o [BRIDGE]: Skip the LISTENING_STP state if STP is disabled
  o [BRIDGE]: take BR_NETPROTO_LOCK for unlinking bridge device slaves

Paul Mackerras <paulus@samba.org>:
  o PPC32: Make the heartbeat count and reset variables be per-cpu
  o PPC32: update the default configs in arch/ppc/configs
  o PPC32: define register numbers for extra BATs; patch from Cort Dougan
  o PPC32: define TIOCM_MODEM_BITS, irda wants it
  o PPC32: Add support for the Total Impact BRIQ platform

Robert Love <rml@tech9.net>:
  o get_pid() typo fix

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Workaround NFS hangs introduced in 2.4.20-pre

Summary of changes from v2.4.20-pre8 to v2.4.20-pre9
============================================

<alex_williamson@attbi.com>:
  o fs/partitions/sun.c: raid autodetect for sun disk labels

<brihall@pcisys.net>:
  o Update for JMTek USBDrive

<devik@cdi.cz>:
  o net/sched/sch_htb.c: Verify classid and direct_qlen properly

<felipewd@terra.com.br>:
  o Support get-MII-data ioctls in 8139cp net driver

<hch@sgi.com>:
  o fix drm ioctl ABI default

<helgaas@fc.hp.com>:
  o pc_keyb.c: hook for keybd controller detection
  o Configure.help update (1/2)
  o AGPGART 2/5: size AGP mem correctly when memory is
  o ati_pcigart: support 16K and 64K page size
  o Configure.help update (2/2)
  o PCI ID database update

<jes@trained-monkey.org>:
  o acenic net drvr fix: remove '=' typo in intr mask writel()

<marcelo@freak.distro.conectiva>:
  o Place buffer dirtied in truncate() on inode's  dirty data list (Eric Sandeen)
  o Enable CONFIG_DRM_I810_XFREE_41 so we are compatible with XFree 4.1 as default
  o Changed EXTRAVERSION to -pre9

<rgcrettol@datacomm.ch>:
  o USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix

<schoenfr@gaaertner.de>:
  o net/ipv4/proc.c: Dont print dummy member of icmp_mib

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Bump ext3 version number
  o 2.4.20-pre4/ext3: Fix LVM snapshot deadlock
  o 2.4.20-pre4/ext3: jbd commit interval tuning
  o Sanity check for Intermezzo/ext3
  o ext3 commit notification for Intermezzo
  o Fix the order of inodes being marked dirty in a couple of corner cases

<thiel@ksan.de>:
  o Kernel TUN/TAP Documentation rework

<yoshfuji@linux-ipv6.org>:
  o [IPv6]: Verify ND options properly
  o net/ipv6/addrconf.c: Refine IPv6 Address Validation Timer
  o net/ipv6/ndisc.c: Add missing credits
  o net/ipv6/ip6_fib.c: Default route support on router

Adrian Bunk <bunk@fs.tum.de>:
  o add "If unsure, say N" to CONFIG_X86_TSC_DISABLE
  o Configure.help entry for the e100 driver (fwd)

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o security - various bits in iee1394
  o Fix config.in breakage from mips people
  o resend maestro3 update

Andi Kleen <ak@muc.de>:
  o Fix disabling of x86 capabilities from command line
  o Fix pageattr with mem=nopentium

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix problems with NFS
  o JFS: detect and fix invalid directory index values
  o JFS: Remove assert(i < MAX_ACTIVE)

David S. Miller <davem@nuts.ninka.net>:
  o net/ipv4/netfilter/ip_conntrack_proto_tcp.c: Include linux/string.h
  o drivers/block/ll_rw_blk.c: u64 is not necessarily long long
  o init/do_mounts.c: Protect cramfs stuff with CONFIG_BLK_DEV_RAM too
  o drivers/net/acenic.h: readl is not an lvalue
  o drivers/net/ppp_generic.c:ppp_receive_frame Kill unused local label

Edward Peng <edward_peng@dlink.com.tw>:
  o update sundance driver to support building on older kernel

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added Palm Zire support to the visor driver

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: Trivial fixes

James Morris <jmorris@intercode.com.au>:
  o net/ipv4/netfilter/ipchains_core.c: Use GFP_ATOMIC under ip_fw_lock

Javier Achirica <achirica@ttd.net>:
  o sync airo wireless driver with 2.5
  o airo wireless: use ETH_ALEN constant where appropriate
  o airo wireless: disable access to card while prom flashing in progress [note: more work needs to be done here, but this is better than nothing -jgarzik]
  o airo wireless: more verbose MAC-enable errors
  o airo wireless: power down on if down. add local 'ai' to fix build
  o airo wireless: fix "non-probe mode" setup
  o airo wireless: Fixes signal level retrieval in SPY mode (releases memory block after read out)
  o airo wireless net drvr: add Cisco MIC support Conditionally enabled when out-of-tree, but open source, crypto lib is present.

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o irtty MODEM_BITS additional fix

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Update eepro100 net driver's mdio_{read,write} functions to take 'struct net_device *' not 'long' as their first argument.  This makes eepro100 compatible with the standard MII ethtool API, preparing it for that support.
  o update eepro100 net driver to use standard MII phy API/lib, when implementing ethtool media ioctls.
  o Add new MII lib functions mii_check_link, mii_check_media
  o sundance net drvr: fix reset_tx logic (contributed by Edward Peng @ D-Link, cleaned up by me)
  o sundance net drvr: fix DFE-580TX packet drop issue, further reset_tx fixes (contributed by Edward Peng @ D-Link)
  o sundance net drvr: bump version to LK1.05
  o [net drivers] fix MII lib force-media ethtool path (contributed by Edward Peng @ D-Link)
  o sis900 net driver update
  o [net drivers] MII lib update
  o [net drivers] Rename MII lib API member, s/duplex_lock/force_media/, and update all drivers that reference this struct member.
  o Add MII lib helper func generic_mii_ioctl, use it in 8139cp net drvr
  o Use new MII lib helper generic_mii_ioctl in several net drivers
  o [net drivers] Remove 'dev' argument from generic_mii_ioctl helper
  o [net drivers] add optional duplex-changed arg to generic_mii_ioctl helper

Oliver Neukum <oliver@neukum.name>:
  o USB: update of hpusbscsi
  o USB: fixes for kaweth

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o [NCPFS]: 32->64bit sparc64 conversions

Richard Henderson <rth@twiddle.net>:
  o alpha strncpy fix

Rusty Russell <rusty@rustcorp.com.au>:
  o Remove list_head typedef

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o Fix sb1000 jiffies usage: kill float constant, use time_after_eq()
  o fix compares of jiffies


Summary of changes from v2.4.20-pre7 to v2.4.20-pre8
============================================

<adam@nmt.edu>:
  o 3ware driver update for 2.4.20-pre7 (resend)

<defouwj@purdue.edu>:
  o net/ipv4/ip_options.c: IPOPT_END padding needs to increment optptr

<info@usblcd.de>:
  o USBLCD updates

<kafai0928@yahoo.com>:
  o Use SET_MODULE_OWNER in eepro100 net driver instead of MOD_{INC,DEC}_USE_COUNT, eliminating a small race

<marcelo@freak.distro.conectiva>:
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20020924233624|33060
  o Changed EXTRAVERSION to -pre8

<ralf@dea.linux-mips.net>:
  o Remove the FBIO_SED1356_BITBLT ioctl which had a dangerous security hole.  That result in an empty s1356fb_ioctl, so nuke the entire ioctl-related code.

<rgs@linalco.com>:
  o Track link state via netif_carrier_xxx, in gmac net driver

<scottm@somanetworks.com>:
  o Small pcihpfs dnotify fix

<silicon@falcon.sch.bme.hu>:
  o comx-hw-munich WAN driver "performance fix": remove hideous udelay

<taka@valinux.co.jp>:
  o arch/i386/lib/checksum.S:csum_partial Handle oddly addressed buffers correctly

<wes@infosink.com>:
  o mwave fixes

<zubarev@us.ibm.com>:
  o IBM PCI Hotplug driver update
  o IBM PCI Hotplug driver update for ISA based devices
  o IBM PCI Hotplug driver update for PCI based controllers

Adrian Bunk <bunk@fs.tum.de>:
  o Fix xconfig screwup caused by MIPS merge

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ; unlimited kmalloc in i2c fix (Silvio Cesare)
  o Add missing watchdog checks
  o wrong sizes in amdtp (Silvio Cesare)
  o fix oops in hisax
  o fix mga hang
  o security - missing checks in video4linux (Silvio Cesare)
  o gmac fixups (Roberto Gordo Saez)
  o S390 misc fixes
  o remove escaped user space diagnostic code
  o tighten modem probe/naming for ac97 (me)
  o forte audio updates
  o Kaweth - align packets for non x86 (Oliver Neukum)
  o replace end user confusing "on fire" joke with real info
  o fix include in freecom.c (Andre Hedrick)
  o Security - vicam (Silvio Cesare)
  o big endian support for voodoo2 frame buffer
  o Warn if mounting an ext3fs as ext2
  o Add additional MSRs to definitions (Dominik Brodowski,
  o fix vmalloc corner case (Dave Miller)
  o quoting fix in unbz64wrap (me)
  o Changes updates (Niels Jensen)
  o doc pointer for khttpd
  o update maestro3 docs to match maestro3 code
  o Fix PCI gameport handling (me)
  o sign fix for i2c (Silvio Cesare)
  o Make trident use new pcigame interfaces (me)
  o add modem bits define for x86

Andi Kleen <ak@muc.de>:
  o ACPI fixes for x86-64
  o AGP for 8151/x86-64
  o x86-64 core changes to sync with x86-64.org
  o Minor change for x86-64 NUMA
  o x86-64 panic blink
  o Fix x86-64 fbcon
  o Fix some x86-64 bugs

Andrew Morton <akpm@zip.com.au>:
  o Fix "multiple definition of 'smc_init'" error in smc-ircc irda driver, by declaring smc_init static.

Ben Collins <bcollins@debian.org>:
  o IEEE-1394 updates

Benjamin LaHaise <bcrl@redhat.com>:
  o ns83820.c v0.20 -- a brown paper bag edition
  o ns83820 v0.20 fixup

charles.white@hp.com <Charles.White@hp.com>:
  o Add cpqarray/cciss entries to root_dev_names

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: cleanup -- Remove excessive typedefs
  o JFS: Avoid parallel allocations within the same allocation group
  o JFS: Slightly relax allocation group reservation
  o JFS: Put legacy OS/2 extended attributes in "os2." namespace
  o JFS: Fix compiler errors in xattr.c
  o JFS: Fix off-by-one error in dbNextAG

David Brownell <david-b@pacbell.net>:
  o usbnet sync w/2.5: new devs, ethtool, etc

David S. Miller <davem@nuts.ninka.net>:
  o [TIGON3]: Do not reference vlgrp unless TG3_VLAN_TAG_USED is set
  o [TIGON3]: Fix slight perf regression from TSO changes
  o [VLAN] Use unregister_netdevice to prevent rtnl double-lock
  o [TIGON3]: New way to flush posted writes of GRC_MISC_CFG
  o [NAPI]: Do not check netif_running() in netif_rx_schedule_prep
  o [NAPI]: Set SCHED before dev->open, clear if fails.  Restore netif_running check to netif_rx_schedule_prep
  o [TIGON3]: Comment out tg3_enable_ints PCI write flush for now
  o [TIGON3]: Use spin_lock_irqsave in tg3_interrupt, fixes SMP hang
  o arch/sparc64/defconfig: Update
  o [TIGON3]: Add 5704 support
  o [TIGON3]: GRC_MISC_CFG_BOARD_ID_5704CIOBE is wrong
  o [TIGON3]: Fiber WOL support, chip clock bug fix
  o [TIGON3]: Static initializer changes from 2.5.x driver
  o [TIGON3]: Fix some comment tabbing
  o [TIGON3]: Fix some extraneous trailing whitespace
  o include/linux/spinlock.h: Fix compiler version check
  o [TIGON3]: Fix link polarity setting on all non-5700 chips
  o [TIGON3]: Optimize NAPI irq masking a bit
  o [TIGON3]: Define NIC_SRAM_MBUF_POOL_SIZE64 properly
  o drivers/char/drm/drmP.h: Disable DRM_DEBUG
  o arch/sparc64/defconfig: Update
  o [SPARC64]: Trap kernel bogus program counter at fault time
  o [DRM]: Set DRM_DEBUG_CODE back to 2, comment out page_to_bus reference
  o [DRM]: Comment out another page_to_bus reference

David S. Miller <davem@redhat.com>:
  o Fix a couple compiler warnings in e100 net driver

Greg Kroah-Hartman <greg@kroah.com>:
  o export pci_scan_bus, as the IBM pci hotplug driver needs it
  o IBM PCI Hotplug driver: sync up with the 2.5 version (__init and formatting fixes)
  o USB: fix timeout value for ezusb firmware download function
  o USB: document struct usb_driver and add module owner field
  o PCI Hotplug: added max bus speed and current bus speed files to the pci hotplug core
  o PCI Hotplug: added speed status to the IBM driver
  o PCI Hotplug: added speed status to the Compaq driver
  o add export for __inode_dir_notify so dnotify can be used from filesystems in a modules
  o PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare
  o PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on
  o USB: fix oopses in hub.c.  Thanks to Alan Stern for pointing them out

Hugh Dickins <hugh@veritas.com>:
  o tmpfs 1/5 shmem_rename fixes
  o tmpfs 2/5 shmem_symlink like 2.5/ac
  o tmpfs 3/5 pretend dirent size
  o tmpfs 4/5 three trivia
  o tmpfs 5/5 closer to 2.5/ac

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha, arm, parisc: PCI setup update

Jan-Benedict Glaw <jbglaw@lug-owl.de>:
  o Sync up with 2.5: Doku/formatting updates for my srm_env.c

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add support for netif_carrier_xxx reporting to 3c59x net driver (based on a patch by Nelson Tan Gin Hwa, via Andrew Morton)
  o Merge up to version 1.04 of sundance net driver
  o Add support for Cirrus Logic GD7548 to clgenfb fbdev driver (contributed by gabucino@mplayerhq.hu)
  o Fix merge error in 3c59x netif_carrier_xxx change
  o merge most of the hppa support into tulip net driver
  o Fixes for little-used paths and obscure races, in 8139cp net driver (contributed by matthias@waechter.wiz.at)
  o Update list of airo wireless commands, and two RIDs, from linux-wlan-ng sources and online sources
  o sundance net driver fixes, and a few cleanups too
  o clean up previous sundance net driver fixes
  o sundance net driver modernization
  o Update eepro100 net driver hardware resume to Becker eepro100.c version
  o further sundance net driver fixes
  o Improve RX buffer size calculation, in sundance net driver (suggested by Donald Becker)
  o Kill more e100 net driver compile warnings

Jens Axboe <axboe@suse.de>:
  o Avoid innapropriate oversized scsi_malloc() calls
  o back out merge_only logic
  o ide-cd sense clearing

Jes Sorensen <jes@wildopensource.com>:
  o acenic net driver update

Marc Boucher <marc@mbsi.ca>:
  o Fix VAIO WXP01Z3 blacklist entry

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Fix error handling of pci_request_regions

matt_domsch@dell.com <Matt_Domsch@dell.com>:
  o Move include/asm-ia64/efi.h to include/linux/efi.h
  o Merge IA64 port copy of include/linux/efi.h

Oliver Neukum <oliver@neukum.name>:
  o hpusbscsi disconnect fix

Roger Luethi <rl@hellgate.ch>:
  o Remove ancient ETHER_STATS statistics code from several net drivers, code that has not been compile-enabled nor compileable in ages.

Russell King <rmk@arm.linux.org.uk>:
  o This patch fixes a bug in handling the timeout in pcnet_cs.c, where it uses the following test to determine whether the timeout has expired:

Tom Rini <trini@kernel.crashing.org>:
  o PPC-specific 3c509 net driver update
  o Add a PCI ID for the Motorola MPC107
  o PPC32: Fix booting on MPC8xx and MPC8260 machines

Urban Widmark <urban@teststation.com>:
  o smbfs gcc warning fix

Summary of changes from v2.4.20-pre6 to v2.4.20-pre7
============================================

<akpm@digeo.com>:
  o Sync up syscall table with 2.5

<alan@redhat.com>:
  o fix ramdisk cache flush

<fzago@austin.rr.com>:
  o [PATCH] (repost) fix for big endian machines in scanner.c

<hch@lst.de>:
  o inline grab_cache_page
  o cleanup try_to_free_pages naming
  o fix syscall prototypes in init/do_mounts.c

<mlang@delysid.org>:
  o HandyTech HandyLink patch

<paulus@au1.ibm.com>:
  o PPC32: Add extended attributes syscalls

<proski@gnu.org>:
  o 2.4.20-pre6: befs still not in fs/Makefile

<ralf@dea.linux-mips.net>:
  o mips
  o mips64
  o mips64-ip27
  o mips-sgi-ip22
  o mips-ip32
  o mips-mips
  o mips-sibyte
  o maintainers
  o drivers-net-mace
  o drivers-net
  o drivers-net
  o drivers-net
  o drivers-net
  o drivers-sgi
  o mips-cobalt
  o pci-ids
  o drivers-scsi
  o drivers-scsi
  o drivers-tc
  o drivers-ide
  o drivers-ide
  o mips-arc
  o mips-dec
  o mips-alchemy
  o mips-galileo-boards
  o drivers-video
  o drivers-video
  o mips-vr41xx
  o mips-momentum
  o mips-ddb
  o drivers-mtd
  o drivers-mtd

<thockin@freakshow.cobalt.com>:
  o NVRAM driver

<zwane@mwaikambo.name>:
  o trivial ohci fixes

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entry for the ForteMedia FM801 driver
  o add Configure.help entries for CONFIG_USB_SERIAL_KEYSPAN_USA19Q{W,I}

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o IA64 sync

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: add permission checks before getting or setting xattrs

David Brownell <david-b@pacbell.net>:
  o usbcore updates

Geert Uytterhoeven <geert@linux-m68k.org>:
  o M68k extended attributes
  o Fixup fbcon build

Greg Kroah-Hartman <greg@kroah.com>:
  o USB serial: added device path to the proc file now that usb_make_path() is available

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o transparent pci-pci bridges fix
  o alpha rwsem update

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o Fix stupid compile error in wavelan_cs

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add kernel-related BitKeeper docs/scripts, as found in the 2.5.x kernel Documentation/BK-usage sub-directory.

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o 2.4.20-pre6 Bluetooth core fixes

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Fix tg3 compile problems
  o Remove reiserfs not very well tested code
  o tg3.c
  o Fix bogus printk which was resulting in bootup oops
  o Add asm-ia64/include/efi.h needed by generic efi code

Oliver Neukum <oliver@neukum.name>:
  o new ids for hpusbscsi

Paul Mackerras <paulus@samba.org>:
  o PPC32: Add declaration of gg2_pci_config_base variable
  o don't use outl as label in ppp_generic.c
  o PPC fix in drivers/pci/Makefile
  o kd_mksound inclusion on PPC

Steven Cole <elenstev@mesatop.com>:
  o Configure.help fix for CONFIG_IP_NF_MATCH_DSCP

Summary of changes from v2.4.20-pre5 to v2.4.20-pre6
============================================

<bheilbrun@paypal.com>:
  o Fix e100 driver compilation

<bmatheny@purdue.edu>:
  o Lexar USB CF Reader

<cel@citi.umich.edu>:
  o prevent oops in xprt_lock_write, against 2.4.20

<green@angband.namesys.com>:
  o Turn on blocks preallocation by default for reiserfs
  o reiserfs: Mistakenly forgotten inode attributes option was added back
  o reiserfs: Take into account file information even when not doing preallocation. Fixes a bug with displacing_large_files option
  o reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW
  o reiserfs: Allow to insert more than one unformatted pointer into the tree at a time. Use that to speed up hole creation/filling
  o Implemented reiserfs_file_write(), to write large amount of data at once into files on reiserfs volumes which should boost write speed somewhat and also should be somewhat more SMP friendly
  o Export generic_osync_inode,block_commit_write, remove_suid

<hch@lst.de>:
  o list.h update (resent again)

<hpa@zytor.com>:
  o Patch: Make Transmeta Crusoe processors report "i686"
  o tmpfs: return a nonzero size for directories
  o Make framebuffer work on ATI Rage Mobility P/M

<kkeil@suse.de>:
  o Fixup Eicon Diva support

<pekon@informatics.muni.cz>:
  o Patch to include support for Minolta Dimage 7i

<petkan@users.sourceforge.net>:
  o USB: pegasus.h
  o USB: pegasus driver patch

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Fix O_SYNC for non-data-journaled

Adrian Bunk <bunk@fs.tum.de>:
  o Fix .text.exit error with static compile of synclinkmp.c

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o forte sound
  o old Acorn error handling paths
  o remove bogoprintk, add LBA28 to paride
  o L make i845 gart recover after suspend
  o enable amd watchdog in config.in
  o makefile for amd tco
  o fix missing checks in video1394
  o more irda __FUNCTION__ stuff
  o fix sisfb errors
  o IRDA function stuff
  o further khttpd updates
  o i845G fixes

Alexander Viro <viro@math.psu.edu>:
  o handle_initrd() and request_module()

Christoph Hellwig <hch@sb.bsdonline.org>:
  o JFS: cosmetical changes to reduces the diff to 2.5
  o JFS: remove jfs_get_volume_size
  o JFS: backport lmLogWait from 2.5
  o JFS: Remove unused file jfs_extendfs.h
  o JFS: use buffer_heads to access the superblock
  o JFS: use block device inode/mapping instead of direct_inode/direct_mapping
  o JFS: ifdef out unused functions related to partial blocks
  o JFS: sync the block device on umount or r/o remount
  o JFS: we still need extHint
  o [VFS] Add support for extended attributes
  o JFS: backport xattr support from 2.5
  o JFS: remove superflous includes

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Move 24-bit byte-swapping code out of JFS-specific code
  o JFS: rework extent invalidation
  o JFS: Add write_super_lockfs() and unlock_fs() for snapshot
  o JFS: extended attribute fixes

David Brownell <david-b@pacbell.net>:
  o USB: ohci completion of unlinked urbs patch

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Ultra-III+ updates and better error trap logging
  o arch/sparc64/kernel/cpu.c: Fix typo in printk
  o arch/sparc64/kernel/traps.c: Add spitfire_ prefix to clean_and_reenable_l1_caches, BUG on non-spitfire cpus
  o include/asm-sparc64/rwsem.h: Add __down_{read,write}_trylock
  o [TIGON3]: PHY reset fixes
  o [TIGON3]: Make sure to always enable AS_MASTER bits when necessary
  o [TIGON3]: PCI write posting fixes
  o [TIGON3]: tr32_mailbox does not exist, use tr32 :-)
  o [TIGON3]: Low power, wake-on-lan, and DMA test fixes
  o drivers/md/raid1.c:raid1_read_balance workaround gcc miscompile on sparc64
  o drivers/usb/rtl8150.c: Include linux/init.h
  o [IGMP]: Make ip_mc_dec_group return void
  o net/core/dst.c: asm/bitops.h --> linux/bitops.h
  o net/ipv4/netfilter/ipchains_core.c: Fix MODULE_LICENSE
  o drivers/net/ppp_generic.c: Fix byte-aligned packets, nearly every arch csum_partial cannot handle this
  o arch/sparc64/kernel/ioctl32.c: Handle SIOCDEVPRIVATE transparently
  o net/core/pktgen.c: Access userspace properly
  o drivers/net/ppp_generic.c: Fix skb_put len arg when copying unaligned skb
  o arch/sparc64/defconfig: Update
  o arch/sparc64/defconfig: Turn rtl8150 back on
  o drivers/net/ppp_generic.c: Allocate right length in unaligned SKB fix
  o arch/sparc64/kernel/ioctl32.c: Translate PPPIOCS{PASS,ACTIVE}
  o [TIGON3]: When not low-power, only set GPIO enables in lclctrl on 5700 chips
  o arch/sparc64/lib/VIScsum.S: Do not use VIS on oddly aligned buffer
  o drivers/net/ppp_generic.c: Revert my idiotic unaligned SKB changes
  o arch/sparc64/lib/VIScsum.S: Fix endianness bugs in previous change
  o arch/sparc64/kernel/ioctl32.c: Frob cmd in PPPIOCS{PASS,ACTIVE}
  o [TIGON3]: Merge TSO code from 2.5.x driver, disabled in 2.4.x
  o [TCP]: Delay tstamp state commit in input fast path until we verify csum

Geert Uytterhoeven <geert@linux-m68k.org>:
  o HP300 I/O updates
  o Wrong fbcon_mac dependency
  o Mac/m68k debug fixes
  o M68k core I/O fixes
  o HP300 updates
  o Spelling fixes
  o Mac/m68k Sonic fix
  o Mac/m68k Nubus updates
  o Amiga serial driver fix
  o Atari STRAM fixes
  o Mac/m68k I/O updates
  o Zorro bus ID updates
  o M68k IRQ configuration fix
  o M68k VT updates
  o Parport fixes
  o Sun-3/3x initialization fix
  o Mac/m68k build fix
  o 16550 serial fix
  o HP300 LANCE driver updates
  o M68k dump_stack() update
  o Amiga Clgenfb hack
  o Atari ATI Mach64 fixes
  o Apollo mouse driver update
  o HP300 DIO bus updates
  o Apollo keyboard driver update
  o M68k configuration updates
  o BVME6000 RTC driver update
  o M68k compile fixes
  o Misc Mac/m68k updates

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added LCD driver
  o USB: updated the bluetooth driver to the latest version
  o USB: usbserial core synced up with the 2.5 version
  o belkin_sa update due to usbserial core changes
  o USB: cyberjack update due to usbserial core changes
  o USB: digi_acceleport update due to usbserial core changes
  o USB: empeg update due to usbserial core changes
  o USB: ftdi_sio update due to usbserial core changes
  o USB: io_edgeport update due to usbserial core changes
  o USB: io_ti update due to usbserial core changes
  o USB: ipaq update due to usbserial core changes
  o USB: ir-usb update due to usbserial core changes
  o USB: keyspan_pda update due to usbserial core changes
  o USB: keyspan update due to usbserial core changes
  o USB: kl5kusb105 update due to usbserial core changes
  o USB: mct_u232 update due to usbserial core changes
  o USB: omninet update due to usbserial core changes
  o USB: pl2303 update due to usbserial core changes
  o USB: visor update due to usbserial core changes
  o USB: whiteheat update due to usbserial core changes

Harald Welte <laforge@gnumonks.org>:
  o MAINTAINERS: Update NETFILTER entry
  o [NETFILTER]: Fix OOPS in ipt_ULOG

Itai Nahshon <nahshon@actcom.co.il>:
  o USB keyboards (patch)

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o scsi_scan.c
  o Makefile
  o xattr.h

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd - More small fixes for TCP nfsd

Oliver Neukum <oliver@neukum.name>:
  o USB: backport of kaweth driver

Paul Fulghum <paulkf@microgate.com>:
  o Configure.help (synclinkmp/_cs)

Paul Mackerras <paulus@samba.org>:
  o PPC32: ensure that sys_[rt_]sigsuspend give the correct error code
  o PPC32: minor boot wrapper fixes
  o PPC32: Ensure the MMU hash table gets set up correctly on POWER3
  o PPC32: Add some new PPC config options and update the defconfigs
  o PPC32: Updates for the MPC8xx embedded PowerPC machines
  o PPC32: Improved support for the CHRP platform
  o PPC32: Updates for the APUS platform
  o PPC32: Move some openfirmware-specific code
  o PPC32: a bunch of minor fixes (spinlock debug, comments, etc.)
  o PPC32: Minor updates to the restart/halt functions for PReP
  o PPC32: Implement __down_read/write_trylock for PPC32

Pete Zaitcev <zaitcev@redhat.com>:
  o Patch for urb->status abuse in usb-storage in 2.4

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o ncpfs misc fixes

Tomas Szepe <szepe@pinerecords.com>:
  o warnkill trivia 1/2

Summary of changes from v2.4.20-pre4 to v2.4.20-pre5
============================================

<andersen@codepoet.org>:
  o 2.4.20-pre[234] hosed /proc/partitions fix

<bhavesh@avaya.com>:
  o Fix scheduler's RT behaviour

<danc@mvista.com>:
  o PPC32: Add support for SBS Palomar 4 board

<davem@pizda.ninka.net>:
  o SPARC64: Initial Cheetah-plus support, not fully debugged yet

<dwmw2@redhat.com>:
  o Another JFFS2 oops fix

<dz@cs.unitn.it>:
  o latest version of i8k module

<engebret@us.ibm.com>:
  o Re: [PATCH] PPC64 update to 2.4.19-rc1

<hch@lst.de>:
  o Merge ETHTOOL_GDRVINFO support for several pcmcia net drivers
  o update drm to XFree 4.2 version
  o use -iwithprefix to find gcc headers
  o fix theoretical race init pagefault init survive path

<james@cobaltmountain.com>:
  o drivers_usb_usb-uhci.c, typo: the the, missing 'of'
  o drivers_usb_auerswald.c, typo: the the
  o net/ipv4/netfilter/ip_conntrack_core.c: Fix comment typo
  o net/ipv4/netfilter/ip_nat_core.c: Fix comment typo

<jani@iv.ro>:
  o tridentfb bitdepths in Config.in

<jgarzik@tout.normnet.org>:
  o Correct xdr_shift_buf prototype in inc/linux/sunrpc/xdr.h to match implementation (s/unsigned int/size_t/).

<jsiemes@web.de>:
  o net/ipv4/ipconfig.c: Add support for multiple nameservers

<jwoithe@physics.adelaide.edu.au>:
  o Support for Buffalo 40GB USB hard disk

<kisza@sch.bme.hu>:
  o net/ipv6/netfilter/ip6_tables.c: Fix extension header parsing bugs

<mark@alpha.dyndns.org>:
  o USB: ov511 1.61 for 2.4

<paulus@au1.ibm.com>:
  o PPC32: add support for the IBM "Spruce" reference platform
  o PPC32: clean up the interrupt handling on the APUS platform

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Handle dirty buffers encountered
  o 2.4.20-pre4/ext3: Fix "buffer_jdirty" assert failure
  o 2.4.20-pre4/ext3: Fix the "dump corrupts filesystems"
  o 2.4.20-pre4/ext3: Fix buffer alias problem
  o 2.4.20-pre4/ext3: Truncate leak fix
  o 2.4.20-pre4/ext3: Fix out-of-inodes handling
  o 2.4.20-pre4/ext3: fsync optimisation
  o 2.4.20-pre4/ext3: Fix truncate restart error
  o 2.4.20-pre4/ext3: Performance fix for O_SYNC behaviour

<solar@openwall.com>:
  o net/unix/af_unix.c: Set ATIME on socket inode

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o SBUS: extern->static inline
  o these were wrong - they've been right in -ac for ages
  o add config.in for new synclink mp
  o parisc config.in
  o note the initrd vanishing bug and block size issue
  o docs for isapnp update in pre4
  o make synclink vars static
  o fix wrap handling in ieee1394
  o fix warning in i2o
  o set DMA mask in i2o
  o typo fixes for aic7xxx
  o ixj wrong definition
  o zorro proc should use loff_t too
  o hppa also needs a weird kstat
  o only egcs had this problem so dont pad on 2.95+
  o cache align the irq stat
  o sparc64 fix pcibios for changes in pre4
  o new dmi entries
  o long standing khttpd fix
  o generic part of rw trylocks
  o update parport ifdefs for HPPA
  o resend - HIL input bus
  o down_write_trylock
  o fix EFS on cd crash
  o add hppa to fbcon data
  o quieten the latency message
  o ppc64 missing ioctl32 gunk
  o hppa like ia64 doesnt use the old ipc structs
  o new sem_getcount means this cna go
  o more typo fixes
  o typo fixes ctd
  o fix the via rhine
  o fix bttv_read type error
  o fix detected_devices type error
  o isdn gcc warning fixer
  o vt.c clean up ifdefs
  o update /proc description
  o journalling docs
  o PCI fixes
  o docs for ldm update
  o ps2esdi - wrong bit
  o driver for AMD watchdog
  o add synclink_mp
  o saner error return for hotplug
  o i2o typo fix
  o e1000 - return without code
  o decruft smodem
  o fix pci_release/request_regions bugs
  o fix __FUNCTION__ in irda-usb

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o arch/i386/lib/checksum.S: Handle zero length

Brian Beattie <beattie@beattie-home.net>:
  o patch for 2.4 scanner.h add device ids

David S. Miller <davem@nuts.ninka.net>:
  o arch/sparc64/defconfig: Update
  o include/linux/sunrpc/svcsock.h: Make sk_flags a long
  o include/linux/sunrpc/svcsock.h: sk_flags must be a long for bitops
  o SPARC: Update for changed pcibios_enable_device args
  o include/linux/sunrpc/xdr.h: Kill xdr_zero_buf decl, fix xdr_shift_buf args
  o arch/sparc64/mm/ultra.S: Fix branch condition in __cheetah_flush_tlb_range
  o include/asm-sparc/types.h: No need to make dma64_addr_t 64-bits on sparc32
  o SPARC64: Fix obscure cheetah+ hangs
  o TIGON3: Add missing udelay when clearing SRAM stats/status block
  o SPARC64: Fix DRM to use new not old drivers
  o net/unix/af_unix.c: Set msg_namelen in unix_copy_addr properly, define MODULE_LICENSE
  o net/ipv4/tcp_diag.c: Avoid unaligned accesses to tcpdiag_cookie
  o SPARC64:setup_arch Flush correct I-cache line when patching irqsz_patchme
  o SPARC64: Ultra-III+ bug fix and better bad trap logging

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: documentation updates
  o USB: ov511 driver update to the latest version
  o USB: pegasus driver update to the latest version
  o microtek driver update to the latest version
  o wacom driver update to fix incorrect data problem
  o USB: minor cleanups and __FUNCTION__ fixes
  o USB: fix some USB 2.0 hub bugs
  o update to latest version of rtl8150 driver
  o minor printer driver fixes
  o stv680 driver update to latest version
  o USB: usb-ohci bug fix for slow machines and cardbus bug fix
  o USB: uhci incorrect bit operations and FSBR timeout fixes
  o added Configure.help entry for the ACPI PCI Hotplug driver
  o PCI Hotplug: fixed oops when accessing pcihpfs

Hanna Linder <hannal@us.ibm.com>:
  o path_lookup for 2.4.20-pre4

Hugh Dickins <hugh@veritas.com>:
  o M386 flush_one_tlb invlpg

James Morris <jmorris@intercode.com.au>:
  o [NETFILTER]: ip{,6}_queue.c cleanups and fixes

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Fix 8139cp 64-bit DMA support
  o Update e1000 net driver for two small ethtool fixes

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Revert broken cpqarray statistics change in previous -pre
  o Readded context_swtch to kernel_stat structure
  o Changed EXTRAVERSION to -pre5

Neil Brown <neilb@cse.unsw.edu.au>:
  o SUNRPC 1 of 3 - The new "sk_flags" word in struct svc_sock
  o SUNRPC 2 of 3 - Fix two problems with multiple concurrent
  o SUNRPC 3 of 3 - Call svc_sock_setbufsize when socket

Rob Radez <rob@osinvestor.com>:
  o SPARC32: Sparc32 compile fixes with CONFIG_PCI enabled

Rusty Russell <rusty@rustcorp.com.au>:
  o [PATCH] duplicate declarations #2
  o 2.5: kconfig missing OBSOLETE (2_3) again
  o Documentation_filesystems_devfs_README, typo: the the
  o Trivial Patch to SonyCD535 documentation
  o drivers_net_rcpci45.c, typo: the the
  o drivers_net_pcmcia_xircom_cb.c, typo: the the,
  o Re: pci_alloc_consistant gfp flag fix
  o drivers_net_winbond-840.c, typo: the the
  o list_for_each_entry

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver update 1/3
  o e100 net driver update 2/3
  o e100 net driver update 3/3
  o e1000 net driver update 1/5
  o e1000 net driver update 2/5
  o e1000 net driver update 3/5
  o e1000 net driver update 4/5
  o e1000 net driver update 5/5

Tim Waugh <twaugh@redhat.com>:
  o 2.4.20-pre4: parportbook thinko

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: separate finding and parsing the info from the boot wrapper
  o PPC32: implement hooks for extra PCI fixups needed on some platforms
  o PPC32: Add hooks for Abatron BDI2000 debugger, extra compile flags


Summary of changes from v2.4.20-pre3 to v2.4.20-pre4
============================================

<gone@us.ibm.com>:
  o setup_arch() cleanups
  o (2/4) discontigmem support for i386 against 2.4.20pre3

<green@angband.namesys.com>:
  o Fix a problem that when doing online resizing, resizer code forgot to update bitmap usage counters
  o Fix a problem where bitmap usage counters were possibly incorrectly updated on bigendian and 64 bit boxes

<hch@lst.de>:
  o VM docs from -ac
  o fix current BK tree compilation with devfs enabled

<johnstul@us.ibm.com>:
  o 686-notsc_A0
  o [PATCH] notsc-warning_A0

<oliver@oenone.homelinux.org>:
  o USB: hpusbscsi driver updates

<roland@topspin.com>:
  o USB storage: get rid of DMA to stack

Adrian Bunk <bunk@fs.tum.de>:
  o Fix ftape build problems

Christoph Hellwig <hch@sb.bsdonline.org>:
  o JFS: Initial import of version 1.0.18 for Linux 2.4

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix structure alignment problem on 64-bit machines
  o JFS: Add hch's copyright
  o JFS: sanitize ->clear_inode, remove ->put-inode
  o Fix races in JFS threads
  o JFS: Yet another truncation fix
  o JFS does not need to set i_version.  It is never used
  o JFS: fix fsync
  o procfs entries should be created when CONFIG_JFS_STATISTICS is set
  o JFS: set s_maxbytes to 1 byte lower
  o Rework JFS's inode locking
  o JFS: Dynamically allocate metapage structures
  o Remove d_delete calls from jfs_rmdir & jfs_unlink
  o JFS: Fix handling of commit_sem
  o Add resize function to JFS
  o fix typo in fs/jfs/resize.c
  o JFS: Replace depreciated initializer syntax with C99 style
  o JFS: Trivial fixes

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Fix compile warning in init/do_mounts.c

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: serial Config.in cleanups
  o USB: ftdi_sio driver update
  o USB: ipaq driver updates
  o USB: pl2303 driver update
  o USB:  serial driver minor fixes
  o USB: ir-usb driver minor fixes
  o USB: add usb-storage sddr-55 driver
  o USB: bluetooth driver fixes
  o USB: scanner driver update and maintainer change

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Changed EXTRAVERSION to -pre4
  o Added arch/i386/kernel/time.o to exportobj list

Niels Kristian Bech Jensen <nkbj@image.dk>:
  o Avoiding implicit declaration in net/netsyms.c
  o Fixing a compiler warning in drivers/block/genhd.c

Paul Mackerras <paulus@samba.org>:
  o fix bug in yield()

Richard Gooch <rgooch@atnf.csiro.au>:
  o Switched to ISO C structure field initialisers
  o base.c

Simon Evans <spse@secret.org.uk>:
  o 2.4.19 - add support for f5u011 to catc.c

Steven Cole <elenstev@mesatop.com>:
  o 2.4.20-pre2 add module text for 58 options

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Add round trip timing to RPC over UDP client [1/3]
  o Add round trip timing to RPC over UDP client [2/3]
  o Add round trip timing to RPC over UDP client [3/3]
  o Improve RPC request ordering
  o Improve network congestion code [1/3]
  o Improve network congestion code [2/3]
  o Improve network congestion code [3/3]
  o Fix RPC write_space() code
  o Increase UDP socket buffer size

V. Ganesh <ganesh@vxindia.veritas.com>:
  o typo in usb/serial/ipaq.h


Summary of changes from v2.4.20-pre2 to v2.4.20-pre3
============================================

<alex_williamson@hp.com>:
  o fix raid on GPT partitions

<andersen@codepoet.org>:
  o cdrom sane fallback vs 2.4.20-pre1

<garloff@suse.de>:
  o IBM 4000R needs LARGELUN

<gsromero@alumnos.euitt.upm.es>:
  o isofs multi volume compliance fix

<hch@lst.de>:
  o convert to yield() usage

Adrian Bunk <bunk@fs.tum.de>:
  o fix a typo in the description of CONFIG_BLK_STATS

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o PCI enable handling
  o fill in siginfo on alpha
  o ARM cpufreq hooks
  o update reiserfsprogs
  o document an acpi bogon
  o fix firestream gcc 3.1 warnings
  o fix io accounting on cpqarray
  o error check DAC960 copy*user
  o whoops
  o use proper macros in analog joystick
  o use proper tsc macros in random driver
  o add help button to sonypi driver, fix gcc 3.1 warnings
  o flip the vt ifdef the sane way around
  o fix the gcc warnings in cpqphp_nvram
  o make the st usb compile again
  o fix broken ifdef
  o Update CPIA driver (this has been in ac for a bit)
  o fix a gcc warning and a thinko
  o [resend] revert broken atarilance change
  o fix net/Config.in formatting, 83820 typo
  o fix eepro deeply broken code formatting (no other change)
  o latest mpt fusion update from author
  o update serverworks idents
  o fix extern->static inline on sbus
  o allow Zalon to be selected for HP
  o add hp tachyons to cpqfc driver + fix warnings
  o fix dpt_i2o warnings
  o fix esp driver to static inline
  o update scsi makefile for hp stuff
  o make NCR53c9x use inline not extern inline
  o update ncr asm assembler
  o switch scsi.h to static inline
  o fix incorrect read10 to read6 handling on error
  o sgiserial to static inline
  o usb to static inline
  o kaweth new ident (silicom usb)
  o ov511 driver updates
  o update pwc to new map handing too
  o update se401 the same way
  o same again for stv
  o update ohci driver to handle strange natsemi bits
  o update usbvideo and vicam
  o use static inline in clgenfb
  o allow people to select befs
  o make the dnotify cache consistent with other naming
  o make the fasync_cache also named in accordance tonorms
  o make file_lock cache also match default format
  o fix a problem where fsync of an nfs dir gives wrong code
  o small nls tidying
  o update to new ldm partition code
  o add sem_getcount to stop people poking in semaphore
  o allow DMA0 on isapnp
  o allow reporting of 3rd/4th codec
  o ALi 5455 audio
  o files_init - set file limit based on ram
  o get the types right on lib/inflate.c constants
  o add down_read_trylock/write_trylock
  o add befs maintainer
  o update hfs maintainer
  o remove dead url
  o format fix
  o add parisc directories to build
  o remainign minor atm bits
  o fix gcc 3 warning
  o make semaphores gcc 3.1 safe
  o the wbinvd is safe anyway
  o this fixes the remaining vm86/tf screwups
  o add HIL to serio
  o headers for SOM (HP) binary format
  o missed earlier - header change for sonypi
  o second item I found testing - misse scsi.h macro add
  o first bits of ps2esdi cleanup
  o fix depca warnings
  o revert wrong change to isicom
  o first pass xd.c clean up

Andi Kleen <ak@muc.de>:
  o pageattr for 2.4

Andrew Morton <akpm@zip.com.au>:
  o copy_strings speedup
  o fix lru_cache_add vs activate_page race

Bjorn Wesen <bjorn.wesen@axis.com>:
  o arch/cris update

Douglas Gilbert <dougg@torque.net>:
  o lk2.4.19 sg driver header file synchronization
  o scsi_debug driver update

Geert Uytterhoeven <geert@linux-m68k.org>:
  o m68k: PCI DMA updates
  o m68k: add page_to_phys()

jack_hammer@adaptec.com <Jack_Hammer@adaptec.com>:
  o ServeRAID driver update

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o ir240_usb_fix_greg.diff
  o ir240_usb_disconnect-3.diff

Jens Axboe <axboe@suse.de>:
  o elevator seek accounting fixes

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o Add support for ISDN card Eicon Diva 2.02
  o Move PCI device id to include/linux/pci_ids.h
  o Add support for ISDN card Formula-n enter:now, a.k.a. Gerdes Power ISDN
  o Add in-kernel ISAPnP support to HiSax driven ISDN cards
  o Doc changes / Cleanup for ISDN ISAPnP changes
  o ISDN MPPP crash fix
  o Update README.HiSax for the added card
  o Update README.HiSax for the added card
  o ISDN: LED support for netjet driver
  o ISDN: Add Data Over Voice support
  o ISDN: Cisco HDLC update
  o ISDN: Fix DoV (Data over Voice)

Marc Boucher <marc@mbsi.ca>:
  o yet another VAIO dmi_blacklist entry

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Revert 2.4.19's AMD Athlon prefetch workaround
  o Revert APIC error message silencing: APIC errors can be fatal
  o Makefile

Martin Mares <mj@ucw.cz>:
  o pci.ids for 2.4.20-pre2

Neil Brown <neilb@cse.unsw.edu.au>:
  o resend - Enable NFS over TCP via config option

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [2.4.20-pre1] File lease fixes

Steven Cole <elenstev@mesatop.com>:
  o 2.4.20-pre2 update Documentation/sysctl/vm.txt
  o 2.4.20-pre2 remove 8 duplicate help texts from

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS locking bug
  o Teach RPC client to send pages rather than iovecs. [1/3]
  o Teach RPC client to send pages rather than iovecs. [2/3]
  o Teach RPC client to send pages rather than iovecs. [3/3]
  o Fix typo in the RPC reconnect code
  o Clean up RPC receive code [1/2]
  o Clean up RPC receive code [2/2]
  o fixup conflict between NFS kmap patches and 2.4.20-pre

Urban Widmark <urban@teststation.com>:
  o smbfs poll

Summary of changes from v2.4.20-pre1 to v2.4.20-pre2
============================================

<aaron.baranoff@tsc.tdk.com>:
  o Add pci id to tulip net driver

<alan@irongate.swansea.linux.org.uk>:
  o VLAN: Fix gcc-3.1 warnings

<antoine@ausone.whoknows>:
  o Add pci id to tulip net driver

<arndb@de.ibm.com>:
  o 1/18 s390 architecture core updates

<celso@bulma.net>:
  o Pass 'unsigned long' not 'long' as argument to save_flags, in several old net drivers

<ctindel@cup.hp.com>:
  o drivers/net/bonding.c: Handle non-ETHTOOL devices more correctly

<davem@hera.kernel.org>:
  o x.patch

<dent@cosy.sbg.ac.at>:
  o include/net/tcp.h: Kill redundant declaration

<driver@huey.jpl.nasa.gov>:
  o Fix spelling in natsemi net driver

<fbl@conectiva.com.br>:
  o Fix MODULE_DESCRIPTION of olympic and pss drivers

<gnb@alphalink.com.au>:
  o drivers/sbus/char/Config.in: Avoid using ARCH
  o drivers/sbus/char/Config.in: Avoid using ARCH
  o Update net driver Config.in texts to indicate their dependency
  o Mark drivers/net/Config.in entries that depends on CONFIG_OBSOLETE with "(OBSOLETE)" text.

<green@angband.namesys.com>:
  o Many files
  o reiserfs_fs.h, namei.c, bitmap.c
  o Configure.help, Config.in
  o tail_conversion.c, namei.c
  o inode.c
  o reiserfs_fs.h, namei.c, journal.c
  o Many files

<hch@lst.de>:
  o dump_stack()
  o backport yield() and conditional reschedule changes from
  o small VM updates from -aa (1/5)
  o small VM updates from -aa (2/5)
  o small VM updates from -aa (4/5)
  o small VM updates from -aa (5/5)
  o use slab for kiobufs and allocate it's bhs dynamically
  o add missing prototype to arch/i386/kernel/setup.c
  o i386 stackoverflow checker
  o Re: [PATCH] small VM updates from -aa (3/5)
  o conditionally re-enable per-disk stats, convert to seq_file
  o for_each_pgdat/for_each_zone
  o implement kmem_cache_size()
  o advanced f00f bug detection & workaround
  o cure the leftovers of the CONFIG_ISA / X86_64 patch
  o use for_each_pgdat in try_to_free_pages_nozone
  o __set_64bit needs lock prefix
  o minor VM changes from -aa (2/3)
  o minor VM changes from -aa (3/3)

<ica2_ts@csv.ica.uni-stuttgart.de>:
  o net/ipv4/ipconfig.c: [TRIVIAL] fix a typo
  o include/linux/netdevice.h: [TRIVIAL] Use ___cacheline_aligned
  o include/net/tcp.h: [TRIVIAL] Use ___cacheline_aligned

<irohlfs@irohlfs.de>:
  o Add pci id to orinoco wireless net driver

<jackson@realtek.com.tw>:
  o Fix typos in 8139cp net driver RxProto{TCP,UDP} constants

<james@cobaltmountain.com>:
  o net/ipv4/tcp.c: Fix comment typo
  o arch/sparc64/kernel/time.c: Fix comment typo
  o net/sched/sch_ingress.c: [TRIVIAL] Fix debugging printk typo

<jgarzik@tout.normnet.org>:
  o e1000 net driver cleanups

<keithu@parl.clemson.edu>:
  o Get hamachi net driver RX working again

<khc@pm.waw.pl>:
  o Fix epic100 net driver

<maalanen@ra.abo.fi>:
  o Fix use of pointer after kfree(), in au1000_eth net driver

<mw@microdata-pos.de>:
  o Update old eepro net driver

<otaylor@redhat.com>:
  o Yet another new tulip pci id

<sabala@students.uiuc.edu>:
  o Add Conexant LANfinity support to tulip net driver

<steve@gw.chygwyn.com>:
  o [DECNET]: Fix route device refcounting
  o DECnet bug fix

<th122948@scl1.sfbay.sun.com>:
  o Natsemi ethernet driver fixes
  o Natsemi ethernet fixes
  o Lindent drivers/char/nvram.c in anticipation of more patching
  o clean up 'return (x);' style stuff into 'return x' in nvram.c

<thockin@freakshow.cobalt.com>:
  o Fix a typo, so people can have clean logs.  Sheesh :)

<willy@debian.org>:
  o Remove inappropriate use of set_bit in dl2k gige net driver

<willy@w.ods.org>:
  o APM fix for 2.4.20pre1

<wilsonc@abocom.com.tw>:
  o Add two pci ids to 8139too net driver

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix compile problem with multiquad
  o add befs to the list of fs docs
  o parisc doc stuff
  o janitorials on copy_user
  o fix cyclades warning
  o fix up the formatting in Config.in add HP stuff
  o update Makefile for drivers/char for HP bits
  o add author tags to tosh driver
  o fix warnings
  o pcxx janitorials
  o fix wrong bracketing
  o fix formatting the x86_64 people borked
  o ; yet another missing sign check
  o update drivers/Makefile for hp
  o remove unneeded parisc special case
  o undo formatting mess from x86_64, correct list a bit
  o fixup depca, fix a missing sign check
  o fixup e100,e1000
  o switch ne2100 to static not extern inline
  o add new ids to hp driver, plus alignment stuff
  o fix compile warning
  o arch/parisc
  o remove bogus x86_64 junk
  o update lasi driver
  o fix warnings
  o remove bogus x86_64isms, fix warnings
  o fix warning
  o remove unused bits
  o update HP lasi scsi driver
  o fix pas16 command option parsing
  o typo
  o HP fixes for sym2 - approved by maintainer
  o HP Zalon scsi driver
  o fix warning in bin2hex
  o missing semaphore drop on error path
  o update framebuffer fbcon logic for HP
  o fbmem for hp
  o video Makefile for HP
  o fix warning in pm3
  o befs uses NLS
  o ATM warning fixes

Andrew Morton <akpm@zip.com.au>:
  o Fix set_page_dirty race

Ben Collins <bcollins@debian.org>:
  o Ignore Subversion RCS files

Brad Hards <bhards@bigpond.net.au>:
  o Remove unneeded #includes from 3c359, sbni, and sdla_ft1 net drivers

Christoph Hellwig <hch@infradead.org>:
  o Clean up eepro100 net driver update from David M-T

David S. Miller <davem@nuts.ninka.net>:
  o IPv4: Fix MSG_DONTWAIT behavior on output fragmentation
  o VLAN dev: Fix hard_start_xmit return values
  o [NETFILTER]: Add some new iptables modules. (from laforge@gnumonks.com)
  o include/linux/netdevice.h: Define HAVE_NETDEV_POLL

David Woodhouse <dwmw2@infradead.org>:
  o linux-2.4.19-pre10-shared-zlib
  o Trivial JFFS2 oops fix

Eric Sandeen <sandeen@sgi.com>:
  o Fix printk, remove dead prototype in rcpci45 net driver
  o Fix warning in ppp_generic
  o Remove unused var and unused func from ali-ircc IrDA driver

Gerd Knorr <kraxel@bytesex.org>:
  o btaudio driver update
  o gemtek radio driver fix
  o video4linux i2c audio modules update
  o bttv documentation update
  o video4linux tuner update
  o bttv driver update

Greg Kroah-Hartman <greg@kroah.com>:
  o USB pl2303 driver
  o USB: usb.h cleanups, typedef removed for iso packets, and whitespace changes
  o USB: removed urb_t typedef
  o USB: removed the devrequest typedef
  o USB: added TI edgeport usb to serial driver
  o USB: added new host controller driver for HC_SL811 devices
  o USB: added aiptek driver
  o USB: added tiglusb driver
  o USB: added usb-midi driver
  o USB: added new drivers to the build
  o USB: bluetooth fixes for usb typedef cleanups
  o ACPI PCI Hotplug driver update
  o IBM PCI Hotplug driver update

Harald Welte <laforge@gnumonks.org>:
  o net/ipv4/netfilter/ip_nat_core.c: Fix memory leak on unload
  o [IP_{CONNTRACK,NAT}_{IRC,FTP}] Handle helper registration failure properly
  o [NETFILTER]: Backport newnat infrastructure to 2.4.x
  o [NETFILTER]: REJECT packet should not inherit nfmark of original packet
  o [NETFILTER]: Two functions which should be static in ipt_ah.c are not
  o [NETFILTER]: Allow owner match module match process names
  o include/linux/kernel.h: Define HIPQUAD correctly on little-endian

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o New Wireless Extension API - part2
  o wavelan_cs update (v23)
  o Fix dev->trans_start in wavelan
  o ir240_trivial_fixes-3.diff
  o ir240_sys_max_tx-2.diff
  o ir240_irnet_disc_ind_again.diff
  o ir240_discovery_fixes.diff
  o IrDA NSC driver add new chip
  o IrDA irtty bugfixes
  o IrDA: Make discovery expiry work properly for non default period
  o Add new IrDA dongle drivers

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add e100 and e1000 net driver docs
  o Merge spelling fixes from Rusty's "trivial" patch collection
  o Update 3c509 net driver to move MODULE_LICENSE outside all ifdefs
  o Include linux/bitops in e100 net driver, it uses ffs() (Noticed by DaveM)
  o Update 8139too net driver to make new rx-reset method the default
  o Fix mistake in 8139too net driver Config.in entry
  o Proper support for RTL8139 rev K in 8139too net driver
  o Release 8139too net driver version 0.9.26
  o Fix TX checksumming in 8139cp net driver (the feature is still ifdef'd out by default, however)
  o Add 64-bit DMA support to 8139cp net driver

Jens Axboe <axboe@suse.de>:
  o Add block IO directly from highmem support
  o ext3 __FUNCTION__ usage in 2.4
  o sr scatter oops

Jürgen E. Fischer <fischer@linux-buechse.de>:
  o Fix AHA152X problem

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Import patch revert-x8664-config-change.patch
  o Remove duplicate MAINTAINERS entry
  o Import patch revert-wrong-kconfig-syncbanner
  o Changed EXTRAVERSION to pre2
  o Add missing bracket missing in hch's __free_pages_ok() patch

Neil Brown <neilb@cse.unsw.edu.au>:
  o knfsd - 1/19 - Tidy up code in nfsd_lookup
  o knfsd - 2/19 - Tidyup init/exit of nfsd module
  o knfsd - 3/19 - Support fsid=<number> export option to be
  o 1 of 11 - Claim semaphore for ->lookup call
  o 2 of 11 - Change sunrpc to use more list.h lists
  o 3 of 11 - Get sunrpc to use module_init properly
  o 4 of 11 - Tidy up SMP locking for svc_sock
  o 5 of 11 - Detect and close tcp connections that we cannot
  o 6 of 11 - Close idle rpc/tcp sockets
  o 7 of 11 - Cope with short read when reading length of
  o 8 of 11 - Make sure there is alway adequate sndbuf space
  o 9 of 11 - Limit number of active tcp connections to an RPC
  o 10 of 11 - Allow  SO_REUSEADDR for NFS sockets

Olaf Hering <olh@suse.de>:
  o drivers/macintosh only on ppc32

Paul Mackerras <paulus@samba.org>:
  o PPC32: Start moving files to their new locations
  o PPC32: adjustments to correspond with the new locations of files
  o PPC32: more include and Makefile fixes

Pavel Machek <pavel@ucw.cz>:
  o Remove unnecessary prototypes in eepro100 net driver

pavel@janik.cz <Pavel@Janik.cz>:
  o Probe port 0x240 too, in eexpress net driver

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o ncpfs reports ESTALE in 2.4.19

Rob Radez <rob@osinvestor.com>:
  o SPARC: Get sun4c working again
  o Documentation/Configure.help: CONFIG_SPARCAUDIO_DBRI applies to LX systems too

Russell King <rmk@arm.linux.org.uk>:
  o if_ether.h: Use packed attribute where necessary
  o ip6_tables.c: Uncomment debugging printf

Rusty Russell <rusty@rustcorp.com.au>:
  o warning cleanup for drivers/video/sstfb.c
  o TRIVIAL EPERM -> EACCESS
  o documentation typos in
  o header cleanup - arch_ppc64_kernel_htab.c
  o cure gcc3 warning in arch_i386_kernel_apm.c
  o Fix type of compute_loop_size()
  o Re: header cleanup - drivers_net_wan_sdla_ft1.c
  o header cleanup - drivers_net_wan_sbni.c
  o make awe_wave use struct isapnp_device_id
  o explicit signed char cast in i386 spin_is_locked
  o 40) request_region check, 31-40
  o 2.5: kconfig synchronise banners (6_16)
  o Typo in linux_arch_i386_kernel_apic.c
  o cure compiler warnings in arch_i386_kernel_setup.c
  o [PATCH][trivial] silence disable_ide_dma warning in
  o header cleanup - drivers_bluetooth_hci_ldisc.c
  o fix "inline" placement in serial.c
  o warning cleanup for drivers_media_video_zr36067.c
  o silence APIC errors a bit
  o warning cleanup for drivers_atm_atmtcp.c
  o warning cleanup for drivers_message_i2o_i2o_pci.c
  o Typo in arch_mips_dec_wbflush.c
  o Typo in linux_fs_partitions_msdos.c
  o Trivial Patch to sched.h for
  o Maxium inline patch is 40 kilobytes, not kilobits
  o 2.5: kconfig use of $ARCH (1_12)
  o Fix conflicting md_cpu_has_mmx definitions
  o Fix typo in mm_slab.c
  o Typo in linux_arch_i386_kernel_smp.c
  o Typo in linux_include_asm-cris_pgtable.h
  o 2.5: kconfig spurious bool default value (1_3)
  o Typo in linux_arch_mips64_kernel_irq.c
  o redundant declarations (#10_15)
  o Typo in linux_kernel_pm.c
  o 2.5: kconfig synchronise banners 3
  o Typos in linux_arch_i386_kernel_io_apic.c
  o 2.5: kconfig missing EXPERIMENTAL (1_14)
  o 2.5: kconfig use of $ARCH (2_12)
  o 2.5: kconfig synchronise banners (4_16)
  o 25) request_region check, 21-30
  o Typo in linux_arch_i386_kernel_mpparse.c
  o redundant declarations (#11_15)
  o 2.5: kconfig missing EXPERIMENTAL (3_14)
  o 2.5: kconfig use of $ARCH (6_12)
  o Typo in linux_include_asm-m68k_mac_via.h
  o Typo in linux_net_sunrpc_xprt.c
  o 2.5: kconfig synchronise banners 2 (2_3)
  o 2.5: kconfig missing EXPERIMENTAL 2 (5_7)
  o Typo in linux_include_linux_raid_md_k.h
  o [patch, 2.4] cs4232.c doesn't kfree on error path
  o 2.5: kconfig synchronise banners (8_16)
  o Typos in linux_drivers_mtd_devices_blkmtd.c
  o Typos in Documentation_video4linux_meye.txt (2.4.19-rc1)
  o ipc_ statics
  o correct inaccurate comment regarding zone_table's usage
  o 2.5: kconfig synchronise banners (16_16)
  o Typo in linux_include_asm-sh_pgtable-2level.h
  o Typo in linux_include_linux_brlock.h
  o drm_mga bitops -> long fix
  o Typo in linux_arch_mips64_math-emu_ieee754.c
  o Typo in linux_net_unix_af_unix.c
  o 2.5: kconfig use of $ARCH (7_12)
  o Typo in linux_kernel_fork.c
  o 2.5: kconfig missing EXPERIMENTAL 2 (6_7)
  o Typo in linux_arch_ppc64_kernel_pSeries_pci.c
  o redundant declarations (#8_15)
  o 2.5: kconfig synchronise banners (11_16)
  o 2.5: kconfig use of $ARCH (9_12)
  o Typo in linux_net_sched_sch_ingress.c
  o 2.5: kconfig use of $ARCH (8_12)
  o 2.5: kconfig missing EXPERIMENTAL (9_14)
  o 2.5: kconfig use of $ARCH (12_12)
  o Typo in linux_net_ipv4_tcp.c
  o Typos in linux_mm_highmem.c
  o ia64 incorrect field name in message
  o 2.5: kconfig missing EXPERIMENTAL (6_14)
  o Typo in linux_arch_i386_kernel_setup.c
  o 2.5: kconfig synchronise banners (14_16)
  o Typo in linux_drivers_media_video_pms.c
  o 2.5: kconfig EXPERIMENTAL misformed
  o 2.5: kconfig use of $ARCH (4_12)
  o Fix typo in net_ipv4_ipconfig.c
  o 2.5: kconfig missing EXPERIMENTAL (12_14)
  o Typo in linux_arch_ia64_sn_fakeprom_README
  o Typo in linux_fs_pipe.c
  o Typo in linux_drivers_isdn_isdn_ppp.c
  o Typo in linux_drivers_sound_cs4232.c
  o Typo in linux_drivers_ide_ide-geometry.c
  o kerneldoc: In kernel-hacking describe designated
  o 2.5: kconfig sychronise banners (2_16)
  o Use proper ____cacheline_aligned define in
  o 2.5: kconfig use of $ARCH (11_12)
  o 2.5: kconfig use of $ARCH (10_12)
  o 2.5: kconfig synchronise banners (5_16)
  o 2.5: kconfig missing EXPERIMENTAL 2 (2_7)
  o 2.5: kconfig synchronise banners (1_16)
  o Typo in linux_arch_sparc64_kernel_time.c
  o 2.5: kconfig synchronise banners (3_16)
  o 2.5: kconfig missing EXPERIMENTAL 2 (1_7)

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Remove arch/ppc/kernel/local_irq.h as well as move some headers to include/asm-ppc
  o PPC32: Change pcibios_assign_all_busses into a marco
  o PPC32: Don't report the TAU feature on any of the MPC745x CPUs, as it's not supported
  o PPC32: Move arch/ppc/kernel/ppc_asm.h to include/asm-ppc/ppc_asm.h
  o PPC32: Have arch/ppc/kernel/ptrace.c point to 'COPYING' instead of 'README.legal'


Summary of changes from v2.4.19 to v2.4.20-pre1
============================================

<alan@irongate.swansea.linux.org.uk>:
  o 2.4.20-pre1 - parisc specific include files
  o 2.4.20pre1 - parisc gsc bus
  o 2.4.20-pre1 HP HIL drivers
  o Update the MPT fusion drivers to the vendors latest
  o 2.4/2.5 - Fix endianness on 3c503
  o remove unneeded parisc magic in acenic
  o depca update
  o 2.4/2.5 - Fix traps on alpha when using ewrk3
  o fix gcc warnings in baycom_epp
  o 2.4/2.5 Fix endianness in hp-plus
  o fix multiple gcc 3.1 warnings in irda
  o 2.4/2.5 fix endianness on smc boards
  o 2.4/2.5 fix endianness in wd.c
  o 2.4 - move nubus to static inline
  o 2.4 update gsc parallel port - from maintainer
  o update the aacraid driver
  o fix aic7xxx build when PCI=n
  o eata scsi - update from author
  o fix typo in ncr53c8xx
  o u14-34f scsi driver update from author
  o driver for harmony audio
  o trident audio updates
  o fix undefined C in ixj driver
  o fix gcc 3.1 warnings
  o update sti frame buffer
  o pull the rest of sti into a subdirectory and update it
  o Beos file systems (befs)
  o SOM binary load (parisc specific)
  o Add EFI partition support
  o more hp specific include files
  o Fix gcc 3.1 warnings in vlan
  o fix formatting
  o gcc 3.1 warning fixes for generic_serial
  o HP specific drivers
  o fix compiler warning in mxser
  o (resend for 2.4.20-pre1 as asked) synclink pcmcia
  o PDC (parisc bios) console driver
  o fix compiler warnings
  o fix stallion failing to load
  o fix sx driver compile warnings
  o fix standards compliance bugs in the tty layer
  o clean up umem further

<baccala@vger.freesoft.org>:
  o DBRI driver: Add T7903 doc URL

<ctindel@cup.hp.com>:
  o drivers/net/bonding.c: Check ethtool then mii ioctl to determine link status

<ebrower@resilience.com>:
  o SK98LIN: Fix oops in procfs handling if no cards probed

<ecd@skynet.be>:
  o SPARC64: Fix bugs in ioctl32 registration

<felipewd@terra.com.br>:
  o Add Wake-On-Lan support to 8139cp net driver
  o Update 8139cp net driver to enable legacy Rx/TX command register after C+ command register, not before.
  o Add suspend/resume support to 8139cp net driver

<flo@rfc822.org>:
  o 2.4.19-rc5 cyclades.c one liner

<garloff@suse.de>:
  o IDE: memset kmalloced gendisk structures

<hch@lst.de>:
  o remove unused label in fs/dnotify.c

<jejb@mulgrave.(none)>:
  o 53c700
  o [SCSI 53c700] bux fix in tag starvation, cosmetic cleanup of set_depth
  o [SCSI 53c700] update version to 2.8

<jgarzik@rum.normnet.org>:
  o net driver 8139cp updates
  o Support dumping NIC-specific stats in 8139cp net driver

<jo-lkml@suckfuell.net>:
  o Correct locking on IO stats accounting

<kiran@in.ibm.com>:
  o net/core/dst.c: dst_total only needs to exist if RT_CACHE_DEBUG >= 2

<marcel@holtmann.org>:
  o Bluetooth Subsystem PC Card drivers update

<mauelshagen@sistina.com>:
  o LVM 1.0.5 driver update for 2.4.19-rc3

<michaelw@foldr.org>:
  o sparc64: Use SUNW,power-off to power off some Ultra systems

<pkot@linuxnews.pl>:
  o remove the warning from include/linux/dcache.h

<wa@almesberger.net>:
  o include/net/dsfield.h: Remove dead code

<willy@w.ods.org>:
  o Reorder TOSHIBA TC35815 in Config.in

Adrian Bunk <bunk@fs.tum.de>:
  o document that cmd64x.c supports the CMD649 and CMD680

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o PKT SCHED: Add HTB scheduler by Martin Devera

Andi Kleen <ak@muc.de>:
  o RTNETLINK: Allow non-root to receive
  o AMD 8111 PCI IDS
  o AMD 8111 sound support
  o x86-64 auto_fs support
  o bluetooth flags warning fixes
  o cciss interrupt flags warnings
  o CONFIG_ISA for drivers/char
  o CONFIG_ISA for IDE
  o CONFIG_ISA for radio drivers
  o Configuration fixes for net drivers
  o DRM 64bit fixes
  o Early console support for x86-64
  o x86-64 ELF format name
  o Ftape 64bit/x86-64 fixes
  o CONFIG_ISA for i386
  o Interrupt flags fixes for IEEE1394
  o x86-64 support in ipc/
  o 64bit fixes for drivers/isdn
  o 64bit fixes for the megaraid driver
  o paride interrupt flags fixes
  o 64bit warning fixes for PCI
  o synclink interrupt flag fixes
  o 64bit fixes for drivers/video
  o vsyscall/HPET support for x86-64
  o 64bit WAN driver fixes
  o wavelan 64bit warning
  o x86-64 core changes
  o 64bit dpt driver fixes

Andy Grover <agrover@groveronline.com>:
  o Put Intel cache-detection descriptors in a table

Christoph Hellwig <hch@infradead.org>:
  o small inline assembly fix for gcc 3.1 (ffs)
  o proper boot-time messages for P4 Xeon

David Mosberger <davidm@hpl.hp.com>:
  o Update eepro100 net drvr to enable rx DMA without causing unaligned accesses.

David S. Miller <davem@nuts.ninka.net>:
  o Sparc: Fix copy_{to,from}_user return value handling
  o Sparc64: readv/writev SuS compliance fix for sparc32 compat
  o MAINTAINERS: Remove Andi from networking as per his request
  o NET: Backport 2.5.x NAPI infrastructure to 2.4.x
  o Tigon3: On 32-bit just wrap low 32bits of stats if we overflow
  o SunHME: Register IRQ with netdev->name as string
  o Add netif_receive_skb-like interface for VLAN hw accel
  o Tigon3: Add NAPI support
  o arch/sparc64/defconfig: Update
  o PKTGEN: Use htonl instead of __constant_htonl
  o TIGON3: Finish up NAPI implementation
  o PKTGEN: u64 is not necessarily a long long
  o HTB PKTSCHED: u64 is not necessarily a long long
  o PKTGEN: Fix need_resched for 2.4.x, more u64 printf fixes
  o PKTGEN: More need_resched 2.4.x fixes
  o net/ipv4/route.c: Handle large offsets properly in procfs read operation
  o drivers/sbus/char/openprom.c: Verify user len in copyin_string
  o Openprom: Cast nagative tests properly
  o OpenPROM: Cast to ssize_t not int
  o OpenPROM: Kill len check, it is pointless
  o OpenPROM: Sigh, put the length overflow check back it is needed

Edward Peng <edward_peng@dlink.com.tw>:
  o dl2k gige net driver updates

James Morris <jmorris@intercode.com.au>:
  o NETLINK: Add unicast release notifier

Javier Achirica <achirica@ttd.net>:
  o airo wireless net driver update

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add register dumping and NIC-specific stats to 8139too net driver
  o Fix 8139too net driver register dump
  o Temporarily disable MTU-change-while-active support in 8139cp net driver, until it is confirmed fixed on all boards.  Users can still change MTU when the interface is down, like always.
  o Add Intel e100 net driver
  o Add e1000 gige net driver
  o Move e100 net driver after eepro100, in kernel image link order

Jes Sorensen <jes@wildopensource.com>:
  o Tigon3: Use unsigned type for dest_idx_unmasked in tg3_recycle_rx
  o Tigon3: MAX_WAIT_CNT is too large

Joshua Uziel <uzi@uzix.org>:
  o SunHME: Make module license visible when not-PCI

kai.makisara@kolumbus.fi <Kai.Makisara@kolumbus.fi>:
  o SCSI tape patch for 2.4.19

Kanoj Sarcar <kanojsarcar@yahoo.com>:
  o Sparc64: Fix module symbols when stack debugging is on

Keith Owens <kaos@ocs.com.au>:
  o 2.4.19 include/linux/vmalloc.h for highmem

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o core fixes
  o L2CAP fixes
  o SCO fixes
  o HCI USB driver update
  o BNEP support

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Changed makefile to .20-pre1
  o Import patch revert-acenic-change.patch
  o Remove NAPI for now

Rob Radez <rob@osinvestor.com>:
  o Sparc32 code cleanups
  o Sparc32 code cleanups
  o SPARC: Minor header file cleanups
  o floppy.h: Remove unused empty virtual_dma_init
  o arch/sparc/config.in: Remove commented out LVM bits
  o watchdog flags

Robert Love <rml@tech9.net>:
  o net/socket.c: Kill memory leak in sock_fasync

Robert Olsson <robert.olsson@data.slu.se>:
  o PKTGEN: Updates to version 1.2, work mostly from Ben Greear
  o PKTGEN: Update documentation

Rusty Russell <rusty@rustcorp.com.au>:
  o ipv4/route.c: Cleanup ip_rt_acct_read
  o wan/sdla_chdlc.c oops fix
  o ip_nat_core.c - fix compiler warning
  o 3c509.c - 1_2
  o 2.4 i_size_high fixup
  o remove agpgart_be.c unused variables
  o namespace.c - compiler warning

Steven Cole <elenstev@mesatop.com>:
  o 2.4.19,

Tomas Szepe <szepe@pinerecords.com>:
  o SPARC: Dynamically size SRMMU nocache page pool
  o reserve nocache based on RAM size

William Stinson <wstinson@infonie.fr>:
  o [janitor] update the isicom.c multiport serial driver to 1) check the result of copy_from_user  2) return -EFAULT in case not all data was copied 3) release resources in case of failure  
  o [janitor] update the ray_cs.c PCMCIA client driver for the Raylink wireless LAN card 1) checks the result of copy_to_user and  2) returns -EFAULT in case not all data was copied. 
  o [janitor] update the ni65 network driver to 1) remove call to check_region and use request_region instead checking the return value  2) release region resource in case of driver initialisation error
  o [janitor] update the sdlamain Multiprotocol WAN Link Driver to 1) check the status of call to request_region  2) and return an error in case of problem.
  o [janitor] update the DAC960 Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers to  1) check result of calls to request_region and handle failure to allocate region resource 2) add and use an extra label "Failure1" which frees the region resource in case of device driver initialisation error later on
  o [janitor] update the eexpress.c net driver to 1) check the status of call to request_region  2) and return an error and release the interrupt held in case of problem.
  o [janitor] update the comx-hw-comx wan driver to remove call to check_region and check the status of call to request_region instead.
  o [janitor] update the eepro Intel EtherExpress Pro/10 device driver to 1) check the status of call to request_region  2) and return an error in case of problem.
  o [janitor] update the atarilance Ethernet driver for VME Lance cards on the Atari to check the result of request_irq and exit in case of error
  o [janitor] update the yam hamradio driver to

