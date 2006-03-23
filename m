Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWCWTNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWCWTNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWCWTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:13:50 -0500
Received: from smtpout.mac.com ([17.250.248.71]:17372 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422655AbWCWTNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:13:49 -0500
In-Reply-To: <5BB1BC1D-51CE-42A9-83CA-024A8CB1ACA2@mac.com>
References: <200603230543.k2N5hhg22185@unix-os.sc.intel.com> <5BB1BC1D-51CE-42A9-83CA-024A8CB1ACA2@mac.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4D864C3C-7FCB-424D-91E2-76DEA69524F1@mac.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: 2.6.16 hugetlbfs problem
Date: Thu, 23 Mar 2006 13:13:45 -0600
To: Mark Rustad <mrustad@mac.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 23, 2006, at 9:36 AM, Mark Rustad wrote:

> On Mar 22, 2006, at 11:43 PM, Chen, Kenneth W wrote:
>
>> Mark Rustad wrote on Wednesday, March 22, 2006 3:33 PM
>>>>> I seem to be having trouble using hugetlbfs with kernel 2.6.16. I
>>>>> have a small test program that worked with 2.6.16-rc5, but  
>>>>> fails with
>>>>> 2.6.16-rc6 or the release. The program is below. Given a path to a
>>>>> file on a hugetlbfs, it opens/creates the file, mmaps it and  
>>>>> tries to
>>>>> access the first word. On 2.6.16-rc5, it works. On 2.6.16, it  
>>>>> hangs
>>>>> page-faulting until it is killed.
>>>>
>>>> On what platform?  Things like hugetlb and address space layout
>>>> (you're requesting a specific mmap() address I noticed) are very
>>>> platform specific.
>>>
>>> This is on a Xeon, without PAE with the 1GB no-highmem memory  
>>> map, in
>>> all three cases. This is a 32-bit kernel running on a Nacona CPU. I
>>> also had an unmap call over the range to be mmap-ed, but the  
>>> failure/
>>> success cases were the same, so I removed it to reduce the test
>>> program further.
>>
>> It might be something else happening in your environment. I ran  
>> your test
>> code on a similar system. It ran just fine.
>
> Perhaps. I have tried more stuff here, but still no joy. I have put  
> my kernel configuration below. You will see that it is a mostly- 
> monolithic kernel. It is weird that it works with 2.6.16-rc5, but  
> not later. I looked at the incremental patch but nothing jumped out  
> at me, but I am not a vm wizard. I will look again.

It appears that this problem is configuration-related. By turning off  
the kernel debugging options that I had on, things started working. I  
have not yet isolated which of the options being enabled is causing  
the problem, but there was no noise in the kernel log when they were  
enabled and I was experiencing the problem. I will post more after I  
know more.

The kernel version was a red herring. I had turned on the kernel  
debugging options between the two builds. I had just mistakenly  
associated the failure with the update and had forgotten the  
debugging options that I had added when I configured the new kernel.  
I had turned them to just look more carefully for general trouble. No  
good deed goes unpunished. :-)

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.16-0a
> # Mon Mar 20 12:42:24 2006
> #
> CONFIG_X86_32=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_DMI=y
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
> # CONFIG_SYSVIPC is not set
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> # CONFIG_IKCONFIG is not set
> # CONFIG_CPUSETS is not set
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_UID16 is not set
> # CONFIG_VM86 is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_EMBEDDED=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> CONFIG_SLAB=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> # CONFIG_SLOB is not set
>
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_KMOD is not set
> CONFIG_STOP_MACHINE=y
>
> #
> # Block layer
> #
> CONFIG_LBD=y
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> # CONFIG_IOSCHED_AS is not set
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_IOSCHED_CFQ is not set
> # CONFIG_DEFAULT_AS is not set
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> CONFIG_DEFAULT_NOOP=y
> CONFIG_DEFAULT_IOSCHED="noop"
>
> #
> # Processor type and features
> #
> # CONFIG_X86_PC is not set
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> CONFIG_X86_GENERICARCH=y
> # CONFIG_X86_ES7000 is not set
> CONFIG_X86_CYCLONE_TIMER=y
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> CONFIG_MPENTIUM4=y
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=2
> # CONFIG_SCHED_SMT is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> CONFIG_X86_MCE_P4THERMAL=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
>
> #
> # Firmware Drivers
> #
> CONFIG_EDD=y
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_VMSPLIT_3G is not set
> CONFIG_VMSPLIT_3G_OPT=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xB0000000
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> # CONFIG_IRQBALANCE is not set
> CONFIG_REGPARM=y
> # CONFIG_SECCOMP is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_KEXEC is not set
> CONFIG_PHYSICAL_START=0x100000
> # CONFIG_HOTPLUG_CPU is not set
> CONFIG_DOUBLEFAULT=y
>
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_PM_LEGACY is not set
> # CONFIG_PM_DEBUG is not set
>
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_X86_PM_TIMER is not set
> # CONFIG_ACPI_CONTAINER is not set
>
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> # CONFIG_CPU_FREQ_DEBUG is not set
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
>
> #
> # CPUFreq processor drivers
> #
> # CONFIG_X86_ACPI_CPUFREQ is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> CONFIG_X86_P4_CLOCKMOD=y
> # CONFIG_X86_CPUFREQ_NFORCE2 is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
>
> #
> # shared options
> #
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> CONFIG_X86_SPEEDSTEP_LIB=y
>
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCI_MSI is not set
> # CONFIG_PCI_LEGACY_PROC is not set
> # CONFIG_PCI_DEBUG is not set
> CONFIG_ISA_DMA_API=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
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
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_MISC=y
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
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_ASK_IP_FIB_HASH=y
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_MULTIPLE_TABLES=y
> # CONFIG_IP_ROUTE_MULTIPATH is not set
> # CONFIG_IP_ROUTE_VERBOSE is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_TUNNEL is not set
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
> CONFIG_IPV6=y
> # CONFIG_IPV6_PRIVACY is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_IPV6_TUNNEL is not set
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
> # CONFIG_NET_DIVERT is not set
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
> # CONFIG_FW_LOADER is not set
> # CONFIG_DEBUG_DRIVER is not set
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
> # CONFIG_PNP is not set
>
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=8
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
>
> #
> # ATA/ATAPI/MFM/RLL support
> #
> # CONFIG_IDE is not set
>
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
>
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> CONFIG_SCSI_LOGGING=y
>
> #
> # SCSI Transport Attributes
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> CONFIG_SCSI_ISCSI_ATTRS=y
> # CONFIG_SCSI_SAS_ATTRS is not set
>
> #
> # SCSI Transport Layers
> #
> CONFIG_SAS_CLASS=y
> CONFIG_SAS_DEBUG=y
>
> #
> # SCSI low-level drivers
> #
> CONFIG_ISCSI_TCP=m
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC94XX=m
> CONFIG_AIC94XX_DEBUG=y
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_SATA=y
> # CONFIG_SCSI_SATA_AHCI is not set
> # CONFIG_SCSI_SATA_SVW is not set
> # CONFIG_SCSI_ATA_PIIX is not set
> # CONFIG_SCSI_SATA_MV is not set
> # CONFIG_SCSI_SATA_NV is not set
> # CONFIG_SCSI_PDC_ADMA is not set
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
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_FC is not set
> # CONFIG_FUSION_SAS is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
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
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
>
> #
> # PHY device support
> #
>
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
>
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> CONFIG_E1000=y
> CONFIG_E1000_NAPI=y
> # CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
>
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
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
> # CONFIG_PPP is not set
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
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
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
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
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
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_NOWAYOUT=y
>
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_SC520_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_IBMASR is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I6300ESB_WDT is not set
> # CONFIG_I8XX_TCO is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_SBC8360_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
>
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_HW_RANDOM=y
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_CS5535_GPIO is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
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
> CONFIG_I2C_I801=y
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_ISA=y
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
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
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> CONFIG_SENSORS_PCA9551=m
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_SENSORS_RTC8564 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_RTC_X1205_I2C is not set
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
> # CONFIG_W1 is not set
>
> #
> # Hardware Monitoring support
> #
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_F71805F is not set
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
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83781D is not set
> CONFIG_SENSORS_W83792D=m
> # CONFIG_SENSORS_W83L785TS is not set
> CONFIG_SENSORS_W83627HF=y
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
> # Multimedia Capabilities Port drivers
> #
>
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> # CONFIG_VIDEO_SELECT is not set
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
>
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
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
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
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
> CONFIG_USB_STORAGE_FREECOM=y
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> CONFIG_USB_LIBUSUAL=y
>
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_ACECAD is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_ITMTOUCH is not set
> # CONFIG_USB_EGALAX is not set
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
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
>
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
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
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETKIT is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_IDMOUSE is not set
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
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
>
> #
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
> #
> CONFIG_EDAC=y
>
> #
> # Reporting subsystems
> #
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_MM_EDAC=y
> # CONFIG_EDAC_AMD76X is not set
> # CONFIG_EDAC_E7XXX is not set
> CONFIG_EDAC_E752X=y
> # CONFIG_EDAC_I82875P is not set
> # CONFIG_EDAC_I82860 is not set
> # CONFIG_EDAC_R82600 is not set
> CONFIG_EDAC_POLL=y
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_EXT2_FS_SECURITY is not set
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> # CONFIG_XFS_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_INOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_DNOTIFY is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_UDF_FS is not set
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> CONFIG_RELAYFS_FS=y
> # CONFIG_CONFIGFS_FS is not set
>
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> # CONFIG_NFSD is not set
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
>
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="UTF-8"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
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
> # CONFIG_PRINTK_TIME is not set
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_LOG_BUF_SHIFT=16
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_SCHEDSTATS is not set
> CONFIG_DEBUG_SLAB=y
> # CONFIG_DEBUG_PREEMPT is not set
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> CONFIG_DEBUG_VM=y
> # CONFIG_FRAME_POINTER is not set
> CONFIG_FORCED_INLINING=y
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_DEBUG_PAGEALLOC=y
> # CONFIG_DEBUG_RODATA is not set
> CONFIG_4KSTACKS=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
>
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
>
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_AES_586 is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Hardware crypto devices
> #
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
>
> #
> # Library routines
> #
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_X86_SMP=y
> CONFIG_X86_HT=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_TRAMPOLINE=y
> CONFIG_KTIME_SCALAR=y

-- 
Mark Rustad, MRustad@mac.com

