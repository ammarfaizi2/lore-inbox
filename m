Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBLNJL>; Wed, 12 Feb 2003 08:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTBLNJL>; Wed, 12 Feb 2003 08:09:11 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:22144 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267083AbTBLNJF>; Wed, 12 Feb 2003 08:09:05 -0500
Date: Wed, 12 Feb 2003 22:17:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (0/34) summary
Message-ID: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture against 2.5.60.

You can get this patchset from URL bellow.
http://downloads.sourceforge.jp/linux98/2350/linux98-2.5.60.patch.tar.bz2
Comments and test reports are wellcome.


Description:
 o 2.5.50-ac1-*.patch
   PC98 support patch in 2.5.50-ac1 with minimum changes to apply 2.5.60.

 - 2.5.50-ac1-arch.patch

 arch/i386/kernel/cpu/proc.c    |    2 
 arch/i386/mach-pc9800/Makefile |   15 +++++
 arch/i386/mach-pc9800/setup.c  |  117 +++++++++++++++++++++++++++++++++++++++++
 arch/i386/pci/pcbios.c         |   15 -----
 arch/i386/kernel/i8259.c       |   96 +++++++++++++++++----------------
 arch/i386/kernel/mpparse.c     |    2 
 arch/i386/kernel/reboot.c      |   18 ------
 arch/i386/kernel/setup.c       |    1 
 arch/i386/kernel/apic.c        |    7 +-
 arch/i386/kernel/vm86.c        |    8 +-
 arch/i386/Makefile             |    1 
 arch/i386/kernel/io_apic.c     |   24 +++++++-
 arch/i386/kernel/traps.c       |    7 +-
 13 files changed, 225 insertions(+), 88 deletions(-)

 - 2.5.50-ac1-boot98.patch

 arch/i386/boot98/Makefile               |   90 ++
 arch/i386/boot98/bootsect.S             |  397 +++++++++++++
 arch/i386/boot98/compressed/Makefile    |   26 
 arch/i386/boot98/compressed/head.S      |  128 ++++
 arch/i386/boot98/compressed/misc.c      |  379 ++++++++++++
 arch/i386/boot98/compressed/vmlinux.scr |    9 
 arch/i386/boot98/install.sh             |   40 +
 arch/i386/boot98/setup.S                |  961 ++++++++++++++++++++++++++++++++
 arch/i386/boot98/tools/build.c          |  188 ++++++
 arch/i386/boot98/video.S                |  262 ++++++++
 10 files changed, 2480 insertions(+)

 - 2.5.50-ac1-driver.patch

 drivers/char/lp_old98.c          |  577 ++++++++++++++++++++++++++
 drivers/char/upd4990a.c          |  438 ++++++++++++++++++++
 drivers/input/keyboard/98kbd.c   |  379 +++++++++++++++++
 drivers/input/mouse/98busmouse.c |  201 +++++++++
 drivers/input/serio/98kbd-io.c   |  181 ++++++++
 drivers/video/console/gdccon.c   |  834 +++++++++++++++++++++++++++++++++++++++
 drivers/input/keyboard/Makefile  |    1 
 drivers/input/mouse/Makefile     |    1 
 drivers/input/serio/Kconfig      |   12 
 drivers/char/Kconfig             |   22 -
 drivers/block/Makefile           |    4 
 drivers/input/keyboard/Kconfig   |   12 
 drivers/input/mouse/Kconfig      |   12 
 drivers/input/serio/Makefile     |    1 
 drivers/video/console/Makefile   |    1 
 15 files changed, 2675 insertions(+), 1 deletion(-)

 - 2.5.50-ac1-floppy98-1.patch

 drivers/block/floppy98.c | 2315 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 2315 insertions(+)

 - 2.5.50-ac1-floppy98-2.patch

 drivers/block/floppy98.c | 2335 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 2335 insertions(+)

 - 2.5.50-ac1-include.patch

 include/asm-i386/gdc.h                         |  217 +++++++++++++++++++++++++
 include/asm-i386/pc9800_sca.h                  |   25 ++
 include/asm-i386/serial.h                      |    7 
 include/asm-i386/setup.h                       |    1 
 include/asm-i386/upd4990a.h                    |   58 ++++++
 include/linux/upd4990a.h                       |  140 ++++++++++++++++
 include/asm-i386/mach-default/io_ports.h       |   30 +++
 include/asm-i386/mach-default/irq_vectors.h    |    7 
 include/asm-i386/mach-default/mach_reboot.h    |   30 +++
 include/asm-i386/mach-default/pci-functions.h  |   19 ++
 include/asm-i386/mach-pc9800/io_ports.h        |   30 +++
 include/asm-i386/mach-pc9800/irq_vectors.h     |   93 ++++++++++
 include/asm-i386/mach-pc9800/mach_reboot.h     |   21 ++
 include/asm-i386/mach-pc9800/pci-functions.h   |   20 ++
 include/asm-i386/mach-pc9800/setup_arch_post.h |   29 +++
 include/asm-i386/mach-pc9800/setup_arch_pre.h  |   36 ++++
 include/asm-i386/mach-visws/irq_vectors.h      |    6 
 include/asm-i386/mach-voyager/irq_vectors.h    |    6 
 include/asm-i386/processor.h                   |    2 
 19 files changed, 776 insertions(+), 1 deletion(-)


 - alsa-pc98.patch
   ALSA sound drivers for PC98.
   Additional PC98 specific driver.

 sound/isa/cs423x/pc9801_118_magic.h |  411 +++++++++++++++++++++++++++++++
 sound/isa/cs423x/sound_pc9800.h     |   23 +
 sound/core/Makefile                 |    1 
 sound/drivers/mpu401/Makefile       |    1 
 sound/drivers/opl3/Makefile         |    1 
 sound/isa/cs423x/Makefile           |    2 
 sound/isa/Kconfig                   |    6 
 sound/isa/cs423x/pc98.c             |  466 ++++++++++++++++++++++++++++++++++++
 8 files changed, 911 insertions(+)


 - apm.patch
   APM support for PC98. Including PC98's BIOS bug fix.

 arch/i386/kernel/apm.c   |   16 ++++++++++++----
 include/linux/apm_bios.h |   24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)


 - arch-i386.patch
   Core patches for PC98 under arch/i386 and include/asm-i386/mach-* directory.

 arch/i386/Kconfig                              |   10 +
 arch/i386/Makefile                             |   14 +
 arch/i386/kernel/time.c                        |  115 ++------------
 arch/i386/kernel/timers/timer_pit.c            |   22 +-
 arch/i386/kernel/setup.c                       |   99 ------------
 arch/i386/kernel/timers/timer_tsc.c            |   94 +-----------
 arch/i386/kernel/traps.c                       |   12 -
 include/asm-i386/mach-default/calibrate_tsc.h  |   90 +++++++++++
 include/asm-i386/mach-default/mach_resources.h |  113 ++++++++++++++
 include/asm-i386/mach-default/mach_time.h      |  122 +++++++++++++++
 include/asm-i386/mach-default/mach_traps.h     |   29 +++
 include/asm-i386/mach-pc9800/calibrate_tsc.h   |   71 +++++++++
 include/asm-i386/mach-pc9800/do_timer.h        |   80 ++++++++++
 include/asm-i386/mach-pc9800/mach_resources.h  |  192 +++++++++++++++++++++++++
 include/asm-i386/mach-pc9800/mach_time.h       |  136 +++++++++++++++++
 include/asm-i386/mach-pc9800/mach_traps.h      |   27 +++
 include/asm-i386/mach-pc9800/smpboot_hooks.h   |   33 ++++
 17 files changed, 967 insertions(+), 292 deletions(-)


 - console.patch
   Support for PC98 Standard console.
   This patch adds support for 2byte japanese letter KANJI.

 drivers/video/console/Kconfig  |   14 +
 drivers/char/Makefile          |    6 
 drivers/char/console_macros.h  |   14 +
 drivers/char/console_pc9800.h  |   14 +
 drivers/char/consolemap.c      |   58 ++++-
 drivers/char/pc9800.uni        |  260 +++++++++++++++++++++++
 drivers/char/vt.c              |  459 +++++++++++++++++++++++++++++++++++------
 drivers/char/vt_ioctl.c        |   19 +
 include/linux/console.h        |   11 
 include/linux/console_struct.h |   25 ++
 include/linux/consolemap.h     |    1 
 include/linux/tty.h            |    4 
 include/linux/vt.h             |    1 
 include/linux/vt_buffer.h      |    4 
 14 files changed, 820 insertions(+), 70 deletions(-)


 - drivers-net.patch
   C-bus(PC98's legacy bus like ISA) network cards support.

 drivers/net/8390.h       |    3 
 drivers/net/Makefile.lib |    1 
 drivers/net/ne2k_cbus.h  |  481 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/at1700.c     |  115 +++++++++--
 drivers/net/ne.c         |  356 +++++++++++++++++++++++++++++++++-
 drivers/net/3c509.c      |   32 +++
 drivers/net/Kconfig      |   55 +++++
 drivers/net/Makefile     |    1 
 drivers/net/Space.c      |    2 
 9 files changed, 1014 insertions(+), 32 deletions(-)


 - fs.patch
   FAT fs and partition table support.

 fs/partitions/Makefile |    1 
 fs/fat/inode.c         |    4 
 fs/partitions/Kconfig  |    7 +
 fs/partitions/check.c  |    4 
 fs/partitions/msdos.c  |    2 
 fs/partitions/nec98.c  |  272 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/nec98.h  |   10 +
 7 files changed, 298 insertions(+), 2 deletions(-)


 - ide.patch
   Support standard IDE I/F of PC98.

 drivers/ide/Kconfig         |    5 
 drivers/ide/ide-disk.c      |   67 +++
 drivers/ide/ide-probe.c     |   16 
 drivers/ide/ide-proc.c      |    3 
 drivers/ide/ide.c           |    9 
 drivers/ide/legacy/Makefile |    5 
 drivers/ide/legacy/hd98.c   |  904 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/legacy/pc9800.c |   82 +++
 include/asm-i386/ide.h      |   18 
 include/linux/hdreg.h       |   19 
 include/linux/ide.h         |    2 
 11 files changed, 1125 insertions(+), 5 deletions(-)


 - include-asm.patch
   Core patches for PC98 under include/asm-i386/ directory.

 include/asm-i386/pgtable.h     |    4 
 include/asm-i386/dma.h         |    7 +
 include/asm-i386/io.h          |    6 +
 include/asm-i386/irq.h         |    4 
 include/asm-i386/pc9800.h      |   27 ++++
 include/asm-i386/pc9800_dma.h  |  238 +++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/scatterlist.h |    6 +
 include/asm-i386/timex.h       |    4 
 8 files changed, 296 insertions(+)


 - input.patch
   Beep driver and keyboard support files.

 drivers/char/keyboard.c     |    4 +
 drivers/input/misc/98spkr.c |   95 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig  |    4 +
 drivers/input/misc/Makefile |    1 
 include/linux/kbd_kern.h    |    5 +-
 include/linux/keyboard.h    |    1 
 6 files changed, 108 insertions(+), 2 deletions(-)


 - kernel.patch
   Misc files for support PC98.

 kernel/timer.c         |    5 +++++
 include/linux/kernel.h |    6 ++++++
 kernel/dma.c           |    3 +++
 3 files changed, 14 insertions(+)


 - parport.patch
   Parallel port support.

 drivers/parport/parport_pc.c |   66 +++++++++++++++++++++++++++++++++++++++----
 include/linux/parport_pc.h   |   10 ++++++
 2 files changed, 71 insertions(+), 5 deletions(-)


 - pci.patch
   PCI support.

 arch/i386/pci/irq.c    |   27 +++++++++++++++++++++++++++
 drivers/pcmcia/yenta.c |    6 ++++++
 include/asm-i386/pci.h |    4 ++++
 3 files changed, 37 insertions(+)


 - pcmcia.patch
   PCMCIA (16bits) support.

 drivers/pcmcia/i82365.c |    4 ++++
 1 files changed, 4 insertions(+)


 - pnp.patch
   Legacy bus PNP support.

 drivers/pnp/isapnp/core.c |    5 +++++
 1 files changed, 5 insertions(+)


 - scsi.patch
   SCSI host adapter support.

 drivers/scsi/Kconfig        |    7 +
 drivers/scsi/Makefile       |   10 +
 drivers/scsi/scsi_syms.c    |    4 
 drivers/scsi/pc980155.c     |  263 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/pc980155.h     |   47 +++++++
 drivers/scsi/pc980155regs.h |   89 ++++++++++++++
 drivers/scsi/scsi_scan.c    |    1 
 drivers/scsi/scsicam98.c    |  192 ++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c           |   23 +++
 drivers/scsi/wd33c93.c      |   30 ++++-
 drivers/scsi/wd33c93.h      |    5 
 11 files changed, 664 insertions(+), 7 deletions(-)


 - serial.patch
   Serial port driver.

 drivers/serial/Makefile     |    1 
 drivers/serial/8250_pnp.c   |    5 
 drivers/serial/Kconfig      |   17 
 drivers/serial/serial98.c   | 1125 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h |    8 
 5 files changed, 1153 insertions(+), 3 deletions(-)


 - smp.patch
   SMP support.

 arch/i386/kernel/mpparse.c                  |   34 ++++++++++++++++-----
 arch/i386/kernel/smpboot.c                  |   14 ++++++++
 include/asm-i386/mach-default/bios_ebda.h   |   15 +++++++++
 include/asm-i386/mach-pc9800/bios_ebda.h    |   14 ++++++++
 include/asm-i386/mach-pc9800/mach_wakecpu.h |   45 ++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 8 deletions(-)


 -- *-update.patch are updates for files in 2.5.50-ac1.

 - Kconfig-update.patch

 drivers/char/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


 - boot98-update.patch

 arch/i386/boot98/compressed/Makefile |    3 +--
 arch/i386/boot98/Makefile            |   20 +++-----------------
 2 files changed, 4 insertions(+), 19 deletions(-)


 - floppy98-update.patch

 drivers/block/Makefile   |    2 
 drivers/block/floppy98.c |  102 +++++++++++++++++++++++++++--------------------
 2 files changed, 61 insertions(+), 43 deletions(-)


 - gdc-update.patch

 include/asm-i386/gdc.h         |  144 ++++++++++++++++++++++-------------------
 drivers/video/console/gdccon.c |    1 
 2 files changed, 79 insertions(+), 66 deletions(-)


 - i8259.c-update.patch

 arch/i386/kernel/i8259.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


 - input-update.patch

 drivers/input/mouse/98busmouse.c |    7 ++++---
 drivers/input/serio/98kbd-io.c   |    7 ++++---
 drivers/input/keyboard/Kconfig   |    2 +-
 drivers/input/mouse/Kconfig      |    2 +-
 drivers/input/serio/Kconfig      |    2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

 - lp_old98-update.patch

 drivers/char/lp_old98.c |  147 ++++++++++++++++++++++--------------------------
 1 files changed, 69 insertions(+), 78 deletions(-)


 - mach-pc9800-update.patch
 arch/i386/mach-pc9800/Makefile   |   10 -----
 arch/i386/mach-pc9800/setup.c    |    8 ++--
 arch/i386/mach-pc9800/topology.c |   68 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 13 deletions(-)


 - pci-quirks-update.patch

 drivers/pci/quirks.c |    2 ++
 1 files changed, 2 insertions(+)


 - serial.h-update.patch

 include/asm-i386/serial.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


 - upd4990a.h-update.patch

 include/asm-i386/upd4990a.h |    6 ------
 1 files changed, 6 deletions(-)


Thanks,
Osamu Tomita <tomita@cinet.co.jp>

