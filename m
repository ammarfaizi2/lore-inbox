Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132618AbRDBHbc>; Mon, 2 Apr 2001 03:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132619AbRDBHbY>; Mon, 2 Apr 2001 03:31:24 -0400
Received: from mailgate.bridgetrading.com ([62.49.201.178]:4359 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S132618AbRDBHbK>; Mon, 2 Apr 2001 03:31:10 -0400
From: "Chris Funderburg" <chris@directcommunications.net>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: memcpy in 2.2.19
Date: Mon, 2 Apr 2001 08:32:14 +0100
Message-ID: <CHEEIAEEAIFDOCGJIAKPCEKFCJAA.chris@directcommunications.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0047_01C0BB4F.6B686C70"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.96.1010330035203.8826H-100000@mandrakesoft.mandrakesoft.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0047_01C0BB4F.6B686C70
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

My head hurts.  I tried the latest aic patch.  Tried it on another machine,
same version of compiler though.  (Redhat gcc 2.96 20000731) - I then
tried one of the gcc snapshots, but that won't compile _at all_.

Oddly enough, the problem also occurs in reiserfs.

I've attached a copy of my .config if anyone wants to try it for
themselves...

cc -D__KERNEL__ -I/usr/src/linux/include -E -C -P -I/usr/src/linux/include -
imacros /usr/src/linux/include/asm-i386/page_offset.h -Ui386
arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a
drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
drivers/pci/pci.a drivers/pnp/pnp.a drivers/video/video.a \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/filesystems.a(reiserfs.o): In function `ip_check_balance':
reiserfs.o(.text+0xa45e): undefined reference to `memset'
drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'
make: *** [vmlinux] Error 1



-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: 30 March 2001 11:00
To: Chris Funderburg
Cc: Linux-Kernel
Subject: Re: memcpy in 2.2.19


On Fri, 30 Mar 2001, Chris Funderburg wrote:
> What's wrong with this picture:
> ld -m elf_i386 -T /usr/src/kernel/stable/linux/arch/i386/vmlinux.lds -e
[...]
>         -o vmlinux
> drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
> aic7xxx.o(.text+0x116bf): undefined reference to `memcpy'
> make: *** [vmlinux] Error 1
>
> Is this something outside the kernel tree that I've lost?  Seems a bit
weird
> since memcpy must be
> used in thousands of other place.

It's even more strange because memcpy is not called at all from that
routine.  <insert Twilight Zone music>

Generally when this occurs, someone is using a gcc feature to copy a
structure, instead of calling memcpy directly.  Since the kernel is
sometimes compiled with -fno-builtins, and since we also have our own
kernel memcpy, using this particular gcc feature often runs into
problems.

It's not obvious from the code that this is going on, but it's one
possible cause.

Can you try the new aic7xxx driver?  Just search any linux-kernel mail
archive for Justin Gibbs, he is always [re-]posting the link to the
latest aic7xxx driver.  AFAIK it has kernel compatibility and thus
supports 2.2.x...

	Jeff



------=_NextPart_000_0047_01C0BB4F.6B686C70
Content-Type: application/octet-stream;
	name="my.config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="my.config"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
CONFIG_M686=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_MICROCODE=3Dy=0A=
CONFIG_X86_MSR=3Dy=0A=
# CONFIG_X86_CPUID is not set=0A=
CONFIG_1GB=3Dy=0A=
# CONFIG_2GB is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_SMP is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_QUIRKS=3Dy=0A=
CONFIG_PCI_OPTIMIZE=3Dy=0A=
CONFIG_PCI_OLD_PROC=3Dy=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_VISWS is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_BINFMT_AOUT=3Dm=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
# CONFIG_BINFMT_JAVA is not set=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
# CONFIG_APM is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
CONFIG_PNP_PARPORT=3Dm=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
CONFIG_BLK_DEV_IDE=3Dm=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dm=0A=
CONFIG_BLK_DEV_IDECD=3Dm=0A=
CONFIG_BLK_DEV_IDETAPE=3Dm=0A=
CONFIG_BLK_DEV_IDEFLOPPY=3Dm=0A=
# CONFIG_BLK_DEV_IDESCSI is not set=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_VIA82C586 is not set=0A=
# CONFIG_BLK_DEV_CMD646 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
=0A=
#=0A=
# Additional Block Devices=0A=
#=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
CONFIG_BLK_DEV_NBD=3Dy=0A=
CONFIG_BLK_DEV_MD=3Dy=0A=
# CONFIG_MD_LINEAR is not set=0A=
CONFIG_MD_STRIPED=3Dy=0A=
# CONFIG_MD_MIRRORING is not set=0A=
CONFIG_MD_RAID5=3Dy=0A=
CONFIG_MD_BOOT=3Dy=0A=
CONFIG_BLK_DEV_RAM=3Dm=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
CONFIG_PARIDE_PARPORT=3Dm=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_NETLINK=3Dy=0A=
CONFIG_RTNETLINK=3Dy=0A=
CONFIG_NETLINK_DEV=3Dy=0A=
CONFIG_FIREWALL=3Dy=0A=
CONFIG_FILTER=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_RTNETLINK=3Dy=0A=
CONFIG_NETLINK=3Dy=0A=
CONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0A=
CONFIG_IP_ROUTE_TOS=3Dy=0A=
CONFIG_IP_ROUTE_VERBOSE=3Dy=0A=
# CONFIG_IP_ROUTE_LARGE_TABLES is not set=0A=
CONFIG_IP_ROUTE_NAT=3Dy=0A=
# CONFIG_IP_PNP is not set=0A=
CONFIG_IP_FIREWALL=3Dy=0A=
# CONFIG_IP_FIREWALL_NETLINK is not set=0A=
# CONFIG_IP_ROUTE_FWMARK is not set=0A=
CONFIG_IP_TRANSPARENT_PROXY=3Dy=0A=
CONFIG_IP_MASQUERADE=3Dy=0A=
=0A=
#=0A=
# Protocol-specific masquerading support will be built as modules.=0A=
#=0A=
CONFIG_IP_MASQUERADE_ICMP=3Dy=0A=
=0A=
#=0A=
# Protocol-specific masquerading support will be built as modules.=0A=
#=0A=
# CONFIG_IP_MASQUERADE_MOD is not set=0A=
# CONFIG_IP_ROUTER is not set=0A=
CONFIG_NET_IPIP=3Dm=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
CONFIG_IP_ALIAS=3Dy=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
=0A=
#=0A=
# (it is safe to leave these untouched)=0A=
#=0A=
CONFIG_INET_RARP=3Dy=0A=
CONFIG_SKB_LARGE=3Dy=0A=
# CONFIG_IPV6 is not set=0A=
=0A=
#=0A=
#  =0A=
#=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
# CONFIG_CPU_IS_SLOW is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
# CONFIG_PHONE_IXJ is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
CONFIG_CHR_DEV_ST=3Dy=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
# CONFIG_BLK_DEV_SR_VENDOR is not set=0A=
# CONFIG_CHR_DEV_SG is not set=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dy=0A=
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=3Dy=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D24=0A=
CONFIG_AIC7XXX_PROC_STATS=3Dy=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
# CONFIG_I2O_PCI is not set=0A=
# CONFIG_I2O_BLOCK is not set=0A=
# CONFIG_I2O_SCSI is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
CONFIG_BONDING=3Dm=0A=
# CONFIG_EQUALIZER is not set=0A=
CONFIG_ETHERTAP=3Dm=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
# CONFIG_EL1 is not set=0A=
# CONFIG_EL2 is not set=0A=
# CONFIG_ELPLUS is not set=0A=
# CONFIG_EL16 is not set=0A=
CONFIG_EL3=3Dm=0A=
# CONFIG_3C515 is not set=0A=
CONFIG_VORTEX=3Dm=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_RTL8139 is not set=0A=
# CONFIG_RTL8139TOO is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_EISA=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_LP486E is not set=0A=
# CONFIG_CS89x0 is not set=0A=
# CONFIG_DM9102 is not set=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_DEC_ELCP is not set=0A=
# CONFIG_DEC_ELCP_OLD is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_EEXPRESS_PRO100=3Dy=0A=
# CONFIG_LNE390 is not set=0A=
# CONFIG_NE3210 is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_ES3210 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_ZNET is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
CONFIG_PLIP=3Dm=0A=
CONFIG_PPP=3Dy=0A=
=0A=
#=0A=
# CCP compressors for PPP will also be built in.=0A=
#=0A=
CONFIG_SLIP=3Dm=0A=
# CONFIG_SLIP_COMPRESSED is not set=0A=
CONFIG_SLIP_SMART=3Dy=0A=
# CONFIG_SLIP_MODE_SLIP6 is not set=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_HOSTESS_SV11 is not set=0A=
# CONFIG_COSA is not set=0A=
# CONFIG_SEALEVEL_4021 is not set=0A=
# CONFIG_SYNCLINK_SYNCPPP is not set=0A=
# CONFIG_LANMEDIA is not set=0A=
# CONFIG_COMX is not set=0A=
# CONFIG_HDLC is not set=0A=
# CONFIG_DLCI is not set=0A=
# CONFIG_XPEED is not set=0A=
# CONFIG_SBNI is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_SERIAL=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
CONFIG_SERIAL_EXTENDED=3Dy=0A=
CONFIG_SERIAL_MANY_PORTS=3Dy=0A=
CONFIG_SERIAL_SHARE_IRQ=3Dy=0A=
CONFIG_SERIAL_DETECT_IRQ=3Dy=0A=
CONFIG_SERIAL_MULTIPORT=3Dy=0A=
# CONFIG_HUB6 is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
# CONFIG_PRINTER is not set=0A=
CONFIG_MOUSE=3Dy=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_ATIXL_BUSMOUSE is not set=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MS_BUSMOUSE is not set=0A=
CONFIG_PSMOUSE=3Dy=0A=
# CONFIG_82C710_MOUSE is not set=0A=
# CONFIG_PC110_PAD is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_JOYSTICK is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dy=0A=
CONFIG_INTEL_RNG=3Dy=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
# CONFIG_AGP_I810 is not set=0A=
# CONFIG_AGP_VIA is not set=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_ALI is not set=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
# CONFIG_DTLK is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Filesystems=0A=
#=0A=
CONFIG_QUOTA=3Dy=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
CONFIG_REISERFS_FS=3Dy=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
CONFIG_FAT_FS=3Dm=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_UMSDOS_FS is not set=0A=
CONFIG_VFAT_FS=3Dm=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_CODA_FS=3Dm=0A=
CONFIG_NFS_FS=3Dm=0A=
CONFIG_NFS_V3=3Dy=0A=
CONFIG_NFSD=3Dm=0A=
CONFIG_NFSD_V3=3Dy=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_SUNRPC=3Dm=0A=
CONFIG_LOCKD=3Dm=0A=
CONFIG_SMB_FS=3Dm=0A=
# CONFIG_SMB_NLS_DEFAULT is not set=0A=
# CONFIG_NCP_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
# CONFIG_SMD_DISKLABEL is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
CONFIG_NLS_CODEPAGE_737=3Dm=0A=
CONFIG_NLS_CODEPAGE_775=3Dm=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
CONFIG_NLS_CODEPAGE_852=3Dm=0A=
CONFIG_NLS_CODEPAGE_855=3Dm=0A=
CONFIG_NLS_CODEPAGE_857=3Dm=0A=
CONFIG_NLS_CODEPAGE_860=3Dm=0A=
CONFIG_NLS_CODEPAGE_861=3Dm=0A=
CONFIG_NLS_CODEPAGE_862=3Dm=0A=
CONFIG_NLS_CODEPAGE_863=3Dm=0A=
CONFIG_NLS_CODEPAGE_864=3Dm=0A=
CONFIG_NLS_CODEPAGE_865=3Dm=0A=
CONFIG_NLS_CODEPAGE_866=3Dm=0A=
CONFIG_NLS_CODEPAGE_869=3Dm=0A=
CONFIG_NLS_CODEPAGE_874=3Dm=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
CONFIG_NLS_ISO8859_2=3Dm=0A=
CONFIG_NLS_ISO8859_3=3Dm=0A=
CONFIG_NLS_ISO8859_4=3Dm=0A=
CONFIG_NLS_ISO8859_5=3Dm=0A=
CONFIG_NLS_ISO8859_6=3Dm=0A=
CONFIG_NLS_ISO8859_7=3Dm=0A=
CONFIG_NLS_ISO8859_8=3Dm=0A=
CONFIG_NLS_ISO8859_9=3Dm=0A=
CONFIG_NLS_ISO8859_14=3Dm=0A=
CONFIG_NLS_ISO8859_15=3Dm=0A=
CONFIG_NLS_KOI8_R=3Dm=0A=
# CONFIG_NLS_KOI8_RU is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_FB=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
# CONFIG_FB_PM2 is not set=0A=
CONFIG_FB_ATY=3Dy=0A=
CONFIG_FB_VESA=3Dy=0A=
CONFIG_FB_VGA16=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
CONFIG_FBCON_ADVANCED=3Dy=0A=
# CONFIG_FBCON_MFB is not set=0A=
# CONFIG_FBCON_CFB2 is not set=0A=
# CONFIG_FBCON_CFB4 is not set=0A=
CONFIG_FBCON_CFB8=3Dy=0A=
CONFIG_FBCON_CFB16=3Dy=0A=
CONFIG_FBCON_CFB24=3Dy=0A=
CONFIG_FBCON_CFB32=3Dy=0A=
# CONFIG_FBCON_AFB is not set=0A=
# CONFIG_FBCON_ILBM is not set=0A=
# CONFIG_FBCON_IPLAN2P2 is not set=0A=
# CONFIG_FBCON_IPLAN2P4 is not set=0A=
# CONFIG_FBCON_IPLAN2P8 is not set=0A=
# CONFIG_FBCON_MAC is not set=0A=
CONFIG_FBCON_VGA_PLANES=3Dy=0A=
# CONFIG_FBCON_VGA is not set=0A=
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set=0A=
CONFIG_FBCON_FONTS=3Dy=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
# CONFIG_FONT_SUN8x16 is not set=0A=
# CONFIG_FONT_SUN12x22 is not set=0A=
# CONFIG_FONT_6x11 is not set=0A=
# CONFIG_FONT_PEARL_8x8 is not set=0A=
# CONFIG_FONT_ACORN_8x8 is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=

------=_NextPart_000_0047_01C0BB4F.6B686C70--

