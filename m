Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752059AbWJWXXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWJWXXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWJWXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:23:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752059AbWJWXXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:23:06 -0400
Date: Mon, 23 Oct 2006 16:22:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.19-rc3
Message-ID: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2145105941-1161645779=:3962"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2145105941-1161645779=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok,
 a few days late, because I'm a retard and didn't think of doing a release 
when I should have. 

I'm also a bit grumpy, because I think people are sending me more stuff 
than they should at this stage in the game. We've been pretty good about 
keeping the later -rc releases quiet, please keep it that way.

That said, it's mostly harmless cleanups and some architecture updates. 
And some of the added warnings about unused return values have caused a 
number of people to add error handling. And on the driver front, there's 
mainly new driver ID's, and a couple of new drivers.

Shortlog appended,

		Linus
----
Adrian Bunk (12):
      RDMA/amso1100: Fix a NULL dereference in error path
      drivers/char/specialix.c: fix the baud conversion
      USB: ftdi-elan.c: remove dead code
      USB: mos7840.c: fix a check-after-dereference
      [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): remove dead code
      [GFS2] fs/gfs2/ops_fstype.c:gfs2_get_sb_meta(): remove unused variable
      [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use an uninitialized variable
      [GFS2] fs/gfs2/ops_fstype.c:fill_super_meta(): fix NULL dereference
      [GFS2] gfs2_dir_read_data(): fix uninitialized variable usage
      one more ARM IRQ fix
      ATA must depend on BLOCK
      drivers/ide/pci/generic.c: re-add the __setup("all-generic-ide",...)

Akinobu Mita (8):
      [CRYPTO] api: fix crypto_alloc_base() return value
      md: fix /proc/mdstat refcounting
      rd: memory leak on rd_init() failure
      epca: prevent panic on tty_register_driver() failure
      usb devio: handle class_device_create() error
      cpcihp_generic: prevent loading without "bridge" parameter
      driver core: kmalloc() failure check in driver_probe_device
      ocfs2: delete redundant memcmp()

Al Viro (31):
      gfp_t in netlabel
      new cifs endianness bugs
      hp drivers/input stuff: C99 initializers, NULL noise removal, __user annotations
      sun3_ioremap() prototype
      serial167 __user annotations, NULL noise removal
      [GFS2] gfs2 endianness bug: be16 assigned to be32 field
      bug: nfsd/nfs4xdr.c misuse of ERR_PTR()
      fix svc_procfunc declaration
      lockd endianness annotations
      xdr annotations: NFSv2
      xdr annotations: NFSv3
      xdr annotations: NFSv4
      xdr annotations: NFS readdir entries
      fs/nfs/callback* passes error values big-endian
      xdr annotations: fs/nfs/callback*
      nfs: verifier is network-endian
      xdr annotations: mount_clnt
      nfs_common endianness annotations
      nfsd: nfserrno() endianness annotations
      nfsfh simple endianness annotations
      xdr annotations: nfsd_dispatch()
      xdr annotations: NFSv2 server
      xdr annotations: NFSv3 server
      xdr annotations: NFSv4 server
      nfsd: vfs.c endianness annotations
      nfsd: nfs4 code returns error values in net-endian
      nfsd: NFSv{2,3} trivial endianness annotations for error values
      nfsd: NFSv4 errno endianness annotations
      xdr annotations: nfsd callback*
      nfsd: misc endianness annotations
      nfsd: nfs_replay_me

Alan Cox (10):
      rio: fix array checking
      ide: add sanity checking to ide taskfile ioctl
      [ARM] switch to new pci_get_bus_and_slot API
      pci: Stamp out pci_find_* usage in fakephp
      PCI: quirks: switch quirks code offender to use pci_get API
      pci: Additional search functions
      irq updates: make eata_pio compile
      ahci: readability tweak
      libata-sff: Allow for wacky systems
      [ATM] nicstar: Fix a bogus casting warning

Alan Stern (6):
      USB: unusual_devs entry for Nokia 6131
      UHCI: workaround for Asus motherboard
      usbcore: fix refcount bug in endpoint removal
      usbcore: fix endpoint device creation
      USB: unusual_devs entry for Nokia 6234
      Driver core: Don't ignore error returns from probing

Alexey Dobriyan (6):
      ACPI: asus_acpi: don't printk on writing garbage to proc files
      sx: fix user-visible typo (devic)
      USB: drivers/usb/net/*: use BUILD_BUG_ON
      OOM killer meets userspace headers
      kernel/nsproxy.c: use kmemdup()
      i2o/exec-osm.c: use "unsigned long flags;"

Alexey Y. Starikovskiy (2):
      ACPI: Remove deferred execution from global lock acquire wakeup path
      ACPI: created a dedicated workqueue for notify() execution

Allan Stephens (12):
      [TIPC]: Add missing unlock in port timeout code.
      [TIPC]: Debug print buffer enhancements and fixes
      [TIPC]: Stream socket can now send > 66000 bytes at a time
      [TIPC]: Added duplicate node address detection capability
      [TIPC]: Optimize wakeup logic when socket has no waiting processes
      [TIPC]: Remove code bloat introduced by print buffer rework
      [TIPC]: Add support for Ethernet VLANs
      [TIPC]: Name publication events now delivered in chronological order
      [TIPC]: Fixed slow link reactivation when link tolerance is large
      [TIPC]: Can now list multicast link on an isolated network node
      [TIPC]: Unrecognized configuration command now returns error message
      [TIPC]: Updated TIPC version number to 1.6.2

Amit Choudhary (5):
      V4L/DVB (4738): Bt8xx/dvb-bt8xx.c: check kmalloc() return value.
      [ALSA] sound/isa/gus/interwave.c: check kmalloc() return value
      [ALSA] sound/isa/cmi8330.c: check kmalloc() return value
      [ALSA] sound/isa/ad1816a/ad1816a.c: check kmalloc() return value
      [ALSA] sound/isa/opti9xx/opti92x-ad1848.c: check kmalloc() return value

Amol Lad (5):
      [WATCHDOG] ioremap balanced with iounmap for drivers/char/watchdog/s3c2410_wdt.c
      drivers/isdn/hysdn: save_flags()/cli(), restore_flags() replaced appropriately
      drivers/isdn/isdnloop: save_flags()/cli(), restore_flags() replaced appropriately
      PCI hotplug: ioremap balanced with iounmap
      drivers/isdn: ioremap balanced with iounmap

Andi Kleen (8):
      x86-64: Update defconfig
      i386: Update defconfig
      x86: Use -maccumulate-outgoing-args
      x86-64: Revert interrupt backlink changes
      i386: Disable nmi watchdog on all ThinkPads
      x86: Revert new unwind kernel stack termination
      x86-64: Revert timer routing behaviour back to 2.6.16 state
      x86-64: Fix C3 timer test

Andrew Morton (14):
      r8169: PCI ID for Corega Gigabit network card
      Lockdep: fix compile error in drivers/input/serio/serio.c
      invalidate: remove_mapping() fix
      PROC_NUMBUF is wrong
      remove carta_random32
      vmalloc(): don't pass __GFP_ZERO to slab
      acpi_processor_latency_notifier(): UP warning fix
      swsusp: fix memory leaks
      USB: fix usbatm tiny race
      PCI: pcie-check-and-return-bus_register-errors fix
      separate bdi congestion functions from queue congestion functions
      highest_possible_node_id() linkage fix
      i386: fix .cfi_signal_frame copy-n-paste error
      pci: declare pci_get_device_reverse()

Andrew Victor (1):
      [WATCHDOG] Atmel AT91RM9200 rename.

Andrey Mirkin (1):
      scsi: megaraid_{mm,mbox}: 64-bit DMA capability fix

Andy Whitcroft (1):
      Reintroduce NODES_SPAN_OTHER_NODES for powerpc

Aneesh Kumar K.V (1):
      Add entry.S labels to tag file

Anton Blanchard (4):
      [POWERPC] Never panic when taking altivec exceptions from userspace
      [POWERPC] POWER6 has 6 PMCs
      [POWERPC] Better check in show_instructions
      [POWERPC] Check for offline nodes in pci NUMA code

Arnaud Patard (1):
      r8169: fix infinite loop during hotplug

Arnaud Patard (Rtp) (1):
      [WATCHDOG] add ich8 support to iTCO_wdt.c

Arnd Bergmann (3):
      USB: driver for mcs7830 (aka DeLOCK) USB ethernet adapter
      usbnet: improve generic ethtool support
      usbnet: add a mutex around phy register access

Aron Griffis (1):
      [IA64] move ioremap/ioremap_nocache under __KERNEL__

Arthur Kepner (1):
      IB/mthca: Use mmiowb after doorbell ring

Atsushi Nemoto (1):
      [MIPS] save_context_stack fix

Auke Kok (1):
      e100: fix reboot -f with netconsole enabled

Ben Collins (13):
      [SPARC]: Fix some section mismatch warnings in sparc drivers.
      [alim7101] Add pci dev table for auto module loading.
      [mv643xx] Add pci device table for auto module loading.
      [BusLogic] Add pci dev table for auto module loading.
      [fdomain] Add pci dev table for module auto loading.
      [initio] Add pci dev table for module auto loading.
      [ixj] Add pci dev table for module auto loading.
      [hid-core] TurboX Keyboard needs NOGET quirk.
      [controlfb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [igafb] Add pci dev table for module auto loading.
      [platinumfb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [valkyriefb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [pci_ids] Add Quicknet XJ vendor/device ID's.

Benjamin Herrenschmidt (1):
      [POWERPC] Don't crash on cell with 2 BEs when !CONFIG_NUMA

bibo,mao (1):
      x86-64: x86_64 add NX mask for PTE entry

Bjorn Helgaas (3):
      [IA64] remove unused PAL_CALL_IC_OFF
      [IA64] reformat pal.S to fit in 80 columns, fix typos
      [IA64] remove unused acpi_kbd_controller_present, acpi_legacy_devices

BjÃ¶rn Steinbrink (1):
      [NETFILTER]: Missing check for CAP_NET_ADMIN in iptables compat layer

Borislav Petkov (1):
      readjust comments of task_timeslice for kernel doc

Brent Casavant (2):
      ioc4: Remove SN2 feature and config dependencies
      ioc4: Enable build on non-SN2

Brice Goglin (2):
      PCI: Improve pci_msi_supported() comments
      PCI: Update MSI-HOWTO.txt according to pci_msi_supported()

Cedric Le Goater (1):
      [S390] fix vmlinux link when CONFIG_SYSIPC=n

Chandra Seetharaman (1):
      configfs: handle kzalloc() failure in check_perm()

Chris Malley (1):
      USB: Support for BT On-Air USB modem in cdc-acm.c

Christoph Lameter (1):
      Slab: Do not fallback to nodes that have not been bootstrapped yet

Chuck Lever (5):
      NFS: fix minor bug in new NFS symlink code
      NFS: __nfs_revalidate_inode() can use "inode" before checking it is non-NULL
      NFS: remove unused check in nfs4_open_revalidate
      SUNRPC: fix race in in-kernel RPC portmapper client
      SUNRPC: fix a typo

Corey Minyard (1):
      x86-64: Fix for arch/x86_64/pci/Makefile CFLAGS

Cornelia Huck (8):
      [S390] cio: sch_no -> schid.sch_no conversion.
      [S390] cio: update documentation.
      driver core fixes: sysfs_create_link() retval check in class.c
      driver core fixes: bus_add_attrs() retval check
      driver core fixes: bus_add_device() cleanup on error
      driver core fixes: device_add() cleanup on error
      driver core fixes: device_create_file() retval check in dmapool.c
      driver core fixes: sysfs_create_group() retval in topology.c

Craig Shelley (1):
      USB-SERIAL:cp2101 Add new device ID

Daniel Drake (1):
      PCI: VIA IRQ quirk behaviour change

Daniel Ritz (2):
      usbtouchscreen: fix data reading for ITM touchscreens
      PCI: add ICH7/8 ACPI/GPIO io resource quirks

Daniel Walker (1):
      clocksource: acpi_pm: add another greylist chipset

Darren Jenkins (1):
      ACPI: asus_acpi: fix proc files parsing

Darrick J. Wong (1):
      fix "ACPI: Processor native C-states using MWAIT"

Dave Jones (2):
      ipmi: fix return codes in failure case
      Remove useless comment from sb1250

Dave Kleikamp (3):
      JFS: pageno needs to be long
      airo: check if need to freeze
      null dereference in fs/jbd2/journal.c

David Brownell (2):
      USB: ohci-pnx4008 build fixes
      USB: ftdi_sio whitespace fixes

David Gibson (2):
      ibmveth: Fix index increment calculation
      ibmveth: Fix index increment calculation

David Howells (2):
      FRV: Use the correct preemption primitives in kmap_atomic() and co
      autofs3: Make sure all dentries refs are released before calling kill_anon_super()

David M. Grimes (1):
      knfsd: add nfs-export support to tmpfs

David S. Miller (12):
      [XFRM]: Fix xfrm_state_num going negative.
      [SPARC]: Kill BOOTME_SINGLE.
      [SPARC64]: Fix PCI memory space root resource on Hummingbird.
      [SPARC] {bbc_,}envctrl: Use call_usermodehelper().
      [SPARC64]: Update defconfig.
      [TG3]: Bump driver version and release date.
      [IPV6]: Fix route.c warnings when multiple tables are disabled.
      [SPARC64]: Compute dma_end argument to sabre_pbm_init() correctly.
      [SPARC64]: Fix of_ioremap().
      [DCCP] ipv6: Fix opt_skb leak.
      [PKT_SCHED] netem: Orphan SKB when adding to queue.
      [SPARC64]: 8-byte align return value from compat_alloc_user_space()

David Woodhouse (2):
      fix `make headers_install'
      [SPARC]: Clean up asm-sparc/elf.h pollution in userspace.

Deepak Saxena (1):
      Update smc91x driver with ARM Versatile board info

Denis M. Sadykov (5):
      ACPI: EC: Remove unnecessary delay added by previous transation patch.
      ACPI: EC: Remove unused variables and duplicated code
      ACPI: EC: Unify poll and interrupt mode transaction functions
      ACPI: EC: Unify poll and interrupt gpe handlers
      ACPI: EC: Simplify acpi_hw_low_level*() with inb()/outb().

Diego Calleja (1):
      HOWTO: bug report addition

Dmitriy Monakhov (1):
      mm: D-cache aliasing issue in cow_user_page

Dmitry Torokhov (6):
      Input: add missing exports to fix modular build
      Input: i8042 - supress ACK/NAKs when blinking during panic
      Input: atkbd - supress "too many keys" error message
      Input: serio core - handle errors returned by device_bind_driver()
      Input: gameport core - handle errors returned by device_bind_driver()
      ACPI: fix potential OOPS in power driver with CONFIG_ACPI_DEBUG

Dominic Cerquetti (1):
      USB: xpad: dance pad support

Dominik Brodowski (1):
      Documentation: feature-removal-schedule typo

Doug Warzecha (1):
      firmware/dcdbas: add size check in smi_data_write

Duncan Sands (4):
      usbatm: fix tiny race
      speedtch: "extended reach"
      cxacru: add the ZTE ZXDSL 852
      Driver core: plug device probe memory leak

Ed L Cashin (14):
      aoe: eliminate isbusy message
      aoe: update copyright date
      aoe: remove unused NARGS enum
      aoe: zero copy write 1 of 2
      aoe: jumbo frame support 1 of 2
      aoe: clean up printks via macros
      aoe: jumbo frame support 2 of 2
      aoe: improve retransmission heuristics
      aoe: zero copy write 2 of 2
      aoe: module parameter for device timeout
      aoe: use bio->bi_idx
      aoe: remove sysfs comment
      aoe: update driver version
      aoe: revert printk macros

Eiichiro Oiwa (1):
      ACPICA: Fix incorrect handling of PCI Express Root Bridge _HID

eiichiro.oiwa.nm@hitachi.com (1):
      PCI: Turn pci_fixup_video into generic for embedded VGA

Enrico Scholz (1):
      V4L/DVB (4740): Fixed an if-block to avoid floating with debug-messages

Eric Dumazet (6):
      [NET]: reduce sizeof(struct inet_peer), cleanup, change in peer_check_expire()
      [NET]: reduce per cpu ram used for loopback stats
      [TCP]: One NET_INC_STATS() could be NET_INC_STATS_BH in tcp_v4_err()
      [IPV4] inet_peer: Group together avl_left, avl_right, v4daddr to speedup lookups on some CPUS
      [NET]: Can use __get_cpu_var() instead of per_cpu() in loopback driver.
      [NET]: Reduce sizeof(struct flowi) by 20 bytes.

Eric Sesterhenn (7):
      [POWERPC] Off-by-one in /arch/ppc/platforms/mpc8*
      zd1201: Possible NULL dereference
      USB: BUG_ON conversion for wacom.c
      USB: fix use after free in wacom_sys.c
      USB: fix dereference in drivers/usb/misc/adutux.c
      USB: Memory leak in drivers/usb/serial/airprime.c
      pciehp: Remove unnecessary check in pciehp_ctrl.c

Eric W. Biederman (2):
      x86-64: Use irq_domain in ioapic_retrigger_irq
      x86-64: Put more than one cpu in TARGET_CPUS

Evgeniy Polyakov (1):
      w1 kconfig fix

Felix Kuehling (1):
      [ALSA] hda_intel: add ATI RS690 HDMI audio support

Florin Malita (1):
      airo.c: check returned values

Francisco Larramendi (1):
      rtc-max6902: month conversion fix

Franck Bui-Huu (1):
      [MIPS] Use kallsyms_lookup_size_offset() instead of kallsyms_lookup()

Geert Uytterhoeven (1):
      CONFIG_TELCLOCK depends on X86

Gerrit Renker (1):
      [DCCP]: Fix Oops in DCCPv6

Grant Coady (1):
      adm9240: Update Grant Coady's email address

Grant Grundler (1):
      USB: input: extract() and implement() are bit field manipulation routines

Greg Banks (1):
      kbuild: allow multi-word $M in Makefile.modpost

Greg Kroah-Hartman (7):
      USB: revert EHCI VIA workaround patch
      USB: ftdi-elan: fix sparse warnings
      USB: move trancevibrator.c to the proper usb directory
      USB: add USB serial mos7720 driver
      USB: cleanup sierra wireless driver a bit
      PCI Hotplug: move pci_hotplug.h to include/linux/
      aoe: fix sysfs_create_file warnings

Hans Verkuil (3):
      V4L/DVB (4729): Fix VIDIOC_G_FMT for NTSC in cx25840.
      V4L/DVB (4744): The Samsung TCPN2121P30A does not have a tda9887
      V4L/DVB (4746): HM12 is YUV 4:2:0, not YUV 4:1:1

Hartmut Hackmann (1):
      V4L/DVB (4727): Support status readout for saa713x based FM radio

Heiko Carstens (1):
      [S390] Wire up epoll_pwait syscall.

Henrik Kretzschmar (1):
      RDMA/amso1100: pci_module_init() conversion

Herbert Xu (1):
      [CRYPTO] api: Select cryptomgr where needed

Hidetoshi Seto (2):
      sysfs: remove duplicated dput in sysfs_update_file
      sysfs: update obsolete comment in sysfs_update_file

Ingo Molnar (3):
      lockdep: increase max allowed recursion depth
      genirq: clean up irq-flow-type naming
      genirq: clean up irq-flow-type naming, fix

J. Bruce Fields (4):
      knfsd: nfsd4: fix owner-override on open
      knfsd: nfsd4: fix open permission checking
      knfsd: nfsd4: Fix error handling in nfsd's callback client
      nfs4: initialize cl_ipaddr

Jack Steiner (2):
      [IA64] - Allow IPIs in timer loop
      [IA64] Count resched interrupts

Jan Beulich (2):
      x86-64: Speed up dwarf2 unwinder
      x86-64: Fix ENOSYS in system call tracing

Jan Dittmer (1):
      [IPV6] sit: Add missing MODULE_LICENSE

Jan Kara (1):
      Fix IO error reporting on fsync()

Jan Luebbe (1):
      USB: Add device id for Sierra Wireless MC8755

Jan Mate (1):
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Jarek Poplawski (1):
      USB: fix cdc-acm problems with hard irq? (inconsistent lock state)

Jaroslav Kysela (1):
      [ALSA] version 1.0.13

Jean Delvare (5):
      [WATCHDOG] includes for sample watchdog program.
      hwmon: Fix documentation typos
      smsc47m1: List the SMSC LPC47M112 as supported
      hwmon: Let w83781d and lm78 load again
      hwmon: Fix debug messages in w83781d

Jean Tourrilhes (2):
      orinoco: fix WE-21 buffer overflow
      wireless: More WE-21 potential overflows...

Jeff Dike (1):
      uml: MODE_TT is bust

Jeff Garzik (15):
      [WATCHDOG] watchdog/iTCO_wdt: fix bug related to gcc uninit warning
      Input: fm801-gp - handle errors from pci_enable_device()
      V4L/DVB (4741): {ov511,stv680}: handle sysfs errors
      V4L/DVB (4742): Drivers/media/video: handle sysfs errors
      drivers/led: handle sysfs errors
      I2O: handle a few sysfs errors
      fs/partitions/check: add sysfs error handling
      rtc: fix printk of 64-bit res on 32-bit platform
      ISDN: fix drivers, by handling errors thrown by ->readstat()
      ISDN: check for userspace copy faults
      USB/gadget/net2280: handle sysfs errors
      Driver core: bus: remove indentation level
      WAN/pc300: handle, propagate minor errors
      [ATM]: handle sysfs errors
      [ATM] firestream: handle thrown error

Jeff Moyer (1):
      direct-io: sync and invalidate file region when falling back to buffered write

Jens Axboe (2):
      Add lockless helpers for remove_suid()
      Remove SUID when splicing into an inode

Jeremy Fitzhardinge (1):
      i386: Fix fake return address

Jes Sorensen (1):
      [IA64] update sn2_defconfig

Jesper Juhl (1):
      Driver core: Don't leak 'old_class_name' in drivers/base/core.c::device_rename()

Jim Cromie (1):
      w83791d: Fix unchecked return status

Jiri Kosina (3):
      Input: serio - add lockdep annotations
      ACPI: acpi_pci_link_set() can allocate with either GFP_ATOMIC or GFP_KERNEL
      ACPI: check battery status on resume for un/plug events during sleep

Jiri Slaby (1):
      Char: correct pci_get_device changes

John Heffner (1):
      [TCP]: Bound TSO defer time

john stultz (1):
      i386 Time: Avoid PIT SMP lockups

John W. Linville (2):
      zd1211rw: fix build-break caused by association race fix
      wireless: WE-20 compatibility for ESSID and NICKN ioctls

Jonathan Corbet (1):
      V4L/DVB (4743): Fix oops in VIDIOC_G_PARM

keith mannthey (1):
      x86-64: x86_64 hot-add memory srat.c fix

Kenji Kaneshige (5):
      shpchp: fix shpchp_wait_cmd in poll
      pciehp: fix improper info messages
      pciehp - add missing locking
      shpchp: fix command completion check
      shpchp: remove unnecessary cmd_busy member from struct controller

Kevin Lloyd (1):
      USB: Sierra Wireless driver update

Kimball Murray (1):
      ACPI: SCI interrupt source override

Kristen Carlson Accardi (2):
      change pci hotplug subsystem maintainer to Kristen
      libata: use correct map_db values for ICH8

Kristoffer Ericson (2):
      [ARM] 3889/1: [Jornada7xx] Addition of correct SDRAM params into cpu-sa1110.c
      [ARM] 3890/1: [Jornada7xx] Addition of MCU commands into jornada720.h

Krzysztof Helt (1):
      [SPARC]: Sparc compilation fix with floppy enabled

Kumar Gala (1):
      [POWERPC] ppc: Add missing calls to set_irq_regs

Larry Finger (2):
      bcm43xx-softmac: check returned value from pci_enable_device
      bcm43xx-softmac: Fix system hang for x86-64 with >1GB RAM

Laurent Riffard (1):
      sotftmac: fix a slab corruption in WEP restricted key association

Lebedev, Vladimir P (2):
      ACPI: sbs: check for NULL device pointer
      ACPI: sbs: fix module_param() initializers

Len Brown (1):
      ACPI: update comments in motherboard.c

Lennart Poettering (3):
      ACPI: consolidate functions in acpi ec driver
      ACPI: EC: export ec_transaction() for msi-laptop driver
      MSI S270 Laptop support: backlight, wlan, bluetooth states

Li Yang (3):
      [POWERPC] Fix MPC8360EMDS PB board support
      [POWERPC] Add Makefile entry for MPC832x_mds support
      ucc_geth: changes to ucc_geth driver as a result of qe_lib changes and bugfixes

Liam Girdwood (1):
      [ARM] 3888/1: add pxa27x SSP FSRT register bit definition

Lijun Chen (1):
      [TIPC]: Added subscription cancellation capability

Linas Vepstas (1):
      e1000: Reset all functions after a PCI error

Linus Torvalds (5):
      Fix VM_MAYEXEC calculation
      Fix USB gadget net2280.c compile
      Revert "[mv643xx] Add pci device table for auto module loading."
      Revert unintentional and bogus change to drivers/pci/quirks.c
      Linux 2.6.19-rc3

Luiz Fernando N. Capitulino (1):
      airprime: New device ID.

Marcel Holtmann (12):
      [Bluetooth] Fix compat ioctl for BNEP, CMTP and HIDP
      [Bluetooth] Handle return values from driver core functions
      [Bluetooth] Make use of virtual devices tree
      [Bluetooth] Support concurrent connect requests
      [Bluetooth] Disconnect HID interrupt channel first
      [Bluetooth] Fix reference count when connection lookup fails
      [Bluetooth] Check if DLC is still attached to the TTY
      [Bluetooth] Add locking for bt_proto array manipulation
      [Bluetooth] Use work queue to trigger URB submission
      [Bluetooth] Add support for newer ANYCOM USB dongles
      [Bluetooth] Add missing entry for Nokia DTL-4 PCMCIA card
      [Bluetooth] Fix HID disconnect NULL pointer dereference

Marcus Junker (1):
      [WATCHDOG] w83697hf WDT driver

Marek W (1):
      ACPI: asus_acpi: W3000 support

Mark Fasheh (4):
      Take i_mutex in splice_from_pipe()
      Introduce generic_file_splice_write_nolock()
      ocfs2: fix page zeroing during simple extends
      ocfs2: cond_resched() in ocfs2_zero_extend()

Martin Habets (1):
      [SPARC]: Add sparc profiling support

Martin Schwidefsky (2):
      [S390] Fix pte type checking.
      [S390] update default configuration

Matt Domsch (1):
      PCI: optionally sort device lists breadth-first

Matthew Wilcox (3):
      V4L/DVB (4725): Fix vivi compile on parisc
      Fix dev_printk() is now GPL-only
      cciss: Fix warnings (and bug on 1TB discs)

matthieu castet (4):
      UEAGLE : be suspend friendly
      UEAGLE : use interruptible sleep
      UEAGLE : comestic changes
      UEAGLE: fix ueagle-atm Oops

Melissa Howland (1):
      [S390] monwriter find header logic.

Michael Buesch (2):
      bcm43xx: fix race condition in periodic work handler
      softmac: Fix WX and association related races

Michael Chan (1):
      [TG3]: Add lower bound checks for tx ring size.

Michael Krufky (3):
      V4L/DVB (4731a): Kconfig: restore pvrusb2 menu items
      V4L/DVB (4733): Tda10086: fix frontend selection for dvb_attach
      V4L/DVB (4734): Tda826x: fix frontend selection for dvb_attach

Michel Dänzer (1):
      [AGPGART] uninorth: Add module param 'aperture' for aperture size

Miklos Szeredi (6):
      fuse: fix hang on SMP
      document i_size_write locking rules
      fuse: locking fix for nlookup
      fuse: fix spurious BUG
      fuse: fix handling of moved directory
      fuse: fix dereferencing dentry parent

Muli Ben-Yehuda (1):
      x86-64: increase PHB1 split transaction timeout

Neil Brown (1):
      Convert cpu hotplug notifiers to use raw_notifier instead of blocking_notifier

NeilBrown (7):
      knfsd: Fix bug in recent lockd patches that can cause reclaim to fail
      knfsd: Allow lockd to drop replies as appropriate
      knfsd: fix race that can disable NFS server
      md: fix calculation of ->degraded for multipath and raid10
      md: add another COMPAT_IOCTL for md
      md: endian annotation for v1 superblock access
      md: endian annotations for the bitmap superblock

Nick Piggin (1):
      mm: more commenting on lock ordering

Nicolas Pitre (1):
      fix PXA2xx UDC compilation error

Noguchi, Masato (1):
      [POWERPC] spufs: fix support for read/write on cntl

OGAWA Hirofumi (1):
      ext3/4: fix J_ASSERT(transaction->t_updates > 0) in journal_stop()

Olaf Hering (1):
      Fix up rpaphp driver for pci hotplug header move

Oliver Neukum (3):
      USB: remove private debug macros from kaweth
      USB: suspend/resume support for kaweth
      USB: fix suspend support for usblp

Pablo Neira Ayuso (1):
      [NETFILTER]: ctnetlink: Remove debugging messages

Paolo 'Blaisorblade' Giarrusso (9):
      fix typo in memory barrier docs
      uml: remove some leftover PPC code
      uml: split memory allocation prototypes out of user.h
      uml: code convention cleanup of a file
      uml: reenable compilation of enable_timer, disabled by mistake
      uml: use DEFCONFIG_LIST to avoid reading host's config
      uml: cleanup run_helper() API to fix a leak
      uml: kconfig - silence warning
      uml: mmapper - remove just added but wrong "const" attribute

Patrick Boettcher (2):
      V4L/DVB (4748): Fixed oops for Nova-T USB2
      V4L/DVB (4750): AGC command1/2 is board specific

Patrick Caulfield (1):
      [DLM] fix iovec length in recvmsg

Patrick McHardy (6):
      [DECNET]: Use correct config option for routing by fwmark in compare_keys()
      [NETFILTER]: fix cut-and-paste error in exit functions
      [NETFILTER]: arp_tables: missing unregistration on module unload
      [NETFILTER]: ipt_ECN/ipt_TOS: fix incorrect checksum update
      [NETFILTER]: xt_CONNSECMARK: fix Kconfig dependencies
      [NETFILTER]: Update MAINTAINERS entry

Paul Fulghum (1):
      synclink: remove PAGE_SIZE reference

Paul Jackson (1):
      cpuset: mempolicy migration typo fix

Paul Moore (3):
      NetLabel: only deref the CIPSOv4 standard map fields when using standard mapping
      NetLabel: better error handling involving mls_export_cat()
      NetLabel: the CIPSOv4 passthrough mapping does not pass categories correctly

Paul Mundt (7):
      sh: Proper show_stack/show_trace() implementation.
      sh: Remove board-specific ide.h headers.
      sh: Cleanup board header directories.
      sh: Fix exception_handling_table alignment.
      sh: Add some missing board headers.
      sh: Updates for irq-flow-type naming changes.
      sh: Convert INTC2 to IRQ table registration.

Pavel Machek (1):
      ACPI: ibm_acpi: delete obsolete documentation

Pekka Enberg (1):
      ecryptfs: use special_file()

Peter Oberparleiter (1):
      [S390] cio: invalid device operational notification

Peter Zijlstra (3):
      Lockdep: add lockdep_set_class_and_subclass() and lockdep_set_subclass()
      lockdep: annotate i386 apm
      rt-mutex: fixup rt-mutex debug code

Petr Vandrovec (1):
      Fix core files so they make sense to gdb...

Pierre Ossman (2):
      ACPI: fix section for CPU init functions
      New MMC maintainer

Ping Cheng (1):
      USB: Wacom driver updates

Pádraig Brady (1):
      V4L/DVB (4739): SECAM support for saa7113 into saa7115

Ralf Baechle (11):
      [MIPS] Delete unneeded pt_regs forward declaration.
      [MIPS] Malta: Fix uninitialized regs pointer.
      [MIPS] A few more pt_regs fixups.
      [MIPS] Use compat_sys_mount.
      [MIPS] Reserve syscall numbers for kexec_load.
      [MIPS] Fix iounmap argument to const volatile.
      Make <linux/personality.h> userspace proof
      Fix warnings for WARN_ON if CONFIG_BUG is disabled
      Fix timer race
      [MIPS] Cleanup remaining references to mips_counter_frequency.
      [MIPS] Fix aliasing bug in copy_to_user_page / copy_from_user_page

Randy Dunlap (6):
      ACPI: fix printk format warnings
      fix epoll_pwait when EPOLL=n
      Kconfig serial typos
      cad_pid sysctl with PROC_FS=n
      fs/Kconfig: move GENERIC_ACL, fix acl() call errors
      [NET]: kernel-doc fix for sock.h

Randy Vinson (1):
      [POWERPC] Fix IO Window Updates on P2P bridges.

Ranjit Manomohan (1):
      [TG3]: Fix set ring params tx ring size implementation

Robert Walsh (1):
      IB/ipath: Initialize diagpkt file on device init only

Rudolf Marek (2):
      k8temp: Documentation update
      w83627ehf: Fix the detection of fan5

Russell King (4):
      [ARM] Fix fallout from IRQ regs changes
      [ARM] Fix Zaurii keyboard/touchscreen drivers
      [ARM] Update mach-types
      Remove __must_check for device_for_each_child()

Samuel Tardieu (17):
      [WATCHDOG] w83697hf/hg WDT driver - patch 1
      [WATCHDOG] w83697hf/hg WDT driver - patch 2
      [WATCHDOG] w83697hf/hg WDT driver - patch 3
      [WATCHDOG] w83697hf/hg WDT driver - patch 4
      [WATCHDOG] w83697hf/hg WDT driver - patch 5
      [WATCHDOG] w83697hf/hg WDT driver - patch 6
      [WATCHDOG] w83697hf/hg WDT driver - patch 7
      [WATCHDOG] w83697hf/hg WDT driver - patch 8
      [WATCHDOG] w83697hf/hg WDT driver - patch 9
      [WATCHDOG] w83697hf/hg WDT driver - patch 10
      [WATCHDOG] w83697hf/hg WDT driver - patch 11
      [WATCHDOG] w83697hf/hg WDT driver - patch 12
      [WATCHDOG] w83697hf/hg WDT driver - patch 13
      [WATCHDOG] w83697hf/hg WDT driver - patch 14
      [WATCHDOG] w83697hf/hg WDT driver - patch 15
      [WATCHDOG] w83697hf/hg WDT driver - patch 16
      [WATCHDOG] w83697hf/hg WDT driver - Kconfig patch

Satoru Takeuchi (1):
      doc: fixing cpu-hotplug documentation

Stefan Schmidt (3):
      ACPI: ibm_acpi: Remove experimental status for brightness and volume.
      ACPI: ibm_acpi: Update documentation for brightness and volume.
      ACPI: ibm_acpi: Documentation the wan feature.

Stefan Weinhuber (1):
      [S390] dasd: clean up timer.

Stephen Hemminger (16):
      [BRIDGE]: flush forwarding table when device carrier off
      rename net_random to random32
      sky2: MSI test is only a warning
      sky2: turn of workaround timer
      sky2: phy irq on shutdown
      sky2: fiber pause bits
      sky2: advertising register 16 bits
      sky2: use duplex result bits
      sky2: don't reset PHY twice
      sky2: flow control setting fixes
      sky2: no message on rx fifo overflow
      sky2: version 1.9
      sky2: accept multicast pause frames
      sky2: GMAC pause frame
      [NETPOLL]: initialize skb for UDP
      sky2: 88E803X transmit lockup

Steven Toth (1):
      V4L/DVB (4692): Add WinTV-HVR3000 DVB-T support

Steven Whitehouse (2):
      [DECNET]: Fix input routing bug
      [GFS2] Fix bmap to map extents properly

Sunil Mushran (1):
      ocfs2: remove spurious d_count check in ocfs2_rename()

Sven Anders (1):
      [WATCHDOG] Winbond SMsC37B787 watchdog driver

Takashi Iwai (8):
      [ALSA] hda-codec - Fix assignment of PCM devices for Realtek codecs
      [ALSA] Various fixes for suspend/resume of ALSA PCI drivers
      [ALSA] Fix dependency of snd-adlib driver in Kconfig
      [ALSA] hda-codec - Add model entry for ASUS U5F laptop
      [ALSA] Fix re-use of va_list
      [ALSA] Fix AC97 power-saving mode
      [ALSA] Fix addition of user-defined boolean controls
      [ALSA] hda-intel - Add check of MSI availabity

Tejun Heo (1):
      libata: typo fix

Thiemo Seufer (1):
      [MIPS] Fix O32 personality(2) call with 0xffffffff argument.

Thomas Gleixner (1):
      posix-cpu-timers: prevent signal delivery starvation

Thomas Graf (4):
      [IPv6] rules: Use RT6_LOOKUP_F_HAS_SADDR and fix source based selectors
      [IPv4] fib: Remove unused fib_config members
      [IPv6] route: Fix prohibit and blackhole routing decision
      [IPv6] fib: initialize tb6_lock in common place to give lockdep a key

Thomas Maier (1):
      export clear_queue_congested and set_queue_congested

Timur Tabi (1):
      [POWERPC] Add DOS partition table support to mpc834x_itx_defconfig

Tobias Klauser (1):
      [ATM]: No need to return void

Tobias Lorenz (1):
      USB: Mitsumi USB FDD 061M: UNUSUAL_DEV multilun fix

Tony Luck (1):
      [IA64] perfmon fix for global IRQ fix

Trond Myklebust (7):
      NFSv4: Fix thinko in fs/nfs/super.c
      NFS: Fix oops in nfs_cancel_commit_list
      NFS: Fix error handling in nfs_direct_write_result()
      NFS: Fix NFSv4 callback regression
      NFS: Deal with failure of invalidate_inode_pages2()
      VFS: Make d_materialise_unique() enforce directory uniqueness
      NFS: Cache invalidation fixup

Ulrich Drepper (1):
      make UML compile (FC6/x86-64)

Uwe Bugla (1):
      V4L/DVB (4732): Fix spelling error in Kconfig help text for DVB_CORE_ATTACH

Venkatesh Pallipadi (1):
      ACPI: Processor native C-states using MWAIT

Ville Nuorvala (6):
      [IPV6]: Remove struct pol_chain.
      [SCTP]: Fix minor typo
      [IPV6]: Make sure error handling is done when calling ip6_route_output().
      [IPV6]: Clean up BACKTRACK().
      [IPV6]: Make IPV6_SUBTREES depend on IPV6_MULTIPLE_TABLES.
      [IPV6]: Always copy rt->u.dst.error when copying a rt6_info.

Vivek Goyal (2):
      x86-64: fix page align in e820 allocator
      x86-64: Overlapping program headers in physical addr space fix

Vojtech Pavlik (1):
      Fix DMA resource allocation in ACPIPnP

Wim Van Sebroeck (9):
      [WATCHDOG] Winbond SMsC37B787 - remove trailing whitespace
      [WATCHDOG] Winbond SMsC37B787 watchdog fixes
      [WATCHDOG] Kconfig clean-up
      [WATCHDOG] w836?7hf_wdt spinlock fixes.
      [WATCHDOG] Kconfig clean up
      [WATCHDOG] use ENOTTY instead of ENOIOCTLCMD in ioctl()
      [WATCHDOG] w83697hf/hg WDT driver - autodetect patch
      [WATCHDOG] add ich8 support to iTCO_wdt.c (patch 2)
      [WATCHDOG] remove experimental on iTCO_wdt.c

Yasunori Goto (2):
      Change log level of a message of acpi_memhotplug to KERN_DEBUG
      acpi memory hotplug: remove strange add_memory fail message

Yinghai Lu (1):
      x86-64: typo in __assign_irq_vector when updating pos for vector and offset

Yoichi Yuasa (4):
      [MIPS] More vr41xx pt_regs fixups
      [MIPS] Update pnx8500-jbs_defconfig
      [MIPS] Update pnx8550-v2pci_defconfig
      [MIPS] Update tb0287_defconfig

YOSHIFUJI Hideaki (1):
      [IPV6]: Remove bogus WARN_ON in Proxy-NA handling.

Zachary Amsden (1):
      Fix potential interrupts during alternative patching

Zhang, Yanmin (1):
      PCI: fix pcie_portdrv_restore_config undefined without CONFIG_PM error

--21872808-2145105941-1161645779=:3962--
