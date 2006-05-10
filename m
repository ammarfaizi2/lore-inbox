Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEJTor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEJTor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEJTor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:44:47 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:2537 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751248AbWEJTop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:44:45 -0400
Date: Wed, 10 May 2006 15:44:26 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Robert Crocombe <rwcrocombe@raytheon.com>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rtXYZ hangs at boot on quad Opteron
In-Reply-To: <44623EE0.8040300@raytheon.com>
Message-ID: <Pine.LNX.4.58.0605101540490.22959@gandalf.stny.rr.com>
References: <44623EE0.8040300@raytheon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robert,

Thanks, for reporting this.  For further reports, could you please CC Ingo
Molnar.  I added him to this since he is the maintainer of the -rt patch
set. If I get some time, I'll look into this too, but I'm not running
Fedora, and I don't have a Opteron quad :(   Ingo has an 8x but I'm not
sure what CPUs it has.

-- Steve

On Wed, 10 May 2006, Robert Crocombe wrote:

> I am having trouble getting a recent -rt kernel running on a quad
> Opteron box[1] running Fedora Core 4 (64-bit).  This box previously ran
> Debian etch (64-bit) and used the 2.6.14-rt9 kernel.  Attempts with
> recent kernels have had these results:
>
> 2.6.14-rt22     boots, middling performance[2], hung
> 2.6.15          OK
> 2.6.15-rt1      builds, NULL ptr deref on boot
> 2.6.15-rt10     builds, NULL ptr deref on boot
> 2.6.15-rt15     builds, NULL ptr deref on boot
> 2.6.15-21       doesn't build
> 2.6.16          OK
> 2.6.16.8        OK
> 2.6.16-rt01     doesn't build
> 2.6.16-rt02     "
> 2.6.16-rt03     "
> 2.6.16-rt04     "
> 2.6.16-rt05     "
> 2.6.16-rt06     builds, doesn't boot
> 2.6.16-rt07     "
> 2.6.16-rt10     "
> 2.6.16-rt20     "
>
> The recent kernels all immediately hang after displaying "Booting the
> kernel.".
>
> The stock Linus kernels all work fine.
>
> The way I've been configuring the kernels is that I boot into 2.6.16
> and do a:
>
> zcat /proc/config.gz > .config
>
> and then
>
> make oldconfig
>
> and accept the default choice for all the questions posed.  I'll
> attach the 2.6.16 config [3] and a diff to the config for 2.6.16-rt10
> [4] (I managed to delete the -rt20 kernel when trying to prune a
> very lengthy grub list).
>
>
> Let me know what would help you debug.
>
> Please CC.
>
> Thanks.
>
> --
> Robert Crocombe
> rwcrocombe@raytheon.com
>
>
>
>
>
> [1] it's a "Navion Quadputer" from Microway, uses the older Tyan motherboard
>
> Added stuff is an Intel 4-port NIC and a 4-link 1394b card from [mumble].
>
> 00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
> 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
> 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
> 00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
> 00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12)
> 00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12)
> 00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> 01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
> 01:03.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 61)
> 01:03.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 61)
> 01:03.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 62)
> 01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 02:02.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 02)
> 02:03.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
> 02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> Gigabit Ethernet (rev 03)
> 02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
> Gigabit Ethernet (rev 03)
> 03:04.0 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (rev 01)
> 03:04.1 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (rev 01)
> 03:06.0 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (rev 01)
> 03:06.1 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (rev 01)
> 04:04.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link
> Layer Controller (rev 01)
> 04:05.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link
> Layer Controller (rev 01)
> 04:06.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link
> Layer Controller (rev 01)
> 04:07.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link
> Layer Controller (rev 01)
> 05:03.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
>
>
> [2] from testlpp:
>
> total number of responses: 699850
> average reponse latency:   10.39 usecs
> minimum latency:           4.51 usecs
> maximum latency:           1626.58 usecs
>
> nice average, but outliers are ugly.  testlpp was running on a 2.5GHz
> P4 running 2.6.16-rt17.
>
> I was really excited because tests between this P4 and a wussy 1.5GHz
> P4 running the same kernel were very good, especially after doing a
> chrt on 'IRQ 7'.
>
> [3]
>
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.16
> # Mon May  8 12:39:24 2006
> #
> CONFIG_X86_64=y
> CONFIG_64BIT=y
> CONFIG_X86=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_MMU=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_EARLY_PRINTK=y
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
> CONFIG_LOCALVERSION="_local_00"
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> CONFIG_SYSCTL=y
> CONFIG_AUDIT=y
> CONFIG_AUDITSYSCALL=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_CPUSETS=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_UID16=y
> CONFIG_VM86=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_EXTRA_PASS=y
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
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> CONFIG_MODULE_SRCVERSION_ALL=y
> CONFIG_KMOD=y
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
> CONFIG_IOSCHED_AS=y
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_IOSCHED_CFQ is not set
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
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_SCHED_SMT=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_NUMA=y
> CONFIG_K8_NUMA=y
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
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
> CONFIG_NR_CPUS=32
> # CONFIG_HOTPLUG_CPU is not set
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_GART_IOMMU=y
> CONFIG_SWIOTLB=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_INTEL is not set
> CONFIG_X86_MCE_AMD=y
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x100000
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_ISA_DMA_API=y
> CONFIG_GENERIC_PENDING_IRQ=y
>
> #
> # Power management options
> #
> CONFIG_PM=y
> CONFIG_PM_LEGACY=y
> # CONFIG_PM_DEBUG is not set
>
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_VIDEO=m
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_NUMA=y
> CONFIG_ACPI_ASUS=m
> CONFIG_ACPI_IBM=m
> CONFIG_ACPI_TOSHIBA=m
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> CONFIG_CPU_FREQ_DEBUG=y
> CONFIG_CPU_FREQ_STAT=m
> CONFIG_CPU_FREQ_STAT_DETAILS=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=m
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
>
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_POWERNOW_K8=y
> CONFIG_X86_POWERNOW_K8_ACPI=y
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
> CONFIG_X86_ACPI_CPUFREQ=m
>
> #
> # shared options
> #
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_X86_SPEEDSTEP_LIB is not set
>
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_UNORDERED_IO is not set
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCI_MSI=y
> # CONFIG_PCI_LEGACY_PROC is not set
> # CONFIG_PCI_DEBUG is not set
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
> # CONFIG_BINFMT_MISC is not set
> CONFIG_IA32_EMULATION=y
> # CONFIG_IA32_AOUT is not set
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
> CONFIG_NET_KEY=m
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_ASK_IP_FIB_HASH=y
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
> CONFIG_IP_ROUTE_MULTIPATH_RR=m
> CONFIG_IP_ROUTE_MULTIPATH_RANDOM=m
> CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=m
> CONFIG_IP_ROUTE_MULTIPATH_DRR=m
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
>
> #
> # IP: Virtual Server Configuration
> #
> CONFIG_IP_VS=m
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
>
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
>
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> CONFIG_IP_VS_SED=m
> CONFIG_IP_VS_NQ=m
>
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=m
> # CONFIG_IPV6 is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
>
> #
> # Core Netfilter Configuration
> #
> # CONFIG_NETFILTER_NETLINK is not set
> # CONFIG_NETFILTER_XTABLES is not set
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_CT_ACCT=y
> CONFIG_IP_NF_CONNTRACK_MARK=y
> # CONFIG_IP_NF_CONNTRACK_EVENTS is not set
> CONFIG_IP_NF_CT_PROTO_SCTP=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> # CONFIG_IP_NF_NETBIOS_NS is not set
> CONFIG_IP_NF_TFTP=m
> CONFIG_IP_NF_AMANDA=m
> # CONFIG_IP_NF_PPTP is not set
> CONFIG_IP_NF_QUEUE=m
>
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
>
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_MSG is not set
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_HMAC_NONE is not set
> # CONFIG_SCTP_HMAC_SHA1 is not set
> CONFIG_SCTP_HMAC_MD5=y
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
> CONFIG_FW_LOADER=y
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
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_CRYPTOLOOP=m
> CONFIG_BLK_DEV_NBD=m
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=16384
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
>
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=m
> CONFIG_BLK_DEV_IDE=m
>
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_IDEDISK is not set
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
>
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=m
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=m
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=m
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
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=m
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=m
> # CONFIG_CHR_DEV_SCH is not set
>
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
>
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> CONFIG_SCSI_ISCSI_ATTRS=m
> # CONFIG_SCSI_SAS_ATTRS is not set
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
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=m
> CONFIG_MEGARAID_MAILBOX=m
> CONFIG_MEGARAID_LEGACY=m
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_SATA is not set
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
> # CONFIG_SCSI_DEBUG is not set
>
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID5=y
> CONFIG_MD_RAID6=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_MD_FAULTY=m
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_CRYPT=m
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_MIRROR is not set
> # CONFIG_DM_ZERO is not set
> # CONFIG_DM_MULTIPATH is not set
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
> CONFIG_IEEE1394=m
>
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> CONFIG_IEEE1394_OUI_DB=y
> CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
> CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
> CONFIG_IEEE1394_EXPORT_FULL_API=y
>
> #
> # Device Drivers
> #
> CONFIG_IEEE1394_PCILYNX=m
> CONFIG_IEEE1394_OHCI1394=m
>
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_SBP2=m
> # CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
> CONFIG_IEEE1394_ETH1394=m
> CONFIG_IEEE1394_DV1394=m
> CONFIG_IEEE1394_RAWIO=m
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
> CONFIG_BONDING=m
> CONFIG_EQUALIZER=m
> CONFIG_TUN=m
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
> CONFIG_MII=m
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
>
> #
> # Tulip family network device support
> #
> CONFIG_NET_TULIP=y
> CONFIG_DE2104X=m
> CONFIG_TULIP=m
> # CONFIG_TULIP_MWI is not set
> CONFIG_TULIP_MMIO=y
> # CONFIG_TULIP_NAPI is not set
> CONFIG_DE4X5=m
> CONFIG_WINBOND_840=m
> CONFIG_DM9102=m
> # CONFIG_ULI526X is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
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
> CONFIG_E1000=m
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
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_TIGON3=m
> CONFIG_BNX2=m
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
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
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
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=m
> CONFIG_INPUT_UINPUT=m
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
> CONFIG_SERIAL_8250_NR_UARTS=32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> CONFIG_SERIAL_8250_RSA=y
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
> CONFIG_IPMI_HANDLER=m
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> CONFIG_IPMI_WATCHDOG=m
> CONFIG_IPMI_POWEROFF=m
>
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
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
> CONFIG_HW_RANDOM=m
> # CONFIG_NVRAM is not set
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
> CONFIG_DRM=m
> # CONFIG_DRM_TDFX is not set
> CONFIG_DRM_R128=m
> CONFIG_DRM_RADEON=m
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_DRM_VIA is not set
> # CONFIG_DRM_SAVAGE is not set
> CONFIG_MWAVE=y
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
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
>
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=m
> CONFIG_I2C_ALGOPCA=m
>
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=m
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_NFORCE2=m
> # CONFIG_I2C_PARPORT_LIGHT is not set
> CONFIG_I2C_PROSAVAGE=m
> CONFIG_I2C_SAVAGE4=m
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=m
> CONFIG_I2C_STUB=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> CONFIG_I2C_VOODOO3=m
> CONFIG_I2C_PCA_ISA=m
>
> #
> # Miscellaneous I2C Chip support
> #
> CONFIG_SENSORS_DS1337=m
> # CONFIG_SENSORS_DS1374 is not set
> CONFIG_SENSORS_EEPROM=m
> CONFIG_SENSORS_PCF8574=m
> # CONFIG_SENSORS_PCA9539 is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_SENSORS_RTC8564=m
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
> # CONFIG_HWMON is not set
> # CONFIG_HWMON_VID is not set
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
> CONFIG_FB=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_MACMODES is not set
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=m
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> CONFIG_FB_RADEON=m
> CONFIG_FB_RADEON_I2C=y
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=m
> CONFIG_FB_ATY=m
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GENERIC_LCD=y
> CONFIG_FB_ATY_GX=y
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
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
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
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_EHCI_SPLIT_ISO=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_OHCI_HCD=m
> # CONFIG_USB_OHCI_BIG_ENDIAN is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_UHCI_HCD=m
> CONFIG_USB_SL811_HCD=m
>
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
>
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
>
> #
> # may also be needed; see USB_STORAGE Help for more information
> #
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_DPCM=y
> CONFIG_USB_STORAGE_USBAT=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_LIBUSUAL is not set
>
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> CONFIG_HID_FF=y
> CONFIG_HID_PID=y
> CONFIG_LOGITECH_FF=y
> CONFIG_THRUSTMASTER_FF=y
> CONFIG_USB_HIDDEV=y
> CONFIG_USB_AIPTEK=m
> CONFIG_USB_WACOM=m
> # CONFIG_USB_ACECAD is not set
> CONFIG_USB_KBTAB=m
> CONFIG_USB_POWERMATE=m
> CONFIG_USB_MTOUCH=m
> # CONFIG_USB_ITMTOUCH is not set
> CONFIG_USB_EGALAX=m
> # CONFIG_USB_YEALINK is not set
> CONFIG_USB_XPAD=m
> CONFIG_USB_ATI_REMOTE=m
> # CONFIG_USB_ATI_REMOTE2 is not set
> # CONFIG_USB_KEYSPAN_REMOTE is not set
> # CONFIG_USB_APPLETOUCH is not set
>
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=m
> CONFIG_USB_MICROTEK=m
>
> #
> # USB Multimedia devices
> #
> CONFIG_USB_DABUSB=m
>
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
>
> #
> # USB Network Adapters
> #
> CONFIG_USB_CATC=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_USBNET=m
> CONFIG_USB_NET_AX8817X=m
> CONFIG_USB_NET_CDCETHER=m
> # CONFIG_USB_NET_GL620A is not set
> CONFIG_USB_NET_NET1080=m
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> CONFIG_USB_NET_ZAURUS=m
> CONFIG_USB_MON=y
>
> #
> # USB port drivers
> #
>
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_AIRPRIME=m
> # CONFIG_USB_SERIAL_ANYDATA is not set
> CONFIG_USB_SERIAL_BELKIN=m
> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> CONFIG_USB_SERIAL_CP2101=m
> CONFIG_USB_SERIAL_CYPRESS_M8=m
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> CONFIG_USB_SERIAL_GARMIN=m
> CONFIG_USB_SERIAL_IPW=m
> CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KEYSPAN_MPR=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19=y
> CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
> CONFIG_USB_SERIAL_KLSI=m
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_PL2303=m
> CONFIG_USB_SERIAL_HP4X=m
> CONFIG_USB_SERIAL_SAFE=m
> CONFIG_USB_SERIAL_SAFE_PADDED=y
> CONFIG_USB_SERIAL_TI=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_OMNINET=m
> CONFIG_USB_EZUSB=y
>
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=m
> # CONFIG_USB_EMI26 is not set
> CONFIG_USB_AUERSWALD=m
> CONFIG_USB_RIO500=m
> CONFIG_USB_LEGOTOWER=m
> CONFIG_USB_LCD=m
> CONFIG_USB_LED=m
> # CONFIG_USB_CYTHERM is not set
> CONFIG_USB_PHIDGETKIT=m
> CONFIG_USB_PHIDGETSERVO=m
> CONFIG_USB_IDMOUSE=m
> CONFIG_USB_SISUSBVGA=m
> # CONFIG_USB_SISUSBVGA_CON is not set
> # CONFIG_USB_LD is not set
> CONFIG_USB_TEST=m
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
> # CONFIG_EDAC is not set
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
> # CONFIG_EXT2_FS is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=y
> CONFIG_XFS_EXPORT=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_SECURITY=y
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> CONFIG_ROMFS_FS=m
> CONFIG_INOTIFY=y
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_DNOTIFY=y
> CONFIG_AUTOFS_FS=m
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
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> # CONFIG_RELAYFS_FS is not set
> # CONFIG_CONFIGFS_FS is not set
>
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> CONFIG_AFFS_FS=m
> CONFIG_HFS_FS=m
> CONFIG_HFSPLUS_FS=m
> CONFIG_BEFS_FS=m
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=m
> CONFIG_CRAMFS=m
> CONFIG_VXFS_FS=m
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=m
> CONFIG_SYSV_FS=m
> CONFIG_UFS_FS=m
>
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> CONFIG_NFS_DIRECTIO=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V3_ACL is not set
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> CONFIG_RPCSEC_GSS_SPKM3=m
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> # CONFIG_CIFS_EXPERIMENTAL is not set
> CONFIG_NCP_FS=m
> CONFIG_NCPFS_PACKET_SIGNING=y
> CONFIG_NCPFS_IOCTL_LOCKING=y
> CONFIG_NCPFS_STRONG=y
> CONFIG_NCPFS_NFS_NS=y
> CONFIG_NCPFS_OS2_NS=y
> CONFIG_NCPFS_SMALLDOS=y
> CONFIG_NCPFS_NLS=y
> CONFIG_NCPFS_EXTRAS=y
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=y
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=y
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
>
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
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
> CONFIG_NLS_ASCII=y
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
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=m
> CONFIG_KPROBES=y
>
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_FORCED_INLINING=y
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_DEBUG_RODATA is not set
> # CONFIG_IOMMU_DEBUG is not set
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
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_WP512=m
> CONFIG_CRYPTO_TGR192=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_AES=m
> # CONFIG_CRYPTO_AES_X86_64 is not set
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Hardware crypto devices
> #
>
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
>
>
> [4]
>
> --- config_2.6.16_local_00	2006-05-10 11:38:07.734671224 -0700
> +++ config_2.6.16-rt10_local_00	2006-05-10 11:41:03.203670676 -0700
> @@ -1,14 +1,15 @@
>   #
>   # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.16
> -# Mon May  8 12:39:24 2006
> +# Linux kernel version: 2.6.16-rt10
> +# Mon May  8 14:31:03 2006
>   #
>   CONFIG_X86_64=y
>   CONFIG_64BIT=y
>   CONFIG_X86=y
> +CONFIG_GENERIC_TIME=y
> +CONFIG_GENERIC_TIME_VSYSCALL=y
>   CONFIG_SEMAPHORE_SLEEPERS=y
>   CONFIG_MMU=y
> -CONFIG_RWSEM_GENERIC_SPINLOCK=y
>   CONFIG_GENERIC_CALIBRATE_DELAY=y
>   CONFIG_X86_CMPXCHG=y
>   CONFIG_EARLY_PRINTK=y
> @@ -53,6 +54,7 @@
>   CONFIG_BUG=y
>   CONFIG_ELF_CORE=y
>   CONFIG_BASE_FULL=y
> +CONFIG_RT_MUTEXES=y
>   CONFIG_FUTEX=y
>   CONFIG_EPOLL=y
>   CONFIG_SHMEM=y
> @@ -113,13 +115,22 @@
>   CONFIG_X86_IO_APIC=y
>   CONFIG_X86_LOCAL_APIC=y
>   CONFIG_MTRR=y
> +# CONFIG_HIGH_RES_TIMERS is not set
>   CONFIG_SMP=y
>   CONFIG_SCHED_SMT=y
>   # CONFIG_PREEMPT_NONE is not set
>   # CONFIG_PREEMPT_VOLUNTARY is not set
> +# CONFIG_PREEMPT_DESKTOP is not set
> +CONFIG_PREEMPT_RT=y
>   CONFIG_PREEMPT=y
> +CONFIG_PREEMPT_SOFTIRQS=y
> +CONFIG_PREEMPT_HARDIRQS=y
>   CONFIG_PREEMPT_BKL=y
> +# CONFIG_CLASSIC_RCU is not set
> +CONFIG_PREEMPT_RCU=y
> +CONFIG_RCU_STATS=y
>   CONFIG_NUMA=y
> +CONFIG_RWSEM_GENERIC_SPINLOCK=y
>   CONFIG_K8_NUMA=y
>   CONFIG_X86_64_ACPI_NUMA=y
>   # CONFIG_NUMA_EMU is not set
> @@ -909,6 +920,9 @@
>   CONFIG_HW_RANDOM=m
>   # CONFIG_NVRAM is not set
>   CONFIG_RTC=y
> +# CONFIG_RTC_HISTOGRAM is not set
> +CONFIG_BLOCKER=y
> +CONFIG_LPPTEST=y
>   # CONFIG_DTLK is not set
>   # CONFIG_R3964 is not set
>   # CONFIG_APPLICOM is not set
> @@ -1517,21 +1531,30 @@
>   # Kernel hacking
>   #
>   # CONFIG_PRINTK_TIME is not set
> +# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
>   CONFIG_MAGIC_SYSRQ=y
>   CONFIG_DEBUG_KERNEL=y
>   CONFIG_LOG_BUF_SHIFT=17
> +# CONFIG_PARANOID_GENERIC_TIME is not set
>   CONFIG_DETECT_SOFTLOCKUP=y
>   # CONFIG_SCHEDSTATS is not set
>   # CONFIG_DEBUG_SLAB is not set
>   CONFIG_DEBUG_PREEMPT=y
> -CONFIG_DEBUG_MUTEXES=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_SPINLOCK_SLEEP=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_PI_LIST=y
> +# CONFIG_RT_MUTEX_TESTER is not set
> +CONFIG_WAKEUP_TIMING=y
> +# CONFIG_WAKEUP_LATENCY_HIST is not set
> +CONFIG_PREEMPT_TRACE=y
> +# CONFIG_CRITICAL_PREEMPT_TIMING is not set
> +# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
> +CONFIG_LATENCY_TIMING=y
> +# CONFIG_LATENCY_TRACE is not set
>   # CONFIG_DEBUG_KOBJECT is not set
>   CONFIG_DEBUG_INFO=y
>   CONFIG_DEBUG_FS=y
>   # CONFIG_DEBUG_VM is not set
> -# CONFIG_FRAME_POINTER is not set
> +# CONFIG_USE_FRAME_POINTER is not set
>   CONFIG_FORCED_INLINING=y
>   # CONFIG_RCU_TORTURE_TEST is not set
>   # CONFIG_DEBUG_RODATA is not set
> @@ -1586,3 +1609,4 @@
>   CONFIG_LIBCRC32C=m
>   CONFIG_ZLIB_INFLATE=y
>   CONFIG_ZLIB_DEFLATE=m
> +CONFIG_PLIST=y
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
