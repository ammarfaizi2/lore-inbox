Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWLCPwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWLCPwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbWLCPwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:52:19 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:64221 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1752809AbWLCPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:52:16 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD drive errors and lost ticks
Date: Sun, 03 Dec 2006 15:52:14 +0000
Message-Id: <120320061552.9126.4572F2AD0001D571000023A622058844849D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Oct  4 2006)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_9126_1165161134_0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_9126_1165161134_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi
It seems that your kernel is using IDE for your CDROM and libata for your other drives. I recall having a similar problem with my laptop (DMA Disabled) when I had both IDE and SATA/PATA support enabled. I had to disable IDE altogether and let SATA/PATA drivers handle all my drives in order to get DMA on the CDROM.

Try and pass ide=noprobe option to the kernel boot command line  and see if that makes a difference first - may be that will allow the SATA/PATA drivers to claim the CDROM before IDE sees it.

If that won't work try and disable ATA/ATAPI/MFM/RLL support in your config and enable Serial ATA (prod) and Parallel ATA (experimental drivers) and select the right SATA drivers as built ins or modules (I think in your case it is going to be NVIDIA SATA support and/or AMD/Nvidia PATA support but I may be wrong). Then rebuild the kernel and see if your DVD drive has DMA and you can watch DVDs.


Parag

 -------------- Original message ----------------------
From: Christoph Anton Mitterer <calestyo@scientia.net>
> Hi.
> 
> It seems that the old firmware doesn't solve the problem,... at least
> with one CD where I was sure that the drive wasn't able to read it in at
> all. I'm going to test other DVDs tuesday.
> 
> Thanks, Chris.
> 
> my kernel is 2.6.18.2
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.18
> # Fri Nov 10 01:13:28 2006
> #
> CONFIG_X86_64=y
> CONFIG_64BIT=y
> CONFIG_X86=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_MMU=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_DMI=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> # CONFIG_TASKSTATS is not set
> CONFIG_AUDIT=y
> CONFIG_AUDITSYSCALL=y
> # CONFIG_IKCONFIG is not set
> CONFIG_CPUSETS=y
> # CONFIG_RELAY is not set
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> # CONFIG_EMBEDDED is not set
> CONFIG_UID16=y
> CONFIG_SYSCTL=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_SLAB=y
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_RT_MUTEXES=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> # CONFIG_SLOB is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> CONFIG_MODULE_SRCVERSION_ALL=y
> CONFIG_KMOD=y
> CONFIG_STOP_MACHINE=y
> 
> #
> # Block layer
> #
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_LSF=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_AS=y
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="anticipatory"
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VSMP is not set
> CONFIG_MK8=y
> # CONFIG_MPSC is not set
> # CONFIG_GENERIC_CPU is not set
> CONFIG_X86_L1_CACHE_BYTES=64
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_INTERNODE_CACHE_BYTES=64
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=m
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> # CONFIG_SCHED_SMT is not set
> CONFIG_SCHED_MC=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_NUMA=y
> CONFIG_K8_NUMA=y
> CONFIG_NODES_SHIFT=6
> CONFIG_X86_64_ACPI_NUMA=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
> CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_NEED_MULTIPLE_NODES=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MIGRATION=y
> CONFIG_RESOURCES_64BIT=y
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
> CONFIG_OUT_OF_LINE_PFN_TO_PAGE=y
> CONFIG_NR_CPUS=4
> # CONFIG_HOTPLUG_CPU is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_IOMMU=y
> # CONFIG_CALGARY_IOMMU is not set
> CONFIG_SWIOTLB=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_INTEL is not set
> CONFIG_X86_MCE_AMD=y
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x200000
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_REORDER=y
> CONFIG_K8_NB=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_ISA_DMA_API=y
> CONFIG_GENERIC_PENDING_IRQ=y
> 
> #
> # Power management options
> #
> CONFIG_PM=y
> # CONFIG_PM_LEGACY is not set
> # CONFIG_PM_DEBUG is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
> # CONFIG_ACPI_SBS is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_MSI=y
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=m
> CONFIG_IA32_EMULATION=y
> CONFIG_IA32_AOUT=m
> CONFIG_COMPAT=y
> CONFIG_SYSVIPC_COMPAT=y
> 
> #
> # Networking
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_NETDEBUG is not set
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=y
> CONFIG_NET_KEY=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=y
> CONFIG_INET_ESP=y
> CONFIG_INET_IPCOMP=y
> CONFIG_INET_XFRM_TUNNEL=y
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
> CONFIG_IPV6=y
> CONFIG_IPV6_PRIVACY=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> CONFIG_INET6_IPCOMP=y
> CONFIG_INET6_XFRM_TUNNEL=y
> CONFIG_INET6_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_IPV6_TUNNEL=m
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETFILTER is not set
> 
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> 
> #
> # TIPC Configuration (EXPERIMENTAL)
> #
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_SYS_HYPERVISOR is not set
> 
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> # CONFIG_CONNECTOR is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> CONFIG_BLK_DEV_NBD=y
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_IDE_TASK_IOCTL=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=y
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_SATA=y
> # CONFIG_SCSI_SATA_AHCI is not set
> # CONFIG_SCSI_SATA_SVW is not set
> # CONFIG_SCSI_ATA_PIIX is not set
> # CONFIG_SCSI_SATA_MV is not set
> CONFIG_SCSI_SATA_NV=y
> # CONFIG_SCSI_PDC_ADMA is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_SATA_QSTOR is not set
> # CONFIG_SCSI_SATA_PROMISE is not set
> # CONFIG_SCSI_SATA_SX4 is not set
> # CONFIG_SCSI_SATA_SIL is not set
> # CONFIG_SCSI_SATA_SIL24 is not set
> # CONFIG_SCSI_SATA_SIS is not set
> # CONFIG_SCSI_SATA_ULI is not set
> # CONFIG_SCSI_SATA_VIA is not set
> # CONFIG_SCSI_SATA_VITESSE is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> # CONFIG_BLK_DEV_MD is not set
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_CRYPT=y
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_MIRROR is not set
> # CONFIG_DM_ZERO is not set
> # CONFIG_DM_MULTIPATH is not set
> 
> #
> # Fusion MPT device support
> #
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=y
> # CONFIG_FUSION_FC is not set
> # CONFIG_FUSION_SAS is not set
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_CTL=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_IEEE1394=y
> 
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> # CONFIG_IEEE1394_OUI_DB is not set
> CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
> CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
> # CONFIG_IEEE1394_EXPORT_FULL_API is not set
> 
> #
> # Device Drivers
> #
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=y
> 
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_SBP2=y
> CONFIG_IEEE1394_ETH1394=m
> CONFIG_IEEE1394_DV1394=m
> CONFIG_IEEE1394_RAWIO=y
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=y
> # CONFIG_NET_SB1000 is not set
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> 
> #
> # PHY device support
> #
> # CONFIG_PHYLIB is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MII is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> CONFIG_FORCEDETH=y
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_VIA_RHINE is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> # CONFIG_MYRI10GE is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=m
> # CONFIG_PPP_MULTILINK is not set
> # CONFIG_PPP_FILTER is not set
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> # CONFIG_PPP_DEFLATE is not set
> # CONFIG_PPP_BSDCOMP is not set
> # CONFIG_PPP_MPPE is not set
> CONFIG_PPPOE=m
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=m
> # CONFIG_JOYSTICK_A3D is not set
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> # CONFIG_JOYSTICK_GF2K is not set
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> # CONFIG_JOYSTICK_TMDC is not set
> # CONFIG_JOYSTICK_IFORCE is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> # CONFIG_JOYSTICK_SPACEORB is not set
> # CONFIG_JOYSTICK_SPACEBALL is not set
> # CONFIG_JOYSTICK_STINGER is not set
> # CONFIG_JOYSTICK_TWIDJOY is not set
> # CONFIG_JOYSTICK_JOYDUMP is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_GAMEPORT=m
> # CONFIG_GAMEPORT_NS558 is not set
> # CONFIG_GAMEPORT_L4 is not set
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_CONSOLE is not set
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_RAW_DRIVER is not set
> CONFIG_HPET=y
> # CONFIG_HPET_RTC_IRQ is not set
> # CONFIG_HPET_MMAP is not set
> CONFIG_HANGCHECK_TIMER=m
> 
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> 
> #
> # I2C Algorithms
> #
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> # CONFIG_I2C_ALGOPCA is not set
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_ISA=y
> CONFIG_I2C_NFORCE2=y
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
> # CONFIG_I2C_PCA_ISA is not set
> 
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_SENSORS_DS1337 is not set
> # CONFIG_SENSORS_DS1374 is not set
> CONFIG_SENSORS_EEPROM=y
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> 
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
> 
> #
> # Dallas's 1-wire bus
> #
> 
> #
> # Hardware Monitoring support
> #
> CONFIG_HWMON=y
> # CONFIG_HWMON_VID is not set
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_FSCPOS is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> CONFIG_SENSORS_SMSC47B397=y
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=y
> # CONFIG_VIDEO_V4L1 is not set
> # CONFIG_VIDEO_V4L1_COMPAT is not set
> CONFIG_VIDEO_V4L2=y
> 
> #
> # Video Capture Adapters
> #
> 
> #
> # Video Capture Adapters
> #
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_VIVI is not set
> # CONFIG_VIDEO_SAA7134 is not set
> # CONFIG_VIDEO_CX88 is not set
> 
> #
> # Encoders and Decoders
> #
> # CONFIG_VIDEO_MSP3400 is not set
> # CONFIG_VIDEO_CS53L32A is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_WM8775 is not set
> # CONFIG_VIDEO_WM8739 is not set
> # CONFIG_VIDEO_CX2341X is not set
> # CONFIG_VIDEO_CX25840 is not set
> # CONFIG_VIDEO_SAA711X is not set
> # CONFIG_VIDEO_SAA7127 is not set
> # CONFIG_VIDEO_UPD64031A is not set
> # CONFIG_VIDEO_UPD64083 is not set
> 
> #
> # V4L USB devices
> #
> # CONFIG_VIDEO_PVRUSB2 is not set
> 
> #
> # Radio Adapters
> #
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> # CONFIG_USB_DABUSB is not set
> 
> #
> # Graphics support
> #
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_MACMODES is not set
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_INTEL is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_GEODE is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> CONFIG_VIDEO_SELECT=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> # CONFIG_LOGO is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=m
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_PCM_OSS_PLUGINS=y
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_RTCTIMER=y
> CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
> # CONFIG_SND_DYNAMIC_MINORS is not set
> CONFIG_SND_SUPPORT_OLD_API=y
> # CONFIG_SND_VERBOSE_PROCFS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=y
> CONFIG_SND_AC97_CODEC=y
> CONFIG_SND_AC97_BUS=y
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDA_INTEL is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> CONFIG_SND_ICE1724=y
> CONFIG_SND_INTEL8X0=y
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
> 
> #
> # USB devices
> #
> CONFIG_SND_USB_AUDIO=y
> # CONFIG_SND_USB_USX2Y is not set
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_USB_ARCH_HAS_EHCI=y
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_SUSPEND is not set
> # CONFIG_USB_OTG is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_OHCI_BIG_ENDIAN is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> # CONFIG_USB_UHCI_HCD is not set
> # CONFIG_USB_SL811_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> 
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
> 
> #
> # may also be needed; see USB_STORAGE Help for more information
> #
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_LIBUSUAL is not set
> 
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=y
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_ACECAD is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_TOUCHSCREEN is not set
> # CONFIG_USB_YEALINK is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> # CONFIG_USB_ATI_REMOTE2 is not set
> # CONFIG_USB_KEYSPAN_REMOTE is not set
> # CONFIG_USB_APPLETOUCH is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> 
> #
> # USB Network Adapters
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_MON is not set
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETKIT is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TEST is not set
> 
> #
> # USB DSL modem support
> #
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
> 
> #
> # LED devices
> #
> # CONFIG_NEW_LEDS is not set
> 
> #
> # LED drivers
> #
> 
> #
> # LED Triggers
> #
> 
> #
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
> # CONFIG_IPATH_CORE is not set
> 
> #
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
> #
> CONFIG_EDAC=m
> 
> #
> # Reporting subsystems
> #
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_MM_EDAC=m
> # CONFIG_EDAC_E752X is not set
> CONFIG_EDAC_K8=m
> # CONFIG_EDAC_I5000 is not set
> CONFIG_EDAC_POLL=y
> 
> #
> # Real Time Clock
> #
> # CONFIG_RTC_CLASS is not set
> 
> #
> # DMA Engine support
> #
> CONFIG_DMA_ENGINE=y
> 
> #
> # DMA Clients
> #
> CONFIG_NET_DMA=y
> 
> #
> # DMA Devices
> #
> CONFIG_INTEL_IOATDMA=m
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=m
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT2_FS_XIP=y
> CONFIG_FS_XIP=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> CONFIG_REISERFS_FS_POSIX_ACL=y
> CONFIG_REISERFS_FS_SECURITY=y
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_SECURITY=y
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=m
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_SECURITY=y
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_OCFS2_FS is not set
> CONFIG_MINIX_FS=m
> CONFIG_ROMFS_FS=m
> CONFIG_INOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_DNOTIFY=y
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=m
> # CONFIG_FUSE_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=y
> CONFIG_UDF_FS=y
> CONFIG_UDF_NLS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> # CONFIG_CONFIGFS_FS is not set
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ASFS_FS is not set
> # CONFIG_HFS_FS is not set
> CONFIG_HFSPLUS_FS=m
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=m
> CONFIG_VXFS_FS=m
> CONFIG_HPFS_FS=m
> CONFIG_QNX4FS_FS=m
> CONFIG_SYSV_FS=m
> CONFIG_UFS_FS=m
> # CONFIG_UFS_FS_WRITE is not set
> # CONFIG_UFS_DEBUG is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_NFS_ACL_SUPPORT=m
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=m
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_XATTR is not set
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_EXPERIMENTAL is not set
> CONFIG_NCP_FS=m
> CONFIG_NCPFS_PACKET_SIGNING=y
> CONFIG_NCPFS_IOCTL_LOCKING=y
> CONFIG_NCPFS_STRONG=y
> CONFIG_NCPFS_NFS_NS=y
> CONFIG_NCPFS_OS2_NS=y
> # CONFIG_NCPFS_SMALLDOS is not set
> CONFIG_NCPFS_NLS=y
> CONFIG_NCPFS_EXTRAS=y
> CONFIG_CODA_FS=m
> # CONFIG_CODA_FS_OLD_API is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_ACORN_PARTITION=y
> CONFIG_ACORN_PARTITION_CUMANA=y
> CONFIG_ACORN_PARTITION_EESOX=y
> CONFIG_ACORN_PARTITION_ICS=y
> CONFIG_ACORN_PARTITION_ADFS=y
> CONFIG_ACORN_PARTITION_POWERTEC=y
> CONFIG_ACORN_PARTITION_RISCIX=y
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> CONFIG_ATARI_PARTITION=y
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> CONFIG_SGI_PARTITION=y
> CONFIG_ULTRIX_PARTITION=y
> CONFIG_SUN_PARTITION=y
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=m
> CONFIG_NLS_CODEPAGE_852=m
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=m
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_UTF8=m
> 
> #
> # Instrumentation Support
> #
> # CONFIG_PROFILING is not set
> # CONFIG_KPROBES is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_KERNEL is not set
> CONFIG_LOG_BUF_SHIFT=15
> # CONFIG_DEBUG_FS is not set
> # CONFIG_UNWIND_INFO is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_DEBUG_PROC_KEYS is not set
> CONFIG_SECURITY=y
> # CONFIG_SECURITY_NETWORK is not set
> CONFIG_SECURITY_CAPABILITIES=y
> # CONFIG_SECURITY_ROOTPLUG is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_TGR192=m
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_X86_64=y
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> CONFIG_CRYPTO_TEST=m
> 
> #
> # Hardware crypto devices
> #
> 
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> CONFIG_CRC16=m
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_PLIST=y
> 
> 
> 
> 
> dmesg:
> Bootdata ok (command line is root=/dev/sda1 ro snd-ice1724.index=0
> snd-intel8x0.index=1 )
> Linux version 2.6.18 () (root@euler) (gcc version 4.1.2 20061028
> (prerelease) (Debian 4.1.1-19)) #1 SMP PREEMPT Fri Nov 10 01:18:51 CET 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
>  BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000da000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
>  BIOS-e820: 000000007ff80000 - 000000007ff91000 (ACPI data)
>  BIOS-e820: 000000007ff91000 - 0000000080000000 (ACPI NVS)
>  BIOS-e820: 0000000080000000 - 000000009ff80000 (usable)
>  BIOS-e820: 000000009ff80000 - 00000000a0000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @
> 0x00000000000f78f0
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
> 0x000000007ff8b258
> ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @
> 0x000000007ff90b06
> ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @
> 0x000000007ff90b7a
> ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @
> 0x000000007ff90bca
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
> 0x000000007ff90c68
> ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
> 0x000000007ff90c90
> ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @
> 0x0000000000000000
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2
> Node 0 using interleaving mode 1/0
> No NUMA configuration found
> Faking a node at 0000000000000000-000000009ff80000
> Bootmem setup node 0 0000000000000000-000000009ff80000
> On node 0 totalpages: 644782
>   DMA zone: 2676 pages, LIFO batch:0
>   DMA32 zone: 642106 pages, LIFO batch:31
> Nvidia board detected. Ignoring ACPI timer override.
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:1 APIC version 16
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:1 APIC version 16
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
> Processor #2 15:1 APIC version 16
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
> Processor #3 15:1 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x05] address[0xd0000000] gsi_base[24])
> IOAPIC[1]: apic_id 5, version 17, address 0xd0000000, GSI 24-27
> ACPI: IOAPIC (id[0x06] address[0xd0001000] gsi_base[28])
> IOAPIC[2]: apic_id 6, version 17, address 0xd0001000, GSI 28-31
> ACPI: IOAPIC (id[0x07] address[0xd0800000] gsi_base[32])
> IOAPIC[3]: apic_id 7, version 17, address 0xd0800000, GSI 32-55
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> ACPI: IRQ9 used by override.
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at a4000000 (gap: a0000000:40000000)
> Built 1 zonelists.  Total pages: 644782
> Kernel command line: root=/dev/sda1 ro snd-ice1724.index=0
> snd-intel8x0.index=1
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Disabling vsyscall due to use of PM timer
> time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
> time.c: Detected 2210.224 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Checking aperture...
> CPU 0: aperture @ ac000000 size 64 MB
> CPU 1: aperture @ ac000000 size 64 MB
> Memory: 2572708k/2620928k available (3007k kernel code, 47304k reserved,
> 1245k data, 216k init)
> Calibrating delay using timer specific routine.. 4422.26 BogoMIPS
> (lpj=2211133)
> Security Framework v1.0.0 initialized
> Capability LSM initialized
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0/0 -> Node 0
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> Freeing SMP alternatives: 32k freed
> ACPI: Core revision 20060707
> spurious 8259A interrupt: IRQ7.
> Using local APIC timer interrupts.
> result 12558091
> Detected 12.558 MHz APIC timer.
> Booting processor 1/4 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4419.72 BogoMIPS
> (lpj=2209861)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1/1 -> Node 0
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 1
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff 2 cycles, maxerr 581 cycles)
> Booting processor 2/4 APIC 0x2
> Initializing CPU#2
> Calibrating delay using timer specific routine.. 4419.79 BogoMIPS
> (lpj=2209897)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 2/2 -> Node 0
> CPU: Physical Processor ID: 1
> CPU: Processor Core ID: 0
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 2: Syncing TSC to CPU 0.
> CPU 2: synchronized TSC with CPU 0 (last diff -118 cycles, maxerr 1098
> cycles)
> Booting processor 3/4 APIC 0x3
> Initializing CPU#3
> Calibrating delay using timer specific routine.. 4419.79 BogoMIPS
> (lpj=2209898)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 3/3 -> Node 0
> CPU: Physical Processor ID: 1
> CPU: Processor Core ID: 1
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff -130 cycles, maxerr 1087
> cycles)
> Brought up 4 CPUs
> testing NMI watchdog ... OK.
> migration_cost=400
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> PCI: Transparent bridge - 0000:00:09.0
> Boot video device is 0000:02:00.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0
> ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
> ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Root Bridge [PCI2] (0000:10)
> PCI: Probing PCI hardware (bus 10)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
> ACPI: PCI Root Bridge [PCI1] (0000:80)
> PCI: Probing PCI hardware (bus 80)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.XVR0._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 48 49 50 51) *0, disabled.
> ACPI: PCI Interrupt Link [LNK2] (IRQs 48 49 50 51) *0, disabled.
> ACPI: PCI Interrupt Link [LNK3] (IRQs 48 49 50 51) *0, disabled.
> ACPI: PCI Interrupt Link [LNK4] (IRQs 48 49 50 51) *0, disabled.
> ACPI: PCI Interrupt Link [LNK5] (IRQs 48 49 50 51) *0, disabled.
> ACPI: PCI Interrupt Link [LUS0] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LUS2] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LMAC] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LACI] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LMCI] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LPID] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LTID] (IRQs 52 53 54 55) *0, disabled.
> ACPI: PCI Interrupt Link [LSI1] (IRQs 52 53 54 55) *0, disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 14 devices
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
> report
> PCI-DMA: Disabling IOMMU.
> pnp: 00:02: ioport range 0x8000-0x807f could not be reserved
> pnp: 00:02: ioport range 0x8080-0x80ff has been reserved
> pnp: 00:02: ioport range 0x8400-0x847f has been reserved
> pnp: 00:02: ioport range 0x8480-0x84ff has been reserved
> pnp: 00:02: ioport range 0x8800-0x887f has been reserved
> pnp: 00:02: ioport range 0x8880-0x88ff has been reserved
> pnp: 00:02: ioport range 0xa000-0xa03f has been reserved
> pnp: 00:02: ioport range 0xa040-0xa07f has been reserved
> PCI: Bridge: 0000:00:09.0
>   IO window: disabled.
>   MEM window: b0100000-b01fffff
>   PREFETCH window: disabled.
> PCI: Failed to allocate mem resource #6:20000@d0000000 for 0000:02:00.0
> PCI: Bridge: 0000:00:0e.0
>   IO window: 2000-2fff
>   MEM window: b1000000-b2ffffff
>   PREFETCH window: c0000000-cfffffff
> PCI: Setting latency timer of device 0000:00:09.0 to 64
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> PCI: Bridge: 0000:10:0a.0
>   IO window: 3000-3fff
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:10:0b.0
>   IO window: 4000-4fff
>   MEM window: d0100000-d05fffff
>   PREFETCH window: a4000000-a41fffff
> PCI: Bridge: 0000:80:0e.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Setting latency timer of device 0000:80:0e.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> Simple Boot Flag at 0x36 set to 0x1
> audit: initializing netlink socket (disabled)
> audit(1165155063.185:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
> PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
> pci 0000:12:04.0: HCRESET not completed yet!
> pci 0000:12:04.1: HCRESET not completed yet!
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:0e.0:pcie00]
> PCI: Setting latency timer of device 0000:80:0e.0 to 64
> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:80:0e.0:pcie00]
> ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> Real Time Clock Driver v1.12ac
> Non-volatile memory driver v1.2
> Linux agpgart interface v0.101 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> nbd: registered device at major 43
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
> ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 23
> GSI 16 sharing vector 0xC9 and IRQ 16
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LMAC] -> GSI 23 (level,
> high) -> IRQ 201
> PCI: Setting latency timer of device 0000:00:0a.0 to 64
> forcedeth: using HIGHDMA
> eth0: forcedeth.c: subsystem: 010f1:2895 bound to 0000:00:0a.0
> ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 55
> GSI 17 sharing vector 0xD1 and IRQ 17
> ACPI: PCI Interrupt 0000:80:0a.0[A] -> Link [LMAC] -> GSI 55 (level,
> high) -> IRQ 209
> PCI: Setting latency timer of device 0000:80:0a.0 to 64
> forcedeth: using HIGHDMA
> eth1: forcedeth.c: subsystem: 010f1:2895 bound to 0000:80:0a.0
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> Linux video capture interface: v2.00
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
> NFORCE-CK804: chipset revision 242
> NFORCE-CK804: not 100% native mode: will probe irqs later
> NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
>     ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: IC35L120AVV207-1, ATA DISK drive
> hdb: PLEXTOR DVDR PX-760A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> Probing IDE interface ide1...
> hda: max request size: 512KiB
> hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63,
> UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
> Uniform CD-ROM driver Revision: 3.20
> Loading iSCSI transport class v1.1-646.<7>libata version 2.00 loaded.
> sata_nv 0000:00:07.0: version 2.0
> ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
> GSI 18 sharing vector 0xD9 and IRQ 18
> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level,
> high) -> IRQ 217
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0x1C40 ctl 0x1C36 bmdma 0x1C10 irq 217
> ata2: SATA max UDMA/133 cmd 0x1C38 ctl 0x1C32 bmdma 0x1C18 irq 217
> scsi0 : sata_nv
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/133
> scsi1 : sata_nv
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
> ata2.00: ata2: dev 0 multi count 16
> ata2.00: configured for UDMA/133
>   Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 21
> GSI 19 sharing vector 0xE1 and IRQ 19
> ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 21 (level,
> high) -> IRQ 225
> PCI: Setting latency timer of device 0000:00:08.0 to 64
> ata3: SATA max UDMA/133 cmd 0x1C58 ctl 0x1C4E bmdma 0x1C20 irq 225
> ata4: SATA max UDMA/133 cmd 0x1C50 ctl 0x1C4A bmdma 0x1C28 irq 225
> scsi2 : sata_nv
> ata3: SATA link down (SStatus 0 SControl 300)
> scsi3 : sata_nv
> ata4: SATA link down (SStatus 0 SControl 300)
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3
> sd 0:0:0:0: Attached scsi disk sda
> SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb: sdb1
> sd 1:0:0:0: Attached scsi disk sdb
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sd 1:0:0:0: Attached scsi generic sg1 type 0
> Fusion MPT base driver 3.04.01
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.04.01
> GSI 20 sharing vector 0xE9 and IRQ 20
> ACPI: PCI Interrupt 0000:12:06.0[A] -> GSI 30 (level, low) -> IRQ 233
> mptbase: Initiating ioc0 bringup
> ioc0: 53C1030: Capabilities={Initiator,Target}
> scsi4 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=233
> GSI 21 sharing vector 0x32 and IRQ 21
> ACPI: PCI Interrupt 0000:12:06.1[B] -> GSI 31 (level, low) -> IRQ 50
> mptbase: Initiating ioc1 bringup
> ioc1: 53C1030: Capabilities={Initiator,Target}
> scsi5 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=50
> Fusion MPT misc device (ioctl) driver 3.04.01
> mptctl: Registered with Fusion MPT base driver
> mptctl: /dev/mptctl @ (major,minor=10,220)
> ieee1394: Initialized config rom entry `ip1394'
> ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 19
> GSI 22 sharing vector 0x3A and IRQ 22
> ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK4] -> GSI 19 (level,
> high) -> IRQ 58
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58] 
> MMIO=[b0104000-b01047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> ieee1394: raw1394: /dev/raw1394 device initialized
> ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
> ieee1394: sbp2: Try serialize_io=0 for better performance
> ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
> GSI 23 sharing vector 0x42 and IRQ 23
> ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 20 (level,
> high) -> IRQ 66
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ehci_hcd 0000:00:02.1: EHCI Host Controller
> ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:02.1: debug port 1
> PCI: cache line size of 64 is not supported by device 0000:00:02.1
> ehci_hcd 0000:00:02.1: irq 66, io mem 0xb0001000
> ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 10 ports detected
> ACPI: PCI Interrupt 0000:12:04.2[C] -> GSI 30 (level, low) -> IRQ 233
> PCI: VIA IRQ fixup for 0000:12:04.2, from 5 to 9
> ehci_hcd 0000:12:04.2: EHCI Host Controller
> ehci_hcd 0000:12:04.2: new USB bus registered, assigned bus number 2
> ehci_hcd 0000:12:04.2: irq 233, io mem 0xd0100000
> ehci_hcd 0000:12:04.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 4 ports detected
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 23 (level,
> high) -> IRQ 201
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:00:02.0: irq 201, io mem 0xb0000000
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 10 ports detected
> Initializing USB Mass Storage driver...
> usb 2-1: new high speed USB device using ehci_hcd and address 2
> usb 2-1: configuration #1 chosen from 1 choice
> usb 3-2: new low speed USB device using ohci_hcd and address 2
> usb 3-2: configuration #1 chosen from 1 choice
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0810000238d2d]
> usb 3-4: new full speed USB device using ohci_hcd and address 3
> usb 3-4: configuration #1 chosen from 1 choice
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver hiddev
> input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input0
> input: USB HID v1.11 Keyboard [Microsoft Natural® Ergonomic Keyboard
> 4000] on usb-0000:00:02.0-2
> input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input1
> input: USB HID v1.11 Device [Microsoft Natural® Ergonomic Keyboard 4000]
> on usb-0000:00:02.0-2
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: PC Speaker as /class/input/input2
> i2c /dev entries driver
> i2c_adapter i2c-0: nForce2 SMBus adapter at 0xa000
> i2c_adapter i2c-1: nForce2 SMBus adapter at 0xa040
> smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 1)
> device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
> dm-devel@redhat.com
> Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
> 13:55:50 2006 UTC).
> ACPI: PCI Interrupt Link [LACI] enabled at IRQ 22
> ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LACI] -> GSI 22 (level,
> high) -> IRQ 217
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> input: PS2++ Logitech MX Mouse as /class/input/input3
> AC'97 0 analog subsections not ready
> intel8x0_measure_ac97_clock: measured 51852 usecs
> intel8x0: clocking to 46813
> GSI 24 sharing vector 0x4A and IRQ 24
> ACPI: PCI Interrupt 0000:11:04.0[A] -> GSI 24 (level, low) -> IRQ 74
> usbcore: registered new driver snd-usb-audio
> ALSA device list:
>   #0: Terratec Aureon 7.1-Universe at 0x3080, irq 74
>   #1: NVidia CK804 with AD1981B at 0xb0002000, irq 217
> TCP bic registered
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 216k freed
> eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> EDAC MC: Ver: 2.0.1 Nov 10 2006
> EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
> EDAC MC1: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:19.2
> EXT3 FS on sda1, internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda3, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> CSLIP: code copyright 1989 Regents of the University of California
> PPP generic driver version 2.4.2
> NET: Registered protocol family 24
> eth0: no IPv6 routers present
> eth1: no IPv6 routers present
> nvidia: module license 'NVIDIA' taints kernel.
> ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 18
> GSI 25 sharing vector 0x52 and IRQ 25
> ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK3] -> GSI 18 (level,
> high) -> IRQ 82
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8776  Mon Oct 16
> 21:53:43 PDT 2006
> i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
> i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
> i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for chips
> gaim[3409]: segfault at 0000000000000120 rip 00002b3349200acd rsp
> 0000000040fff020 error 6
> cdrom: This disc doesn't have any tracks I recognize!
> 
> 
> My System:
> Mainboard: Tyan S2895
> Chipsets: Nvidia nforce professional 2200 and 2050 and AMD 8131
> CPU: 2x DualCore Opterons model 275
> RAM: 4GB Kingston Registered/ECC
> Diskdrives: IBM/Hitachi: 1 PATA, 2 SATA
> 



--NextPart_Webmail_9m3u9jl4l_9126_1165161134_0
Content-Type: message/rfc822

From: Christoph Anton Mitterer <calestyo@scientia.net>
To: kernel-stuff@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD drive errors and lost ticks
Date: Sun, 3 Dec 2006 15:01:43 +0000
Content-Type: Multipart/mixed;
 boundary="NextPart_Webmail_9m3u9jl4l_9126_1165161134_1"

--NextPart_Webmail_9m3u9jl4l_9126_1165161134_1
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--NextPart_Webmail_9m3u9jl4l_9126_1165161134_1--

--NextPart_Webmail_9m3u9jl4l_9126_1165161134_0--
