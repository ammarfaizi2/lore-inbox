Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbTFZGft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 02:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbTFZGft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 02:35:49 -0400
Received: from outbound04.telus.net ([199.185.220.223]:57054 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S265431AbTFZGfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 02:35:25 -0400
Subject: 2.5.72 is panicing, not syncing
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056610184.4185.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Jun 2003 00:49:45 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.72 is panicing, not syncing!

I suspect that the problem is somewhat related to earlier
scheduling_while_atomic errors that others have gotten with 2.5.72.  I
get that about every second boot (so things are inconsistent --possibly
a race?).  The error message I get with the panic is:

Call Trace:
[<c0243b2f>] task_mulin_intr+0x1c1/0x270
[<c023e21e>] ide_intr+0x2d5/0x5d3
[<c0112838>] timer_interrupt+0x2ce/0x3b3
[<c024396e>] task_mulin_intr+0x0/0x270
[<c010c4cd>] handle_IRQ_event+0x39/0x62
[<c010cab5>] do_IRQ+0x144/0x3a4
[<c0107269>] default_idle+0x0/0x2c
[<c010adfe>] show_trace+x0x42/0x0a
[<c0107269>] default_idle+0x0/0x2c
[<c0107269>] default_idle+0x0/0x2c
[<c010ab38>] common_interrupt+0x10/0x20
[<c0107269>] default_idle+0x0/0x2c
[<c0107290>] default_idle+0x27/0x2c
[<c0107301>] cpu_idle+0x31/0x3a
[<c0105000>] rest_init+0x0/0xf5
[<c03b0725>] start_kernel+0x1b8/0x210
[<c03b043f>] unknown_bootoption+0x0/0xfa
 
Code: 0f 0b 29 00 2e b6 30 c0 2b 15 ec 7b 40 c0 c1 fa 03 69 d2 cd
 (0)Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I have gone through the resolutions suggested by other
scheduling_while_atomic posters and their resolutions do not seem to
apply to me.  All modules are loading except for firewire (which RH9
tries to un-configure). I do catch the word 'poison' before things
scroll off the screen when the system is complaining about firewire (it
also coughs up a call trace).  Everything else seems to load till I get
to either the boot prompt (which after entering a user name I get
scheduling_while _atomic in an endless loop, or the panic as seen above
(which I get before getting a user prompt).  I will attach my build
script for 2.5.72, and will post an oops if no one points me to a patch
or has an obvious solution about something I am missing.  My build
script is modified from the boot scripts I use to build 2.4.x kernels.
(I will grep out anything that is not set).  Please reply to me
personally as I am not on the list.
 
Thanks in advance,
Bob


#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
 
#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
 
#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_FUTEX=y
CONFIG_EPOLL=y
 
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
 
#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
                                                                                
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
                                                                                
#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
                                                                              #
# CPU Frequency scaling
#
                                                                            
#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HOTPLUG=y
                                                                                
#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
                                                                                
#
# PCI Hotplug Support
#
                                                                                
#
# Executable file formats
#
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
                                                                                
#
# Memory Technology Devices (MTD)
#
                                                                                
#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_1284=y
                                                                                
#
# Plug and Play support
#
CONFIG_PNP=y
                                                                                
#
# Protocols
#
                                                                                
#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=y
                                                                                
#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PG=m
                                                                                
#
# Parallel IDE protocol modules
#
                                                                                
#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y
                                                                                
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
                                                                                
#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
                                                                                
#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDE_CHIPSETS=y
                                                                                
#
# Note: most of these also require special kernel boot parameters
#
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
                                                                                
#
# SCSI device support
#
CONFIG_SCSI=y
                                                                                
#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
                                                                                
#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
                                                                                
#
# SCSI low-level drivers
#
CONFIG_SCSI_IMM=m
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
                                                                                
#
# PCMCIA SCSI adapter support
#
                                                                                
#
# Old CD-ROM drivers (not SCSI, not IDE)
#
                                                                                
#
# Multi-device support (RAID and LVM)
#
                                                                                
#
# Fusion MPT device support
#
                                                                                
#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m
                                                                                
#
# Subsystem Options
#
                                                                                
#
# Device Drivers
#
CONFIG_IEEE1394_OHCI1394=m
                                                                                
#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
                                                                                
#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
                                                                                
#
# Networking support
#
CONFIG_NET=y
                                                                                
#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
                                                                                
#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
                                                                                
#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
                                                                                
#
# QoS and/or fair queueing
#
                                                                                
#
# Network testing
#
CONFIG_NETDEVICES=y
                                                                                
#
# ARCnet devices
#
CONFIG_DUMMY=m
                                                                                
#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
                                                                                
#
# Tulip family network device support
#
CONFIG_NET_PCI=y
CONFIG_SIS900=m
                                                                                
#
# Ethernet (1000 Mbit)
#
                                                                                
#
# Ethernet (10000 Mbit)
#
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
                                                                                
#
# Wireless LAN (non-hamradio)
#
                                                                                
#
# Token Ring devices (depends on LLC=y)
#
                                                                                
#
# Wan interfaces
#
                                                                                
#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
                                                                                
#
# Amateur Radio support
#
                                                                                
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
CONFIG_IRDA_DEBUG=y
                                                                                
#
# Infrared-port device drivers
#
                                                                                
#
# SIR device drivers
#
                                                                                
#
# Dongle support
#
                                                                                
#
# Old SIR device drivers
#
#
# Old Serial dongle support
#
                                                                                
#
# FIR device drivers
#
                                                                                
#
# ISDN subsystem
#
                                                                                
#
# Telephony Support
#
                                                                                
#
# Input device support
#
CONFIG_INPUT=y
                                                                                
#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
                                                                                
#
# Input I/O drivers
#
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
                                                                                
#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
                                                                                
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
                                                                                
#
# Serial drivers
#
                                                                                
#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
                                                                                
#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
                                                                                
#
# I2C Hardware Sensors Mainboard support
#
                                                                                
#
# I2C Hardware Sensors Chip support
#
                                                                                
#
# Mice
#
                                                                                
#
# IPMI
#
                                                                                
#
# Watchdog Cards
#
CONFIG_NVRAM=m
                                                                                
#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m
                                                                                
#
# PCMCIA character devices
#
                                                                                
#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m
                                                                                
#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
                                                                                
#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
                                                                                
#
# Radio Adapters
#
                                                                                
#
# Digital Video Broadcasting Devices
#
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
                                                                                
#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=m
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_AUTOFS4_FS=y
                                                                                
#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
                                                                                
#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
                                                                                
#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
                                                                                
#
# Miscellaneous filesystems
#
                                                                                
#
# Network File Systems
#
CONFIG_SMB_FS=m
                                                                                
#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
                                                                                
#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
                                                                                
#
# Graphics support
#
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RIVA=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIRTUAL=m
                                                                                
#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
                                                                                
#
# Logo configuration
#
                                                                                
#
# Sound
#
CONFIG_SOUND=m
                                                                                
#
# Advanced Linux Sound Architecture
#
                                                                                
#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
CONFIG_SOUND_TVMIXER=m
                                                                                
#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y
                                                                                
#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
                                                                                
#
# USB Host Controller Drivers
#
                                                                                
#
# USB Device Class drivers
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
                                                                                
#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
                                                                                
#
# USB HID Boot Protocol drivers
#
#
# USB Imaging devices
#
CONFIG_USB_SCANNER=m
                                                                                
#
# USB Multimedia devices
#
                                                                                
#
# USB Network adaptors
#
                                                                                
#
# USB port drivers
#
                                                                                
#
# USB Serial Converter support
#
                                                                                
#
# USB Miscellaneous drivers
#
                                                                                
#
# Bluetooth support
#
                                                                                
#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
                                                                                
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_KALLSYMS=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
                                                                                
#
# Security options
#
                                                                                
#
# Cryptographic options
#
                                                                             
#
# Library routines
#
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

-- 
Bob Gill <gillb4@telusplanet.net>

