Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752548AbVHGSsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbVHGSsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbVHGSsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:48:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752548AbVHGSr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:47:59 -0400
Date: Sun, 7 Aug 2005 11:47:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.13-rc6: aic7xxx testers please..
Message-ID: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James and gang found the aic7xxx slowdown that happened after 2.6.12, and 
we'd like to get particular testing that it's fixed, so if you have a 
relevant machine, please do test this.

There are other fixes too, a number of them reverting (at least for now)  
patches that people had problems with. In general, anybody who has
reported regressions since 2.6.12, please re-test with -rc6 and report
back (even if, or perhaps _particularly_ if, no change to the regression).

Apart from some reverts and the aic7xxx performance regression fix,
there's arm and ppc updates, and some PCI resource allocation updates that
hopefully will reduce the number of machines (especially laptopns) that
have strange undocumented MB devices that clash in PCI IO space.. And 
various small one-liners.

The appended shortlog/diffstat gives more some more specific insight..

		Linus

--- shortlog ---

Alasdair G Kergon:
  dm-raid locking fix

Alexander Nyberg:
  x86-64: use proper VM_FAULT_xxx macros

Alexey Starikovskiy:
  [ACPI] restore /proc/acpi/button/ (ala 2.6.12)

Andi Kleen:
  x86_64: ignore machine checks from boot time

Andrew Morton:
  [SCSI] fc4 warning fix
  revert "timer exit cleanup"
  REPORTING-BUGS: track regressions
  __bio_clone() dead comment

Aristeu Sergio Rozanski Filho:
  ppc32: 8xx: convert fec driver to use work_struct
  ppc32: 8xx: using dma_alloc_coherent() instead consistent_alloc()
  ppc32: 8xx: fec: fix interrupt handler prototypes
  ppc32: 8xx fix CPM ethernet description
  ppc32: 8xx restrict ENET_BIG_BUFFERS option
  ppc32: 8xx kill unused variable in commproc

Ben Dooks:
  ARM: 2832/1: BAST - limit clock-rate for IIC bus

Benjamin Herrenschmidt:
  Remove suspend() calls from shutdown path

Catalin Marinas:
  ARM: 2841/1: Fix VFP +/-0 case for doubles addition

Christoph Hellwig:
  [SPARC]: Fix up sleep_on() removal in vfc driver.

Daniel Jacobowitz:
  x86_64: fix 32-bit thread debugging

David Brownell:
  USB: ehci: microframe handling fix

David Gibson:
  Fix hugepage crash on failing mmap()

David Howells:
  Keys: Fix key management syscall interface bugs
  Error during attempt to join key management session can leave semaphore pinned
  Destruction of failed keyring oopses

David S. Miller:
  tcp: fix TSO sizing bugs
  [IPV4]: Fix memory leak during fib_info hash expansion.

David Shaohua Li:
  [ACPI] PCI interrupt link suspend/resume - revert to 2.6.12 behaviour
  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom

Deepak Saxena:
  ARM: 2839/1: Remove XScale cache and TLB locking code
  ARM: 2835/1: Add UPF_SKIP_TEST to IXP4xx serial ports

Dominik Brodowski:
  pci and yenta: pcibios_bus_to_resource

Dominik Hackl:
  crc32.c typo fix

Eric W. Biederman:
  i386 voyager: Add machine_shutdown
  i386 visws: Add machine_shutdown and emergency_restart
  x86_64 bootmem: sparse_mem/kexec merge bug.

Hal Rosenstock:
  [IPoIB] Handle sending of unicast RARP responses

Haren Myneni:
  Xmon bug fix for soft-reset

Herbert Xu:
  tcp: fix TSO cwnd caching bug

Hugh Dickins:
  fix VmSize and VmData after mremap

Ian Campbell:
  ARM: 2833/2:  Remove support for WDIOF_MAGICCLOSE from sa1100-wdt

Ingo Molnar:
  Fix semundo lock leakage

Ivan Kokshaysky:
  increase PCIBIOS_MIN_IO on x86
  ACPI: increase PCIBIOS_MIN_IO on x86
  Fix restore of 64-bit PCI BAR's

Jack Hammer:
  [SCSI] ServeRAID V7.12.02

James Bottomley:
  [SCSI] aic7xxx: fix bug in DT handing
  [SCSI] aic7xxx: final fixes for DT handling
  [SCSI] fix aic7xxx performance issues since 2.6.12-rc2
  fix voyager compile after machine_emergency_restart breakage

Jens Axboe:
  cfq-iosched: fix problem with barriers and max_depth == 1

Jim Keniston:
  Add Documentation/kprobes.txt

John McCutchan:
  inotify delete race fix
  Clean up inotify delete race fix

John W. Linville:
  PCI: restore BAR values after D3hot->D0 for devices that need it

Kai Makisara:
  [SCSI] Fix SCSI tape oops at module removal

Len Brown:
  [ACPI] fix 64-bit build warning in processor_idle.c
  /home/lenb/src/to-linus branch 'acpi-2.6.12'
  [ACPI] delete Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
  /home/lenb/src/to-linus-stable branch 'acpi-2.6.12'
  Merge ../to-linus-stable

Linda Xie:
  [SCSI] scsi/ibmvscsi/srp.h: Fix a wrong type code used for SRP_LOGIN_REJ

Linus Torvalds:
  pci: make bus resource start address override minimum IO address
  Fix up recent get_user_pages() handling
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/.../lenb/to-linus
  It wasn't just x86-64 that had hardcoded VM_FAULT_xxx numbers
  Merge head 'for-linus' of master.kernel.org:/.../roland/infiniband
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/.../lenb/to-linus
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/.../jejb/scsi-for-linus-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Add fakey 'deflateBound()' function to the in-kernel zlib routines
  Check input buffer size in zisofs
  ppc: Export __handle_mm_fault for MOL
  Merge master.kernel.org:/.../holtmann/bluetooth-2.6
  Linux 2.6.13-rc6

Luming Yu:
  [ACPI] revert Embedded Controller to polling-mode by default (ala 2.6.12)
  [ACPI] CONFIG_ACPI_HOTKEY is now "n" by default

Marcel Holtmann:
  [Bluetooth] Send HCI_Reset for Kensington dongle
  [Bluetooth] Revert session reference counting fix
  [Bluetooth] Kill redundant NULL checks before kfree()
  [Bluetooth] Remove unused functions and cleanup symbol exports
  [Bluetooth] Add direction and timestamp to stack internal events

Marcel Selhorst:
  tpm_infineon: Support for new TPM 1.2 and PNPACPI

Marcelo Tosatti:
  ppc32: 8xx commproc avoid direct pte manipulation, use dma coherent API instead

Matt Porter:
  ppc32: fix ppc440 pagetable attributes
  ppc32: ppc440 pagetable attributes (comments updates)

Mauro Carvalho Chehab:
  v4l: oopsfix for BTTV on badly behaved PCI chipsets

Michael Burian:
  ARM: 2840/1: Add mach-types to Documentation/dontdiff

Michael Gernoth:
  ARM: 2844/1: Add maintainer for Jornada 720

Miklos Szeredi:
  namespace.c: fix bind mount from foreign namespace

NeilBrown:
  md: remove a stray debugging printk.
  md: make 'md' and alias for 'md-mod'
  md: always honour md bitmap being read from disk
  md: yet another attempt to get bitmap-based resync to do the right thing in all cases...
  md: make sure md bitmap updates are flushed when array is stopped.

Nick Piggin:
  fix get_user_pages bug

Olaf Hering:
  aic byteorder fixes after recent cleanup
  remove linux/pagemap.h from linux/swap.h

Olav Kongas:
  USB: Fix setup packet initialization in isp116x-hcd

Olof Johansson:
  ppc64: Fix UP kernel build

Paul Mackerras:
  Obvious bugfix for yenta resource allocation
  ppc64: fix for kexec boot issue

Pete Zaitcev:
  USB: ub documentation update

Petr Vandrovec:
  rtc: msleep() cannot be used from interrupt

Ravikiran G Thirumalai:
  ide: fix kmalloc_node breakage in ide driver
  Move the fix to align node_end_pfns to a proper location

Richard Purdie:
  ARM: 2837/2: Re: ARM: Make NWFPE preempt safe
  ARM: 2838/1: Fix arm oprofile backtrace warning

Robert Love:
  inotify: update help text

Roland Dreier:
  [IB/cm]: Correct CM port redirect reject codes

Russell King:
  ARM: Fix ARM fault handler for get_user_pages() fixes.

Simon Derr:
  __vm_enough_memory() signedness fix

Tejun Heo:
  blk: fix tag shrinking (revive real_max_size)

Tim Yamin:
  Update in-kernel zlib routines

Tom Duffy:
  Make visws compile again
  visws: linkage fix

Venkatesh Pallipadi:
  remove special HPET_EMULATE_RTC config option

--- diffstat ---

 Documentation/dontdiff                         |    1 
 Documentation/kprobes.txt                      |  588 ++++++++++++++++++++
 Documentation/usb/usbmon.txt                   |    2 
 Documentation/video4linux/bttv/Insmod-options  |    3 
 Documentation/x86_64/boot-options.txt          |    5 
 Makefile                                       |    2 
 REPORTING-BUGS                                 |   21 -
 arch/alpha/kernel/pci.c                        |   16 +
 arch/arm/kernel/bios32.c                       |   17 +
 arch/arm/mach-ixp4xx/coyote-setup.c            |    2 
 arch/arm/mach-ixp4xx/gtwx5715-setup.c          |    2 
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |    4 
 arch/arm/mach-s3c2410/mach-bast.c              |   16 +
 arch/arm/mach-sa1100/jornada720.c              |    1 
 arch/arm/mm/fault.c                            |    6 
 arch/arm/mm/proc-xscale.S                      |  136 -----
 arch/arm/nwfpe/double_cpdo.c                   |   24 -
 arch/arm/nwfpe/extended_cpdo.c                 |   24 -
 arch/arm/nwfpe/fpa11.c                         |   30 -
 arch/arm/nwfpe/fpa11.h                         |   11 
 arch/arm/nwfpe/fpa11_cpdo.c                    |   28 +
 arch/arm/nwfpe/fpa11_cpdt.c                    |   22 -
 arch/arm/nwfpe/fpa11_cprt.c                    |   28 +
 arch/arm/nwfpe/fpmodule.c                      |   15 -
 arch/arm/nwfpe/single_cpdo.c                   |   24 -
 arch/arm/nwfpe/softfloat.c                     |  334 ++++++------
 arch/arm/nwfpe/softfloat.h                     |   68 +-
 arch/arm/oprofile/backtrace.c                  |    2 
 arch/arm/vfp/vfpdouble.c                       |    3 
 arch/arm26/mm/fault.c                          |   17 -
 arch/cris/mm/fault.c                           |    6 
 arch/frv/mm/fault.c                            |    6 
 arch/i386/Kconfig                              |    3 
 arch/i386/mach-visws/reboot.c                  |   11 
 arch/i386/mach-visws/setup.c                   |    2 
 arch/i386/mach-voyager/voyager_basic.c         |   13 
 arch/i386/mm/discontig.c                       |   19 -
 arch/i386/pci/visws.c                          |    2 
 arch/m68k/mm/fault.c                           |    6 
 arch/parisc/mm/fault.c                         |   12 
 arch/ppc/8xx_io/Kconfig                        |    4 
 arch/ppc/8xx_io/commproc.c                     |   20 -
 arch/ppc/8xx_io/fec.c                          |   43 +
 arch/ppc/kernel/pci.c                          |   15 +
 arch/ppc/kernel/ppc_ksyms.c                    |    2 
 arch/ppc/syslib/m8xx_setup.c                   |    8 
 arch/ppc64/boot/zlib.c                         |    3 
 arch/ppc64/kernel/head.S                       |    2 
 arch/ppc64/kernel/machine_kexec.c              |   12 
 arch/ppc64/kernel/mpic.c                       |    4 
 arch/ppc64/kernel/mpic.h                       |    2 
 arch/ppc64/kernel/pci.c                        |   20 +
 arch/ppc64/kernel/xics.c                       |   31 +
 arch/ppc64/xmon/xmon.c                         |    3 
 arch/sh64/mm/fault.c                           |    6 
 arch/sparc64/kernel/pci.c                      |    6 
 arch/x86_64/ia32/ptrace32.c                    |    8 
 arch/x86_64/kernel/mce.c                       |   16 -
 arch/x86_64/kernel/setup.c                     |    6 
 arch/x86_64/mm/fault.c                         |    6 
 drivers/acpi/Kconfig                           |    5 
 drivers/acpi/button.c                          |  206 +++++++
 drivers/acpi/dispatcher/dswload.c              |    6 
 drivers/acpi/ec.c                              |   24 +
 drivers/acpi/hotkey.c                          |  690 ++++++++++++++----------
 drivers/acpi/motherboard.c                     |    2 
 drivers/acpi/osl.c                             |    6 
 drivers/acpi/pci_link.c                        |   18 +
 drivers/acpi/processor_idle.c                  |    7 
 drivers/block/cfq-iosched.c                    |    1 
 drivers/block/ll_rw_blk.c                      |   18 +
 drivers/bluetooth/bpa10x.c                     |    7 
 drivers/bluetooth/hci_bcsp.c                   |    2 
 drivers/bluetooth/hci_h4.c                     |    5 
 drivers/bluetooth/hci_ldisc.c                  |    2 
 drivers/bluetooth/hci_usb.c                    |   11 
 drivers/char/rtc.c                             |    7 
 drivers/char/tpm/Kconfig                       |   11 
 drivers/char/tpm/tpm_infineon.c                |  146 ++++-
 drivers/char/watchdog/sa1100_wdt.c             |   49 --
 drivers/fc4/fc.c                               |    2 
 drivers/ide/ide-probe.c                        |   16 -
 drivers/infiniband/include/ib_cm.h             |    3 
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    5 
 drivers/md/bitmap.c                            |   75 ++-
 drivers/md/dm-raid1.c                          |    2 
 drivers/md/md.c                                |    4 
 drivers/md/raid1.c                             |   29 +
 drivers/media/video/bttv-cards.c               |    8 
 drivers/media/video/bttv-driver.c              |   28 +
 drivers/pci/bus.c                              |    4 
 drivers/pci/pci.c                              |   59 ++
 drivers/pci/setup-res.c                        |    9 
 drivers/pcmcia/yenta_socket.c                  |   18 -
 drivers/sbus/char/vfc.h                        |    2 
 drivers/sbus/char/vfc_dev.c                    |    1 
 drivers/sbus/char/vfc_i2c.c                    |   19 -
 drivers/scsi/aic7xxx/aic7xxx_osm.c             |   24 -
 drivers/scsi/aic7xxx/aicasm/aicasm.c           |    4 
 drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h |    8 
 drivers/scsi/ibmvscsi/srp.h                    |    2 
 drivers/scsi/ips.c                             |    8 
 drivers/scsi/ips.h                             |   39 +
 drivers/scsi/st.c                              |    8 
 drivers/usb/host/ehci-dbg.c                    |    2 
 drivers/usb/host/ehci-q.c                      |    5 
 drivers/usb/host/ehci-sched.c                  |   13 
 drivers/usb/host/ehci.h                        |    5 
 drivers/usb/host/isp116x-hcd.c                 |    4 
 drivers/usb/mon/Kconfig                        |    9 
 drivers/usb/mon/Makefile                       |    1 
 fs/Kconfig                                     |   11 
 fs/bio.c                                       |    8 
 fs/isofs/compress.c                            |    6 
 fs/namei.c                                     |    5 
 fs/namespace.c                                 |    2 
 include/asm-alpha/pci.h                        |    3 
 include/asm-arm/pci.h                          |    4 
 include/asm-generic/pci.h                      |    8 
 include/asm-i386/mach-visws/do_timer.h         |    1 
 include/asm-i386/pci.h                         |    4 
 include/asm-parisc/pci.h                       |    4 
 include/asm-ppc/pci.h                          |    4 
 include/asm-ppc/pgtable.h                      |   52 ++
 include/asm-ppc64/machdep.h                    |    2 
 include/asm-ppc64/pci.h                        |    4 
 include/asm-ppc64/xics.h                       |    2 
 include/asm-x86_64/pci.h                       |    4 
 include/linux/blkdev.h                         |    1 
 include/linux/fsnotify.h                       |    4 
 include/linux/mm.h                             |   22 +
 include/linux/pci.h                            |    3 
 include/linux/raid/bitmap.h                    |    1 
 include/linux/swap.h                           |    3 
 include/linux/zlib.h                           |    5 
 include/net/bluetooth/bluetooth.h              |    8 
 ipc/sem.c                                      |   10 
 kernel/exit.c                                  |    4 
 kernel/posix-timers.c                          |    1 
 kernel/sys.c                                   |    2 
 lib/crc32.c                                    |    2 
 lib/inflate.c                                  |   16 -
 lib/zlib_inflate/inftrees.c                    |    2 
 mm/hugetlb.c                                   |   11 
 mm/memory.c                                    |   35 +
 mm/mmap.c                                      |    6 
 mm/mremap.c                                    |    2 
 mm/nommu.c                                     |    6 
 net/bluetooth/hci_core.c                       |    2 
 net/bluetooth/hci_event.c                      |    4 
 net/bluetooth/lib.c                            |   25 -
 net/bluetooth/rfcomm/core.c                    |    4 
 net/ipv4/fib_semantics.c                       |    9 
 net/ipv4/tcp_output.c                          |   86 +--
 security/keys/keyctl.c                         |   11 
 security/keys/keyring.c                        |    6 
 security/keys/process_keys.c                   |    2 
 security/keys/request_key.c                    |    2 
 158 files changed, 2480 insertions(+), 1327 deletions(-)
