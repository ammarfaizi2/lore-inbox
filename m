Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJNIwU>; Mon, 14 Oct 2002 04:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261879AbSJNIwU>; Mon, 14 Oct 2002 04:52:20 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:54626 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261875AbSJNIwR>; Mon, 14 Oct 2002 04:52:17 -0400
Message-ID: <3DAA86F4.79FA136E@cinet.co.jp>
Date: Mon, 14 Oct 2002 17:57:24 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.42-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] Add support for PC-9800 architecture
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are porting Linux for NEC PC-9800 architecture
since 2.1.57, and continue testing and updating.
Formaly, PC-9800 was most popular machine in japan.
Many peoples love it (like us), and many students use
 it in school yet.
We hope our patches into the kernel.
Check and advice please.
Sorry for bad English, because I'm not native writer.

we put patch URL below so too big for mail.
http://downloads.sourceforge.jp/linux98/1365/linux98-2.5.42-for-merge-diffs.bz2
about PC-9800 archtecture, please see
http://www.kmc.gr.jp/proj/linux98/index-english.html

and here is diffstat result.

 linux-2.5.42/arch/i386/Makefile                        |   17 
 linux-2.5.42/arch/i386/boot98/Makefile                 |   93 
 linux-2.5.42/arch/i386/boot98/bootsect.S               |  397 ++
 linux-2.5.42/arch/i386/boot98/compressed/Makefile      |   30 
 linux-2.5.42/arch/i386/boot98/compressed/head.S        |  128 
 linux-2.5.42/arch/i386/boot98/compressed/misc.c        |  375 ++
 linux-2.5.42/arch/i386/boot98/compressed/vmlinux.scr   |    9 
 linux-2.5.42/arch/i386/boot98/install.sh               |   40 
 linux-2.5.42/arch/i386/boot98/setup.S                  |  950 ++++++
 linux-2.5.42/arch/i386/boot98/tools/build.c            |  188 +
 linux-2.5.42/arch/i386/boot98/video.S                  |  262 +
 linux-2.5.42/arch/i386/config.in                       |   19 
 linux-2.5.42/arch/i386/kernel/Makefile                 |    4 
 linux-2.5.42/arch/i386/kernel/apic.c                   |   16 
 linux-2.5.42/arch/i386/kernel/apm.c                    |   54 
 linux-2.5.42/arch/i386/kernel/cpu/proc.c               |    2 
 linux-2.5.42/arch/i386/kernel/i8259.c                  |  100 
 linux-2.5.42/arch/i386/kernel/io_apic.c                |   25 
 linux-2.5.42/arch/i386/kernel/mpparse.c                |   35 
 linux-2.5.42/arch/i386/kernel/pc9800_debug.c           |  362 ++
 linux-2.5.42/arch/i386/kernel/reboot.c                 |   11 
 linux-2.5.42/arch/i386/kernel/setup.c                  |   93 
 linux-2.5.42/arch/i386/kernel/smpboot.c                |   14 
 linux-2.5.42/arch/i386/kernel/time.c                   |  128 
 linux-2.5.42/arch/i386/kernel/timers/timer_pit.c       |   25 
 linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c       |   42 
 linux-2.5.42/arch/i386/kernel/traps.c                  |   22 
 linux-2.5.42/arch/i386/kernel/vm86.c                   |   21 
 linux-2.5.42/arch/i386/mach-generic/io_ports.h         |   20 
 linux-2.5.42/arch/i386/mach-pc9800/Makefile            |   15 
 linux-2.5.42/arch/i386/mach-pc9800/do_timer.h          |   81 
 linux-2.5.42/arch/i386/mach-pc9800/entry_arch.h        |   34 
 linux-2.5.42/arch/i386/mach-pc9800/io_ports.h          |   20 
 linux-2.5.42/arch/i386/mach-pc9800/irq_vectors.h       |   85 
 linux-2.5.42/arch/i386/mach-pc9800/setup.c             |  113 
 linux-2.5.42/arch/i386/mach-pc9800/setup_arch_post.h   |   29 
 linux-2.5.42/arch/i386/mach-pc9800/setup_arch_pre.h    |   36 
 linux-2.5.42/arch/i386/mach-pc9800/smpboot_hooks.h     |   33 
 linux-2.5.42/arch/i386/mach-visws/io_ports.h           |   20 
 linux-2.5.42/arch/i386/pci/irq.c                       |   27 
 linux-2.5.42/arch/i386/pci/pcbios.c                    |   17 
 linux-2.5.42/drivers/block/Makefile                    |    4 
 linux-2.5.42/drivers/block/floppy98.c                  | 4633 ++++++++++++++++++++++++++++++
 linux-2.5.42/drivers/char/Config.in                    |    6 
 linux-2.5.42/drivers/char/Makefile                     |   18 
 linux-2.5.42/drivers/char/console_macros.h             |   24 
 linux-2.5.42/drivers/char/console_pc9800.h             |   27 
 linux-2.5.42/drivers/char/consolemap.c                 |   67 
 linux-2.5.42/drivers/char/defkeymap_pc9800.c           |  285 +
 linux-2.5.42/drivers/char/defkeymap_pc9800.map         |  439 ++
 linux-2.5.42/drivers/char/keyboard.c                   |   79 
 linux-2.5.42/drivers/char/lp_old98.c                   |  580 +++
 linux-2.5.42/drivers/char/pc9800.uni                   |  260 +
 linux-2.5.42/drivers/char/upd4990a.c                   |  438 ++
 linux-2.5.42/drivers/char/vc_screen.c                  |   33 
 linux-2.5.42/drivers/char/vt.c                         |  690 ++++
 linux-2.5.42/drivers/char/vt_ioctl.c                   |   19 
 linux-2.5.42/drivers/ide/Config.in                     |    4 
 linux-2.5.42/drivers/ide/ide-disk.c                    |   67 
 linux-2.5.42/drivers/ide/ide-geometry.c                |    2 
 linux-2.5.42/drivers/ide/ide-probe.c                   |   25 
 linux-2.5.42/drivers/ide/ide-proc.c                    |    3 
 linux-2.5.42/drivers/ide/ide.c                         |   14 
 linux-2.5.42/drivers/ide/legacy/Makefile               |    5 
 linux-2.5.42/drivers/ide/legacy/hd98.c                 |  856 +++++
 linux-2.5.42/drivers/ide/legacy/pc9800.c               |   82 
 linux-2.5.42/drivers/input/keyboard/98kbd.c            |  359 ++
 linux-2.5.42/drivers/input/keyboard/Config.in          |    4 
 linux-2.5.42/drivers/input/keyboard/Makefile           |    1 
 linux-2.5.42/drivers/input/misc/pcspkr.c               |   24 
 linux-2.5.42/drivers/input/mouse/Config.in             |    7 
 linux-2.5.42/drivers/input/mouse/logibm.c              |   48 
 linux-2.5.42/drivers/input/serio/Config.in             |    3 
 linux-2.5.42/drivers/input/serio/Makefile              |    1 
 linux-2.5.42/drivers/input/serio/i8042-98.c            |  358 ++
 linux-2.5.42/drivers/input/serio/i8042-98io.h          |   74 
 linux-2.5.42/drivers/input/serio/i8042.h               |    2 
 linux-2.5.42/drivers/net/3c569b.c                      | 1241 ++++++++
 linux-2.5.42/drivers/net/8390.h                        |    3 
 linux-2.5.42/drivers/net/Config.in                     |   26 
 linux-2.5.42/drivers/net/Makefile                      |    2 
 linux-2.5.42/drivers/net/Makefile.lib                  |    2 
 linux-2.5.42/drivers/net/Space.c                       |    2 
 linux-2.5.42/drivers/net/at1000.c                      |  768 ++++
 linux-2.5.42/drivers/net/ne.c                          |  517 +++
 linux-2.5.42/drivers/net/ne2k_cbus.h                   |  473 +++
 linux-2.5.42/drivers/parport/parport_pc.c              |   73 
 linux-2.5.42/drivers/pci/pci.ids                       |   16 
 linux-2.5.42/drivers/pci/quirks.c                      |    7 
 linux-2.5.42/drivers/pcmcia/yenta.c                    |    6 
 linux-2.5.42/drivers/pnp/isapnp.c                      |    5 
 linux-2.5.42/drivers/scsi/Config.in                    |    3 
 linux-2.5.42/drivers/scsi/Makefile                     |    1 
 linux-2.5.42/drivers/scsi/advansys.c                   |    9 
 linux-2.5.42/drivers/scsi/aic7xxx/aic7xxx_linux_host.h |    3 
 linux-2.5.42/drivers/scsi/aic7xxx_old/aic7xxx.h        |    9 
 linux-2.5.42/drivers/scsi/pc980155.c                   |  262 +
 linux-2.5.42/drivers/scsi/pc980155.h                   |   47 
 linux-2.5.42/drivers/scsi/pc980155regs.h               |   89 
 linux-2.5.42/drivers/scsi/scsi_scan.c                  |    1 
 linux-2.5.42/drivers/scsi/scsi_syms.c                  |    6 
 linux-2.5.42/drivers/scsi/scsicam.c                    |   93 
 linux-2.5.42/drivers/scsi/sd.c                         |    8 
 linux-2.5.42/drivers/scsi/wd33c93.c                    |  112 
 linux-2.5.42/drivers/scsi/wd33c93.h                    |    5 
 linux-2.5.42/drivers/serial/8250_cs.c                  |    1 
 linux-2.5.42/drivers/serial/8250_pnp.c                 |    7 
 linux-2.5.42/drivers/serial/Config.in                  |   10 
 linux-2.5.42/drivers/serial/Makefile                   |    6 
 linux-2.5.42/drivers/serial/serial98.c                 | 2896 ++++++++++++++++++
 linux-2.5.42/drivers/video/Config.in                   |    4 
 linux-2.5.42/drivers/video/Makefile                    |    4 
 linux-2.5.42/drivers/video/egcfb.c                     |  654 ++++
 linux-2.5.42/drivers/video/fbcon-egc.c                 |  681 ++++
 linux-2.5.42/drivers/video/fbcon.c                     |  461 ++
 linux-2.5.42/drivers/video/fbmem.c                     |   60 
 linux-2.5.42/drivers/video/gdccon.c                    |  963 ++++++
 linux-2.5.42/fs/fat/inode.c                            |    9 
 linux-2.5.42/fs/partitions/Config.in                   |    9 
 linux-2.5.42/fs/partitions/Makefile                    |    2 
 linux-2.5.42/fs/partitions/check.c                     |    8 
 linux-2.5.42/fs/partitions/msdos.c                     |   15 
 linux-2.5.42/fs/partitions/nec98.c                     |  265 +
 linux-2.5.42/fs/partitions/nec98.h                     |   10 
 linux-2.5.42/fs/partitions/x68000.c                    |   94 
 linux-2.5.42/fs/partitions/x68000.h                    |    6 
 linux-2.5.42/include/asm-i386/bugs.h                   |    2 
 linux-2.5.42/include/asm-i386/dma.h                    |    7 
 linux-2.5.42/include/asm-i386/floppy.h                 |   11 
 linux-2.5.42/include/asm-i386/gdc.h                    |  225 +
 linux-2.5.42/include/asm-i386/ide.h                    |   18 
 linux-2.5.42/include/asm-i386/io.h                     |    6 
 linux-2.5.42/include/asm-i386/irq.h                    |    4 
 linux-2.5.42/include/asm-i386/mpspec.h                 |    4 
 linux-2.5.42/include/asm-i386/pc9800.h                 |   27 
 linux-2.5.42/include/asm-i386/pc9800_debug.h           |  152 
 linux-2.5.42/include/asm-i386/pc9800_dma.h             |  238 +
 linux-2.5.42/include/asm-i386/pc9800_sca.h             |   25 
 linux-2.5.42/include/asm-i386/pci.h                    |    4 
 linux-2.5.42/include/asm-i386/pgtable.h                |    4 
 linux-2.5.42/include/asm-i386/processor.h              |    2 
 linux-2.5.42/include/asm-i386/scatterlist.h            |    6 
 linux-2.5.42/include/asm-i386/serial.h                 |   18 
 linux-2.5.42/include/asm-i386/setup.h                  |    3 
 linux-2.5.42/include/asm-i386/smpboot.h                |    9 
 linux-2.5.42/include/asm-i386/timex.h                  |    4 
 linux-2.5.42/include/asm-i386/upd4990a.h               |   58 
 linux-2.5.42/include/linux/apm_bios.h                  |   24 
 linux-2.5.42/include/linux/console.h                   |    3 
 linux-2.5.42/include/linux/console_struct.h            |   34 
 linux-2.5.42/include/linux/consolemap.h                |    6 
 linux-2.5.42/include/linux/fdreg.h                     |   24 
 linux-2.5.42/include/linux/hdreg.h                     |   19 
 linux-2.5.42/include/linux/ide.h                       |    2 
 linux-2.5.42/include/linux/input.h                     |   21 
 linux-2.5.42/include/linux/ioport.h                    |   14 
 linux-2.5.42/include/linux/kbd_kern.h                  |   11 
 linux-2.5.42/include/linux/keyboard.h                  |    4 
 linux-2.5.42/include/linux/logibusmouse.h              |   30 
 linux-2.5.42/include/linux/parport_pc.h                |   10 
 linux-2.5.42/include/linux/pc_keyb.h                   |   18 
 linux-2.5.42/include/linux/pci_ids.h                   |   20 
 linux-2.5.42/include/linux/serial.h                    |   13 
 linux-2.5.42/include/linux/serialP.h                   |    5 
 linux-2.5.42/include/linux/serial_core.h               |    9 
 linux-2.5.42/include/linux/serial_reg.h                |   43 
 linux-2.5.42/include/linux/tty.h                       |    8 
 linux-2.5.42/include/linux/upd4990a.h                  |  140 
 linux-2.5.42/include/linux/vt.h                        |    5 
 linux-2.5.42/include/linux/vt_buffer.h                 |    6 
 linux-2.5.42/include/scsi/scsicam.h                    |    5 
 linux-2.5.42/include/sound/mpu401.h                    |    4 
 linux-2.5.42/include/sound/pc9801_118_magic.h          |  411 ++
 linux-2.5.42/include/sound/sound_pc9800.h              |   23 
 linux-2.5.42/include/video/fbcon-egc.h                 |   32 
 linux-2.5.42/kernel/dma.c                              |    3 
 linux-2.5.42/kernel/resource.c                         |  100 
 linux-2.5.42/kernel/timer.c                            |    5 
 linux-2.5.42/sound/core/Makefile                       |    4 
 linux-2.5.42/sound/core/seq/Makefile                   |    4 
 linux-2.5.42/sound/core/seq/instr/Makefile             |    3 
 linux-2.5.42/sound/drivers/Config.in                   |    3 
 linux-2.5.42/sound/drivers/mpu401/mpu401_uart.c        |  173 +
 linux-2.5.42/sound/drivers/opl3/Makefile               |    6 
 linux-2.5.42/sound/drivers/opl3/opl3_lib.c             |   29 
 linux-2.5.42/sound/isa/cs423x/cs4231.c                 |   32 
 linux-2.5.42/sound/isa/cs423x/cs4231_lib.c             |   74 
 linux-2.5.42/sound/oss/Config.in                       |   18 
 linux-2.5.42/sound/oss/Makefile                        |    1 
 linux-2.5.42/sound/oss/ad1848.c                        |   45 
 linux-2.5.42/sound/oss/dev_table.h                     |    3 
 linux-2.5.42/sound/oss/dmabuf.c                        |    3 
 linux-2.5.42/sound/oss/mpu401.c                        |  178 +
 linux-2.5.42/sound/oss/opl3.c                          |  132 
 linux-2.5.42/sound/oss/pc9801_86_pcm.c                 | 2580 ++++++++++++++++
 linux-2.5.42/sound/oss/sb.h                            |   34 
 linux-2.5.42/sound/oss/sb_common.c                     |  103 
 linux-2.5.42/sound/oss/sound_config.h                  |   12 
 linux-2.5.42/sound/oss/uart401.c                       |   17 
 199 files changed, 28658 insertions(+), 162 deletions(-)
