Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314649AbSD1AGG>; Sat, 27 Apr 2002 20:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314650AbSD1AGF>; Sat, 27 Apr 2002 20:06:05 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:41963 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S314649AbSD1AF5>; Sat, 27 Apr 2002 20:05:57 -0400
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: zisofs data corruption in 2.4.19-pre7-ac2
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 28 Apr 2002 02:03:50 +0200
Message-ID: <qwwu1pw4rkp.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Alan,

I think I discovered an obscure bug in zisofs in 2.4.19-pre7-ac2. It
manifests thus:

$ mkzftree -F 7x14.pbm data
$ mkisofs -z -R -o data.iso data 
$ mount -o loop data.iso /mnt/cdimage
$ cat /mnt/cdimage/7x14.pbm
cat: data: Input/output error

and the following (single) line gets logged:
zisofs: zisofs_inflate returned 3, inode = 47342, index = 0, fpage = 0,
  xpage = 0, avail_in = 0, avail_out = 1890, ai = 2024, ao = 4096

The very same iso image works fine in 2.4.19-pre7. Since the files are
tiny I am attaching 7x14.pbm, data.iso (gzippped) and my .config.

I have zisofs-tools-1.0.3, and tested with both mkisofs from
cdrtools-1.11a09 with patch from zisofs' source tree and the one from
cdrtools-1.11a21 (which already supports zisofs).

The bug shows up only with a few files in my tree (about one in
thousand). More info and testing available upon request.

                                                Regards, Petr


--=-=-=
Content-Disposition: attachment; filename=config-2.4.19-pre7-ac2
Content-Description: Kernel config

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

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
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_IKCONFIG is not set
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=m
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set

#
# Wireless Pcmcia cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_AIRO_CS is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRCOM is not set
CONFIG_PCMCIA_XIRTULIP=y
CONFIG_NET_PCMCIA_RADIO=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_NETWAVE is not set
CONFIG_PCMCIA_WAVELAN=m
# CONFIG_AIRONET4500_CS is not set

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
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=y
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
CONFIG_SOUND_MAESTRO=m
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
CONFIG_USB_USBNET=m

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--=-=-=
Content-Type: image/x-portable-bitmap
Content-Disposition: attachment; filename=7x14.pbm
Content-Transfer-Encoding: base64
Content-Description: The bug trigger

iVBORw0KGgoAAAANSUhEUgAAAx4AAAAcAQAAAADHYVQFAAAIZUlEQVR4nGJgYAxggIAGBhYO
BgWHBiYGagMAAAAA//9i2sIY08enIMHApIAuxcXAwMDQ4MHAwMDAgCGJFcg1fDiAzYkAAAAA
//9iuhC/4hcTAw8jhjFMDCICJw4w2DAwMDAwMDPJ1XH+eP68n4GBgYH5cJuNzcffn0/4tzs1
cgmf77ez+c8lpOGx/xODYsJ/BgUGFoYEDiZGBwMGqAMBAAAA//9iqmGMZmBgYGBoQLFBIIGB
gYEhMzGBsY6BgYGBQbGFuUWAU9LxYAMDCyNj4uFnbDPYBRM+VzMxTGCMPJjMJsTAwMBwiOEA
44f/DQwMDAwGDAwMDA9gpgEAAAD//2Jq6V/KxsDwhWE/wivMCVBVMhwMDAwsHAwMDCxHGJgE
GBkUGFgYWP43sLbXM/xhYGBgYGBhYITp+uPAyMDw7wPEtR8Y/v1HOBkAAAD//2JiYIz49U/m
BcN+B7gY546/Lz4wMHzT+r+BofG/IAMDA4PDjwcsDB8Y/jhwSXD+2KPYwPgP4lIOhgsMDAwM
/xgYGBj+NjE8YGBg4OezKfjAvLiNmYXh0uPTfetsbnIAAAAA//9iqmVf0rjpCIMAUnipvPPW
YGhgYLi2x34BA8NPiCCjiILEA/vGbwz8HA8cGKQYGB4eYG9gEGD438DAwPCB4b/Af6gBjM1s
ktKJC/f8Y2G4aZh4mJlNgwEAAAD//wTBMQqDMBiA0S9VsFvAXdQbdOqcrYfo4kXEDILX8CiC
F3AVpDiJ4z8Zh2j63qNV3/WjCaXT0ejuvGvWJUVVFtjLCY43J8AW1EvVfi8Q9Aa5mS1CPyQm
WwCuGACR+7x6D08CPsgP/gAAAP//NNIhFgFRFADQOz8NhSXImqhNZC+TtGnjHNECRMUGrEC2
AUUwRR7FfMF5kruGm2I4Hb6NOtabWI5S16TZsCpuR8zviwvjq7JoJVUUuzNdnnoFVGQen/3z
jW1b6jFBz799ZH4AAAD//2KqYYxgOMDGMAURTQx/F/z3YGD4x3CtIeICAwM7RJDFoZSBgUGA
ReI9h0J9AwMkOyj8YWBgYPj2z4Hh/wKYbkYGBgaO/w4MDDcg/DcMDAAAAAD//0zQsRFAQBBA
0b83G1wguFJUwBqN6EDOjLlApBJlKEUHhAJjBRKvhBfmfqUd+KsnpCOAZHM5KGluixQIspwX
NpqgYPDAjjuAbul7TSFGz3ADKlSaXgAAAP//YjJgjGD428CQY4Gw5GATw/4NDAwMDE+eGzAw
/PnxgGHB/971v/4/v/Df9hvDH8aG/wekfmX8+O/AW8VQw/B/wb+GX/9f/F/AIA8Jn7+/nr9g
PsA74V/Og//zbRl+fb4AAAAA//9c1KEVgDAQBNF/vBORRwcpJYICKCmCwlGQBytn9CxxRk6M
2DR9xDqGwkU5fNhvbyqVj81uh2biBgAA//9iYGBaAVOLYQkDAwODBwODAgMLpsnIoAFKy7F8
YH/AwMDAwMB8gIEPYQkAAAD//yIKOTi2OTAwMDg4NrAwcTAwTmRkk2Rg4GhoZiCywAYAAAD/
/2JiYGBgYGwxcIBwKyY+PMDAYMOQwNjMyMDAwAARfuB42JOHgeGB45E6Jh4NxvONzLwqDAwH
GzuhlvDAjQvAagkAAAD//4LYxMKxhMGBgUGQo2WSkAIDg1PNBCaXJgY5BoaDDRwCSQwMDAwM
QnIVUOUfkCgHAwfFNgchqC8lGBQhvmRoaGZgcYCbDwAAAP//YkLoZGz4ybCnYP8BBgaLFoZ/
f5gYeBgYGg8ILNygkHCwme0XF+/v7+/Pz7ermS18vF/OhlFLRCNgIoPEA8XDnr/gvjSE+JLj
YGMnC4MHzBIAAAAA//+C+YSDgZEpoIvDgNlIgYEhjSGBoZmBQYuBwcmBU0hFYaKSS6eQRysT
CwcTC4dAu4hGwEIniCU1qAYxcEAoAURQMzAwMAAAAAD//2Jy6RLRP8DA8IPB6cD+KgYJhgeO
DgwMDAsYaxsYGBgY/nsxMHx5WPnpyfF+aOHOACkSGZoYGBgYfh5j+Pj4eL+cXcXHx8fbeCQM
ih4f75ezYXgkohGwUKYFZgkAAAD//2JiYGD4eICBgYGBKeGX9A8bhv+ODgwiDAyOLAyCDAIM
/6sZmQIUGBgYGBjMoDoYExgYGBgYDkF4mpKGiQebuXklDRP3/PjwQNAw8WAzG6MFAwMDAxvc
JwAAAAD//2JhkBf428Twh4GB4WlTNcMRhv/Jv+XeMDAw7rcV/PCBYfH9Q2wd/B///PjwYLnl
xy8vNjcx/F9wjoGBgeGJ4isGhl8M1/UsCh8duQArLyA1lcFPBgaGDw8ewSwBAAAA//9iefJ/
Qdw/JpY/DAy/26RfvmBQ3q6a9IyBca0AA8MHBgZZRhcPkd/8XCIagQwM/Ewsv+A544UiAwMD
A8Ofiadc1XzFGD7++XHZCSZ3wfMVAwMjIgsDAAAA//9iYmBMgMUQYyrDjf9zpT8yMDD8D4CJ
ubLA1KJmewkGBgYGBitGx0YmFg5JBnZeSQe43B8GBgaGH4g6HgAAAP//YnrB+B7qAtWCBoYa
Boe/DQx3GBgYoE0i5k5BFQUU0xlYHjAwMDDIODAwMDAcYRBQcGhkYmThEFBAWMLioODQyKIg
AOMDAAAA//9iYljxt/sAAwMDw7/ZBxgYvvy/8P8Awy8Gxg0MDL8YGBQYWP+yboEUj2xffn5+
fna2WU7G//n2tb9s08/Pt29g2Hx+vn3tr6+fn5+f7zvbLOfF//n2tb/00+fb1377dQNmCQAA
AP//YmBgYFFgYuFAKkthQIALWrlBk6IAiiyqcixyKg4TYHwAAAAA//9iYmD4v+B/gwYsYaCE
C9SSL9gMQnMQptAXSEOGgYGBAQAAAP//AwAt+i2ubQONAwAAAABJRU5ErkJggg==
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=data.iso.gz
Content-Transfer-Encoding: base64
Content-Description: The bug trigger (iso image)

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
--=-=-=

-- 
No chinese, no fortune.

--=-=-=--
