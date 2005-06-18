Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFRFMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFRFMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 01:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVFRFMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 01:12:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVFRFLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 01:11:23 -0400
Date: Fri, 17 Jun 2005 22:13:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.12
Message-ID: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As some people may have noticed already, 2.6.12 is out there now.

The full ChangeLog ended up missing, because I only have the history from
2.6.12-rc2 in my git archives, but if you want to, you can puzzle it
together by taking the 2.6.12 changelog and merging it with the -rc1 and 
-rc2 logs in the testing directory. The file that says "ChangeLog-2.6.12" 
only contains the stuff from -rc2 onward.

Included here in the email are the changes since -rc6, and as you can see
from the appended diffstat, most of the things are pretty small (ie it
looks like a long list, and then you look at the diffstat and realize that
most of the changes end up being just a line or two).

One of the least important changes is still worth pointing out: it was
discussed earlier on the kernel mailing list in another thread, but maybe
people didn't notice it: the sign-off procedure was clarified to make it
clear that the person signing off understands that the project - and thus
the patch and the sign-off itself, of course - is public and will be
archived.

This may sound silly and obvious - and it is - but it makes people more
comfortable about the fact that we obviously save identifying information
in the sign-off (that's the whole point), and in general people also
submit things like their own email addresses in CREDITS files etc, and so
nobody should be expecting any of that to be kept confidential.

I don't think anybody did, of course, but hey, this way it's explicit. So 
part of the new stuff is this patch:

	diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
	--- a/Documentation/SubmittingPatches
	+++ b/Documentation/SubmittingPatches
	@@ -271,7 +271,7 @@ patch, which certifies that you wrote it
	 pass it on as a open-source patch.  The rules are pretty simple: if you
	 can certify the below:
	 
	-        Developer's Certificate of Origin 1.0
	+        Developer's Certificate of Origin 1.1
	 
	         By making a contribution to this project, I certify that:
	 
	@@ -291,6 +291,12 @@ can certify the below:
	             person who certified (a), (b) or (c) and I have not modified
	             it.
	 
	+       (d) I understand and agree that this project and the contribution
	+           are public and that a record of the contribution (including all
	+           personal information I submit with it, including my sign-off) is
	+           maintained indefinitely and may be redistributed consistent with
	+           this project or the open source license(s) involved.
	+
	 then you just add a line saying
	 
	        Signed-off-by: Random J Developer <random@developer.org>

just so that people are aware of this.

Btw, in case anybody ends up wondering about what the actual patches are,
if you're a git user (or, more likely, not quite a user yet, but rather
wondering what you can do with git), you can start off with doing

	git-whatchanged -p v2.6.12-rc6..v2.6.12

and it will do exactly what you think it migth do - it shows every commit 
between -rc6 and the final 2.6.12 release as a patch ("-p") with the 
associated commit message. 

			Linus


-----
Al Viro:
  namei fixes (1-19)

Alan Cox:
  pwc bug fix

Alan Hourihane:
  i945G patch for agpgart

Albert Lee:
  sg traverse fix for __atapi_pio_bytes()

Albrecht Dreß:
  ARM: 2694/1: [s3c2410/dma] release irq properly to fix kernel oops

Alexandre Oliva:
  sbp2 slab corruption fix

Ananth N Mavinakayanahalli:
  ppc64 kprobes: remove spurious MSR_SE masking
  ppc64 kprobes: correct kprobe registration return values
  ppc64 kprobes: don't eat dabr/iabr exceptions

Andi Kleen:
  [TCP]: Adjust TCP mem order check to new alloc_large_system_hash

Andrew Morton:
  revert x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture

Benjamin Herrenschmidt:
  radeonfb: don't blow up VGA console on load
  ppc32: Fix nasty sleep/wakeup problem

Bjorn Helgaas:
  PCI: do VIA IRQ fixup always, not just in PIC mode

Catalin Marinas:
  ARM: 2714/1: Fix the IB2 definitions for the Versatile platform
  ARM: 2713/1: Fix the GPIO base for Integrator/CP
  ARM: 2712/1: Fix the RGB order for the Versatile CLCD

Christoph Hellwig:
  PCI: don't override drv->shutdown unconditionally

Christoph Lameter:
  [IA64] Fix race condition in the rt_sigprocmask fastcall

Daniel Jacobowitz:
  Fix large core dumps with a 32-bit off_t

Dave Airlie:
  remove bogus hack from radeon IRQ handler
  drm add i945G pci id

Dave Neuer:
  ARM: 2706/1: Fix compile on SA-based iPAQs and remove stale CREDITS info

David Brownell:
  spin longer for ehci port reset completion
  ARM: 2709/1: Systems with PCMCIA should also see IDE options (for CompactFlash memories)

David Mosberger:
  Replace check_bridge_mode() with (bridge->mode & AGSTAT_MODE_3_0).
  Include <linux/config.h> before testing CONFIG_ACPI

David Mosberger-Tang:
  [IA64] Fill holes in FIXADDR_USER space with zero pages.

David S. Miller:
  [NETFILTER]: ipt_recent: last_pkts is an array of "unsigned long" not "u_int32_t"
  [TG3]: Update driver version and release date.
  [TG3]: Update driver version and release date.
  [ETHTOOL]: Check correct pointer in ethtool_set_coalesce().

Dean Nelson:
  [IA64] fix setting of sn_hub_info->shub_1_1_found

Deepak Saxena:
  ARM: 2700/1: Disable IXP2000 IRQs at bootup
  ARM: 2692/1: Fix compile warnings in include/asm-arm/arch-ixp2000/io.h

Denis Vlasenko:
  moxa: do not ignore input

Dmitry Torokhov:
  ALPS: fix enabling hardware tapping

Eugene Surovegin:
  ppc32: add 405EP cpu_spec entry
  ppc32: add 405EP cpu_spec entry
  ppc32: add 405EP cpu_spec entry

Gabor Fekete:
  [IPV6]: Update parm.link in ip6ip6_tnl_change()

Geert Uytterhoeven:
  M68k: Mark Sun-3 NCR5380 SCSI broken
  M68k: Update defconfigs
  Remove obsolete HAVE_ARCH_GET_SIGNAL_TO_DELIVER?
  IrDA: IrDA: Fix CONFIG_VIA_FIR typo (double `those')

Giorgio Padrin:
  ARM: 2703/1: pxa-regs.h: complete I2S GPIO alternate functions for PXA27x

Ian Abbott:
  USB: ftdi_sio: avoid losing received data in tty-ldisc

Ingo Molnar:
  timer exit cleanup

J. Simonetti:
  [IPV4]: Sysctl configurable icmp error source address.

Jan Kara:
  cond_resched_lock() fix

Jeff Dike:
  uml: slirp and slip driver cleanups and fixes
  uml: use fork instead of clone
  uml: build cleanups
  uml: remove duplicate includes
  uml: clean up error path
  uml: fix strace -f
  uml: compile fixes for gcc 4
  uml: make the emulated iomem driver work on 2.6

Jens Axboe:
  sata_sil: Fix FIFO PCI Bus Arbitration kernel oops

John W. Linville:
  [TG3]: Update pci.ids for BCM5752

Jon Smirl:
  Typo in fbdev sysfs support, virtual_size

Karsten Wiese:
  usbusx2y: prevent oops & dead keyboard on usb unplugging while the device is being used
  usbaudio: prevent oops & dead keyboard on usb unplugging while the device is being used

Keir Fraser:
  AGP fix for Xen VMM

Keith Owens:
  Stop arch/i386/kernel/vsyscall-note.o being rebuilt every time
  [IA64] Extract correct break number for break.b
  [IA64] Module gp must point to valid memory

Kiyoshi Ueda:
  When cfq I/O scheduler is selected, get_request() in __make_request() calls

Kumar Gala:
  ppc32: Fix incorrect CPU_FTR fixup usage for unified caches

Lars Marowsky-Bree:
  dm: Handle READA requests in dm-mpath.c

Linus Torvalds:
  Linux 2.6.12
  Merge 'for-linus' branch of rsync://rsync.kernel.org/.../axboe/linux-2.6-block
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge 'for-linus' branch of master.kernel.org:/.../axboe/linux-2.6-block
  Merge rsync://rsync.kernel.org/.../davem/net-2.6
  Update DCO ("signoff") rules to 1.1
  Merge rsync://rsync.kernel.org/.../davem/net-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge rsync://rsync.kernel.org/.../sfrench/cifs-2.6
  Merge rsync://rsync.kernel.org/.../airlied/drm-2.6
  ppc: remove two extraneous descriptors for the 405EP CPU
  Merge rsync://rsync.kernel.org/.../gregkh/usb-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge rsync://rsync.kernel.org/.../aegl/linux-2.6
  Merge rsync://rsync.kernel.org/.../gregkh/usb-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge rsync://rsync.kernel.org/.../davem/net-2.6
  Merge rsync://rsync.kernel.org/.../davem/tg3-2.6
  Merge rsync://rsync.kernel.org/.../aegl/linux-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Automatic merge of master.kernel.org:/home/rmk/linux-2.6-arm
  Merge of master.kernel.org:/.../davej/agpgart
  Merge of rsync://rsync.kernel.org/.../davem/tg3-2.6
  Merge of rsync://rsync.kernel.org/.../davem/net-2.6

Markus Lidel:
  i2o: Fix free of event memory in i2o_block_event()

Martin Schwidefsky:
  broken fault_in_pages_readable call in generic_file_buffered_write()

Matthew Dobson:
  send_IPI_mask_sequence() warning fix

Michael Chan:
  [TG3]: Fix 5700/5701 DMA corruption on Apple G4.
  [TG3] Fix link failure in 5701
  [TG3]: Add TSO firmware license

Michael Ellerman:
  iseries_veth: Supress spurious WARN_ON() at module unload

Michael Werner:
  sgi-agp: fixes a problem with accessing GART memory in sgi_tioca_insert_memory and sgi_tioca_remove_memory

Mike Frysinger:
  ARM: 2696/1: remove ';' in ELF_DATA define in asm-arm{,26}/elf.h

Narendra Sankar:
  PCI: MSI functionality broken on Serverworks GC chipset

Neil Horman:
  [SCTP] Add support for ip_nonlocal_bind sysctl & IP_FREEBIND socket option
  [SCTP] Support SO_BINDTODEVICE socket option on incoming packets.

Nicolas Pitre:
  ARM: 2715/1: restore CPLD interrupts upon resume for Lubbock and Mainstone
  ARM: 2711/1: fix compilation on PXA targets with CONFIG_PM=n
  ARM: 2664/2: add support for atomic ops on pre-ARMv6 SMP systems
  ARM: 2705/1: fix writesw for misaligned source pointer

Olaf Hering:
  update ppc64 defconfig
  ppc64: print negative numbers correctly in boot wrapper

Oliver Neukum:
  fix for kaweth broken by changes in the networking layer

Olof Johansson:
  Fix PCI BAR size interpretation on 64-bit arches

Patrick McHardy:
  [NETFILTER]: Advance seq-file position in exp_next_seq()

Paul Mackerras:
  ppc64: update example configs
  ppc64: Fix PER_LINUX32 behaviour

Pete Zaitcev:
  USB: fix ub issues

Peter Chubb:
  ia64: fix floating-point preemption problem

Ralf Baechle:
  [NET]: Move the netdev list to vger.kernel.org.

Randy Dunlap:
  macmodes: needs a license
  [IPV4]: Multipath modules need a license to prevent kernel tainting.

Russell King:
  ARM: Remove zero-byte sized file
  Serial: remove unused variable in sa1100 driver
  ARM: Fix Xscale copy_page implementation

Rémi Denis-Courmont:
  [IPv6] Don't generate temporary for TUN devices

Scott Murray:
  PCI Hotplug: fix CPCI reference counting bug

Sridhar Samudrala:
  [SCTP] Fix incorrect setting of sk_bound_dev_if when binding/sending to a ipv6

Stephen Hemminger:
  [NET]: Fix sysctl net.core.dev_weight
  [NET]: Allow controlling NAPI device weight with sysfs

Steve French:
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  [CIFS] Fix cifs update of page cache. Write at correct offset when out of memory
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  [CIFS] Update cifs version number and fix whitespace
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git

Tejun Heo:
  This patch fixes q->unplug_thresh condition check in
  This patch kills elevator_global_init() in elevator.c which does

Thomas Graf:
  [PKT_SCHED]: Fix numeric comparison in meta ematch
  [PKT_SCHED]: Dump classification result for basic classifier
  [PKT_SCHED]: Allow socket attributes to be matched on via meta ematch
  [PKT_SCHED]: Fix typo in NET_EMATCH_STACK help text

Thomas Hood:
  apm.c: ignore_normal_resume is set a bit too late

Todd Poynor:
  ARM: 2691/1: PXA27x sleep fixes take 2

Tom Rini:
  [NET]: linux/if_tr.h needs asm/byteorder.h
  ppc32: add <linux/compiler.h> to <asm/sigcontext.h>

Tony Luck:
  [IA64] Update comment to describe modes set in default control register.
  Auto merge with /home/aegl/GIT/linus
  auto merge with /home/aegl/GIT/linus

Trond Myklebust:
  NFS: Ensure that we revalidate the cached file length for llseek(SEEK_END)
  NFS: Fix lookup intent handling

Vincent Sanders:
  ARM: 2708/1: Fix hackkit CPU Frequency build faliure
  ARM: 2707/2: Fix badge4 CPU Frequency build faliure

Vladislav Yasevich:
  [SCTP] Extend the info exported via /proc/net/sctp to support netstat for SCTP.
  [SCTP]: Fix bug in restart of peeled-off associations.

Vojtech Pavlik:
  input: disable scroll feature on AT keyboards

William Lee Irwin III:
  sparc32: silence access_ok() warnings

YOSHIFUJI Hideaki:
  [IPV6]: Ensure to use icmpv6_socket in non-preemptive context.

Yoshinori Sato:
  binfmt_flat mmap flag fix
  h8300 build error fix

---
 CREDITS                                      |    6 -
 Documentation/SubmittingPatches              |    8 +
 Documentation/networking/vortex.txt          |    2 
 MAINTAINERS                                  |   48 ++--
 Makefile                                     |    2 
 arch/arm/Kconfig                             |    6 -
 arch/arm/boot/compressed/head-xscale.S       |    7 +
 arch/arm/configs/badge4_defconfig            |   29 ++-
 arch/arm/configs/h3600_defconfig             |   24 +-
 arch/arm/configs/hackkit_defconfig           |   22 +-
 arch/arm/kernel/entry-armv.S                 |   16 +
 arch/arm/kernel/traps.c                      |   49 ++++
 arch/arm/lib/io-writesw-armv4.S              |    6 -
 arch/arm/mach-integrator/integrator_cp.c     |    1 
 arch/arm/mach-pxa/lubbock.c                  |   30 +++
 arch/arm/mach-pxa/mainstone.c                |   40 +++-
 arch/arm/mach-pxa/pm.c                       |   32 ++-
 arch/arm/mach-pxa/pxa25x.c                   |   33 +++
 arch/arm/mach-pxa/pxa27x.c                   |   36 +++
 arch/arm/mach-s3c2410/dma.c                  |    4 
 arch/arm/mach-sa1100/Kconfig                 |    2 
 arch/arm/mach-versatile/core.c               |    2 
 arch/arm/mm/Kconfig                          |   15 +
 arch/arm/mm/Makefile                         |    2 
 arch/arm/mm/copypage-xscale.S                |  113 ----------
 arch/arm/mm/copypage-xscale.c                |  131 ++++++++++++
 arch/arm/mm/minicache.c                      |   73 ------
 arch/i386/kernel/Makefile                    |    2 
 arch/i386/kernel/apm.c                       |    2 
 arch/ia64/kernel/fsys.S                      |    4 
 arch/ia64/kernel/module.c                    |   10 +
 arch/ia64/kernel/ptrace.c                    |    6 +
 arch/ia64/kernel/setup.c                     |    3 
 arch/ia64/kernel/traps.c                     |   29 ++-
 arch/ia64/mm/init.c                          |   19 +-
 arch/ia64/sn/kernel/setup.c                  |    4 
 arch/m68k/configs/amiga_defconfig            |   15 -
 arch/m68k/configs/apollo_defconfig           |    7 -
 arch/m68k/configs/atari_defconfig            |    7 -
 arch/m68k/configs/bvme6000_defconfig         |    7 -
 arch/m68k/configs/hp300_defconfig            |    7 -
 arch/m68k/configs/mac_defconfig              |    7 -
 arch/m68k/configs/mvme147_defconfig          |    7 -
 arch/m68k/configs/mvme16x_defconfig          |    7 -
 arch/m68k/configs/q40_defconfig              |   15 -
 arch/m68k/configs/sun3_defconfig             |    8 -
 arch/m68k/configs/sun3x_defconfig            |    7 -
 arch/m68k/defconfig                          |    7 -
 arch/ppc/kernel/cputable.c                   |   11 +
 arch/ppc/kernel/misc.S                       |    6 -
 arch/ppc/platforms/pmac_cpufreq.c            |    7 -
 arch/ppc64/boot/prom.c                       |   28 ++
 arch/ppc64/configs/g5_defconfig              |   76 ++++---
 arch/ppc64/configs/iSeries_defconfig         |   62 +++--
 arch/ppc64/configs/maple_defconfig           |   70 ++++--
 arch/ppc64/configs/pSeries_defconfig         |  102 ++++++---
 arch/ppc64/defconfig                         |  104 ++++++---
 arch/ppc64/kernel/kprobes.c                  |   18 +-
 arch/ppc64/kernel/misc.S                     |    2 
 arch/ppc64/kernel/sys_ppc32.c                |   70 +++---
 arch/ppc64/kernel/syscalls.c                 |   33 ++-
 arch/um/Kconfig_char                         |    6 +
 arch/um/drivers/Makefile                     |    6 -
 arch/um/drivers/chan_user.c                  |   26 +-
 arch/um/drivers/mmapper_kern.c               |   24 ++
 arch/um/drivers/net_user.c                   |    2 
 arch/um/drivers/slip.h                       |   23 --
 arch/um/drivers/slip_common.c                |   54 +++++
 arch/um/drivers/slip_common.h                |  104 +++++++++
 arch/um/drivers/slip_kern.c                  |   12 +
 arch/um/drivers/slip_proto.h                 |   93 --------
 arch/um/drivers/slip_user.c                  |  154 ++++++--------
 arch/um/drivers/slirp.h                      |   26 --
 arch/um/drivers/slirp_kern.c                 |    5 
 arch/um/drivers/slirp_user.c                 |  102 ++-------
 arch/um/drivers/stderr_console.c             |    6 -
 arch/um/include/mconsole.h                   |    2 
 arch/um/include/net_user.h                   |    2 
 arch/um/include/os.h                         |    2 
 arch/um/include/sysdep-i386/ptrace.h         |    5 
 arch/um/include/user_util.h                  |    3 
 arch/um/kernel/main.c                        |    2 
 arch/um/kernel/process.c                     |   49 ++--
 arch/um/kernel/skas/process_kern.c           |    7 +
 arch/um/kernel/um_arch.c                     |    1 
 arch/um/os-Linux/elf_aux.c                   |    6 -
 arch/um/os-Linux/file.c                      |    2 
 arch/um/scripts/Makefile.rules               |    2 
 arch/x86_64/kernel/aperture.c                |   41 +---
 drivers/block/cfq-iosched.c                  |    9 +
 drivers/block/elevator.c                     |    9 -
 drivers/block/ub.c                           |    4 
 drivers/char/agp/agp.h                       |    2 
 drivers/char/agp/ali-agp.c                   |    4 
 drivers/char/agp/amd-k7-agp.c                |    6 -
 drivers/char/agp/amd64-agp.c                 |    4 
 drivers/char/agp/ati-agp.c                   |    6 -
 drivers/char/agp/backend.c                   |    6 -
 drivers/char/agp/efficeon-agp.c              |    2 
 drivers/char/agp/generic.c                   |   36 +--
 drivers/char/agp/hp-agp.c                    |    4 
 drivers/char/agp/i460-agp.c                  |    4 
 drivers/char/agp/intel-agp.c                 |   21 +-
 drivers/char/agp/sgi-agp.c                   |   12 +
 drivers/char/agp/sworks-agp.c                |    8 -
 drivers/char/agp/uninorth-agp.c              |    2 
 drivers/char/drm/drm_pciids.h                |    1 
 drivers/char/drm/radeon_irq.c                |    5 
 drivers/char/mxser.c                         |   38 +--
 drivers/ieee1394/sbp2.c                      |    3 
 drivers/input/keyboard/atkbd.c               |    2 
 drivers/input/mouse/alps.c                   |    2 
 drivers/macintosh/via-pmu.c                  |    6 +
 drivers/md/dm-mpath.c                        |    3 
 drivers/message/i2o/i2o_block.c              |    1 
 drivers/net/irda/Kconfig                     |    2 
 drivers/net/iseries_veth.c                   |    9 -
 drivers/net/r8169.c                          |    2 
 drivers/net/tg3.c                            |   39 +++
 drivers/pci/hotplug/cpci_hotplug_core.c      |    2 
 drivers/pci/hotplug/cpci_hotplug_pci.c       |    5 
 drivers/pci/pci-driver.c                     |    5 
 drivers/pci/pci.ids                          |    1 
 drivers/pci/probe.c                          |    2 
 drivers/pci/quirks.c                         |   41 ++--
 drivers/scsi/Kconfig                         |    2 
 drivers/scsi/libata-core.c                   |    4 
 drivers/scsi/sata_sil.c                      |    8 +
 drivers/serial/sa1100.c                      |    2 
 drivers/usb/host/ehci-hub.c                  |    5 
 drivers/usb/media/pwc/pwc-if.c               |    4 
 drivers/usb/net/kaweth.c                     |    2 
 drivers/usb/serial/ftdi_sio.c                |  118 ++++++++--
 drivers/video/aty/radeon_base.c              |    7 -
 drivers/video/fbsysfs.c                      |    2 
 drivers/video/macmodes.c                     |    1 
 fs/binfmt_elf.c                              |    2 
 fs/binfmt_flat.c                             |    6 -
 fs/cifs/CHANGES                              |    3 
 fs/cifs/cifsfs.h                             |    2 
 fs/cifs/file.c                               |    2 
 fs/cifs/inode.c                              |   34 +--
 fs/namei.c                                   |  153 ++++++++-----
 fs/nfs/dir.c                                 |   49 +++-
 fs/nfs/file.c                                |   42 ++++
 include/asm-alpha/agp.h                      |   10 +
 include/asm-arm/arch-integrator/platform.h   |    4 
 include/asm-arm/arch-ixp2000/io.h            |   16 +
 include/asm-arm/arch-pxa/pxa-regs.h          |    2 
 include/asm-arm/arch-versatile/platform.h    |   16 +
 include/asm-arm/elf.h                        |    4 
 include/asm-arm26/elf.h                      |    2 
 include/asm-arm26/signal.h                   |    3 
 include/asm-h8300/kmap_types.h               |    6 -
 include/asm-h8300/mman.h                     |    3 
 include/asm-i386/agp.h                       |   10 +
 include/asm-i386/mach-numaq/mach_ipi.h       |    2 
 include/asm-ia64/agp.h                       |   10 +
 include/asm-ia64/pgtable.h                   |    8 +
 include/asm-ia64/processor.h                 |   10 +
 include/asm-ppc/agp.h                        |   10 +
 include/asm-ppc/sigcontext.h                 |    2 
 include/asm-ppc64/agp.h                      |   10 +
 include/asm-ppc64/elf.h                      |    4 
 include/asm-sparc/uaccess.h                  |    5 
 include/asm-sparc64/agp.h                    |   10 +
 include/asm-x86_64/agp.h                     |   10 +
 include/linux/acpi.h                         |    2 
 include/linux/if_tr.h                        |    2 
 include/linux/pci_ids.h                      |    3 
 include/linux/signal.h                       |    2 
 include/linux/sysctl.h                       |    1 
 include/linux/tc_ematch/tc_em_meta.h         |   30 +++
 include/net/ip.h                             |    1 
 kernel/exit.c                                |    4 
 kernel/posix-timers.c                        |    1 
 kernel/sched.c                               |    7 -
 mm/filemap.c                                 |    8 +
 net/core/dev.c                               |    1 
 net/core/ethtool.c                           |    2 
 net/core/net-sysfs.c                         |   17 +
 net/ipv4/af_inet.c                           |    1 
 net/ipv4/icmp.c                              |    9 +
 net/ipv4/multipath_drr.c                     |    2 
 net/ipv4/multipath_random.c                  |    2 
 net/ipv4/multipath_rr.c                      |    2 
 net/ipv4/multipath_wrandom.c                 |    2 
 net/ipv4/netfilter/ip_conntrack_standalone.c |    1 
 net/ipv4/netfilter/ipt_recent.c              |   10 -
 net/ipv4/sysctl_net_ipv4.c                   |    9 +
 net/ipv4/tcp.c                               |    2 
 net/ipv6/addrconf.c                          |    1 
 net/ipv6/icmp.c                              |   14 +
 net/ipv6/ip6_tunnel.c                        |    1 
 net/sched/Kconfig                            |    2 
 net/sched/act_api.c                          |    2 
 net/sched/cls_basic.c                        |    3 
 net/sched/em_meta.c                          |  295 ++++++++++++++++++++++++--
 net/sctp/input.c                             |   49 +++-
 net/sctp/ipv6.c                              |   36 +--
 net/sctp/proc.c                              |  190 +++++++++++++----
 net/sctp/protocol.c                          |    7 -
 net/sctp/socket.c                            |   12 +
 sound/usb/usbaudio.c                         |    2 
 sound/usb/usx2y/usbusx2y.c                   |   11 +
 205 files changed, 2496 insertions(+), 1438 deletions(-)
