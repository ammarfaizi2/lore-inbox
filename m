Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSH0USn>; Tue, 27 Aug 2002 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSH0USn>; Tue, 27 Aug 2002 16:18:43 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:23566 "EHLO debian")
	by vger.kernel.org with ESMTP id <S314446AbSH0USe>;
	Tue, 27 Aug 2002 16:18:34 -0400
Date: Tue, 27 Aug 2002 22:22:50 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32
Message-ID: <20020827202250.GA24265@debian>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a small compile error 
  
  gcc-3.2 -E
  -Wp,-MD,/root/linux-2.5.32/include/linux/modules/drivers/message/i2o/.i2o_block.ver.d
  -D__KERNEL__ -I/root/linux-2.5.32/include -Wall -Wstrict-prototypes
  -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
  -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix
  include    -DKBUILD_BASENAME=i2o_block -D__GENKSYMS__  i2o_block.c |
  /sbin/genksyms -p smp_ -k 2.5.32 >
  /root/linux-2.5.32/include/linux/modules/drivers/message/i2o/i2o_block.ver.tmp
  i2o_block.c:43:2: #error Please convert me to
  Documentation/DMA-mapping.txt
  make[5]: ***
  [/root/linux-2.5.32/include/linux/modules/drivers/message/i2o/i2o_block.ver]
  Error 1
  make[5]: Leaving directory `/root/linux-2.5.32/drivers/message/i2o'
  make[4]: *** [i2o] Error 2
  make[4]: Leaving directory `/root/linux-2.5.32/drivers/message'
  make[3]: *** [message] Error 2
  make[3]: Leaving directory `/root/linux-2.5.32/drivers'
  make[2]: *** [_sfdep_drivers] Error 2
  make[2]: Leaving directory `/root/linux-2.5.32'
  make[1]: *** [include/linux/modversions.h] Error 2
  make[1]: Leaving directory `/root/linux-2.5.32'
  make: *** [.hdepend] Error 2
  bash-2.05a# 

Best Regards

Stephane Wirtel

On Tue, Aug 27, 2002 at 12:47:16PM -0700, Linus Torvalds wrote:
> 
> Delayed by various issues (including a HT-only MTRR bug that Ingo finally
> chased down and that kept me chasing shadows for days). As a result, this 
> is fairly big..
> 
> Most noticeable is the (already discussed) IDE revert, and the threading
> updates. The input layer switch-over may also end up being a bit painful
> for a while, since that not only adds a lot of config options that you
> have to get right to have a working keyboard and mouse (we'll fix that
> usability nightmare), but the drivers themselves are different and there
> are likely devices out there that depended on various quirks.
> 
> The AIO core code from Ben got merged, and Al worked on cleaning up the 
> gendisk stuff from a number of drivers that were missed last time. And the 
> usual USB updates..
> 
> Oh, and various architecture updates (sparc64, ppc64, ia-64).
> 
> 		Linus
> 
> -----
> 
> Summary of changes from v2.5.31 to v2.5.32
> ============================================
> 
> <ac9410@attbi.com>:
>   o 2.5.31 i2c updates
> 
> <agrover@acpi3.jf.intel.com>:
>   o remove redundant slab.h include (Brad Hards)
> 
> <bheilbrun@paypal.com>:
>   o Reorder unlocking in rq_unlock
> 
> <cel@citi.umich.edu>:
>   o eliminate hangs during RPC client shutdown
> 
> <ctindel@cup.hp.com>:
>   o drivers/net/bonding.c: Handle non-ETHTOOL devices more correctly
> 
> David Mosberger <davidm@tiger.hpl.hp.com>:
>   o ia64: Sync up with 2.5.18
>   o ia64: Fix fls() declaration so it actually gets inlined.  Duh
>   o ia64: Add perfmon_itanium.h
>   o ia64: Fix typo in arch/ia64/kernel/signal.c (reported by Peter
>     Chubb)
>   o ia64: Make gcc3.1 more aggressive with inline so it does the Right
>     Thing on DRM
>   o ia64: Wide IOSAPIC base_irq field to 32 bits.  Patch by KOCHI
>     Takayoshi
>   o ia64: Get rid of obsolete MAP_NR_DENSE().  Patch by Bjorn Helgaas
>   o ia64: Correct value delivered in siginfo.si_addr for SIGTRAP due to
>     a debug breakpoint.  Patch by Stephane Eranian.
>   o ia64: Install NaT page at address zero to speed up speculation
>     across NULL pointers.  Patch by Ken Chen.
>   o ia64: Add McKinley-tuned versions of copy_user() and memcpy(). 
>     Patch by Ken Chen
>   o ia64: Fix NaT consumption fault handler to not oops if fault was
>     triggered in a code section with an exception handler.
>   o ia64: Change EFI memory descriptor walking code to ignore memory
>     areas that could cause illegal memory attribute aliasing.
>   o ia64: Don't inherit all PSR bits across fork() & exec()
>   o ia64: Build memcpy.o on Itanium only
>   o ia64: Fix perfmon initialization bug.  Patch by Stephane Eranian
>   o ia64: New file perfmon_mckinley.h
>   o ia64: TLB flushing fixes and reserve large-page syscall numbers
>   o ia64: Misc. minor fixes
>   o ia64: Fix formatting of Rusty's designated initializer changes
>   o ia64: Fix "make xconfig".  Patch by Keith Owens
>   o ia64: Drop global irqlock support from hardirq.h.  Move HP
>     simulator config file to arch/ia64/hp/sim/ subdirectory.
>   o ia64: Sync up with 2.5.29+
>   o ia64: Allow for more than 32 CPUs.  Minor formatting cleanups
>   o ia64: More 2.5.xx syncing
>   o ia64: Minor formatting fixes
>   o ia64: Make fph-restore lazy.  Patch by Asit K. Mallick
>   o ia64: Print fpswa revision number.  Based on patch by KOCHI
>     Takayoshi.
> 
> <driver@huey.jpl.nasa.gov>:
>   o Fix spelling in natsemi net driver
> 
> <hch@lst.de>:
>   o i_sem-less generic_file_write for O_DIRECT & XFS
>   o fix syscall prototypes in init/do_mounts.c
> 
> <jackson@realtek.com.tw>:
>   o Fix typos in 8139cp net driver RxProto{TCP,UDP} constants
> 
> <james@cobaltmountain.com>:
>   o net/ipv4/netfilter/ip_conntrack_core.c: Fix comment typo
> 
> <jdike@karaya.com>:
>   o UML patch fixup
> 
> <jejb@mulgrave.(none)>:
>   o [SCSI 53c700] clean up cli code
>   o [SCSI debug driver] change DRIVER_ATTR usage
> 
> <jenna.s.hall@intel.com>:
>   o Here is a small patch that missed inclusion with the bigger MCA
>     logging patch last February.  Please include this in the next
>     possible ia64 kernel patch.
> 
> <jsiemes@web.de>:
>   o net/ipv4/ipconfig.c: Add support for multiple nameservers
> 
> <jsimmons@maxwell.earthlink.net>:
>   o Removal of get_fix and get_var. Use the fields in struct fb_info
>     instead
>   o A couple of Oops fixes
>   o Code cleanups and bug fixes
>   o ported Mach 64 driver to new fbdev api
>   o Bug fixes for Sparc platform
>   o Moved over to use the fix field in struct fb_info instead of fields
>     in struct display
>   o M68k fbdev fixes
> 
> <jwoithe@physics.adelaide.edu.au>:
>   o Support for Buffalo 40GB USB hard disk
> 
> <k-suganuma@mvj.biglobe.ne.jp>:
>   o hotplug boot change updates
> 
> <kai@zephyr.physics.uiowa.edu>:
>   o kbuild: remove spurious comment
>   o kbuild: remove duplicated dependencies
>   o kbuild: remove duplicate CONFIG_DEBUG_SPINLOCK
>   o kbuild: remove OSS pointless hex default
>   o kbuild: remove duplicate modules menu
>   o kbuild: fix missing/spurious EXPERIMENTAL
>   o kbuild: fix Config.in if statement syntax error
> 
> <kenneth.w.chen@intel.com>:
>   o This patch fixes some critical bugs in copy_user exception handler
>     found by Xavier.  The fixes are all in the exception handler and
>     there are no changes in the main "copy" body.  I have tested with
>     both gcc2.96 and gcc3.1 compiler.  Please report issues to me if
>     there are any.  Thanks.
> 
> <kisza@sch.bme.hu>:
>   o net/ipv6/netfilter/ip6_tables.c: Fix extension header parsing bugs
> 
> <kmsmith@umich.edu>:
>   o kNFSd: new error codes for NFSv4
>   o kNFSd: NFSv4: error codes in include/linux/nfsd/nfsd.h
>   o kNFSd: NFSv4: fix type checking in fh_verify()
>   o kNFSd: NFSv4: change ->rq_vers==3 to ->rq_vers>2
>   o kNFSd: NFSv4: return err_nofilehandle if missing fh in fh_verify()
>   o kNFSd: NFSv4: wipe out all evidence in fh_put()
>   o kNFSd: NFSv4: allow resfh==fhp in fh_compose()
>   o kNFSd: NFSv4: overflow check in nfsd_commit()
>   o kNFSd: NFSv4: allow type==0 in nfsd_unlink()
>   o kNFSd: NFSv4: tweak nfsd_create_v3() for NFSv4
>   o kNFSd: NFSv4: new argument to nfsd_access()
>   o kNFSd: NFSv4: tweak nfsd_readdir() for NFSv4
> 
> <maalanen@ra.abo.fi>:
>   o vmalloc.c error path fixes
> 
> <manik@cisco.com>:
>   o More__builtin_expect() cleanup in favour of likely/unlikely
> 
> <mannthey@us.ibm.com>:
>   o for i386 SETUP CODE
> 
> <patmans@us.ibm.com>:
>   o Re: [PATCH] 2.5.30 scsi_scan.c cleanup/rewrite
> 
> <pbadari@us.ibm.com>:
>   o embarrassing 2.5.31 small bug fix for blkdev_reread_part()
> 
> <peterc@gelato.unsw.edu.au>:
>   o simserial.c needs hw_irq.h to get the declaration for
>     ia64_alloc_irq()
> 
> <sam@mars.ravnborg.org>:
>   o kbuild: Moved conmakehash to scripts
>   o mrproper: Moved knowledge of files in scripts to scripts/Makefile
>     No reason to keep this knowledge in a central place when it can be
>     avoided
> 
> <sam@ravnborg.org>:
>   o trivial: 2.5.31+bk forgotten endmenu
> 
> <solar@openwall.com>:
>   o net/unix/af_unix.c: Set ATIME on socket inode
> 
> <steve.cameron@hp.com>:
>   o cpqfc, 2.5.30, lun fix
>   o fix cpqfc passthrough ioctl for 2.5.30
> 
> <steve@gw.chygwyn.com>:
>   o [DECNET]: Fix route device refcounting
> 
> <willy@debian.org>:
>   o Trivial: remove sti from aic7xxx_old
>   o lockd shouldn't call posix_unblock_lock here
> 
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o Fix #undef warning in xirc2ps_cs net driver
> 
> Alexander Viro <viro@math.psu.edu>:
>   o DAC960 per-disk gendisks
>   o compile fixes, xd.c switched to per-disk gendisks
>   o cciss partitioning stuff, per-disk gendisks
>   o per-disk gendisks in ataraid
>   o acsi per-disk gendisks
>   o dasd per-disk gendisks
>   o umem per-disk gendisks
>   o per-disk gendisks in md.c
>   o per-disk gendisks in i2o
> 
> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
>   o arch/i386/lib/checksum.S: Handle zero length
> 
> Andrew Morton <akpm@zip.com.au>:
>   o fix ARCH_HAS_PREFETCH
>   o reduced locking in buffer.c
>   o scaled writeback throttling levels
>   o random fixes
>   o designated initialisers for ext2
>   o export simple_strtoull
>   o printk from userspace
>   o pagevec infrastructure
>   o multithread page reclaim
>   o batched movement of lru pages in writeback
>   o batched addition of pages to the LRU
>   o batched removal of pages from the LRU
>   o make pagemap_lru_lock irq-safe
>   o pagemap_lru_lock wrapup
>   o deferred and batched addition of pages to the LRU
>   o uninitialised local in generic_file_write
>   o memory leak in current BK
>   o PageReserved test in __pagevec_release()
>   o Fix a race between __page_cache_release() and shrink_cache()
>   o fix uniprocessor lockups
>   o Fix a BUG in try_to_unmap()
>   o Fix YA bug in __page_cache_release
>   o LRU race semi-fix
> 
> Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
>   o usb_string fix
> 
> Andy Grover <agrover@groveronline.com>:
>   o By Herbert Nachtnebel
>   o Make CONFIG_ACPI_BOOT work again (Pavel Machek)
>   o Change acpi_system_suspend to use new irq functions (Pavel Machek)
>   o A trio of minor fixes
>   o ACPI interpreter updates
> 
> Anton Altaparmakov <aia21@cantab.net>:
>   o NTFS: 2.0.25 - Small bug fixes and cleanups
> 
> Anton Blanchard <anton@samba.org>:
>   o ppc64: Release the FWNMI area during a system reset, fixes xmon
>   o ppc64: Fix stupid bug in pte_protect, it helps when we pass the
>     value in
>   o ppc64: defconfig update
>   o ppc64: 2.5.28 update
>   o ppc64: Correct number of arguments passed to handle_sysrq
>   o ppc64: Make cpu_relax a barrier
>   o ppc64: rwsem updates from ppc32 and synchronize_irq fix from x86
>   o ppc64: rename to pread64/pwrite64 and add sys_readahead
>   o ppc64: Small clean up of NUMA code
>   o ppc64: hotplug cpu changes
>   o ppc64: fix up set_tb and SPRN_TB* defines as well as some misc
>     cleanups
>   o ppc64: Remove -fsigned-char and use -mcpu=power4 in CFLAGS
>   o ppc64: Allow user to change MSR_FE0 and MSR_FE1 - from ppc32
>   o ppc64: defconfig update
>   o ppc64: avoid bitops where possible in cacheflush avoidance code
>   o ppc64: remove unused include
>   o ppc64: merge in ppc32 changes to atomic_dec_and_lock
>   o ppc64: set medium HMT priority in __delay, it gets used outside of
>     udelay
>   o ppc64: fix atomic_dec_and_lock symbol export
>   o Use HMT hints in cpu_relax
>   o ppc64: remove duplicate includes, from Brad Hards
>   o ppc64: Disable irqs in init_new_context, destroy_context
>   o ppc64: Fix breakage when I added sys_readahead
>   o ppc64: missing include
>   o ppc64: 32 bit syscall cleanup, first step in making this stuff
>     generic
>   o ppc64: remove some unimplemented syscalls
>   o ppc64: 32 bit mknod and chmod need no sign extension
> 
> Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
>   o make psnap and p8022 use the new LLC stack
>   o LLC: Remove global variables used in confirms and indications
>   o LLC: fix AF_LLC connection confirm and core connection request bugs
>   o [ATALK] fix compilation of appletalk drivers
>   o LLC: use skb->cb to store the LLC events
> 
> Asit K. Mallick <asit.k.mallick@intel.com>:
>   o fix Itanium copy_user for uninitialized NaT
> 
> Benjamin LaHaise <bcrl@redhat.com>:
>   o reduce stack usage of sanitize_e820_map
>   o convert quota.h to bsd 3 clause
>   o add basic stubs for aio
>   o add aio core
> 
> Bjorn Helgaas <bjorn_helgaas@hp.com>:
>   o ia64: GENERIC build fixes
>   o ia64: Here's a patch to make sba_iommu work again
>   o Here are a couple patches against 2.5.18-ia64-020530.  The first is
>     some trivial cleanup in ia64/kernel/acpi.c (no need to initialize
>     automatics that are immediately assigned, don't check for "0 ==
>     __va(x)", don't bail out of acpi_boot_init
> 
> Brad Hards <bhards@bigpond.net.au>:
>   o Remove unneeded #includes from 3c359, sbni, and sdla_ft1 net
>     drivers
> 
> Brian Beattie <beattie@beattie-home.net>:
>   o patch for 2.5 scanner.h add device id's
> 
> Christoph Hellwig <hch@sb.bsdonline.org>:
>   o VM: Rework vmalloc code to support mapping of arbitray pages
>   o Cleanup BKL handling and move kernel_flag definition to common code
>   o Cleanup console merge
> 
> Dave Hansen <haveblue@us.ibm.com>:
>   o NUMA-Q disable irqbalance
>   o fix link problem in ips driver
> 
> Dave Jones <davej@suse.de>:
>   o Modular x86 MTRR driver
>   o ROMFS superblock cleanup
>   o UFS superblock cleanup
>   o struct superblock cleanups
> 
> Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
>   o JFS: Trivial fixes
>   o [JFS] direct-to-BIO pagecache IO
> 
> David Brownell <david-b@pacbell.net>:
>   o ehci updates
>   o ohci, rm sparc64 oops
>   o ehci, debug info in driverfs
>   o ehci does interrupt queuing
>   o expose dma_addr_t in urbs
>   o HCDs support new DMA APIs (part 1 of 2)
>   o HCDs support new DMA APIs (part 2 of 2)
>   o USB core cleanups
>   o misc usbcore cleanups
> 
> David Mosberger <davidm@wailua.hpl.hp.com>:
>   o ia64: Fix do_profile() to account kernel ticks spent on behalf of
>     pid 0.  Clean up arch/ia64/config.in (based on patch by Keith
>     Owens).
>   o ia64: Sync with 2.5.30
>   o ia64: Sync up with 2.5.31
> 
> David S. Miller <davem@nuts.ninka.net>:
>   o net/llc/llc_main.c: Fix typo in struct member init
>   o SPARC: Implement pcic_present which walks OBP tree, use it always
>     in sbus_init
>   o arch/sparc64/defconfig: Update
>   o arch/sparc64/kernel/pci.c:pcic_present Invoke pci_is_controller
>   o drivers/scsi/esp.c: Kill unused local var flags
>   o include/linux/netdevice.h: Define HAVE_NETDEV_POLL
>   o kernel/sched.c:migration_init Avoid int-->pointer cast warning on
>     64-bit
>   o kernel/softirq.c:spawn_ksoftirqd Avoid int-->pointer cast warning
>     on 64-bit
>   o kernel/cpu.c:cpu_up Avoid int-->pointer cast warning on 64-bit
>   o drivers/ide/ide-disk.c:lba_capacity_is_ok {u,s}64 is not
>     necessarily a long long
>   o fs/jfs/resize.c:jfs_extendfs {u,s}64 is not necessarily a long long
>   o drivers/scsi/sr.c: Fix casting between pointer and int
>   o drivers/scsi/st.c: Fix casting between pointer and int
>   o drivers/scsi/qlogicisp.c:isp1020_load_paramters Kill unused local
>     variable
>   o SPARC64: Initial Cheetah+ cpu support
>   o arch/sparc64/mm/modutil.c: Fixup vmalloc interface changes
>   o include/linux/fb.h: Declare do_install_cmap
>   o [VIDEO]: Port SBUS framebuffer to video layer changes
>   o drivers/video/aty/mach64_cursor.c: Kill warning on sparc64
>   o arch/sparc64/defconfig: Update
>   o include/asm-sparc{,64}/ide.h: Get IDE layer building again on Sparc
>   o arch/sparc64/kernel/smp.c:smp_tune_scheduling Handle Cheetah+
>   o SPARC64: Fix obscure cheetah+ hangs
>   o TIGON3: Add missing udelay when clearing SRAM stats/status block
>   o net/unix/af_unix.c: Set msg_namelen in unix_copy_addr properly,
>     define MODULE_LICENSE
>   o net/ipv4/tcp_diag.c: Avoid unaligned accesses to tcpdiag_cookie
>   o SPARC64:setup_arch Flush correct I-cache line when patching
>     irqsz_patchme
>   o SPARC64: Bug fixes in arch/sparc64/mm/ultra.S
>   o [CLONE_*TID]: Make tsk->user_tid and int so that 64-bit arches work
>   o [SPARC64]: Synchronize with 2.5.x changes
>   o [SPARC32]: Synchronize with 2.5.x changes
>   o net/unix/af_unix.c: protinfo is dead, use unix_sk()
>   o SPARC64: Ultra-III+ bug fix and better bad trap logging
> 
> David S. Miller <davem@redhat.com>:
>   o I did find one bug, hid_submit_ctrl() does not cpu_to_le16() all
>     the control request fields properly.
> 
> Douglas Gilbert <dougg@torque.net>:
>   o Here is an update for scsi_debug that utilizes driverfs support for
>     per driver parameters added in lk 2.5.31
>   o lk 2.5.31 scsi interface documentation
>   o This version of sg for the lk 2.5 series re-adds direct IO support
>     using work done by Kai Makisara (on st driver, posted 2002/7/29).
> 
> Eric Sandeen <sandeen@sgi.com>:
>   o Remove unused var and unused func from ali-ircc IrDA driver
> 
> franz.sirl-kernel@lauterbach.com <Franz.Sirl-kernel@lauterbach.com>:
>   o Hi Vojtech, I noticed you just pushed the pc_keyb.c removal to
>     linux-input, here is the PPC part of it that removes now superflous
>     stuff. The small change in keyboard.c is a bugfix from 2.4 and ruby
>     that didn't make it into 2.5 yet.
>   o Two minor fixes on top of the PPC final input conversion
> 
> Geert Uytterhoeven <geert@linux-m68k.org>:
>   o Compile fixes for Amiga input drivers
> 
> Greg Kroah-Hartman <greg@kroah.com>:
>   o USB storage: split up BUG_ON for easier debugging
>   o USB: Makefile fix for previous patch
>   o USB: remove LINUX_VERSION_CODE checks
>   o USB: moved put_bus to its proper place (as the last thing we do
>     shutting down.)
>   o USB: check to see if we have a disconnect function before trying to
>     call it
>   o USB: fixed DEVICE_ATTR usage in the ehci driver
>   o USB: changed usb_match_id to not need the usb_device pointer
>   o USB: rename printer.c to usblp.c as that's what it has been calling
>     itself :)
>   o USB: added usblcd driver
>   o USB: fix minor number for the usblcd driver
>   o USB: added the speedtouch usb driver
> 
> Harald Welte <laforge@gnumonks.org>:
>   o include/linux/kernel.h: Define HIPQUAD correctly on little-endian
>   o [NETFILTER]: Synchronize with 2.4.x newnat infrastructure
>   o NETFILTER: New netfilter modules
>   o NETFILTER: Rest of new netfilter modules changes
> 
> Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
>   o Fix generic_file_send()
>   o add sendfile() support to fatfs (3/3)
> 
> Ingo Molnar <mingo@elte.hu>:
>   o tls-2.5.31-D9
>   o APM TLS fix, 2.5.31-BK
>   o CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
>   o clone-detached-2.5.31-B0
>   o user-vm-unlock-2.5.31-A2
>   o thread release infrastructure
>   o stale thread detach debugging removal
>   o thread management - take three
>   o Thread exit notification by futex
>   o Re: Boot failure in 2.5.31 BK with new TLS patch
>   o O(1) sys_exit(), threading, scalable-exit-2.5.31-B4
>   o O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
>   o HT & MTRRs, 2.5.31-BK-curr
> 
> James Morris <jmorris@intercode.com.au>:
>   o [NETFILTER]: Fixup ip6_queue much like ip_queue was
>   o net/ipv4/netfilter/ipfwadm_core.c: Fix 2.5.x compilation
> 
> Jan-Benedict Glaw <jbglaw@lug-owl.de>:
>   o CodingStyle and docu update to srm_env
> 
> Jeff Garzik <jgarzik@mandrakesoft.com>:
>   o Remove dead prototype, fix printk format string in rcpci45 net
>     driver
>   o Include linux/bitops.h in e100 net driver, it uses ffs (Noticed by
>     DaveM)
> 
> Jens Axboe <axboe@burns.home.kernel.dk>:
>   o Delete 2.5 IDE core
>   o Add 2.4 IDE core, based on late 2.4.19-pre-acX version
>   o Add missing pci ids for various ide controllers
>   o Add x86 versions of various irq and resource stuff for 2.4-ide
>   o Add back in the request types that 2.4 still uses, need to clean
>     these a bit later
>   o Add back in the missing 2.4-ide bits from hdreg.h These also wants
>     a bit of cleaning later.
>   o Add in 2.4 ide-scsi
>   o sym53c8xx_2
> 
> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>   o ISDN: Move calculating the currently used bandwidth
>   o ISDN: Start cleaning isdn_net hangup timeout handling
>   o ISDN: Fix Config.in problem
>   o ISDN: Use C99 initializers
>   o ISDN: __FUNCTION__ cleanup
>   o ISDN: Change Christian Mock's email adress
>   o ISDN: Fix BC_BUSY problem
>   o ISDN: Remove debugging code
>   o kbuild: check for updated [Cc]onfig.in files
>   o kbuild: Cleanup the chmod rule in scripts/
>   o kbuild: Fix drivers/net/appletalk/Config.in
>   o kbuild: Remove HPATH, general cleanup
>   o kbuild: Common rule for preprocessing vmlinux.lds
> 
> kai.makisara@kolumbus.fi <Kai.Makisara@kolumbus.fi>:
>   o SCSI tape direct transfers for 2.5.31
> 
> Linus Torvalds <torvalds@home.transmeta.com>:
>   o Don't allow user-level helpers to be run when our infrastructure
>     isn't ready for it (either during early boot, or at shutdown)
>   o Missed prototype for 'system_running' fix
>   o Don't BUG_ON() SCSI length confusion. Print out the problem and the
>     call trace instead.
>   o Move x86 big-kernel-lock implementation into <linux/smp_lock.h>,
>     since it was generic.
>   o Hmm.. It was never correct to directly include <asm/smplock.h>, but
>     some files still did (and got the wrong results on UP).
>   o re-do spinlock cleanup, it was innocent Cset exclude:
>     torvalds@home.transmeta.com|ChangeSet|20020821235957|57282
>   o Handle page fault atomicity correctly when preempt is enabled
>   o Fix syntax error in character driver Config.in file introduced by
>     input merge
>   o Keyboard reset NAK does not imply that the keyboard isn't there.
>   o Get rid of /proc dependency on inode numbers
>   o Clean up asm-i386/smplock.h
>   o Remove extraneous ptrace.h include
>   o Fix missing kmap_types.h header (it got included "by mistake" with
>     highmem enabled, but not otherwise, and was always required).
>   o Update defconfig to current state (keyboard/input layer in
>     particular)
> 
> Luca Barbieri <ldb@ldb.ods.org>:
>   o Make rmap.c alloc/free actually inline
> 
> Martin Mares <mj@ucw.cz>:
>   o PCI ID's for 2.5.31
> 
> martin.bligh@us.ibm.com <Martin.Bligh@us.ibm.com>:
>   o NUMA-Q relocate early ioremap
>   o NUMA-Q disable irqbalance
> 
> Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
>   o USB-storage: final abort handler cleanup
>   o USB-storage: final abort handler cleanup, for real
>   o fix devices which don't support EVPD
>   o fix devices which don't support START_STOP
> 
> Neil Brown <neilb@cse.unsw.edu.au>:
>   o Rearrange setting of snd/rcv buf size to avoid locking issue
>   o RPC/TCP 2 of 4 - Allow  SO_REUSEADDR for NFS sockets
>   o RPC/TCP 3 of 4 - Correct error message when rpc/tcp sent fails
>   o RPC/TCP 4 of 4 - Handle short read when reading RPC/TCP packet
>     length
>   o Fix two problems with multiple concurrent nfs/tcp connects
>   o call svc_sock_setbufsize when socket created
>   o Fix error message printed when not enough queue space
>   o md: Fix assort typos in most recent MD patches
>   o md: Silence a warning in md.c
>   o md: Store rdev instead of bdev in per-personality status arrays
>   o md: MD error handers and md_sync_acct now get rdev instead of bdev
>   o md: Keep track of number of pending requests on each component
>     device on an MD array
>   o md: Remove used_slot field from per-personality info
>   o md: Make spare handling simple ... personalities know less
>   o md: Improve code for deciding whether to skip an IO in raid5
>   o md: Remove 'alias_device' flag
>   o md: Remove per-personality 'operational' and 'write_only' flags
>   o md: Make the old-ioctl warning in md only complain about MD ioctls
>   o md: Get rid of un-necessary warning in md
>   o md: Fix up oops-able error message
> 
> Oliver Neukum <oliver@neukum.name>:
>   o fix urb leak in error in cdc-ether
>   o Problem with CDC Ethernet driver (CDCEther.c)
> 
> Patrick Mochel <mochel@osdl.org>:
>   o Change DEVICE_ATTR, BUS_ATTR, and DRIVER_ATTR macros to not take a
>     '_str' parameter, and just __stringify the name instead.
>   o Update device model locking
>   o Fix and prevent bugs in device_register()
>   o Update device model locking
>   o Remove do_driver_detach(), since device_detach does the same thing
>   o Use C99 initializers in driver model core
>   o Make sure we do to_dev(node) in device_suspend()
>   o Remove device_root device; replace with global_device_list
>   o Remove extra '#include <linux/err.h>' in drivers/base/core.c
>   o Introduce struct device_class
>   o Introduce struct device_interface
>   o Define input device class and register it
>   o Define a struct device_interface for all the input interfaces and
>     register them with the input device class when started up. 
>   o unlock the right lock in enum_device
>   o input layer update
>   o Remove input_handler list; replace with
>     LIST_HEAD(input_handler_list)
>   o Use standard linked lists in input layer
> 
> Paul Larson <plars@austin.ibm.com>:
>   o Include tgid when finding next_safe in get_pid()
> 
> Paul Mackerras <paulus@samba.org>:
>   o USB root hub polling and suspend
>   o add FP exception mode prctl
>   o PPC32: add the bits needed for AIO and sendfile64 support
>   o PPC32: define L1_CACHE_SHIFT
>   o PPC32: Fix the type of set_rtc_time
>   o PPC32: include sched.h before elfcore.h in ppc_ksyms.c
>   o PPC32: define bits that are needed for the IDE subsystem now
>   o PPC32: remove code that sets kd_mksound now that it isn't a pointer
> 
> pavel@janik.cz <Pavel@Janik.cz>:
>   o Probe port 0x240 too, in eexpress net driver
> 
> Pete Zaitcev <zaitcev@redhat.com>:
>   o SPARC: More work to get sparc32 working in 2.5.x
>   o SPARC: Fix prom_printf and prom console behavior
>   o include/asm-sparc/pgtable.h: Fix woops in ZERO_PAGE
> 
> Petr Vandrovec <vandrove@vc.cvut.cz>:
>   o C99 designated initializers for fs/ncpfs
>   o Support secondary head DDC on G450/G550
>   o Make secondary output support mandatory for Matrox G450/G550
>   o Remove structure holding state of secondary output in the matroxfb
>     driver
>   o matroxfb: Find appropriate setting for specified color depth by
>     looking through table instead of using if-else branches in code.
>     Source is cleaner, and generated code is smaller with this change.
>     By Denis Zaitsev <zzz@cd-club.ru>
>   o Simplify rules for writting secondary output drivers to matroxfb
>   o Use arrays for holding Matrox output drivers, it is nicer and more
>     extensible than current solution with per-CRTC bitmaps.
>   o Store pointer to matroxfb specific fb information instead of
>     universal fb_info* pointer for secondary head. Saves some
>     typecasts.
>   o Use container_of instead of simple typecast when we convert
>     pointers from pointer to fb_info to pointers to matrox_fb_info.
>   o Initialize Matrox G100 and G400 hardware with values read from BIOS
>     instead of with failsafe settings discovered in the past.
>   o matroxfb DVI updates
>   o Add TV-Out support for Matrox G450/G550. Due to the hardware only
>     secondary CRTC can be used as a source for TV output.
>   o Make debug printouts in matroxfb G400 TV-out disabled by default
>   o Remove currcon field from private fb_info in matroxfb. It was moved
>     to the generic layer long ago.
>   o Use sizeof(*var) instead of sizeof(struct xxx) in matroxfb
>   o Return ENOTTY instead of EINVAL for unknown ioctl ops in matroxfb
>   o Add support for MGA-TVO-B into matroxfb. By Mike Pieper
>   o matroxfb: Do not store results of bitwise AND directly in variables
>     which are treated as a booleans. Comparsion does not work correctly
>     on them. 
>   o Set system PLL vcomax correctly in matroxfb. Discovered by Dirk
>     Uffmann
>   o Update matroxfb to the current fbdev API
>   o Unicode characters 0x80-0x9F are valid ISO* characters
>   o broken cfb* support in the 2.5.31-bk
>   o es1371 synchronize_irq
>   o oops from console subsystem: dereferencing wild pointer
>   o More display -> fb_info fixes for new fbdev
> 
> Randy Dunlap <rddunlap@osdl.org>:
>   o Network Options and Network Devices together
> 
> Rik van Riel <riel@conectiva.com.br>:
>   o rmap bugfix, try_to_unmap
> 
> Robert Love <rml@tech9.net>:
>   o spinlock.h cleanup
> 
> Rusty Russell <rusty@rustcorp.com.au>:
>   o Designated initializers for ia64
>   o [TRIVIAL] Use __cachline_aligned in netdevice.h
>   o ia64 incorrect field name in message
>   o designated initializers for include/linux
>   o Designated initializers for i386
>   o Export __per_cpu_offset so modules can use per-cpu data
>   o get_cpu_var patch
>   o DECLARE_PER_CPU/DEFINE_PER_CPU patch
>   o init_tasks is not defined anywhere
> 
> Simon Evans <spse@secret.org.uk>:
>   o misc fixes for konicawc driver
>   o cleanup RingQueue_* functions in usbvideo.c
>   o konicawc - make snapshot button into input device
>   o add callback for VIDIOCSWIN ioctl to usbvideo
>   o add VIDIOCSWIN support to konicawc driver
>   o use __FUNCTION__ in usbvideo
>   o typedef uvd_t removal in usbvideo
> 
> Stéphane Eranian <eranian@hpl.hp.com>:
>   o Allow blocking on overflow notifications to work again
> 
> Tom Rini <trini@kernel.crashing.org>:
>   o A generic RTC driver [1/3]
>   o A generic RTC driver [2/3]
>   o A generic RTC driver [3/3]
> 
> Trond Myklebust <trond.myklebust@fys.uio.no>:
>   o Fix typo in the RPC reconnect code
>   o cleanup RPC accounting
>   o Clean up the RPC socket slot allocation code [1/2]
>   o Clean up the RPC socket slot allocation code [2/2]
>   o Improve NFS READ reply sanity checking
>   o Improve READDIR/READDIRPLUS sanity checking
> 
> V. Ganesh <ganesh@vxindia.veritas.com>:
>   o typo in usb/serial/ipaq.h
> 
> Vojtech Pavlik <vojtech@suse.cz>:
>   o Fix i8042.c to ignore fake key releases generated by AT keyboard in
>     translated set 2. This fixes a problem where shift-pgup, with the
>     pgup released first generated an unknown scancode warning and the
>     shift remained stuck.
>   o This is the last and most important step in the input core
>     conversion
>   o This (re)implements getkeycode/setkeycode, kbd_rate and kd_mksound
>     as functions interfacing to the input core. PC-Speaker handling is
>     moved to a separate file. Uinput is moved to a input/misc
>     directory.
>   o Shorten the keycode handling code in keyboard.c and evdev.c
>   o Fix bits that have fallen out when merging input-based keyboard.c
>     into 2.5 - kbd0 init, sysrq support, show_regs, show_mem,
>     show_state support, correct handling of shifts across vt switches,
>     console blanking, console callback. Hope that's all.
>   o Always build input.o in - avoid build problems with keyboard.c
>   o Add mouse model reporting into psmouse.c
>   o Fix a dangling 'else' after removing ps/2 keyboard support
>   o Workaround to make iforce-usb.c compile with Pat Mochel's input to
>     standard lists conversion.
>   o Minor endianness and debugging fixes. Most thanks to Dave Miller
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
