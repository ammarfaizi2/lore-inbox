Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUGUJRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUGUJRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 05:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUGUJRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 05:17:03 -0400
Received: from av13-2-sn4.m-sp.skanova.net ([81.228.10.103]:57243 "EHLO
	av13-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S266477AbUGUJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 05:14:18 -0400
Date: Wed, 21 Jul 2004 11:14:17 +0200
To: "Dave Kelly" <dave@ravelox.co.uk>
Subject: Re: SATA Maxtor 6Y080M0 abonormal status 0xD9
Cc: linux-kernel@vger.kernel.org
References: <40FA42E7.7060101@ravelox.co.uk>
From: "Henrik Gustafsson" <lkml@fnord.se>
Content-Type: multipart/mixed; boundary=----------AXt4D7y8MTySTsEqTkO29o
MIME-Version: 1.0
Message-ID: <opsbhc930b184obg@mail1.telia.com>
In-Reply-To: <40FA42E7.7060101@ravelox.co.uk>
User-Agent: Opera M2/7.50 (Win32, build 3778)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------AXt4D7y8MTySTsEqTkO29o
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

On Sun, 18 Jul 2004 10:29:11 +0100, Dave Kelly <dave@ravelox.co.uk> wrote:
[SNIP]
>
> ata1: command 0xca timeout, stat 0xd9 host_stat 0x61
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: Write (10) 00 01 44 07 ff
> 00 00 c8 00
> Current sda: sense key Medium Error
> Additional sense: Write error - auto reallocation failed
> end_request: I/O error, dev sda, sector 21235711
> ATA: abnormal status 0xD9 on port 0xF885D087
> ATA: abnormal status 0xD9 on port 0xF885D087
> ATA: abnormal status 0xD9 on port 0xF885D087
>
> mkfs hangs and I am unable to kill it without a reboot.

That's almost exactly the error I've gotten from four(!) of my Maxtor  
7Y250M0 SATA disks. One I sent back for repair, and the remaining three  
and the replacement disk are mounted in the chassi, but not connected.  
Figured it to be something related to my controller, but as we don't seem  
to have the same controller, I suppose it's either a bug in the Maxtor  
firmware or something software related. Too bad I don't have another SATA  
controller to try this out on.

I am running a destructive badblocks(8) on the disks as it seems to be a  
good way of provoking this error (the time it takes for the error to  
appear varies greatly). Can't remember how I tested the first disk (the  
one I sent back), but the first two from this batch were connected to port  
four of my Promise S150 SX4 card. The next two were connected to port one,  
to decrease the chances of anything being wrong with a port or cable.

I have attached some information that may or may not be relevant to you  
people, but I'll highlight the errors so I won't have to spam you with  
three complete dmesgs (I'll attach the first dmesg in its entirety. The  
remaining dmesgs are available on request).

I don't have the dmesg for the very first drive I had failing, but the  
error was quite similar. That one ran on a slightly patched 2.6.6-kernel  
with ACPI enabled though. These three are vanilla 2.6.7 with ACPI  
disabled. I haven't been able to provoke the error on my fourth disk yet,  
but I guess it's only a matter of time.

Port 4, disk 1:

ata4: DMA timeout
scsi3: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 17 00 00  
00 80 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 5888

Port 4, disk 2:

ata4: DMA timeout
scsi3: ERROR on channel 0, id 0, lun 0, CDB: Write (10) 00 06 95 fa 00 00  
00 80 00
Current sda: sense key Medium Error
Additional sense: Write error - auto reallocation failed
end_request: I/O error, dev sda, sector 110492160

Port 1, disk 3:

ata1: DMA timeout
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 17 f0 54 00 00  
00 80 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 401626112

I can run additional tests for you, with kernels patched and configured  
anywhich way you want it. Just let me know

Also, about the unkill:able part, I'm having the same problem with  
whatever process it is that is accessing it. Which does kind-of reduce the  
usability when having it in a software RAID-5 array. When one disk fails,  
the array hangs.


// Henrik Gustafsson
------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=config
Content-Type: application/octet-stream; name=config
Content-Transfer-Encoding: 8bit

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
# CONFIG_CLEAN_COMPILE is not set
# CONFIG_STANDALONE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_SX4=m
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
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
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y

------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=cpuinfo
Content-Type: application/octet-stream; name=cpuinfo
Content-Transfer-Encoding: 8bit

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 10
cpu MHz		: 900.415
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1773.56


------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=dmesg_port4_disk1
Content-Type: application/octet-stream; name=dmesg_port4_disk1
Content-Transfer-Encoding: 8bit

Linux version 2.6.7 (root@shiroi) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 Sun Jul 4 03:14:06 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 AOPEN                                     ) @ 0x000f5e70
ACPI: RSDT (v001 AOPEN  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 AOPEN  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 AOPEN  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda3 vga=0x317 splash=verbose
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 899.958 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 516752k/524224k available (1579k kernel code, 6708k reserved, 684k data, 112k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1773.56 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3091] at 0000:00:00.0
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26214)
matroxfb: framebuffer at 0xD4000000, mapped to 0xe0805000, size 16777216
fb0: MATROX frame buffer device
fb0: initializing hardware
udf: registering filesystem
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Console: switching to colour frame buffer device 80x30
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L090AVV207-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3
matroxfb_crtc2: secondary head of fb0 was registered as fb1
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
libata version 1.02 loaded.
sata_sx4 version 0.50
ata1: SATA max UDMA/133 cmd 0xE29BA200 ctl 0xE29BA238 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xE29BA280 ctl 0xE29BA2B8 bmdma 0x0 irq 10
ata3: SATA max UDMA/133 cmd 0xE29BA300 ctl 0xE29BA338 bmdma 0x0 irq 10
ata4: SATA max UDMA/133 cmd 0xE29BA380 ctl 0xE29BA3B8 bmdma 0x0 irq 10
ATA: abnormal status 0x7F on port 0xE29BA21C
scsi0 : sata_sx4
ATA: abnormal status 0x7F on port 0xE29BA29C
scsi1 : sata_sx4
ATA: abnormal status 0x7F on port 0xE29BA31C
scsi2 : sata_sx4
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata4: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_sx4
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
usbcore: registered new driver usbfs
usbcore: registered new driver hub
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
Attached scsi disk sda at scsi3, channel 0, id 0, lun 0
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KX133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:11.2: irq 11, io base 0000d400
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
process `host' is using obsolete setsockopt SO_BSDCOMPAT
ata4: DMA timeout
scsi3: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 17 00 00 00 80 00 
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 5888

------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=iomem
Content-Type: application/octet-stream; name=iomem
Content-Transfer-Encoding: 8bit

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Adapter ROM
000ca000-000d5fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0028ad07 : Kernel code
  0028ad08-00335ebf : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d3ffffff : 0000:00:00.0
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : 0000:01:00.0
    d4000000-d5ffffff : matroxfb FB
d6000000-d8ffffff : PCI Bus #01
  d6000000-d6003fff : 0000:01:00.0
    d6000000-d6003fff : matroxfb MMIO
  d7000000-d77fffff : 0000:01:00.0
da000000-da0fffff : 0000:00:0b.0
  da000000-da0fffff : sata_sx4
da100000-da11ffff : 0000:00:09.0
  da100000-da11ffff : e1000
da120000-da13ffff : 0000:00:09.0
  da120000-da13ffff : e1000
da140000-da147fff : 0000:00:0b.0
  da140000-da147fff : sata_sx4
ffff0000-ffffffff : reserved

------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=ioports
Content-Type: application/octet-stream; name=ioports
Content-Transfer-Encoding: 8bit

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0290-0297 : w83627hf
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : viapro-smbus
c000-c03f : 0000:00:09.0
  c000-c03f : e1000
c400-c4ff : 0000:00:0b.0
  c400-c4ff : sata_sx4
c800-c8ff : 0000:00:0b.0
  c800-c8ff : sata_sx4
cc00-ccff : 0000:00:0b.0
  cc00-ccff : sata_sx4
d000-d00f : 0000:00:11.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:11.2
  d400-d41f : uhci_hcd
e000-e0ff : 0000:00:11.5
  e000-e0ff : VIA8233

------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=lsmod
Content-Type: application/octet-stream; name=lsmod
Content-Transfer-Encoding: 8bit

Module                  Size  Used by
snd_via82xx            22020  0 
snd_pcm                80264  1 snd_via82xx
snd_timer              20100  1 snd_pcm
snd_ac97_codec         64356  1 snd_via82xx
snd_page_alloc          8872  2 snd_via82xx,snd_pcm
snd_mpu401_uart         5760  1 snd_via82xx
snd_rawmidi            17248  1 snd_mpu401_uart
snd                    37816  6 snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi
soundcore               6784  1 snd
uhci_hcd               28144  0 
e1000                  79204  0 
via_agp                 6688  1 
agpgart                27176  1 via_agp
rtc                     9336  0 
sd_mod                 17024  1 
usbcore                95264  3 uhci_hcd
dm_mod                 37312  0 
psmouse                18216  0 
i2c_matroxfb            3904  0 
i2c_algo_bit            8456  1 i2c_matroxfb
w83627hf               27108  0 
eeprom                  6184  0 
i2c_sensor              2304  2 w83627hf,eeprom
i2c_isa                 1600  0 
i2c_viapro              5868  0 
sata_sx4                9828  1 
libata                 34308  1 sata_sx4

------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=lspci
Content-Type: application/octet-stream; name=lspci
Content-Transfer-Encoding: 8bit

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d8ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at da100000 (32-bit, non-prefetchable)
	Region 1: Memory at da120000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at c000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:00:0b.0 RAID bus controller: Promise Technology, Inc. PDC20621 [SATA150 SX4] 4 Channel IDE RAID Controller (rev 01)
	Subsystem: Promise Technology, Inc. PDC20621 [SATA150 SX4] 4 Channel IDE RAID Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1500ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c400
	Region 1: I/O ports at c800 [size=256]
	Region 2: I/O ports at cc00 [size=256]
	Region 3: Memory at da000000 (32-bit, non-prefetchable) [size=1M]
	Region 4: Memory at da140000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 10)
	Subsystem: Analog Devices: Unknown device 5360
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e000
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d4000000 (32-bit, prefetchable)
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1


------------AXt4D7y8MTySTsEqTkO29o
Content-Disposition: attachment; filename=modules
Content-Type: application/octet-stream; name=modules
Content-Transfer-Encoding: 8bit

snd_via82xx 22020 0 - Live 0xe2b04000
snd_pcm 80264 1 snd_via82xx, Live 0xe2ad6000
snd_timer 20100 1 snd_pcm, Live 0xe2a8e000
snd_ac97_codec 64356 1 snd_via82xx, Live 0xe2aeb000
snd_page_alloc 8872 2 snd_via82xx,snd_pcm, Live 0xe2a8a000
snd_mpu401_uart 5760 1 snd_via82xx, Live 0xe2a4e000
snd_rawmidi 17248 1 snd_mpu401_uart, Live 0xe2a1f000
snd 37816 6 snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi, Live 0xe2acb000
soundcore 6784 1 snd, Live 0xe2a48000
uhci_hcd 28144 0 - Live 0xe2a7d000
e1000 79204 0 - Live 0xe2a95000
via_agp 6688 1 - Live 0xe2a36000
agpgart 27176 1 via_agp, Live 0xe2a40000
rtc 9336 0 - Live 0xe2a06000
sd_mod 17024 1 - Live 0xe2a25000
usbcore 95264 3 uhci_hcd, Live 0xe2a53000
dm_mod 37312 0 - Live 0xe2a2b000
psmouse 18216 0 - Live 0xe2a11000
i2c_matroxfb 3904 0 - Live 0xe28e4000
i2c_algo_bit 8456 1 i2c_matroxfb, Live 0xe2a0d000
w83627hf 27108 0 - Live 0xe2a17000
eeprom 6184 0 - Live 0xe2a0a000
i2c_sensor 2304 2 w83627hf,eeprom, Live 0xe2a04000
i2c_isa 1600 0 - Live 0xe28e6000
i2c_viapro 5868 0 - Live 0xe28ec000
sata_sx4 9828 1 - Live 0xe28e8000
libata 34308 1 sata_sx4, Live 0xe28f0000

------------AXt4D7y8MTySTsEqTkO29o--

