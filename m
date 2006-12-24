Return-Path: <linux-kernel-owner+w=401wt.eu-S1754070AbWLXEtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbWLXEtu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 23:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbWLXEtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 23:49:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42396 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbWLXEts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 23:49:48 -0500
Date: Sat, 23 Dec 2006 20:49:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.20-rc2
Message-ID: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1289856710-1166935781=:3671"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1289856710-1166935781=:3671
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok,
 it's a couple of days delayed, because we've been trying to figure out 
what is up with the rtorrent hash failures since 2.6.18.3. I don't think 
we've made any progress, but we've cleaned up a number of suspects in the 
meantime.

It's a bit sad, if only because I was really hoping to make 2.6.20 an easy 
release, and held back on merging some stuff during the merge window for 
that reason. And now we're battling something that was introduced much 
earlier..

Now, practically speaking this isn't likely to affect a lot of people, but 
it's still a worrisome problem, and we've had "top people" looking at it. 
And they'll continue, but xmas is coming.

In the meantime, we'll continue with the stabilization, and this mainly 
does some driver updates (usb, sound, dri, pci hotplug) and ACPI updates 
(much of the latter syntactic cleanups). And arm and powerpc updates.

Shortlog appended.

For developers: if you sent me a patch, and I didn't apply it, it was 
probably just missed because I concentrated on other issues. So pls 
re-send.. Unless I explicitly told you that I'm not going to pull it due 
to the merge window being over, of course ;)

		Linus

---

Adrian Bunk (10):
      ACPI: make drivers/acpi/ec.c:ec_ecdt static
      ACPI: fix NULL check in drivers/acpi/osl.c
      [ALSA] sound/core/control.c: remove dead code
      PCI: don't export device IDs to userspace
      Driver core: proper prototype for drivers/base/init.c:driver_init()
      make kernel/printk.c:ignore_loglevel_setup() static
      fs/sysv/: proper prototypes for 2 functions
      [ATM]: Remove dead ATM_TNETA1570 option.
      [ATM] drivers/atm/fore200e.c: Cleanups.
      [SCTP]: make 2 functions static

Akinobu Mita (9):
      drm: fix return value check
      ata: fix platform_device_register_simple() error check
      ACPI: fix single linked list manipulation
      ACPI: prevent processor module from loading on failures
      [ALSA] sound: initialize rawmidi substream list
      [ALSA] sound: fix PCM substream list
      audit: fix kstrdup() error check
      gss_spkm3: fix error handling in module init
      tlclk: delete unnecessary sysfs_remove_group

Al Viro (4):
      m68k trivial build fixes
      more work_struct fixes: tas300x sound drivers
      fix leaks on pipe(2) failure exits
      [IPV6]: Dumb typo in generic csum_ipv6_magic()

Alan Cox (5):
      Fix help text for CONFIG_ATA_PIIX
      pata_via: Cable detect error
      usb serial: Eliminate bogus ioctl code
      pci: Introduce pci_find_present
      PCI: Fix multiple problems with VIA hardware

Alan Stern (1):
      UHCI: module parameter to ignore overcurrent changes

Alexey Starikovskiy (15):
      ACPI: ec: Allow for write semantics in any command.
      ACPI: ec: Enable EC GPE at beginning of transaction
      ACPI: ec: Increase timeout from 50 to 500 ms to handle old slow machines.
      ACPI: ec: Read status register from check_status() function
      ACPI: ec: Remove expect_event and all races around it.
      ACPI: ec: Remove calls to clear_gpe() and enable_gpe(), as these are handled at
      ACPI: ec: Query only single query at a time.
      ACPI: ec: Change semaphore to mutex.
      ACPI: ec: Rename gpe_bit to gpe
      ACPI: ec: Drop udelay() from poll mode. Loop by reading status field instead.
      ACPI: ec: Acquire Global Lock under EC mutex.
      ACPI: ec: Style changes.
      ACPI: ec: Change #define to enums there possible.
      ACPI: ec: Lindent once again
      ACPI: ibm_acpi: allow clean removal

Andreas Mohr (1):
      [ALSA] via82xx: add __devinitdata

Andrew Morton (15):
      ACPI: uninline ACPI global locking functions
      ACPI: acpi-cpufreq: remove unused data when !CONFIG_SMP
      ACPI: Kconfig - depend on PM rather than selecting it
      [libata] pata_cs5530: suspend/resume support tweak
      [libata] pata_via: suspend/resume support fix
      USB: Nokia E70 is an unusual device
      USB: Nokia E70 is an unusual device
      truncate: clear page dirtiness before running try_to_free_buffers()
      truncate: dirty memory accounting fix
      rtc warning fix
      smc911 workqueue fixes
      schedule_timeout(): improve warning message
      relay: remove inlining
      increase CARDBUS_MEM_SIZE
      build compile.h earlier

Andrew Victor (3):
      USB: ohci at91 warning fix
      USB: at91 udc, support at91sam926x addresses
      USB: at91_udc, misc fixes

Aneesh Kumar K.V (1):
      kobject: kobject_uevent() returns manageable value

Arnd Bergmann (4):
      [POWERPC] cell: update cell_defconfig
      [POWERPC] cell: add forward struct declarations to spu.h
      [POWERPC] spufs: fix assignment of node numbers
      [POWERPC] powerpc: add scanning of ebc bus to of_platform

Avi Kivity (4):
      KVM: AMD SVM: handle MSR_STAR in 32-bit mode
      KVM: AMD SVM: Save and restore the floating point unit state
      KVM: Use more traditional error handling in kvm_mmu_init()
      KVM: API versioning

Badari Pulavarty (1):
      Fix for shmem_truncate_range() BUG_ON()

Ben Collins (1):
      ib_verbs: Use explicit if-else statements to avoid errors with do-while macros

Ben Dooks (18):
      [ARM] 4038/1: S3C24XX: Fix copyrights in include/asm-arm/arch-s3c2410 (core)
      [ARM] 4039/1: S3C24XX: Fix copyrights in include/asm-arm/arch-s3c2410 (mach)
      [ARM] 4040/1: S3C24XX: Fix copyrights in arch/arm/mach-s3c2410
      [ARM] 4041/1: S3C24XX: Fix sparse errors from VA addresses
      [ARM] 4042/1: H1940: Fix sparse errors from VA addresses
      [ARM] 4043/1: S3C24XX: fix sparse warnings in arch/arm/mach-s3c2410/s3c2440-clock.c
      [ARM] 4044/1: S3C24XX: fix sparse warnings in arch/arm/mach-s3c2410/s3c2442-clock.c
      [ARM] 4045/1: S3C24XX: remove old VA for non-shared areas
      [ARM] 4046/1: S3C24XX: fix sparse errors arch/arm/mach-s3c2410
      [ARM] 4048/1: S3C24XX: make s3c2410_pm_resume() static
      [ARM] 4049/1: S3C24XX: fix sparse warning due to upf_t in regs-serial.h
      [ARM] 4050/1: S3C24XX: remove old changelogs in arch/arm/mach-s3c2410
      [ARM] 4051/1: S3C24XX: clean includes in S3C2440 and S3C2442 support
      [ARM] 4052/1: S3C24XX: Fix PM in arch/arm/mach-s3c2410/Kconfig
      [ARM] 4059/1: VR1000: fix LED3's platform device number
      [ARM] 4062/1: S3C24XX: Anubis and Osiris shuld have CONFIG_PM_SIMTEC
      MAINTAINERS: fix email for S3C2410 and S3C2440
      fix s3c24xx gpio driver (include linux/workqueue.h)

Benjamin Herrenschmidt (3):
      [POWERPC] cell: Fix spufs with "new style" device-tree
      [POWERPC] Workaround oldworld OF bug with IRQs & P2P bridges
      [POWERPC] Fix build of cell zImage.initrd

Burman Yan (2):
      USB AUERSWALD: replace kmalloc+memset with kzalloc
      ACPI: replace kmalloc+memset with kzalloc

Chen, Justin (1):
      ACPI: optimize pci_rootbridge search

Chris Frey (1):
      USB: fix to usbfs_snoop logging of user defined control urbs

Christian Borntraeger (2):
      [S390] hypfs fixes
      [S390] sclp_cpi module license.

Christian Hesse (1):
      [ALSA] hda-codec - fix typo in PCI IDs

Christoph Lameter (1):
      slab: fix kmem_ptr_validate definition

Clemens Ladisch (3):
      [ALSA] use the ALIGN macro
      [ALSA] use the roundup macro
      [ALSA] pcm core: fix silence_start calculations

Conke Hu (1):
      PCI: ATI sb600 sata quirk

Dan Williams (1):
      [ARM] 4022/1: iop13xx: generic irq fixups

Dave Airlie (3):
      drm: fixup comment header style
      drm: make kernel context switch same as for drm git tree.
      drm: r128: comment aligment with drm git

Dave Jones (2):
      [CPUFREQ] Advise not to use longhaul on VIA C7.
      [CPUFREQ] longhaul compile fix.

Dave Kleikamp (1):
      Fix JFS after clear_page_dirty() removal

David Brownell (3):
      USB: gadget driver unbind() is optional; section fixes; misc
      USB: MAINTAINERS update, EHCI and OHCI
      USB: ohci whitespace/comment fixups

David Chinner (1):
      Fix XFS after clear_page_dirty() removal

David Clare (1):
      USB: Prevent the funsoft serial device from entering raw mode

David Rientjes (1):
      PCI quirks: remove redundant check

David S. Miller (8):
      [SPARC64]: Kill no-remapping-needed code in head.S
      [SPARC64]: Minor irq handling cleanups.
      [DocBook]: Fix two typos in generic IRQ docs.
      [SPARC64]: Mirror x86_64's PERCPU_ENOUGH_ROOM definition.
      [SPARC]: Update defconfig.
      [SPARC]: Make bitops use same spinlocks as atomics.
      [NETFILTER] IPV6: Fix dependencies.
      [UDP]: Fix reversed logic in udp_get_port().

David Woodhouse (1):
      [POWERPC] Probe Efika platform before CHRP.

Dhaval Giani (1):
      [CPUFREQ] fixes typo in cpufreq.c

Dmitry Torokhov (1):
      ACPI: button: register with input layer

Eagle Jones (1):
      USB: airprime: add device id for dell wireless 5500 hsdpa card

Ed L. Cashin (1):
      fix aoe without scatter-gather [Bug 7662]

Eric Anholt (1):
      drm: savage: compat fix from drm git.

Eric Smith (1):
      usb serial: add support for Novatel S720/U720 CDMA/EV-DO modems

Eric W. Biederman (1):
      Fix reparenting to the same thread group. (take 2)

Evgeniy Polyakov (2):
      [CONNECTOR]: Fix compilation breakage introduced recently.
      [CONNECTOR]: Replace delayed work with usual work queue.

Fabrice Knevez (1):
      [SUNKBD]: Fix sunkbd_enable(sunkbd, 0); obvious.

Florian Festi (1):
      input/hid: Supporting more keys from the HUT Consumer Page

Geert Uytterhoeven (1):
      __set_irq_handler bogus space

Gerrit Renker (1):
      [TCP]: Fix ambiguity in the `before' relation.

Glen Masgai (1):
      [ALSA] ymfpci: fix swap_rear for S/PDIF passthrough

Greg Kroah-Hartman (1):
      USB Storage: remove duplicate Nokia entry in unusual_devs.h

Henrique de Moraes Holschuh (22):
      ACPI: ibm-acpi: new ibm-acpi maintainer
      ACPI: ibm-acpi: do not use / in driver names
      ACPI: ibm-acpi: trivial Lindent cleanups
      ACPI: ibm-acpi: Use a enum to select the thermal sensor reading strategy
      ACPI: ibm-acpi: Implement direct-ec-access thermal reading modes for up to 16 sensors
      ACPI: ibm-acpi: document thermal sensor locations for the A31
      ACPI: ibm-acpi: prepare to cleanup fan_read and fan_write
      ACPI: ibm-acpi: clean up fan_read
      ACPI: ibm-acpi: break fan_read into separate functions
      ACPI: ibm-acpi: cleanup fan_write
      ACPI: ibm-acpi: document fan control
      ACPI: ibm-acpi: extend fan status functions
      ACPI: ibm-acpi: fix and extend fan enable
      ACPI: ibm-acpi: fix and extend fan control functions
      ACPI: ibm-acpi: store embedded controller firmware version for matching
      ACPI: ibm-acpi: workaround for EC 0x2f initialization bug
      ACPI: ibm-acpi: implement fan watchdog command
      ACPI: ibm-acpi: add support for the ultrabay on the T60,X60
      ACPI: ibm-acpi: make non-generic bay support optional
      ACPI: ibm-acpi: backlight device cleanup
      ACPI: ibm-acpi: style fixes and cruft removal
      ACPI: ibm-acpi: update version and copyright

Hisashi Hifumi (1):
      jbd: wait for already submitted t_sync_datalist buffer to complete

Holger Macht (3):
      ACPI: ibm_acpi: Add support for the generic backlight device
      ACPI: asus_acpi: Add support for the generic backlight device
      ACPI: toshiba_acpi: Add support for the generic backlight device

Inaky Perez-Gonzalez (1):
      pci: add class codes for Wireless RF controllers

Ingo Molnar (6):
      x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
      x86_64: fix boot time hang in detect_calgary()
      workqueue: fix schedule_on_each_cpu()
      lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
      sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code
      suspend: fix suspend on single-CPU systems

Ira Snyder (1):
      initializer entry defined twice in pata_rz1000

Ivan Skytte Jorgensen (1):
      [SCTP]: Fix typo adaption -> adaptation as per the latest API draft.

James C Georgas (1):
      [ALSA] ac97_codec - trivial fix for bit update functions

James Courtier-Dutton (3):
      [ALSA] snd-ca0106: Add new card variant.
      [ALSA] snd-ca0106: Fix typos.
      [ALSA] ac97: Identify CMI9761 chips.

James Morris (1):
      KVM: add valid_vcpu() helper

James Simmons (1):
      fbdev: update after backlight argument change

Jan Capek (1):
      USB: ftdi_sio - MachX product ID added

Jan Engelhardt (1):
      ACPI: Remove unnecessary from/to-void* and to-void casts in drivers/acpi

Jaroslav Kysela (2):
      [ALSA] ac97_codec (ALC655): add EAPD hack for MSI L725 laptop
      [ALSA] version 1.0.14rc1

Jason Gaston (1):
      ata_piix: IDE mode SATA patch for Intel ICH9

Jean Delvare (3):
      drm: Stop defining pci_pretty_name
      [ALSA] sound: Don't include i2c-dev.h
      microcode: fix mc_cpu_notifier section warning

Jeff Garzik (5):
      DRM: handle pci_enable_device failure
      [libata] use kmap_atomic(KM_IRQ0) in SCSI simulator
      [libata] sata_svw: Disable ATAPI DMA on current boards (errata workaround)
      USB: fix ohci.h over-use warnings
      [libata] sata_svw, sata_vsc: kill iomem warnings

Jens Axboe (9):
      ->nr_sectors and ->hard_nr_sectors are not used for BLOCK_PC requests
      Remove queue merging hooks
      __blk_rq_map_user() doesn't need to grab the queue_lock
      __blk_rq_unmap_user() fails to return error
      Fixup blk_rq_unmap_user() API
      cfq-iosched: don't allow sync merges across queues
      block: document io scheduler allow_merge_fn hook
      elevator: fixup typo in merge logic
      cfq-iosched: tighten allow merge criteria

Jens Osterkamp (1):
      [POWERPC] cell: Enable spider workarounds on all PCI buses

Jeremy Fitzhardinge (1):
      ptrace: Fix EFL_OFFSET value according to i386 pda changes

Jesper Juhl (2):
      ACPI: Get rid of 'unused variable' warning in acpi_ev_global_lock_handler()
      PCI: Be a bit defensive in quirk_nvidia_ck804() so we don't risk dereferencing a NULL pdev.

Jiri Kosina (2):
      Generic HID layer - build: USB_HID should select HID
      Generic HID layer - update MAINTAINERS

Johann Wilhelm (2):
      usb-storage: Ignore the virtual cd-drive of the Huawei E220 USB Modem
      usb-gsm-driver: Added VendorId and ProductId for Huawei E220 USB Modem

Johannes Hoelzl (1):
      Add Baltech Reader ID to CP2101 driver

John Keller (1):
      ACPI: Add support for acpi_load_table/acpi_unload_table_id

Josh Boyer (1):
      Make JFFS depend on CONFIG_BROKEN

Kenji Kaneshige (5):
      PCI: pcieport-driver: remove invalid warning message
      shpchp: remove unnecessary struct php_ctlr
      shpchp: cleanup struct controller
      shpchp: remove shpchprm_get_physical_slot_number
      shpchp: cleanup shpchp.h

Kristen Carlson Accardi (4):
      ACPI: dock: use mutex instead of spinlock
      ACPI: dock: Make the dock station driver a platform device driver.
      ACPI: dock: add uevent to indicate change in device status
      acpiphp: Link-time error for PCI Hotplug

Krzysztof Helt (1):
      [ARM] 4015/1: s3c2410 cpu ifdefs

Leigh Brown (2):
      [TCP]: Fix oops caused by tcp_v4_md5_do_del
      [TCP]: Trivial fix to message in tcp_v4_inbound_md5_hash

Len Brown (3):
      ACPI: dock: fix build warning
      ACPI: ibm_acpi: respond to workqueue update
      ACPI: fix git automerge failure

Lennert Buytenhek (6):
      [ARM] 4054/1: ep93xx: add HWCAP_CRUNCH
      [ARM] 4055/1: iop13xx: fix phys_io/io_pg_offst for iq81340mc/sc
      [ARM] 4056/1: iop13xx: fix resource.end off-by-one in flash setup
      [ARM] 4057/1: ixp23xx: unconditionally enable hardware coherency
      [ARM] 4061/1: xsc3: change of maintainer
      [ARM] 4060/1: update several ARM defconfigs

Leonid Arsh (1):
      IB/mthca: Add HCA profile module parameters

Li Yewang (1):
      [IPV4]: Fix BUG of ip_rt_send_redirect()

Linas Vepstas (2):
      [POWERPC] Fix PCI device channel state initialization
      rpaphp: compiler warning cleanup

Linus Torvalds (11):
      Remove stack unwinder for now
      Fix "delayed_work_pending()" macro expansion
      Fix incorrect user space access locking in mincore()
      Make workqueue bit operations work on "atomic_long_t"
      Fix up mm/mincore.c error value cases
      Clean up and make try_to_free_buffers() not race with dirty pages
      VM: Remove "clear_page_dirty()" and "test_clear_page_dirty()" functions
      Clean up and export cancel_dirty_page() to modules
      Fix reiserfs after "test_clear_page_dirty()" removal
      Fix up CIFS for "test_clear_page_dirty()" removal
      Linux 2.6.20-rc2

Maciej W. Rozycki (1):
      mips: if_fddi.h: Add a missing inclusion

Magnus Damm (1):
      fix vm_events_fold_cpu() build breakage

Marcel Holtmann (1):
      Call init_timer() for ISDN PPP CCP reset state timer

Mark Fasheh (1):
      Conditionally check expected_preempt_count in __resched_legal()

Martin Bligh (1):
      ACPI: avoid gcc warnings in ACPI mutex debug code

Martin Schwidefsky (1):
      [S390] update default configuration

Martin Waitz (1):
      kernel-doc: remove Martin from MAINTAINERS

Mattia Dongili (1):
      [CPUFREQ] set policy->curfreq on initialization

Michael Chan (7):
      [BNX2]: Fix panic in bnx2_tx_int().
      [BNX2]: Fix bug in bnx2_nvram_write().
      [BNX2]: Fix minor loopback problem.
      [TG3]: Assign tp->link_config.orig_* values.
      [TG3]: Fix race condition when calling register_netdev().
      [TG3]: Power down/up 5906 PHY correctly.
      [TG3]: Update version and reldate.

Michel Dänzer (2):
      i915_vblank_tasklet: Try harder to avoid tearing.
      drm: Unify radeon offset checking.

Michael Ellerman (6):
      PCI: Create __pci_bus_find_cap_start() from __pci_bus_find_cap()
      PCI: Add pci_find_ht_capability() for finding Hypertransport capabilities
      PCI: Use pci_find_ht_capability() in drivers/pci/htirq.c
      PCI: Add #defines for Hypertransport MSI fields
      PCI: Use pci_find_ht_capability() in drivers/pci/quirks.c
      PCI: Only check the HT capability bits in mpic.c

Michael Halcrow (1):
      fsstack: Remove inode copy

Michael Holzheu (3):
      [S390] Fix reboot hang on LPARs
      [S390] Fix reboot hang
      [S390] Save prefix register for dump on panic

Michael Riepe (3):
      KVM: Do not export unsupported msrs to userspace
      KVM: Force real-mode cs limit to 64K
      KVM: Handle p5 mce msrs

Mike Miller (2):
      cciss: set default raid level when reading geometry fails
      cciss: fix XFER_READ/XFER_WRITE in do_cciss_request

Miklos Szeredi (1):
      fuse: remove clear_page_dirty() call

NeilBrown (1):
      md: fix a few problems with the interface (sysfs and ioctl) to md

Nick Piggin (1):
      mm: more rmap debugging

Nickolay V. Shmyrev (1):
      [ALSA] snd_hda_intel 3stack mode for ASUS P5P-L2

Nigel Cunningham (1):
      Fix swapped parameters in mm/vmscan.c

OGAWA Hirofumi (1):
      arch/i386/pci/mmconfig.c tlb flush fix

Oleg Nesterov (1):
      sys_mincore: s/max/min/

Oliver Neukum (3):
      USB: fix transvibrator disconnect race
      USB: removing ifdefed code from gl620a
      USB: mutexification of usblp

Olivier Galibert (1):
      bluetooth: add support for another Kensington dongle

Patrick Caulfield (1):
      [DLM] fix compile warning

Paul Jackson (1):
      CONFIG_VM_EVENT_COUNTER comment decrustify

Paul Mackerras (2):
      [POWERPC] Fix register save area alignment for swapcontext syscall
      gxt4500: Fix colormap and PLL setting, support GXT6000P

Paul Moore (2):
      NetLabel: perform input validation earlier on CIPSOv4 DOI add ops
      NetLabel: correctly fill in unused CIPSOv4 level and category mappings

Pavel Machek (1):
      [ARM] 4035/1: fix collie compilation

Peer Chen (1):
      [libata] Move some PCI IDs from sata_nv to ahci

Peter Korsgaard (1):
      serial/uartlite: Only enable port if request_port succeeded

Peter Williams (1):
      sched: improve efficiency of sched_fork()

Peter Zijlstra (1):
      Fix up page_mkclean_one(): virtual caches, s390

Petko Manolov (1):
      USB: rtl8150 new device id

Ping Cheng (1):
      USB: fix Wacom Intuos3 4x6 bugs

Prarit Bhargava (1):
      ACPI: dock: Fix symbol conflict between acpiphp and dock

Rafael J. Wysocki (1):
      ACPI: S4: Use "platform" rather than "shutdown" mode by default

Ralf Baechle (8):
      [AX.25]: Mark all kmalloc users __must_check
      [AX.25]: Fix unchecked ax25_protocol_register uses.
      [AX.25]: Fix unchecked ax25_listen_register uses
      [AX.25]: Fix unchecked nr_add_node uses.
      [AX.25]: Fix unchecked ax25_linkfail_register uses
      [AX.25]: Fix unchecked rose_add_loopback_node uses
      [AX.25]: Fix unchecked rose_add_loopback_neigh uses
      PCI legacy resource fix

Ralph Wuerthner (1):
      [S390] zcrypt: module unload fixes.

Randy Dunlap (3):
      ACPI: make ec_transaction not extern
      fix kernel-doc warnings in 2.6.20-rc1
      kernel-doc: allow unnamed structs/unions

Remy Bruno (1):
      [ALSA] hdsp: precise_ptr control switched off by default

Richard Purdie (1):
      [ARM] 4034/1: pxafb: Fix compile errors

Robert P. J. Day (1):
      Add a new section to CodingStyle, promoting include/linux/kernel.h

Roland Dreier (3):
      IB: Fix ib_dma_alloc_coherent() wrapper
      IB/srp: Fix FMR mapping for 32-bit kernels and addresses above 4G
      IB/mthca: Use DEFINE_MUTEX() instead of mutex_init()

Russell King (4):
      [ARM] Add more syscalls
      [ARM] Fix BUG()s in ioremap() code
      [ARM] Fix warnings from asm/system.h
      PCI: use /sys/bus/pci/drivers/<driver>/new_id first

Satoru Takeuchi (1):
      ACPI: update comment

Sean Young (1):
      USB: Fix oops in PhidgetServo

Sridhar Samudrala (1):
      [SCTP]: Don't export include/linux/sctp.h to userspace.

Stefan Bader (1):
      [S390] cio: css_register_subchannel race.

Stephen Rothwell (6):
      [POWERPC] iSeries: fix viodasd init
      [POWERPC] iSeries: fix viotape init
      [POWERPC] iSeries: fix iseries_veth init
      [POWERPC] iSeries: fix viocd init
      [POWERPC] iSeries: fix viocons init
      [POWERPC] iSeries: fix CONFIG_VIOPATH dependency

Steven Whitehouse (1):
      [GFS2] Fix Kconfig

Takamasa Ohtake (1):
      USB: ohci handles hardware faults during root port resets

Takashi Iwai (11):
      [ALSA] hda-codec - Fix wrong error checks in patch_{realtek,analog}.c
      [ALSA] hda-codec - Don't return error at initialization of modem codec
      [ALSA] hda-codec - Fix a typo
      [ALSA] hda-codec - Add model for HP q965
      [ALSA] hda-codec - Fix model for ASUS V1j laptop
      [ALSA] hda-codec - Fix detection of supported sample rates
      [ALSA] hda-codec - Verbose proc output for PCM parameters
      [ALSA] ac97 - Fix potential negative array index
      [ALSA] Fix races in PCM OSS emulation
      [ALSA] Fix invalid assignment of PCI revision
      [ALSA] Remove IRQF_DISABLED for shared PCI irqs

Tejun Heo (6):
      ata_piix: use piix_host_stop() in ich_pata_ops
      libata: don't initialize sg in ata_exec_internal() if DMA_NONE (take #2)
      ahci: do not mangle saved HOST_CAP while resetting controller
      libata: clean up variable name usage in xlat related functions
      libata: kill @cdb argument from xlat methods
      libata: take scmd->cmd_len into account when translating SCSI commands

Thomas Gleixner (1):
      genirq: fix irq flow handler uninstall

Thomas Tuttle (1):
      ACPI: Implement acpi_video_get_next_level()

Tim Chen (1):
      sched: remove __cpuinitdata anotation to cpu_isolated_map

Tobias Klauser (2):
      [ALSA] sound/usb/usbaudio: Handle return value of usb_register()
      Add cscope generated files to .gitignore

Tony Olech (1):
      USB: u132-hcd/ftdi-elan: add support for Option GT 3G Quad card

Ursula Braun (1):
      [S390] Hipersocket multicast queue: make sure outbound handler is called

Vadim Lobanov (1):
      fdtable: Provide free_fdtable() wrapper

Venkatesh Pallipadi (2):
      [CPUFREQ] Trivial cleanup for acpi read/write port in acpi-cpufreq.c
      kref refcnt and false positives

Vitaly Wool (3):
      [POWERPC] Update MTD OF documentation
      USB: OHCI support for PNX8550
      smc911x: fix netpoll compilation faliure

Wojtek Kaniewski (3):
      USB: at91_udc: allow drivers that support high speed
      USB: at91_udc: Cleanup variables after failure in usb_gadget_register_driver()
      USB: at91_udc: Additional checks

Yan Burman (1):
      [TG3]: replace kmalloc+memset with kzalloc

Yasunori Goto (3):
      handle SLOB with sparsemen
      compile error of register_memory()
      memory hotplug: fix compile error for i386 with NUMA config

Yu Luming (1):
      ACPI: video: Add dev argument for backlight_device_register

brandon@ifup.org (1):
      ACPI: dock: Add a docked sysfs file to the dock driver.

---1463790079-1289856710-1166935781=:3671--
