Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbTGLWea (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbTGLWea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:34:30 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:51721
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S268677AbTGLWd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:33:29 -0400
Subject: 2.5.75-mm1: lockup when inserting USB storage device
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-5Svdbi21qIpAWZzO/RYc"
Message-Id: <1058050082.4831.70.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Jul 2003 15:48:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Svdbi21qIpAWZzO/RYc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm getting a system lockup when I insert a USB storage device (either a
IBM memory key, or a USB MemoryStick reader).

It seems to happen after I've done a suspend/resume cycle.  If I insert
the device on a freshly booted system it doesn't lock up.

In the lockup case, it prints:

hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501.

and then goes completely silent - the cursor stops blinking and
alt-sysreq doesn't respond.

When I insert the same device on a fresh boot, it looks like it does all
the right things:

hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
usb 3-1: USB device not accepting new address=2 (error=-110)
hub 3-0:0: new USB device on port 1, assigned address 3
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM       Model: Memory Key        Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 127840 512-byte hdwr sectors (65 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 00 00

but trying to open /dev/sda or /dev/sda1 gives ENXIO.

I've attached the /proc/bus/usb/devices before and after insertion; my
.config; the output of lspci and lsusb; my loaded modules and the full
dmesg output.  "cat /proc/scsi/scsi" hangs forever.

This is an IBM ThinkPad X31, which uses the Intel i855PM chipset, which
includes USB 1.1 and USB 2.0.  I think this IBM memory stick supports
USB2, though it only seems to be recognized as a USB 1.1 device.

Any ideas?

Thanks,
	J

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=config.txt
Content-Type: text/plain; name=config.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

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
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
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
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
CONFIG_I82365=y
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m

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
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
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
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
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
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
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
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_FERAL_ISP is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

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
# CONFIG_NETFILTER is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
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
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=m
CONFIG_MPI350=m
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_PCI_HERMES is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
# CONFIG_PCMCIA_ATMEL is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
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
CONFIG_PCMCIA_PCNET=m
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

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
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRTTY_OLD is not set
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_OLD is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_OLD is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

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
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

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
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
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
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
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
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
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
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

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
CONFIG_USB_EHCI_HCD=m
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
# CONFIG_USB_HIDINPUT is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
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
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

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
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_KGDB is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=dev-after.txt
Content-Type: text/plain; name=dev-after.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #3)
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #2)
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=08ec ProdID=0011 Rev= 2.00
S:  Manufacturer=IBM
S:  Product=USB 2.0 Memory Key
S:  SerialNumber=021E43012E0058F2
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 94mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #1)
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 ehci_hcd
S:  Product=Intel Corp. 82801DB USB EHCI Con
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=dev-before.txt
Content-Type: text/plain; name=dev-before.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #3)
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #2)
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 uhci-hcd
S:  Product=Intel Corp. 82801DB USB (Hub #1)
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
S:  Manufacturer=Linux 2.5.75-mm1 ehci_hcd
S:  Product=Intel Corp. 82801DB USB EHCI Con
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.5.75-mm1 (jeremy@abulafia) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Fri Jul 11 10:08:58 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff79000 (ACPI data)
 BIOS-e820: 000000001ff79000 - 000000001ff7b000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2 resume=/dev/hda4 video=radeonfb:dfp,1024x768 clock=tsc acpi=off
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1299.171 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2572.28 BogoMIPS
Memory: 514280k/523648k available (2283k kernel code, 8628k reserved, 761k data, 168k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After generic, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1298.0744 MHz.
..... host bus clock speed is 99.0903 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd906, last bus=8
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
ACPI: Disabled via command line (acpi=off)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 9 for device 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:02:02.0
radeonfb_pci_register BEGIN
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
radeonfb: ref_clk=2700, ref_div=60, xclk=14400 from BIOS
radeonfb: probed DDR SGRAM 16384k videoram
radeonfb: panel ID string: 1024x768                
radeonfb: detected DFP panel size from BIOS: 1024x768
radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
hStart = 1040, hEnd = 1176, hTotal = 1344
vStart = 770, vEnd = 776, vTotal = 806
h_total_disp = 0x7f00a7	   hsync_strt_wid = 0x91040a
v_total_disp = 0x2ff0325	   vsync_strt_wid = 0x860301
post div = 0x4
fb_div = 0x18f
ppll_div_3 = 0x2018f
ron = 1312, roff = 22988
vclk_freq = 4489, per = 821
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1300MHz": max frequency: 1300000kHz
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:02:00.1
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 0000:02:08.0
eth0: Intel Corp. 82801BD PRO/100 VE (, 00:09:6B:CD:31:1A, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 9 for device 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:02:02.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: host protected area => 1
hda: 33542773 sectors (17174 MB) w/1768KiB Cache, CHS=35494/15/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
Console: switching to colour frame buffer device 128x48
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
Yenta IRQ list 0098, PCI irq11
Socket status: 30000006
PCI: Found IRQ 10 for device 0000:02:00.1
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.6
Yenta IRQ list 0098, PCI irq10
Socket status: 30000006
Intel PCIC probe: not found.
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 252): journal_recover: JBD: recovery, exit status 0, recovered transactions 655063 to 655900
(fs/jbd/recovery.c, 254): journal_recover: JBD: Replayed 1929 and revoked 1/9 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 196566
ext3_orphan_cleanup: deleting unreferenced inode 196564
ext3_orphan_cleanup: deleting unreferenced inode 196558
ext3_orphan_cleanup: deleting unreferenced inode 196418
ext3_orphan_cleanup: deleting unreferenced inode 196427
ext3_orphan_cleanup: deleting unreferenced inode 196411
ext3_orphan_cleanup: deleting unreferenced inode 196361
EXT3-fs: hda2: 7 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Real Time Clock Driver v1.11
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Found IRQ 5 for device 0000:00:1d.7
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB EHCI Con
ehci_hcd 0000:00:1d.7: irq 5, pci mem e1854000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
uhci-hcd 0000:00:1d.0: irq 11, io base 00001800
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
uhci-hcd 0000:00:1d.1: irq 5, io base 00001820
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:02:02.0
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
uhci-hcd 0000:00:1d.2: irq 9, io base 00001840
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 1050836k swap on /dev/hda4.  Priority:-1 extents:1
ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 9 for device 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:02.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[c0205000-c02057ff]  Max Packet=[2048]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 9b050404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 9b050404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 9b050404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
microcode: CPU0 no microcode found! (sig=695, pflags=32)
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Probing for MPI350 card
PCI: Found IRQ 9 for device 0000:02:02.0
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:00.2
rxfids[0].CardRamOff=e1995800
txfids[0].CardRamOff=e1995808
mpi350: found device
v_info(ddd64260)->rxfids[0].CardRamOff=e1995800
v_info(ddd64260)->txfids[0].CardRamOff=e1995808
MPI350 start: MAC  00:02:8a:5c:7f:07
mpi350: stop_venus_card(dev=ddd64000)
SCSI subsystem initialized
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
usb 3-1: USB device not accepting new address=2 (error=-110)
hub 3-0:0: new USB device on port 1, assigned address 3
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM       Model: Memory Key        Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 127840 512-byte hdwr sectors (65 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 00 00

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=lsusb.txt
Content-Type: text/plain; name=lsusb.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Unknown line at line 1809
Duplicate HUT Usage Spec at line 2650

Bus 004 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.75-mm1 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #3)
  iSerial                 1 0000:00:1d.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 003: ID 08ec:0011 M-Systems 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x08ec M-Systems
  idProduct          0x0011 
  bcdDevice            2.00
  iManufacturer           1 	
  iProduct                2 	
  iSerial                 3 	
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower               94mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.75-mm1 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #2)
  iSerial                 1 0000:00:1d.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.75-mm1 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #1)
  iSerial                 1 0000:00:1d.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         1 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.75-mm1 ehci_hcd
  iProduct                2 Intel Corp. 82801DB USB EHCI Con
  iSerial                 1 0000:00:1d.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=4)
     0409 English(US)

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=modules.txt
Content-Type: text/plain; name=modules.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
usb_storage            31419  1 
radeon                125080  2 
sd_mod                 13088  0 
scsi_mod              108564  2 usb_storage,sd_mod
autofs                 21248  0 
mpi350                 95308  0 
parport_pc             38576  0 
parport                43200  1 parport_pc
ohci1394               38656  0 
ieee1394               79116  1 ohci1394
hid                    26048  0 
uhci_hcd               43144  0 
ehci_hcd               27008  0 
usbcore               118868  6 usb_storage,hid,uhci_hcd,ehci_hcd
rtc                    20440  0 

--=-5Svdbi21qIpAWZzO/RYc
Content-Disposition: attachment; filename=pci.txt
Content-Type: text/plain; name=pci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: IBM: Unknown device 0529
	Flags: bus master, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Flags: bus master, medium devsel, latency 0, IRQ 5
	Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1860 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: IBM: Unknown device 052d
	Flags: medium devsel, IRQ 10
	I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
	Subsystem: IBM: Unknown device 0534
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]
	Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0524
	Flags: medium devsel, IRQ 10
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 052f
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM: Unknown device 0532
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM: Unknown device 0532
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00002800-000028ff
	I/O window 1: 00002c00-00002cff
	16-bit legacy interface ports at 0001

02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: IBM: Unknown device 0533
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at c0205000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <available only to root>

02:02.0 Network controller: AIRONET Wireless Communications Cisco Aironet Wireless 802.11b
	Subsystem: AIRONET Wireless Communications: Unknown device 5000
	Flags: bus master, fast devsel, latency 64, IRQ 9
	I/O ports at 8000 [size=256]
	Memory at c0200000 (32-bit, non-prefetchable) [size=16K]
	Memory at c0400000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at <unassigned> [disabled] [size=2M]
	Capabilities: <available only to root>

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethernet Controller (rev 81)
	Subsystem: IBM: Unknown device 0522
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at c0204000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8400 [size=64]
	Capabilities: <available only to root>


--=-5Svdbi21qIpAWZzO/RYc--

