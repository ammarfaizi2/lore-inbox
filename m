Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVD1SbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVD1SbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVD1SbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:31:16 -0400
Received: from kanga.kvack.org ([66.96.29.28]:16360 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262224AbVD1S3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:29:53 -0400
Date: Thu, 28 Apr 2005 14:29:26 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] unify semaphore implementations
Message-ID: <20050428182926.GC16545@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Please review the following series of patches for unifying the 
semaphore implementation across all architectures (not posted as 
they're about 350K), as they have only been tested on x86-64.  The 
code generated is functionally identical to the earlier i386 
variant, but since gcc has no way of taking condition codes as 
results, there are two additional instructions inserted from the 
use of generic atomic operations.  All told the >6000 lines of code 
deleted makes for a much easier job for subsequent patches changing 
semaphore functionality.  Cheers,

		-ben

http://www.kvack.org/~bcrl/patches/sem-cleanup-A2/10-rename_semaphore_h.diff
	Introduce linux/semaphore.h.  Convert all users of asm/semaphore.h over 
	to linux/semaphore.h.

http://www.kvack.org/~bcrl/patches/sem-cleanup-A2/20-move_rwlock.diff
	Move i386 rwlock helper functions out of semaphore.c and into their own 
	file rwlock.c.

http://www.kvack.org/~bcrl/patches/sem-cleanup-A2/30-one_semaphore.diff
	Replace all semaphore implementations with a single implementation 
	derrived from the i386 code using atomic operations.  Tested on x86-64, 
	compiled on i386 and ia64.
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

 sem-10/arch/alpha/kernel/alpha_ksyms.c                   |    2 
 sem-10/arch/arm/common/rtctime.c                         |    2 
 sem-10/arch/arm/kernel/semaphore.c                       |    5 
 sem-10/arch/arm/mach-integrator/clock.c                  |    2 
 sem-10/arch/arm/mach-omap/clock.c                        |    2 
 sem-10/arch/arm/mach-versatile/clock.c                   |    2 
 sem-10/arch/arm/oprofile/common.c                        |    2 
 sem-10/arch/arm26/kernel/armksyms.c                      |    2 
 sem-10/arch/arm26/kernel/semaphore.c                     |    5 
 sem-10/arch/arm26/kernel/traps.c                         |    2 
 sem-10/arch/cris/kernel/crisksyms.c                      |    2 
 sem-10/arch/cris/kernel/semaphore.c                      |    4 
 sem-10/arch/frv/kernel/frv_ksyms.c                       |    2 
 sem-10/arch/frv/kernel/semaphore.c                       |    2 
 sem-10/arch/h8300/kernel/h8300_ksyms.c                   |    2 
 sem-10/arch/h8300/kernel/semaphore.c                     |    4 
 sem-10/arch/i386/kernel/cpu/common.c                     |    2 
 sem-10/arch/i386/kernel/cpu/proc.c                       |    2 
 sem-10/arch/i386/kernel/i386_ksyms.c                     |    2 
 sem-10/arch/i386/kernel/semaphore.c                      |    4 
 sem-10/arch/ia64/ia32/sys_ia32.c                         |    2 
 sem-10/arch/ia64/kernel/ia64_ksyms.c                     |    2 
 sem-10/arch/ia64/kernel/salinfo.c                        |    2 
 sem-10/arch/ia64/kernel/semaphore.c                      |    4 
 sem-10/arch/ia64/sn/kernel/sn2/sn_hwperf.c               |    2 
 sem-10/arch/m32r/kernel/m32r_ksyms.c                     |    2 
 sem-10/arch/m32r/kernel/semaphore.c                      |    4 
 sem-10/arch/m68k/atari/stram.c                           |    2 
 sem-10/arch/m68k/kernel/m68k_ksyms.c                     |    2 
 sem-10/arch/m68k/kernel/semaphore.c                      |    4 
 sem-10/arch/m68k/sun3/intersil.c                         |    2 
 sem-10/arch/m68knommu/kernel/m68k_ksyms.c                |    2 
 sem-10/arch/m68knommu/kernel/semaphore.c                 |    4 
 sem-10/arch/mips/kernel/semaphore.c                      |    2 
 sem-10/arch/mips/lasat/picvue.h                          |    2 
 sem-10/arch/mips/sgi-ip27/ip27-console.c                 |    2 
 sem-10/arch/parisc/kernel/parisc_ksyms.c                 |    2 
 sem-10/arch/parisc/kernel/semaphore.c                    |    4 
 sem-10/arch/parisc/kernel/sys_parisc32.c                 |    2 
 sem-10/arch/ppc/kernel/ppc_ksyms.c                       |    2 
 sem-10/arch/ppc/kernel/semaphore.c                       |    2 
 sem-10/arch/ppc/kernel/syscalls.c                        |    2 
 sem-10/arch/ppc/syslib/ocp.c                             |    2 
 sem-10/arch/ppc64/kernel/rtas.c                          |    2 
 sem-10/arch/ppc64/kernel/semaphore.c                     |    2 
 sem-10/arch/ppc64/kernel/sys_ppc32.c                     |    2 
 sem-10/arch/ppc64/kernel/syscalls.c                      |    2 
 sem-10/arch/ppc64/mm/imalloc.c                           |    2 
 sem-10/arch/s390/kernel/compat_linux.c                   |    2 
 sem-10/arch/s390/kernel/debug.c                          |    2 
 sem-10/arch/s390/kernel/semaphore.c                      |    2 
 sem-10/arch/sh/kernel/semaphore.c                        |    6 
 sem-10/arch/sh/kernel/sh_ksyms.c                         |    2 
 sem-10/arch/sh/mm/pg-dma.c                               |    2 
 sem-10/arch/sh64/kernel/semaphore.c                      |    6 
 sem-10/arch/sh64/kernel/sh_ksyms.c                       |    2 
 sem-10/arch/sparc/kernel/semaphore.c                     |    4 
 sem-10/arch/sparc64/kernel/sys_sparc32.c                 |    2 
 sem-10/arch/um/drivers/port_kern.c                       |    2 
 sem-10/arch/um/drivers/xterm_kern.c                      |    2 
 sem-10/arch/um/include/line.h                            |    2 
 sem-10/arch/um/kernel/trap_kern.c                        |    2 
 sem-10/arch/um/sys-i386/ksyms.c                          |    2 
 sem-10/arch/v850/kernel/semaphore.c                      |    4 
 sem-10/arch/v850/kernel/syscalls.c                       |    2 
 sem-10/arch/v850/kernel/v850_ksyms.c                     |    2 
 sem-10/arch/x86_64/ia32/sys_ia32.c                       |    2 
 sem-10/arch/x86_64/kernel/semaphore.c                    |    4 
 sem-10/arch/x86_64/kernel/x8664_ksyms.c                  |    2 
 sem-10/drivers/atm/idt77252.c                            |    2 
 sem-10/drivers/base/core.c                               |    2 
 sem-10/drivers/base/firmware_class.c                     |    2 
 sem-10/drivers/base/power/shutdown.c                     |    2 
 sem-10/drivers/block/cryptoloop.c                        |    2 
 sem-10/drivers/block/sx8.c                               |    2 
 sem-10/drivers/char/generic_serial.c                     |    2 
 sem-10/drivers/char/ipmi/ipmi_devintf.c                  |    2 
 sem-10/drivers/char/ipmi/ipmi_poweroff.c                 |    2 
 sem-10/drivers/char/rio/rioboot.c                        |    2 
 sem-10/drivers/char/rio/riocmd.c                         |    2 
 sem-10/drivers/char/rio/rioctrl.c                        |    2 
 sem-10/drivers/char/rio/rioinit.c                        |    2 
 sem-10/drivers/char/rio/riointr.c                        |    2 
 sem-10/drivers/char/rio/rioparam.c                       |    2 
 sem-10/drivers/char/rio/rioroute.c                       |    2 
 sem-10/drivers/char/rio/riotable.c                       |    2 
 sem-10/drivers/char/rio/riotty.c                         |    2 
 sem-10/drivers/char/rocket.c                             |    2 
 sem-10/drivers/char/ser_a2232.c                          |    2 
 sem-10/drivers/char/snsc.h                               |    2 
 sem-10/drivers/char/watchdog/sc1200wdt.c                 |    2 
 sem-10/drivers/fc4/fc.c                                  |    2 
 sem-10/drivers/i2c/busses/i2c-ali1535.c                  |    2 
 sem-10/drivers/ieee1394/eth1394.c                        |    2 
 sem-10/drivers/ieee1394/hosts.h                          |    2 
 sem-10/drivers/ieee1394/ieee1394_core.c                  |    2 
 sem-10/drivers/ieee1394/ieee1394_core.h                  |    2 
 sem-10/drivers/ieee1394/ieee1394_types.h                 |    2 
 sem-10/drivers/infiniband/core/device.c                  |    2 
 sem-10/drivers/infiniband/core/user_mad.c                |    2 
 sem-10/drivers/infiniband/hw/mthca/mthca_dev.h           |    2 
 sem-10/drivers/infiniband/hw/mthca/mthca_memfree.h       |    2 
 sem-10/drivers/infiniband/ulp/ipoib/ipoib.h              |    2 
 sem-10/drivers/input/joystick/iforce/iforce.h            |    2 
 sem-10/drivers/macintosh/adb.c                           |    2 
 sem-10/drivers/media/dvb/dvb-core/dmxdev.h               |    2 
 sem-10/drivers/media/dvb/dvb-core/dvb_demux.h            |    2 
 sem-10/drivers/media/dvb/dvb-core/dvb_frontend.c         |    2 
 sem-10/drivers/media/dvb/ttpci/av7110.c                  |    2 
 sem-10/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 sem-10/drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    2 
 sem-10/drivers/media/radio/miropcm20-rds-core.c          |    2 
 sem-10/drivers/media/radio/radio-aimslab.c               |    2 
 sem-10/drivers/media/radio/radio-maestro.c               |    2 
 sem-10/drivers/media/radio/radio-maxiradio.c             |    2 
 sem-10/drivers/media/radio/radio-sf16fmi.c               |    2 
 sem-10/drivers/media/radio/radio-sf16fmr2.c              |    2 
 sem-10/drivers/media/video/arv.c                         |    2 
 sem-10/drivers/media/video/bw-qcam.c                     |    2 
 sem-10/drivers/media/video/c-qcam.c                      |    2 
 sem-10/drivers/media/video/cpia.c                        |    2 
 sem-10/drivers/media/video/ir-kbd-i2c.c                  |    2 
 sem-10/drivers/media/video/msp3400.c                     |    2 
 sem-10/drivers/media/video/planb.c                       |    2 
 sem-10/drivers/media/video/tvmixer.c                     |    2 
 sem-10/drivers/media/video/videodev.c                    |    2 
 sem-10/drivers/mtd/mtd_blkdevs.c                         |    2 
 sem-10/drivers/net/3c527.c                               |    2 
 sem-10/drivers/net/hamradio/6pack.c                      |    2 
 sem-10/drivers/net/ibmveth.c                             |    2 
 sem-10/drivers/net/plip.c                                |    2 
 sem-10/drivers/net/ppp_synctty.c                         |    2 
 sem-10/drivers/oprofile/event_buffer.h                   |    2 
 sem-10/drivers/oprofile/oprof.c                          |    2 
 sem-10/drivers/pci/hotplug/acpiphp_glue.c                |    2 
 sem-10/drivers/pci/hotplug/pciehp.h                      |    2 
 sem-10/drivers/pci/hotplug/rpadlpar_core.c               |    2 
 sem-10/drivers/pci/hotplug/shpchp.h                      |    2 
 sem-10/drivers/s390/char/sclp_cpi.c                      |    2 
 sem-10/drivers/s390/cio/ccwgroup.c                       |    2 
 sem-10/drivers/s390/cio/qdio.c                           |    2 
 sem-10/drivers/s390/net/qeth_main.c                      |    2 
 sem-10/drivers/scsi/aacraid/aachba.c                     |    2 
 sem-10/drivers/scsi/aacraid/commctrl.c                   |    2 
 sem-10/drivers/scsi/aacraid/comminit.c                   |    2 
 sem-10/drivers/scsi/aacraid/commsup.c                    |    2 
 sem-10/drivers/scsi/aacraid/dpcsup.c                     |    2 
 sem-10/drivers/scsi/aacraid/linit.c                      |    2 
 sem-10/drivers/scsi/aacraid/rkt.c                        |    2 
 sem-10/drivers/scsi/aacraid/rx.c                         |    2 
 sem-10/drivers/scsi/aacraid/sa.c                         |    2 
 sem-10/drivers/scsi/aha152x.c                            |    2 
 sem-10/drivers/scsi/dpt/dpti_i2o.h                       |    2 
 sem-10/drivers/scsi/libata-core.c                        |    2 
 sem-10/drivers/scsi/megaraid/mega_common.h               |    2 
 sem-10/drivers/scsi/megaraid/megaraid_ioctl.h            |    2 
 sem-10/drivers/scsi/qla2xxx/qla_def.h                    |    2 
 sem-10/drivers/scsi/scsi_scan.c                          |    2 
 sem-10/drivers/scsi/scsi_transport_spi.c                 |    2 
 sem-10/drivers/serial/mcfserial.c                        |    2 
 sem-10/drivers/serial/pmac_zilog.c                       |    2 
 sem-10/drivers/usb/atm/usb_atm.h                         |    2 
 sem-10/drivers/usb/class/usb-midi.c                      |    2 
 sem-10/drivers/usb/core/hub.c                            |    2 
 sem-10/drivers/usb/media/ov511.c                         |    2 
 sem-10/drivers/usb/media/pwc/pwc.h                       |    2 
 sem-10/drivers/usb/media/sn9c102.h                       |    2 
 sem-10/drivers/usb/media/w9968cf.h                       |    2 
 sem-10/drivers/usb/net/kaweth.c                          |    2 
 sem-10/drivers/usb/serial/io_ti.c                        |    2 
 sem-10/drivers/usb/serial/ti_usb_3410_5052.c             |    2 
 sem-10/drivers/w1/w1.h                                   |    2 
 sem-10/fs/cramfs/inode.c                                 |    2 
 sem-10/fs/eventpoll.c                                    |    2 
 sem-10/fs/isofs/compress.c                               |    2 
 sem-10/fs/jffs/inode-v23.c                               |    2 
 sem-10/fs/jffs/intrep.c                                  |    2 
 sem-10/fs/jffs2/compr_zlib.c                             |    2 
 sem-10/fs/locks.c                                        |    2 
 sem-10/fs/ntfs/inode.h                                   |    2 
 sem-10/fs/partitions/devfs.c                             |    2 
 sem-10/fs/reiserfs/journal.c                             |    2 
 sem-10/fs/reiserfs/xattr.c                               |    2 
 sem-10/fs/sysfs/file.c                                   |    2 
 sem-10/fs/xfs/linux-2.6/mutex.h                          |    2 
 sem-10/fs/xfs/linux-2.6/sema.h                           |    2 
 sem-10/include/asm-i386/mmu.h                            |    2 
 sem-10/include/asm-ia64/sn/nodepda.h                     |    2 
 sem-10/include/asm-ppc/ocp.h                             |    2 
 sem-10/include/asm-sh/dma.h                              |    2 
 sem-10/include/asm-x86_64/mmu.h                          |    2 
 sem-10/include/linux/cpu.h                               |    2 
 sem-10/include/linux/devfs_fs_kernel.h                   |    2 
 sem-10/include/linux/device.h                            |    2 
 sem-10/include/linux/fs.h                                |    2 
 sem-10/include/linux/i2c.h                               |    2 
 sem-10/include/linux/i2o.h                               |    2 
 sem-10/include/linux/ide.h                               |    2 
 sem-10/include/linux/if_pppox.h                          |    2 
 sem-10/include/linux/jbd.h                               |    2 
 sem-10/include/linux/jffs2_fs_i.h                        |    2 
 sem-10/include/linux/jffs2_fs_sb.h                       |    2 
 sem-10/include/linux/lp.h                                |    2 
 sem-10/include/linux/mtd/blktrans.h                      |    2 
 sem-10/include/linux/mtd/doc2000.h                       |    2 
 sem-10/include/linux/parport.h                           |    2 
 sem-10/include/linux/raid/md.h                           |    2 
 sem-10/include/linux/sched.h                             |    2 
 sem-10/include/linux/seq_file.h                          |    2 
 sem-10/include/linux/syscalls.h                          |    2 
 sem-10/include/linux/udf_fs_sb.h                         |    2 
 sem-10/include/sound/core.h                              |    2 
 sem-10/include/sound/rawmidi.h                           |    2 
 sem-10/ipc/compat.c                                      |    2 
 sem-10/kernel/cpu.c                                      |    2 
 sem-10/kernel/cpuset.c                                   |    2 
 sem-10/kernel/kthread.c                                  |    2 
 sem-10/kernel/module.c                                   |    2 
 sem-10/kernel/posix-timers.c                             |    2 
 sem-10/kernel/profile.c                                  |    2 
 sem-10/kernel/stop_machine.c                             |    2 
 sem-10/lib/reed_solomon/reed_solomon.c                   |    2 
 sem-10/net/core/flow.c                                   |    2 
 sem-10/net/ipv4/ipcomp.c                                 |    2 
 sem-10/net/ipv4/netfilter/arp_tables.c                   |    2 
 sem-10/net/ipv4/netfilter/ip_tables.c                    |    2 
 sem-10/net/ipv6/ipcomp6.c                                |    2 
 sem-10/net/ipv6/netfilter/ip6_tables.c                   |    2 
 sem-10/security/selinux/hooks.c                          |    2 
 sem-10/security/selinux/selinuxfs.c                      |    2 
 sem-10/security/selinux/ss/conditional.c                 |    2 
 sem-10/security/selinux/ss/services.c                    |    2 
 sem-10/sound/arm/sa11xx-uda1341.c                        |    2 
 sem-10/sound/core/memalloc.c                             |    2 
 sem-10/sound/core/seq/seq_midi.c                         |    2 
 sem-10/sound/oss/aci.c                                   |    2 
 sem-10/sound/oss/dmasound/dmasound_awacs.c               |    2 
 sem-10/sound/oss/via82cxxx_audio.c                       |    2 
 sem-10/sound/oss/vwsnd.c                                 |    2 
 sem-20/arch/i386/kernel/Makefile                         |    1 
 sem-20/arch/i386/kernel/rwlock.c                         |   50 ++
 sem-20/arch/i386/kernel/semaphore.c                      |   33 -
 sem-30/Makefile                                          |    2 
 sem-30/arch/alpha/kernel/Makefile                        |    2 
 sem-30/arch/alpha/kernel/alpha_ksyms.c                   |    9 
 sem-30/arch/alpha/kernel/semaphore.c                     |  224 ------------
 sem-30/arch/arm/kernel/Makefile                          |    2 
 sem-30/arch/arm/kernel/semaphore.c                       |  219 ------------
 sem-30/arch/arm26/kernel/Makefile                        |    2 
 sem-30/arch/arm26/kernel/semaphore.c                     |  222 ------------
 sem-30/arch/cris/kernel/Makefile                         |    2 
 sem-30/arch/cris/kernel/crisksyms.c                      |    6 
 sem-30/arch/cris/kernel/semaphore.c                      |  130 -------
 sem-30/arch/frv/kernel/Makefile                          |    2 
 sem-30/arch/frv/kernel/semaphore.c                       |  156 --------
 sem-30/arch/h8300/kernel/Makefile                        |    2 
 sem-30/arch/h8300/kernel/semaphore.c                     |  133 -------
 sem-30/arch/i386/kernel/Makefile                         |    2 
 sem-30/arch/i386/kernel/i386_ksyms.c                     |    4 
 sem-30/arch/i386/kernel/semaphore.c                      |  264 ---------------
 sem-30/arch/ia64/kernel/Makefile                         |    2 
 sem-30/arch/ia64/kernel/ia64_ksyms.c                     |    6 
 sem-30/arch/ia64/kernel/semaphore.c                      |  165 ---------
 sem-30/arch/m32r/kernel/Makefile                         |    2 
 sem-30/arch/m32r/kernel/m32r_ksyms.c                     |    4 
 sem-30/arch/m32r/kernel/semaphore.c                      |  186 ----------
 sem-30/arch/m68k/kernel/Makefile                         |    2 
 sem-30/arch/m68k/kernel/m68k_ksyms.c                     |    5 
 sem-30/arch/m68k/kernel/semaphore.c                      |  133 -------
 sem-30/arch/m68k/lib/Makefile                            |    2 
 sem-30/arch/m68k/lib/semaphore.S                         |   53 ---
 sem-30/arch/m68knommu/kernel/Makefile                    |    2 
 sem-30/arch/m68knommu/kernel/m68k_ksyms.c                |    5 
 sem-30/arch/m68knommu/kernel/semaphore.c                 |  134 -------
 sem-30/arch/m68knommu/lib/Makefile                       |    2 
 sem-30/arch/m68knommu/lib/semaphore.S                    |   67 ---
 sem-30/arch/mips/kernel/Makefile                         |    2 
 sem-30/arch/mips/kernel/semaphore.c                      |  164 ---------
 sem-30/arch/parisc/kernel/Makefile                       |    2 
 sem-30/arch/parisc/kernel/parisc_ksyms.c                 |    5 
 sem-30/arch/parisc/kernel/semaphore.c                    |  102 -----
 sem-30/arch/ppc/kernel/Makefile                          |    2 
 sem-30/arch/ppc/kernel/ppc_ksyms.c                       |    3 
 sem-30/arch/ppc/kernel/semaphore.c                       |  131 -------
 sem-30/arch/ppc64/kernel/Makefile                        |    2 
 sem-30/arch/ppc64/kernel/semaphore.c                     |  136 -------
 sem-30/arch/s390/kernel/Makefile                         |    2 
 sem-30/arch/s390/kernel/s390_ksyms.c                     |    7 
 sem-30/arch/s390/kernel/semaphore.c                      |  108 ------
 sem-30/arch/sh/kernel/Makefile                           |    2 
 sem-30/arch/sh/kernel/semaphore.c                        |  139 -------
 sem-30/arch/sh/kernel/sh_ksyms.c                         |    6 
 sem-30/arch/sh64/kernel/Makefile                         |    2 
 sem-30/arch/sh64/kernel/semaphore.c                      |  140 -------
 sem-30/arch/sh64/kernel/sh_ksyms.c                       |    3 
 sem-30/arch/sparc/kernel/Makefile                        |    2 
 sem-30/arch/sparc/kernel/semaphore.c                     |  155 --------
 sem-30/arch/sparc/kernel/sparc_ksyms.c                   |    5 
 sem-30/arch/sparc64/kernel/Makefile                      |    2 
 sem-30/arch/sparc64/kernel/semaphore.c                   |  251 --------------
 sem-30/arch/sparc64/kernel/sparc64_ksyms.c               |    6 
 sem-30/arch/um/sys-i386/ksyms.c                          |    6 
 sem-30/arch/v850/kernel/Makefile                         |    2 
 sem-30/arch/v850/kernel/semaphore.c                      |  166 ---------
 sem-30/arch/v850/kernel/v850_ksyms.c                     |    6 
 sem-30/arch/x86_64/kernel/Makefile                       |    2 
 sem-30/arch/x86_64/kernel/semaphore.c                    |  180 ----------
 sem-30/arch/x86_64/kernel/x8664_ksyms.c                  |    4 
 sem-30/arch/x86_64/lib/thunk.S                           |   16 
 sem-30/include/asm-alpha/semaphore.h                     |  153 --------
 sem-30/include/asm-arm/semaphore.h                       |  106 ------
 sem-30/include/asm-arm26/semaphore.h                     |  103 -----
 sem-30/include/asm-cris/semaphore.h                      |  142 --------
 sem-30/include/asm-frv/semaphore.h                       |  161 ---------
 sem-30/include/asm-h8300/semaphore-helper.h              |   86 ----
 sem-30/include/asm-h8300/semaphore.h                     |  194 -----------
 sem-30/include/asm-i386/semaphore.h                      |  194 -----------
 sem-30/include/asm-ia64/semaphore.h                      |  102 -----
 sem-30/include/asm-m32r/semaphore.h                      |  205 -----------
 sem-30/include/asm-m68k/semaphore.h                      |  167 ---------
 sem-30/include/asm-m68knommu/semaphore.h                 |  157 --------
 sem-30/include/asm-mips/semaphore.h                      |  112 ------
 sem-30/include/asm-parisc/semaphore.h                    |  147 --------
 sem-30/include/asm-ppc/semaphore.h                       |  111 ------
 sem-30/include/asm-ppc64/semaphore.h                     |   98 -----
 sem-30/include/asm-s390/semaphore.h                      |  110 ------
 sem-30/include/asm-sh/semaphore.h                        |  119 ------
 sem-30/include/asm-sh64/semaphore.h                      |  123 ------
 sem-30/include/asm-sparc/semaphore.h                     |  196 -----------
 sem-30/include/asm-sparc64/semaphore.h                   |   57 ---
 sem-30/include/asm-um/semaphore.h                        |    6 
 sem-30/include/asm-v850/semaphore.h                      |   88 -----
 sem-30/include/asm-x86_64/semaphore.h                    |  196 -----------
 sem-30/include/linux/semaphore.h                         |  147 ++++++++
 sem-30/kernel/Makefile                                   |    3 
 sem-30/kernel/semaphore.c                                |  179 ++++++++++
 336 files changed, 659 insertions(+), 7315 deletions(-)
