Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTAEHHV>; Sun, 5 Jan 2003 02:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTAEHHV>; Sun, 5 Jan 2003 02:07:21 -0500
Received: from [61.197.228.217] ([61.197.228.217]:52864 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S263321AbTAEHHR>; Sun, 5 Jan 2003 02:07:17 -0500
Message-ID: <3E17DB8B.214D8FAC@cinet.co.jp>
Date: Sun, 05 Jan 2003 16:15:23 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.54-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>,
       " YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCHSET] PC-9800 subarch support for 2.5.54
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.54.
Please download from following URL.
http://downloads.sourceforge.jp/linux98/1988/linux98-2.5.54.patch.tar.bz2

Changes:
 - Change "pc98" variable to macro definition.
    GCC makes better codes for both standerd PC and PC98.
    Thanks, YOSHIFUJI Hideaki.
 - Change identifier CONFIG_PC9800 to CONFIG_X86_PC9800.

Description:
 - 2.5.50-ac1-merged.patch
   PC98 support patch in 2.5.50-ac1 with minimum changes
   to apply 2.5.54.
 arch/i386/boot98/Makefile                      |   90
 arch/i386/boot98/bootsect.S                    |  397 ++
 arch/i386/boot98/compressed/Makefile           |   26
 arch/i386/boot98/compressed/head.S             |  128
 arch/i386/boot98/compressed/misc.c             |  379 ++
 arch/i386/boot98/compressed/vmlinux.scr        |    9
 arch/i386/boot98/install.sh                    |   40
 arch/i386/boot98/setup.S                       |  961 +++++
 arch/i386/boot98/tools/build.c                 |  188 +
 arch/i386/boot98/video.S                       |  262 +
 arch/i386/kernel/cpu/proc.c                    |    2
 arch/i386/mach-pc9800/Makefile                 |   15
 arch/i386/mach-pc9800/setup.c                  |  117
 arch/i386/pci/pcbios.c                         |   15
 drivers/block/Makefile                         |    4
 drivers/block/floppy98.c                       | 4650 +++++++++++++++++++++++++
 drivers/char/Kconfig                           |   21
 drivers/char/lp_old98.c                        |  577 +++
 drivers/char/upd4990a.c                        |  438 ++
 drivers/input/keyboard/98kbd.c                 |  379 ++
 drivers/input/keyboard/Kconfig                 |   12
 drivers/input/mouse/98busmouse.c               |  201 +
 drivers/input/mouse/Kconfig                    |   12
 drivers/input/serio/98kbd-io.c                 |  181
 drivers/input/serio/Kconfig                    |   12
 include/asm-i386/gdc.h                         |  217 +
 include/asm-i386/pc9800_sca.h                  |   25
 include/asm-i386/serial.h                      |    7
 include/asm-i386/setup.h                       |    1
 include/asm-i386/upd4990a.h                    |   58
 include/linux/upd4990a.h                       |  140
 drivers/video/console/gdccon.c                 |  834 ++++
 drivers/input/keyboard/Makefile                |    1
 drivers/input/mouse/Makefile                   |    1
 drivers/input/serio/Makefile                   |    1
 arch/i386/kernel/i8259.c                       |   96
 arch/i386/kernel/io_apic.c                     |   24
 arch/i386/kernel/mpparse.c                     |    2
 arch/i386/kernel/reboot.c                      |   18
 arch/i386/kernel/setup.c                       |    1
 arch/i386/kernel/traps.c                       |    7
 include/asm-i386/mach-default/io_ports.h       |   30
 include/asm-i386/mach-default/irq_vectors.h    |    7
 include/asm-i386/mach-default/mach_reboot.h    |   30
 include/asm-i386/mach-default/pci-functions.h  |   19
 include/asm-i386/mach-pc9800/io_ports.h        |   30
 include/asm-i386/mach-pc9800/irq_vectors.h     |   93
 include/asm-i386/mach-pc9800/mach_reboot.h     |   21
 include/asm-i386/mach-pc9800/pci-functions.h   |   20
 include/asm-i386/mach-pc9800/setup_arch_post.h |   29
 include/asm-i386/mach-pc9800/setup_arch_pre.h  |   36
 include/asm-i386/mach-visws/irq_vectors.h      |    6
 include/asm-i386/mach-voyager/irq_vectors.h    |    6
 arch/i386/Makefile                             |    1
 arch/i386/kernel/apic.c                        |    7
 arch/i386/kernel/vm86.c                        |    8
 drivers/video/console/Makefile                 |    1
 include/asm-i386/processor.h                   |    2
 58 files changed, 10806 insertions(+), 89 deletions(-)

 - alsa-pc98.patch
   Fix bug for PC98 in 2.5.54 and additional driver.
 sound/isa/cs423x/pc9801_118_magic.h |  411 +++++++++++++++++++++++++++++++
 sound/isa/cs423x/sound_pc9800.h     |   23 +
 sound/drivers/mpu401/Makefile       |    1
 sound/isa/cs423x/Makefile           |    2
 sound/core/Makefile                 |    1
 sound/drivers/mpu401/mpu401.c       |    9
 sound/drivers/opl3/Makefile         |    1
 sound/isa/Kconfig                   |    6
 sound/isa/cs423x/pc98.c             |  466 ++++++++++++++++++++++++++++++++++++
 9 files changed, 917 insertions(+), 3 deletions(-)

 - apm.patch
   APM support for PC98. Including PC98's BIOS bug fix.
 arch/i386/kernel/apm.c   |   16 ++++++++++++----
 include/linux/apm_bios.h |   24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

 - arch-i386.patch
   PC98 support patches under arch/i386 and include/asm-i386/mach-* directory.
 arch/i386/Makefile                             |   14 +
 arch/i386/Kconfig                              |   10 +
 arch/i386/kernel/setup.c                       |   99 ------------
 arch/i386/kernel/time.c                        |  115 ++------------
 arch/i386/kernel/timers/timer_pit.c            |   22 +-
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
   Standard console for PC98 support.
 drivers/video/console/Kconfig  |   14 +
 drivers/char/Makefile          |    9
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
 14 files changed, 822 insertions(+), 71 deletions(-)

 - drivers-net.patch
   C-bus(PC98's legacy bus like ISA) network cards support.
 drivers/net/8390.h       |    3
 drivers/net/Kconfig      |   55 +++++
 drivers/net/Makefile     |    1
 drivers/net/Makefile.lib |    1
 drivers/net/Space.c      |    2
 drivers/net/3c509.c      |   35 +++
 drivers/net/at1700.c     |  115 +++++++++--
 drivers/net/ne.c         |  358 +++++++++++++++++++++++++++++++++-
 drivers/net/ne2k_cbus.h  |  481 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1019 insertions(+), 32 deletions(-)

 - fs.patch
   FAT fs and partition table support.
 fs/fat/inode.c         |    4
 fs/partitions/Kconfig  |    7 +
 fs/partitions/Makefile |    1
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
 include/linux/kernel.h |    6 ++++++
 kernel/dma.c           |    3 +++
 kernel/timer.c         |    5 +++++
 3 files changed, 14 insertions(+)

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
 include/linux/kernel.h |    6 ++++++
 kernel/dma.c           |    3 +++
 kernel/timer.c         |    5 +++++
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
 drivers/scsi/pc980155.c     |  263 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/pc980155.h     |   47 +++++++
 drivers/scsi/pc980155regs.h |   89 ++++++++++++++
 drivers/scsi/scsi_scan.c    |    1
 drivers/scsi/scsi_syms.c    |    4
 drivers/scsi/scsicam98.c    |  192 ++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c           |   23 +++
 drivers/scsi/wd33c93.c      |   30 ++++-
 drivers/scsi/wd33c93.h      |    5
 11 files changed, 664 insertions(+), 7 deletions(-)

 - serial-pnp.patch
   Onboard modem support.
 drivers/serial/8250_pnp.c |    5 +++++
 1 files changed, 5 insertions(+)

 - smp.patch
   SMP support.
 arch/i386/kernel/mpparse.c                |   34 ++++++++++++++++++++++--------
 arch/i386/kernel/smpboot.c                |   14 ++++++++++++
 include/asm-i386/mach-default/bios_ebda.h |   15 +++++++++++++
 include/asm-i386/mach-pc9800/bios_ebda.h  |   14 ++++++++++++
 include/asm-i386/smpboot.h                |    9 +++++++
 5 files changed, 78 insertions(+), 8 deletions(-)

 -- *-update.patch are updates for files in 2.5.50-ac1.
 - Kconfig-update.patch
 drivers/char/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

 - boot98-update.patch
 arch/i386/boot98/compressed/Makefile |    3 +--
 arch/i386/boot98/Makefile            |   20 +++-----------------
 2 files changed, 4 insertions(+), 19 deletions(-)

 - floppy98-update.patch
 drivers/block/floppy98.c |   84 +++++++++++++++++++++++++++--------------------
 drivers/block/Makefile   |    2 -
 2 files changed, 50 insertions(+), 36 deletions(-)

 - gdc-update.patch
 include/asm-i386/gdc.h         |  144 ++++++++++++++++++++++-------------------
 drivers/video/console/gdccon.c |    1
 2 files changed, 79 insertions(+), 66 deletions(-)

 - i8259_c-update.patch
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

 - serial_h-update.patch
 include/asm-i386/serial.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

 - upd4990a_h-update.patch
 include/asm-i386/upd4990a.h |    6 ------
 1 files changed, 6 deletions(-)


Regards,
Osamu Tomita
