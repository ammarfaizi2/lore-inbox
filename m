Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbTCMOWN>; Thu, 13 Mar 2003 09:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbTCMOWN>; Thu, 13 Mar 2003 09:22:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2945 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262328AbTCMOWK>; Thu, 13 Mar 2003 09:22:10 -0500
Date: Thu, 13 Mar 2003 09:34:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Trying to build 2.4.20 on another machine
Message-ID: <Pine.LNX.3.95.1030313092659.21462A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What makes `fastdep` fail on some ext2 directories? `realpath()` 
fails, but the directories exist in the source-code tree and
`make dep` is executed by root.

make[1]: Entering directory `/usr/src/linux-2.4.20/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/i386/boot'
scripts/mkdep -- init/*.c > .depend
scripts/mkdep -- `find /usr/src/linux-2.4.20/include/asm /usr/src/linux-2.4.20/include/linux /usr/src/linux-2.4.20/include/scsi /usr/src/linux-2.4.20/include/net /usr/src/linux-2.4.20/include/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name
 \*.h ! -name modversions.h -print` > .hdepend
make _sfdep_kernel _sfdep_drivers _sfdep_mm _sfdep_fs _sfdep_net _sfdep_ipc _sfdep_lib _sfdep_arch/i386/kernel _sfdep_arch/i386/mm _sfdep_arch/i386/lib _FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc lib arch/i386/kernel arch/i386/mm arch/i386/lib"
make[1]: Entering directory `/usr/src/linux-2.4.20'
make -C kernel fastdep
make[2]: Entering directory `/usr/src/linux-2.4.20/kernel'
/usr/src/linux-2.4.20/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -march=i586  -nostdinc -iwithprefix include -- acct.c capability.c c
ontext.c dma.c exec_domain.c exit.c fork.c info.c itimer.c kmod.c ksyms.c module.c panic.c pm.c printk.c ptrace.c resource.c sched.c signal.c softirq.c sys.c sysctl.c time.c timer.c uid16.c user.c > .depend
make[2]: Leaving directory `/usr/src/linux-2.4.20/kernel'
make -C drivers fastdep
make[2]: Entering directory `/usr/src/linux-2.4.20/drivers'
/usr/src/linux-2.4.20/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -march=i586  -nostdinc -iwithprefix include --  > .depend
make _sfdep_acpi _sfdep_atm _sfdep_block _sfdep_bluetooth _sfdep_cdrom _sfdep_char _sfdep_dio _sfdep_fc4 _sfdep_gsc _sfdep_hil _sfdep_hotplug _sfdep_i2c _sfdep_ide _sfdep_ieee1394 _sfdep_input _sfdep_isdn _sfdep_macintosh _sfdep_md _sfdep_media _sfdep_mes
sage/fusion _sfdep_message/i2o _sfdep_misc _sfdep_mtd _sfdep_net _sfdep_net/hamradio _sfdep_nubus _sfdep_parport _sfdep_pci _sfdep_pcmcia _sfdep_pnp _sfdep_sbus _sfdep_scsi _sfdep_sgi _sfdep_sound _sfdep_tc _sfdep_telephony _sfdep_usb _sfdep_video _sfdep_
zorro _FASTDEP_ALL_SUB_DIRS="acpi atm block bluetooth cdrom char dio fc4 gsc hil hotplug i2c ide ieee1394 input isdn macintosh md media message/fusion message/i2o misc mtd net net/hamradio nubus parport pci pcmcia pnp sbus scsi sgi sound tc telephony usb 
video zorro"
make[3]: Entering directory `/usr/src/linux-2.4.20/drivers'
make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux-2.4.20/drivers/acpi'
/usr/src/linux-2.4.20/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -march=i586 -D_LINUX -I/include -nostdinc -iwithprefix include -- ac
pi_ksyms.c driver.c os.c > .depend
realpath(/include) failed, No such file or directory
make[4]: *** [fastdep] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.20/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20'
make: *** [dep-files] Error 2


The machine is an early 586 that runs a linux-2.2.15 kernel and
libc-5.3.12 and  gcc 2.7.2. The last kernel that was
successfully built on that machine was linux-2.4.18 however it
wouldn't run reliably (SCSI crashes) so I've been running 2.2.15
for years.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


