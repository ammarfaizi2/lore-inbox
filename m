Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286899AbRL1NOJ>; Fri, 28 Dec 2001 08:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286898AbRL1NOD>; Fri, 28 Dec 2001 08:14:03 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:17426 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S286899AbRL1NN4>; Fri, 28 Dec 2001 08:13:56 -0500
Message-Id: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
Date: Fri, 28 Dec 2001 13:11:42 +0000
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
From: Roy Hills <linux-kernel-l@nta-monitor.com>
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <20011228121228.GA9920@emma1.emma.line.org>
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
 <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:12 28/12/01 +0100, Matthias Andree wrote:
>On Fri, 28 Dec 2001, Roy Hills wrote:
>
> > I'm using linux kernel 2.2.20 on my systems.  This works fine as a
> > bzImage which most of my systems use, however one of my systems
> > (a Toshiba Tecra laptop) needs to use zImage, and I find that 2.2.20
> > does not work in this case, although previous versions e.g. 2.2.17 do.
>
>Did your kernel grow (configuration change)? zImage has tighter size
>limits than bzImage. Did you actually make zImage or did you just to
>make? The (b)zImage is in arch/i386/boot/

I didn't make any significant configuration changes.  I ran "make oldconfig"
against my .config file for the tecra, and answered "n" to most of the new
questions (the only exception being "CONFIG_TOSHIBA" which I set to "y"
because that seemed the right thing to do).

My sequence of commands was:

make oldconfig
make dep
make clean
make zImage
scp arch/i386/boot/zImage <target-kernel>
scp System.map <target-sysmap>

Note that I build the kernels on a separate machine, hence the "scp" to
copy the kernel & sysmap to the target system.

The old 2.2.17 zImage kernel that runs fine has a filesize of 462060 bytes and
reports 784k kernel code, 412k reserved, 1168k data, 36k init.

The new 2.2.20 zImage kernel that fails has a filesize of 482795 bytes.
Actual sizes are not known as the system fails with "out of memory" just
after the decompression of the kernel and before any kernel messages get 
printed.

Just to eliminate the minor increase in size, I built a minimal 2.2.20 zImage
kernel by eliminating all networking and just about everything else not needed
to boot the system.  This minimal kernel had a filesize of 327534 bytes and
failed in exactly the same way with "out of memory" just after decompression.
Also, whenever a kernel has been too big for zImage in the past, the "make 
zImage"
has failed with a sensible error message.  This time, the make succeeded every
time.  I'm therefore pretty sure that it's not purely a size issue.

Note that the actual problem with Toshiba tecra laptops and bzImage files is
a known hardware problem (something to do with the A20 line).  I'm not trying
to address this problem, just why the normal workaround (use zImage rather
than bzImage to keep in conventional memory) doesn't work any more with
2.2.20.

FYI, here are the kernel config files for 2.2.17 (which works fine) and 
2.2.20 (which
doesn't).  I doubt that they'll help, but I've included them just in case.

1.  2.2.17 working .config

#
# Automatically generated make config: don't edit
#

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M686 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
# CONFIG_KMOD is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_OLD_PROC is not set
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PARPORT is not set
CONFIG_APM=y
# CONFIG_APM_DISABLE_BY_DEFAULT is not set
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_IGNORE_SUSPEND_BOUNCE is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_CHIPSETS is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_ALIAS=y
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
CONFIG_PPP=y

#
# CCP compressors for PPP are only built as modules.
#
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
CONFIG_TR=y
# CONFIG_IBMTR is not set
# CONFIG_IBMLS is not set
# CONFIG_IBMOL is not set
# CONFIG_SKTR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_DLCI is not set
# CONFIG_WAN_DRIVERS is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set
# CONFIG_IRDA_OPTIONS is not set
# CONFIG_IRDA_COMPRESSION is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# FIR device drivers
#
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
CONFIG_TOSHIBA_FIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y

#
# Mice
#
# CONFIG_ATIXL_BUSMOUSE is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_MS_BUSMOUSE is not set
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

2.  2.2.20 non-working .config

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M686 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_OLD_PROC is not set
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PARPORT is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
CONFIG_TOSHIBA=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_CHIPSETS is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
CONFIG_PPP=y

#
# CCP compressors for PPP will also be built in.
#
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
CONFIG_TR=y
# CONFIG_IBMTR is not set
# CONFIG_IBMLS is not set
# CONFIG_IBMOL is not set
# CONFIG_SKTR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_DLCI is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y

#
# Mice
#
# CONFIG_ATIXL_BUSMOUSE is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_MS_BUSMOUSE is not set
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_INTEL_RNG is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_RU is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set


Regards,

Roy Hills


--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/

