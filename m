Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266277AbRGGOZr>; Sat, 7 Jul 2001 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266290AbRGGOZg>; Sat, 7 Jul 2001 10:25:36 -0400
Received: from [213.128.193.148] ([213.128.193.148]:16909 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S266277AbRGGOZ3>;
	Sat, 7 Jul 2001 10:25:29 -0400
Date: Sat, 7 Jul 2001 18:23:57 +0400
Message-Id: <200107071423.f67ENv707049@linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
In-Reply-To: <E15Iqwk-0005kf-00@the-village.bc.nu>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.6 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>> Seems like its something that appeared between 2.4.5 and 2.4.6.  Anyone
>> know the correct fix, other than reversing the change?
AC> I build with all pcmcia network drivers modular on my test builds, what
AC> am I missing here ?
Well. As you might have noticed - this is build for StrongArm platform
(and that's why I wrote this to SA port maintainer, not to linux-kernel at
first).
This is repeatable, of course, and it is started as of 2.4.6 upgrade:
...
make[2]: Leaving directory `/home/green/arm/cvs/linux/kernel/arch/arm/fastfpe'
make[1]: Leaving directory `/home/green/arm/cvs/linux/kernel/arch/arm/fastfpe'
arm-linux-ld -p -X -T arch/arm/vmlinux.lds arch/arm/kernel/head-armv.o arch/arm/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/arm/kernel/kernel.o arch/arm/mm/mm.o arch/arm/mach-sa1100/sa1100.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/cdrom/driver.o drivers/mtd/mtdlink.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/video/video.o \
        net/network.o \
        arch/arm/fastfpe/fast-math-emu.o arch/arm/nwfpe/math-emu.o arch/arm/lib/lib.a /home/green/arm/cvs/linux/kernel/lib/lib.a /skiff/local/lib/gcc-lib/arm-linux/2.95.2/soft-float/libgcc.a \
        --end-group \
        -o vmlinux
arm-linux-ld: cannot open drivers/net/pcmcia/pcmcia_net.o: No such file or directory
make: *** [vmlinux] Error 1

And Rules.make is almost identical to that in vanilla kernel (if someone is
interested). (almost means that it have rule on how to make .o files from .S)

My .config is below:

CONFIG_ARM=y
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_ARCH_SA1100=y
CONFIG_SA1100_BITSY=y
CONFIG_SA1100_USB=m
CONFIG_SA1100_USB_NETLINK=m
CONFIG_SA1100_USB_CHAR=m
CONFIG_SA1100_REGMON=m
CONFIG_CPU_32=y
CONFIG_CPU_32v4=y
CONFIG_CPU_SA1100=y
CONFIG_DISCONTIGMEM=y
CONFIG_CPU_FREQ=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_SA1100=m
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_FPE_NWFPE=y
CONFIG_FPE_FASTFPE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_CMDLINE="keepinitrd"
CONFIG_ALIGNMENT_TRAP=y
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=1
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_BOOTLDR_PARTS=y
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_CFI_B2=y
CONFIG_MTD_CFI_B4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_SA1100=y
CONFIG_MTD_SA1100_KERNELSIZE=c0000
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_INET_ECN=y
CONFIG_IPV6=m
CONFIG_IPV6_MOBILITY=m
CONFIG_IPV6_MOBILITY_DEBUG=y
CONFIG_IP6_NF_IPTABLES=m
CONFIG_NETDEVICES=y
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_NET_RADIO=y
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_WVLAN=m
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y
CONFIG_SA1100_FIR=m
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_SA1100=y
CONFIG_SERIAL_SA1100_CONSOLE=y
CONFIG_SA1100_DEFAULT_BAUDRATE=115200
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
CONFIG_TOUCHSCREEN_BITSY=m
CONFIG_H3600_STOWAWAY=m
CONFIG_PROFILER=m
CONFIG_MOUSE=m
CONFIG_SA1100_RTC=m
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=1
CONFIG_CRAMFS=m
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=m
CONFIG_NFS_FS=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_PC_KEYMAP=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SA1100=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_FONTWIDTH8_ONLY=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_SOUND=m
CONFIG_SOUND_BITSY_UDA1341=m
CONFIG_SOUND_UDA1341=m
CONFIG_DEBUG_ERRORS=y

Bye,
    Oleg
