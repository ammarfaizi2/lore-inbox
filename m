Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRFBKgd>; Sat, 2 Jun 2001 06:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRFBKgX>; Sat, 2 Jun 2001 06:36:23 -0400
Received: from mout1.freenet.de ([194.97.50.132]:53183 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S262432AbRFBKgQ>;
	Sat, 2 Jun 2001 06:36:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
Subject: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
Date: Sat, 2 Jun 2001 12:34:55 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060211530400.00350@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I got massive file corruptions with the kernels mentioned in the subject. I 
can reproduce it every time.

What did I do?

The kernel can't find files or directories which have been created seconds 
before. If I start configure of some program for example, the 
conftest-Directory can't be found again which is created during configure; 
datas can't be read in files (if it could open the file). I'm than getting an 
IO-error. No matter if it's local on reiser or remote via NFS. Always the 
same problem.

If you want to mount some partitions, like mount /boot, the /boot-Directory 
can't be found (IO-error). If you try it again and again, it will suddenly 
work :-(.

I tried to compile the 2.4.5ac6-Kernel under itself. It ended in massive 
errors while reading the sources.
I rebooted the machine (with a lot of errors while unmounting) with kernel 
2.2.19 and tried to compile the above mentioned kernel again. I got a lot of 
other errors -> 2.4.5 destroyed the files! I had to do a rm -R to get rid of 
the whole tree. After newcreation of the tree, the compiling under kernel 
2.2.19 worked fine.

I tried to compile the kernel with egcs 1.1.2 and gcc 2.95.3 - no matter. I 
tried to compile with or without APIC - no matter.

Do you have any suggestions how to compile the kernel to get it working and 
to locate the problem?


Some additional infos to my machine:
512 MB RAM
AMD Athlon 800
no overclocking


lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d6000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge] (prog-if 
00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d0000000-d3ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])         Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400
        Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo 
Super AC97/Audio] (rev 20)
        Subsystem: VIA Technologies, Inc.: Unknown device 4511
        Flags: medium devsel, IRQ 5
        I/O ports at dc00
        I/O ports at e000
        I/O ports at e400
        Capabilities: [c0] Power Management version 2

00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev
02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e800
        Memory at d9000000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1
 
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec00
        Memory at d9001000 (32-bit, non-prefetchable)
 
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 
00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at d0000000 (32-bit, prefetchable)
        I/O ports at c000
        Memory at d5000000 (32-bit, non-prefetchable)
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2





My .config-file (without the options wich have not set):

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
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
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y

#
# QoS and/or fair queueing
#

#
# Telephony Support
#

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
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
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_8139TOO=m
CONFIG_SIS900=m

#
# Ethernet (1000 Mbit)
#

#
# Wireless LAN (non-hamradio)
#

#
# Token Ring devices
#

#
# Wan interfaces
#

#
# Amateur Radio support
#

#
# IrDA (infrared) support
#

#
# ISDN subsystem
#

#
# Old CD-ROM drivers (not SCSI, not IDE)
#

#
# Input core support
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y

#
# Joysticks
#

#
# Watchdog Cards
#

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y

#
# Multimedia devices
#

#
# File systems
#
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_15=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_VIA82CXXX=m

#
# USB support
#

#
# Kernel hacking
#
