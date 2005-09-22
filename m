Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVIVPxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVIVPxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVIVPxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:53:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33749 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030419AbVIVPw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:52:59 -0400
Date: Thu, 22 Sep 2005 08:52:54 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: karim@opersys.com
Cc: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: The system works (2.6.14-rc2): functional k8n-dl
Message-ID: <20050922155254.GE5910@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Some background: I had been wanting to build a dual-opteron box for a
solid development environment at home and did some perusing of possible
MoBos (including seeing what LKML'ers thought. I saw both Karim's and
Sean's postings regarding issues with the ASUS K8N-DL (pretty negative),
but also found
http://gentoo-wiki.com/ASUS_K8N-DL_dual_Opteron_motherboard (I don't run
Gentoo, mind you), which gave me some hope. So I went ahead and bought
the K8N-DL, two Opteron 244s, 2 GB of RAM and 2 WD Caviar 250GB SATA
disks. Enough about the box.

First of all, I was able to install Ubuntu Breezy Badger straight away.
Everything worked (factory installed BIOS 1003), including the network
adapter (via the tg3 driver) and my new wireless keyboard and mouse over
USB! The only trickery was that I needed to boot with "noapic nolapic
pci=noacpi" to get all the IRQs to show up properly and get a clean
boot.

I decided to try and update the BIOS (which you can handily do off a
CDRW :) There are two versions available, 1004 and 1006, beyond the
factory default one.

With 1004, I still needed the custom boot options in 2.6.13.2,
2.6.14-rc1 and 2.6.14-rc2.

But, with 1006, I need no options with 2.6.14-rc2 (I have not gone back
to verify that it is also the case with 2.6.13.2) and I get a flawless
boot! In fact, if I do boot with 2.6.14-rc2 and noapic nolapic
pci=noacpi, I get IRQ 7 disabled. I have included my .config below[1] as
well as the output of dmesg in 2.6.14-rc2 with no special command-line
parameters[2] and the diff relative to the boot of 2.6.14-rc2 with
"noapic nolapic pci=noacpi"[3].

Also, please note that I had some issues install Breezy to the SATA
drives when attached to the Silicon Image controller on the motherboard.
I could not get the partitioner to set up more than a ~140 GB partition
on the drive (it would hang for a bit and then report disconnect events,
if I remember correctly). I checked the cable, etc. So, I have both
disks connected to the nForce4 SATA controller and it is working
flawless with sata_nv.

I just wanted to thank Andi and the other x86_64 folks for getting the
code in such a solid state. I have had only one complaint so far: it
seems that the the "Broadcom Corporation NetXtreme BCM5751 Gigabit
Ethernet PCI Express" adapter, with the tg3 driver, downs and ups the
iface on MTU changes. Unfortunately, with some VPN software I use, it is
sometimes necessary to drop the MTU to 1300 or so to get consistent
connections. When I do this, though, ssh through the tunnel tends to not
function. I have a workaround, where I bounce over a different laptop,
but that's a bit of a pain (and that network adapter seems to be able to
transiently change the MTU). Not a big deal, in any case.

The only other thing I have seen is that on shutdown, powernowd tends to
segfault.

So, at least one success story. I do have logs of the boots with all
combinations of BIOS 1003, 1004 and 1006 and kernels 2.6.13.2,
2.6.14-rc1 and 2.6.14-rc2, if anyone is interested. I am more than happy
to test patches, .configs, etc.

Thanks,
Nish

[1]
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.14-rc2
# Tue Sep 20 21:20:05 2005
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_K8_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_NUMA=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=2
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_UNORDERED_IO=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

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
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
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
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_MV is not set
CONFIG_SCSI_SATA_NV=y
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=y
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=y
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
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
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
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

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
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
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
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

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
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

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
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

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
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

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
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
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
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
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
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

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
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y

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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

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
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
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
CONFIG_NLS_ASCII=y
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
CONFIG_NLS_UTF8=y

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_FRAME_POINTER=y
CONFIG_INIT_DEBUG=y
CONFIG_IOMMU_DEBUG=y
CONFIG_KPROBES=y
CONFIG_IOMMU_LEAK=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y

[2]

 Bootdata ok (command line is root=/dev/sda1 ro)
 Linux version 2.6.14-rc2 (nacc@arkanoid) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu8)) #1 SMP PREEMPT Tue Sep 20 21:24:26 PDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7670
 ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
 ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
 ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fff9580
 ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fff9740
 ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9880
 ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9480
 ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
 SRAT: PXM 0 -> APIC 0 -> Node 0
 SRAT: PXM 1 -> APIC 1 -> Node 1
 SRAT: Node 0 PXM 0 0-9ffff
 SRAT: Node 0 PXM 0 0-3fffffff
 SRAT: Node 1 PXM 1 40000000-7fffffff
 Using 20 for the hash shift. Max adder is 7ffeffff 
 Bootmem setup node 0 0000000000000000-000000003fffffff
 Bootmem setup node 1 0000000040000000-000000007ffeffff
 On node 0 totalpages: 262046
   DMA zone: 3999 pages, LIFO batch:1
   Normal zone: 258047 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
 On node 1 totalpages: 262127
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 262127 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
 Nvidia board detected. Ignoring ACPI timer override.
 ACPI: PM-Timer IO Port: 0x1008
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
 Processor #0 15:5 APIC version 16
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
 Processor #1 15:5 APIC version 16
 ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
 ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
 ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
 ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
 IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 ACPI: BIOS IRQ0 pin2 override ignored.
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
 ACPI: IRQ9 used by override.
 ACPI: IRQ14 used by override.
 ACPI: IRQ15 used by override.
 Setting APIC routing to flat
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
 Checking aperture...
 CPU 0: aperture @ 4000000 size 32 MB
 Aperture from northbridge cpu 0 too small (32 MB)
 No AGP bridge found
 Your BIOS doesn't leave a aperture memory hole
 Please enable the IOMMU option in the BIOS setup
 This costs you 64 MB of RAM
 Mapping aperture over 65536 KB of RAM @ 4000000
 Built 2 zonelists
 Kernel command line: root=/dev/sda1 ro
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 131072 bytes)
 time.c: Using 3.579545 MHz PM timer.
 time.c: Detected 1800.026 MHz processor.
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
 Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
 Memory: 1989180k/2097088k available (3531k kernel code, 107520k reserved, 2407k data, 244k init)
 Calibrating delay using timer specific routine.. 3602.44 BogoMIPS (lpj=1801222)
 Mount-cache hash table entries: 256
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU 0(1) -> Node 0 -> Core 0
 mtrr: v2.0 (20020519)
 Using local APIC timer interrupts.
 Detected 12.500 MHz APIC timer.
 softlockup thread 0 started up.
 Booting processor 1/2 APIC 0x1
 Initializing CPU#1
 Calibrating delay using timer specific routine.. 1999.69 BogoMIPS (lpj=999849)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU 1(1) -> Node 1 -> Core 0
 AMD Opteron(tm) Processor 244 stepping 0a
 CPU 1: Syncing TSC to CPU 0.
 CPU 1: synchronized TSC with CPU 0 (last diff -2776 cycles, maxerr 618 cycles)
 Brought up 2 CPUs
 softlockup thread 1 started up.
 Disabling vsyscall due to use of PM timer
 time.c: Using PM based timekeeping.
 testing NMI watchdog ... OK.
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: Using configuration type 1
 PCI: Using MMCONFIG at e0000000
 ACPI: Subsystem revision 20050902
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
 PCI: Transparent bridge - 0000:00:09.0
 Boot video device is 0000:04:00.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
 ACPI: PCI Interrupt Link [LNK1] (IRQs 5 *7 9 10 11 14 15)
 ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 *11 14 15)
 ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
 ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
 ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LACI] (IRQs *5 7 9 10 11 14 15)
 ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 *11 14 15)
 ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
 ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
 ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
 ACPI: PCI Interrupt Link [LPCA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
 ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
 ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
 ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
 ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
 ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
 ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 PCI-DMA: Disabling AGP.
 PCI-DMA: More than 4GB of RAM and no IOMMU
 PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.
 PCI: Bridge: 0000:00:09.0
   IO window: 9000-afff
   MEM window: fde00000-fdefffff
   PREFETCH window: fdf00000-fdffffff
 PCI: Bridge: 0000:00:0c.0
   IO window: 8000-8fff
   MEM window: fdd00000-fddfffff
   PREFETCH window: fdc00000-fdcfffff
 PCI: Bridge: 0000:00:0d.0
   IO window: 7000-7fff
   MEM window: fdb00000-fdbfffff
   PREFETCH window: fda00000-fdafffff
 PCI: Bridge: 0000:00:0e.0
   IO window: 6000-6fff
   MEM window: fd900000-fd9fffff
   PREFETCH window: d8000000-dfffffff
 PCI: Setting latency timer of device 0000:00:09.0 to 64
 PCI: Setting latency timer of device 0000:00:0c.0 to 64
 PCI: Setting latency timer of device 0000:00:0d.0 to 64
 PCI: Setting latency timer of device 0000:00:0e.0 to 64
 IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
 Total HugeTLB memory allocated, 0
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 fuse init (API version 7.2)
 Initializing Cryptographic API
 PCI: Setting latency timer of device 0000:00:0c.0 to 64
 pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[pcie00]
 Allocate Port Service[pcie03]
 PCI: Setting latency timer of device 0000:00:0d.0 to 64
 pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[pcie00]
 Allocate Port Service[pcie03]
 PCI: Setting latency timer of device 0000:00:0e.0 to 64
 pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[pcie00]
 Allocate Port Service[pcie03]
 ACPI: Power Button (FF) [PWRF]
 ACPI: Power Button (CM) [PWRB]
 Using specific hotkey driver
 ACPI: CPU0 (power states: C1[C1])
 ACPI: CPU1 (power states: C1[C1])
 Real Time Clock Driver v1.12
 Non-volatile memory driver v1.2
 Linux agpgart interface v0.101 (c) Dave Jones
 [drm] Initialized drm 1.0.0 20040925
 Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
 Hangcheck: Using monotonic_clock().
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 parport0: PC-style at 0x378 [PCSPP(,...)]
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 loop: loaded (max 8 devices)
 pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
 tg3.c:v3.40 (September 15, 2005)
 ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
 ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 209
 PCI: Setting latency timer of device 0000:02:00.0 to 64
 eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:13:d4:04:42:47
 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
 eth0: dma_rwctrl[76180000]
 netconsole: not configured, aborting
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
 NFORCE-CK804: chipset revision 242
 NFORCE-CK804: not 100% native mode: will probe irqs later
 NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
 NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
 Probing IDE interface ide0...
 hda: SONY DVD RW DW-Q28A, ATAPI CD/DVD-ROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 Probing IDE interface ide1...
 hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
 Uniform CD-ROM driver Revision: 3.20
 libata version 1.12 loaded.
 sata_sil version 0.9
 ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
 ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 217
 ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 217
 ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 217
 ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 217
 ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 217
 ata1: no device found (phy stat 00000000)
 scsi0 : sata_sil
 ata2: no device found (phy stat 00000000)
 scsi1 : sata_sil
 ata3: no device found (phy stat 00000000)
 scsi2 : sata_sil
 ata4: no device found (phy stat 00000000)
 scsi3 : sata_sil
 sata_nv version 0.8
 ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
 ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 225
 PCI: Setting latency timer of device 0000:00:07.0 to 64
 ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 225
 ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 225
 ata5: no device found (phy stat 00000000)
 scsi4 : sata_nv
 ata6: no device found (phy stat 00000000)
 scsi5 : sata_nv
 ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
 ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 233
 PCI: Setting latency timer of device 0000:00:08.0 to 64
 ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 233
 ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 233
 ata7: dev 0 cfg 49:2f00 82:706b 83:7e01 84:4023 85:7069 86:3c01 87:4023 88:407f
 ata7: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
 nv_sata: Primary device added
 nv_sata: Primary device removed
 nv_sata: Secondary device added
 nv_sata: Secondary device removed
 ata7: dev 0 configured for UDMA/133
 scsi6 : sata_nv
 ata8: dev 0 cfg 49:2f00 82:706b 83:7e01 84:4023 85:7069 86:3c01 87:4023 88:407f
 ata8: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
 nv_sata: Primary device added
 nv_sata: Primary device removed
 nv_sata: Secondary device added
 nv_sata: Secondary device removed
 ata8: dev 0 configured for UDMA/133
 scsi7 : sata_nv
   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
 SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 SCSI device sda: drive cache: write back
 SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 SCSI device sda: drive cache: write back
  sda: sda1 sda2
 Attached scsi disk sda at scsi6, channel 0, id 0, lun 0
 SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
 SCSI device sdb: drive cache: write back
 SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
 SCSI device sdb: drive cache: write back
  sdb:
 Attached scsi disk sdb at scsi7, channel 0, id 0, lun 0
 ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
 ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 209
 ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[fdeff000-fdeff7ff]  Max Packet=[2048]
 ieee1394: raw1394: /dev/raw1394 device initialized
 sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
 ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
 ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 50
 PCI: Setting latency timer of device 0000:00:02.1 to 64
 ehci_hcd 0000:00:02.1: EHCI Host Controller
 ehci_hcd 0000:00:02.1: debug port 1
 ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
 ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
 PCI: cache line size of 64 is not supported by device 0000:00:02.1
 ehci_hcd 0000:00:02.1: park 0
 ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 10 ports detected
 ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
 ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 58
 PCI: Setting latency timer of device 0000:00:02.0 to 64
 ohci_hcd 0000:00:02.0: OHCI Host Controller
 ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
 ohci_hcd 0000:00:02.0: irq 58, io mem 0xfe02f000
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 10 ports detected
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000030641c]
 USB Universal Host Controller Interface driver v2.3
 usb 2-4: new low speed USB device using ohci_hcd and address 2
 usbcore: registered new driver usblp
 /home/nacc/linux/views/2.6.14-rc2/drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
 Initializing USB Mass Storage driver...
 usbcore: registered new driver usb-storage
 USB Mass Storage support registered.
 input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:02.0-4
 input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:02.0-4
 usbcore: registered new driver usbhid
 /home/nacc/linux/views/2.6.14-rc2/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 mice: PS/2 mouse device common for all mice
 i2c /dev entries driver
 i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
 i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
 w83627hf 9191-0290: Enabling temp2, readings might not make sense
 w83627hf 9191-0290: Enabling temp3, readings might not make sense
 Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
 ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 23
 ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 23 (level, low) -> IRQ 225
 PCI: Setting latency timer of device 0000:00:04.0 to 64
 intel8x0_measure_ac97_clock: measured 50682 usecs
 intel8x0: clocking to 46783
 ALSA device list:
   #0: NVidia CK804 with ALC850 at 0xfe02d000, irq 225
 oprofile: using NMI interrupt.
 NET: Registered protocol family 2
 IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
 TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
 TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
 TCP: Hash tables configured (established 262144 bind 65536)
 TCP reno registered
 TCP bic registered
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 NET: Registered protocol family 15
 powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.3)
 powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
 powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
 cpu_init done, current fid 0xa, vid 0x2
 powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
 powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
 cpu_init done, current fid 0x2, vid 0xe
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 244k freed
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda1, internal journal
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda2, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 tg3: eth0: Link is up at 100 Mbps, full duplex.
 tg3: eth0: Flow control is off for TX and off for RX.

[3]
--- bios/dmesg_2.6.14-rc2_1006	2005-09-21 22:05:46.000000000 -0700
+++ bios/dmesg_2.6.14-rc2_noparms_1006	2005-09-21 22:08:30.000000000 -0700
@@ -1,4 +1,4 @@
- Bootdata ok (command line is root=/dev/sda1 ro noapic nolapic pci=noacpi )
+ Bootdata ok (command line is root=/dev/sda1 ro)
  Linux version 2.6.14-rc2 (nacc@arkanoid) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu8)) #1 SMP PREEMPT Tue Sep 20 21:24:26 PDT 2005
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
@@ -46,13 +46,18 @@
  ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
  ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
- Using ACPI for processor (LAPIC) configuration information
- Intel MultiProcessor Specification v1.4
-     Virtual Wire compatibility mode.
- OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
- I/O APIC #4 Version 17 at 0xFEC00000.
+ ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
+ IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
+ ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
+ ACPI: BIOS IRQ0 pin2 override ignored.
+ ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
+ ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
+ ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
+ ACPI: IRQ9 used by override.
+ ACPI: IRQ14 used by override.
+ ACPI: IRQ15 used by override.
  Setting APIC routing to flat
- Processors: 2
+ Using ACPI (MADT) for SMP configuration information
  Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
  Checking aperture...
  CPU 0: aperture @ 4000000 size 32 MB
@@ -63,54 +68,88 @@
  This costs you 64 MB of RAM
  Mapping aperture over 65536 KB of RAM @ 4000000
  Built 2 zonelists
- Kernel command line: root=/dev/sda1 ro noapic nolapic pci=noacpi 
+ Kernel command line: root=/dev/sda1 ro
  Initializing CPU#0
  PID hash table entries: 4096 (order: 12, 131072 bytes)
  time.c: Using 3.579545 MHz PM timer.
- time.c: Detected 1800.025 MHz processor.
+ time.c: Detected 1800.026 MHz processor.
  Console: colour VGA+ 80x25
  Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
  Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
  Memory: 1989180k/2097088k available (3531k kernel code, 107520k reserved, 2407k data, 244k init)
- Calibrating delay using timer specific routine.. 3602.44 BogoMIPS (lpj=1801223)
+ Calibrating delay using timer specific routine.. 3602.44 BogoMIPS (lpj=1801222)
  Mount-cache hash table entries: 256
  CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
  CPU: L2 Cache: 1024K (64 bytes/line)
  CPU 0(1) -> Node 0 -> Core 0
  mtrr: v2.0 (20020519)
- ACPI: setting ELCR to 0aa0 (from 08a0)
  Using local APIC timer interrupts.
  Detected 12.500 MHz APIC timer.
  softlockup thread 0 started up.
  Booting processor 1/2 APIC 0x1
  Initializing CPU#1
- spurious 8259A interrupt: IRQ7.
- Calibrating delay using timer specific routine.. 2002.43 BogoMIPS (lpj=1001218)
+ Calibrating delay using timer specific routine.. 1999.69 BogoMIPS (lpj=999849)
  CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
  CPU: L2 Cache: 1024K (64 bytes/line)
  CPU 1(1) -> Node 1 -> Core 0
  AMD Opteron(tm) Processor 244 stepping 0a
  CPU 1: Syncing TSC to CPU 0.
- CPU 1: synchronized TSC with CPU 0 (last diff -27 cycles, maxerr 503 cycles)
+ CPU 1: synchronized TSC with CPU 0 (last diff -2776 cycles, maxerr 618 cycles)
  Brought up 2 CPUs
  softlockup thread 1 started up.
  Disabling vsyscall due to use of PM timer
  time.c: Using PM based timekeeping.
- testing NMI watchdog ... CPU#1: NMI appears to be stuck (33->38)!
+ testing NMI watchdog ... OK.
  NET: Registered protocol family 16
  ACPI: bus type pci registered
  PCI: Using configuration type 1
  PCI: Using MMCONFIG at e0000000
  ACPI: Subsystem revision 20050902
  ACPI: Interpreter enabled
- ACPI: Using PIC for interrupt routing
- SCSI subsystem initialized
- usbcore: registered new driver usbfs
- usbcore: registered new driver hub
- PCI: Probing PCI hardware
+ ACPI: Using IOAPIC for interrupt routing
+ ACPI: PCI Root Bridge [PCI0] (0000:00)
  PCI: Probing PCI hardware (bus 00)
  PCI: Transparent bridge - 0000:00:09.0
  Boot video device is 0000:04:00.0
+ ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
+ ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
+ ACPI: PCI Interrupt Link [LNK1] (IRQs 5 *7 9 10 11 14 15)
+ ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 *11 14 15)
+ ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
+ ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
+ ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LACI] (IRQs *5 7 9 10 11 14 15)
+ ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 *11 14 15)
+ ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
+ ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
+ ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
+ ACPI: PCI Interrupt Link [LPCA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
+ ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
+ ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
+ ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
+ ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
+ ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
+ ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
+ ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
+ SCSI subsystem initialized
+ usbcore: registered new driver usbfs
+ usbcore: registered new driver hub
+ PCI: Using ACPI for IRQ routing
+ PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  PCI-DMA: Disabling AGP.
  PCI-DMA: More than 4GB of RAM and no IOMMU
  PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.
@@ -180,6 +219,8 @@
  loop: loaded (max 8 devices)
  pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
  tg3.c:v3.40 (September 15, 2005)
+ ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
+ ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 209
  PCI: Setting latency timer of device 0000:02:00.0 to 64
  eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:13:d4:04:42:47
  eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
@@ -203,10 +244,12 @@
  Uniform CD-ROM driver Revision: 3.20
  libata version 1.12 loaded.
  sata_sil version 0.9
- ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 11
- ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 11
- ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 11
- ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 11
+ ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
+ ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 217
+ ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 217
+ ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 217
+ ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 217
+ ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 217
  ata1: no device found (phy stat 00000000)
  scsi0 : sata_sil
  ata2: no device found (phy stat 00000000)
@@ -216,16 +259,20 @@
  ata4: no device found (phy stat 00000000)
  scsi3 : sata_sil
  sata_nv version 0.8
+ ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
+ ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 225
  PCI: Setting latency timer of device 0000:00:07.0 to 64
- ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 11
- ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 11
+ ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 225
+ ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 225
  ata5: no device found (phy stat 00000000)
  scsi4 : sata_nv
  ata6: no device found (phy stat 00000000)
  scsi5 : sata_nv
+ ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
+ ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 233
  PCI: Setting latency timer of device 0000:00:08.0 to 64
- ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 5
- ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 5
+ ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 233
+ ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 233
  ata7: dev 0 cfg 49:2f00 82:706b 83:7e01 84:4023 85:7069 86:3c01 87:4023 88:407f
  ata7: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
  nv_sata: Primary device added
@@ -259,24 +306,29 @@
   sdb:
  Attached scsi disk sdb at scsi7, channel 0, id 0, lun 0
  ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
- ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[7]  MMIO=[fdeff000-fdeff7ff]  Max Packet=[2048]
+ ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 209
+ ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[fdeff000-fdeff7ff]  Max Packet=[2048]
  ieee1394: raw1394: /dev/raw1394 device initialized
  sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
+ ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
+ ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 50
  PCI: Setting latency timer of device 0000:00:02.1 to 64
  ehci_hcd 0000:00:02.1: EHCI Host Controller
  ehci_hcd 0000:00:02.1: debug port 1
  ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
- ehci_hcd 0000:00:02.1: irq 11, io mem 0xfeb00000
+ ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
  PCI: cache line size of 64 is not supported by device 0000:00:02.1
  ehci_hcd 0000:00:02.1: park 0
  ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 10 ports detected
  ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
+ ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
+ ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 58
  PCI: Setting latency timer of device 0000:00:02.0 to 64
  ohci_hcd 0000:00:02.0: OHCI Host Controller
  ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
- ohci_hcd 0000:00:02.0: irq 5, io mem 0xfe02f000
+ ohci_hcd 0000:00:02.0: irq 58, io mem 0xfe02f000
  hub 2-0:1.0: USB hub found
  hub 2-0:1.0: 10 ports detected
  ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000030641c]
@@ -298,11 +350,13 @@
  w83627hf 9191-0290: Enabling temp2, readings might not make sense
  w83627hf 9191-0290: Enabling temp3, readings might not make sense
  Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
+ ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 23
+ ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 23 (level, low) -> IRQ 225
  PCI: Setting latency timer of device 0000:00:04.0 to 64
- intel8x0_measure_ac97_clock: measured 50739 usecs
- intel8x0: clocking to 46836
+ intel8x0_measure_ac97_clock: measured 50682 usecs
+ intel8x0: clocking to 46783
  ALSA device list:
-   #0: NVidia CK804 with ALC850 at 0xfe02d000, irq 5
+   #0: NVidia CK804 with ALC850 at 0xfe02d000, irq 225
  oprofile: using NMI interrupt.
  NET: Registered protocol family 2
  IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
@@ -331,18 +385,5 @@
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on sda2, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
- irq 7: nobody cared (try booting with the "irqpoll" option)
- 
- Call Trace: <IRQ> <ffffffff8046d013>{_spin_unlock_irqrestore+19}
-        <ffffffff8015cf08>{__report_bad_irq+56} <ffffffff8015d171>{note_interrupt+529}
-        <ffffffff8015c863>{handle_IRQ_event+51} <ffffffff8015c97f>{__do_IRQ+207}
-        <ffffffff801108c7>{do_IRQ+55} <ffffffff802a18d4>{acpi_processor_idle+0}
-        <ffffffff8010e3a2>{ret_from_intr+0}  <EOI> <ffffffff802a18d4>{acpi_processor_idle+0}
-        <ffffffff8010c77f>{cpu_idle+95} <ffffffff8010b035>{rest_init+53}
-        <ffffffff8077483a>{start_kernel+490} <ffffffff8077421b>{_sinittext+539}
-        
- handlers:
- [<ffffffff80356f00>] (ohci_irq_handler+0x0/0x7f0)
- Disabling IRQ #7
  tg3: eth0: Link is up at 100 Mbps, full duplex.
  tg3: eth0: Flow control is off for TX and off for RX.
