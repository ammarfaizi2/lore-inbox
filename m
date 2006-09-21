Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWIUWhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWIUWhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWIUWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:37:13 -0400
Received: from ms-smtp-01.ohiordc.rr.com ([65.24.5.135]:16120 "EHLO
	ms-smtp-01.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S932072AbWIUWhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:37:07 -0400
Date: Thu, 21 Sep 2006 18:40:50 -0400
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>,
       Kernel development list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.18-rc7-mm1: no /dev/tty0
Message-ID: <20060921224049.GA2501@nineveh.rivenstone.net>
Mail-Followup-To: Laurent Riffard <laurent.riffard@free.fr>,
	=?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <20060921234151.2dd12d32@werewolf.auna.net> <45130CF9.4060806@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45130CF9.4060806@free.fr>
User-Agent: Mutt/1.5.11
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:06:49AM +0200, Laurent Riffard wrote:
> Le 21.09.2006 23:41, J.A. Magall�n a �crit :

    Trimming CC's is generally frowned upon on LKML.

> >When booting 2.6.18-rc7-mm1, the initscripts complain about /dev/tty0 not
> >being present. Then the boot sequence blocks...:
> >
> >Sep 21 23:23:57 werewolf init: open(/dev/console): No such file or
> >directory
> >Sep 21 23:24:07 werewolf last message repeated 17 times
> >Sep 21 23:24:12 werewolf init: Id "3" respawning too fast: disabled for 5
> >minutes
> >
> >(from syslog)
> >
> >The same userspace boots fine with -rc6-mm2.
> >
> >Any ideas ?
>
> Well, I have similar issues: when booting 2.6.18-rc7-mm1, some /dev
> files are missing:
> - /dev/kmem
> - /dev/kmsg
> - /dev/mem
> - /dev/port
> - /dev/ptmx
> - /dev/tty
>
> Setting CONFIG_SYSFS_DEPRECATED=y didn't help. My .config is attached.
> ~~
> laurent

    There were some problems with older versions of udev not creating
some device nodes with -mm kernels.  I don't know if this has been
fixed, or if it's the same as this:

"- The kernel doesn't work properly on RH FC3 or pretty much anything
  which uses old udev, due to improvements in the driver tree."

    I know that, several -mm's back, Ubuntu Dapper's udev 079 didn't
create /dev/alsa or /dev/psaux.

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.18-rc7-mm1
> # Wed Sep 20 14:09:26 2006
> #
> CONFIG_X86_32=y
> CONFIG_GENERIC_TIME=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_DMI=y
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
>
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SWAP_PREFETCH=y
> CONFIG_SYSVIPC=y
> # CONFIG_IPC_NS is not set
> CONFIG_POSIX_MQUEUE=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_UTS_NS is not set
> # CONFIG_AUDIT is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_SYSFS_DEPRECATED=y
> # CONFIG_RELAY is not set
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_EMBEDDED=y
> CONFIG_UID16=y
> CONFIG_SYSCTL=y
> CONFIG_SYSCTL_SYSCALL=y
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
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
>
> #
> # Block layer
> #
> CONFIG_BLOCK=y
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_LSF is not set
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_DEFAULT_AS is not set
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="cfq"
>
> #
> # Processor type and features
> #
> # CONFIG_SMP is not set
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
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
> CONFIG_X86_L1_CACHE_SHIFT=6
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
> CONFIG_X86_USE_3DNOW=y
> CONFIG_X86_TSC=y
> CONFIG_HPET_TIMER=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=m
> CONFIG_X86_MCE_P4THERMAL=y
> CONFIG_VM86=y
> CONFIG_GENERIC_ISA_DMA=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_X86_REBOOTFIXUPS=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=m
> # CONFIG_X86_CPUID is not set
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
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_3G_OPT is not set
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ZONE_DMA=y
> # CONFIG_RESOURCES_64BIT is not set
> CONFIG_ADAPTIVE_READAHEAD=y
> # CONFIG_READAHEAD_ALLOW_OVERHEADS is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> CONFIG_REGPARM=y
> CONFIG_SECCOMP=y
> # CONFIG_SECCOMP_DISABLE_TSC is not set
> # CONFIG_VGA_NOPROBE is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_KEXEC=y
> CONFIG_PHYSICAL_START=0x100000
> # CONFIG_COMPAT_VDSO is not set
>
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> CONFIG_PM_LEGACY=y
> # CONFIG_PM_DEBUG is not set
> # CONFIG_PM_SYSFS_DEPRECATED is not set
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_PM_STD_PARTITION="/dev/hdb6"
>
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> # CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_HOTKEY=m
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_DOCK is not set
> # CONFIG_ACPI_BAY is not set
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_SONY is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
> # CONFIG_ACPI_SBS is not set
>
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
>
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
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
> # CONFIG_PCI_MULTITHREAD_PROBE is not set
> # CONFIG_PCI_DEBUG is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
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
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_MISC=m
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
> CONFIG_PACKET=m
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=y
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=m
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_ASK_IP_FIB_HASH=y
> # CONFIG_IP_FIB_TRIE is not set
> CONFIG_IP_FIB_HASH=y
> # CONFIG_IP_MULTIPLE_TABLES is not set
> # CONFIG_IP_ROUTE_MULTIPATH is not set
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=m
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> CONFIG_INET_DIAG=m
> CONFIG_INET_TCP_DIAG=m
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
>
> #
> # IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> # CONFIG_IPV6 is not set
> # CONFIG_INET6_XFRM_TUNNEL is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
>
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> # CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
> # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
> # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
> # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> # CONFIG_NETFILTER_XT_MATCH_HELPER is not set
> # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> CONFIG_NETFILTER_XT_MATCH_MAC=m
> CONFIG_NETFILTER_XT_MATCH_MARK=m
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> # CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
> # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
> # CONFIG_NETFILTER_XT_MATCH_REALM is not set
> CONFIG_NETFILTER_XT_MATCH_SCTP=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
> CONFIG_NETFILTER_XT_MATCH_STRING=m
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> # CONFIG_IP_NF_CT_ACCT is not set
> # CONFIG_IP_NF_CONNTRACK_MARK is not set
> # CONFIG_IP_NF_CONNTRACK_EVENTS is not set
> # CONFIG_IP_NF_CONNTRACK_NETLINK is not set
> # CONFIG_IP_NF_CT_PROTO_SCTP is not set
> # CONFIG_IP_NF_FTP is not set
> # CONFIG_IP_NF_IRC is not set
> # CONFIG_IP_NF_NETBIOS_NS is not set
> # CONFIG_IP_NF_TFTP is not set
> # CONFIG_IP_NF_AMANDA is not set
> # CONFIG_IP_NF_PPTP is not set
> # CONFIG_IP_NF_H323 is not set
> # CONFIG_IP_NF_SIP is not set
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_IPRANGE=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_RECENT=m
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_AH is not set
> # CONFIG_IP_NF_MATCH_TTL is not set
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_MATCH_ADDRTYPE=m
> CONFIG_IP_NF_MATCH_HASHLIMIT=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> # CONFIG_IP_NF_TARGET_TCPMSS is not set
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_SAME=m
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_TTL=m
> # CONFIG_IP_NF_RAW is not set
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> # CONFIG_IP_NF_ARP_MANGLE is not set
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
> CONFIG_ATM=m
> CONFIG_ATM_CLIP=m
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> # CONFIG_ATM_LANE is not set
> CONFIG_ATM_BR2684=m
> # CONFIG_ATM_BR2684_IPFILTER is not set
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
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_CLK_JIFFIES=y
> # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
> # CONFIG_NET_SCH_CLK_CPU is not set
>
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> # CONFIG_NET_SCH_ATM is not set
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> # CONFIG_NET_SCH_NETEM is not set
> CONFIG_NET_SCH_INGRESS=m
>
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=m
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=m
> # CONFIG_NET_CLS_RSVP6 is not set
> # CONFIG_NET_EMATCH is not set
> # CONFIG_NET_CLS_ACT is not set
> CONFIG_NET_CLS_POLICE=y
> # CONFIG_NET_CLS_IND is not set
> CONFIG_NET_ESTIMATOR=y
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
> CONFIG_WIRELESS_EXT=y
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
> CONFIG_FW_LOADER=m
> # CONFIG_DEBUG_DRIVER is not set
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
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_GSC is not set
> # CONFIG_PARPORT_AX88796 is not set
> CONFIG_PARPORT_1284=y
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
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_CRYPTOLOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_UB=m
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_CDROM_PKTCDVD=m
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
>
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_IDE_MAX_HWIFS=2
> CONFIG_BLK_DEV_IDE=y
>
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=m
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
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_CS5535 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_JMICRON is not set
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
> CONFIG_BLK_DEV_VIA82CXXX=m
> # CONFIG_IDE_ARM is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
>
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=m
> CONFIG_SCSI_NETLINK=y
> # CONFIG_SCSI_TGT is not set
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
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
> # CONFIG_SCSI_LOGGING is not set
>
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
>
> #
> # SCSI low-level drivers
> #
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_SRP is not set
>
> #
> # Serial ATA (prod) and Parallel ATA (experimental) drivers
> #
> CONFIG_ATA=m
> # CONFIG_SATA_AHCI is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_ATA_PIIX is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SX4 is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIL24 is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CS5520 is not set
> # CONFIG_PATA_CS5530 is not set
> # CONFIG_PATA_CS5535 is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> CONFIG_ATA_GENERIC=m
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8172 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_ATA_JMICRON is not set
> # CONFIG_PATA_LEGACY is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_QDI is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RZ1000 is not set
> # CONFIG_PATA_SC1200 is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> CONFIG_PATA_VIA=m
> # CONFIG_PATA_WINBOND is not set
>
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_RAID5_RESHAPE=y
> # CONFIG_MD_MULTIPATH is not set
> # CONFIG_MD_FAULTY is not set
> CONFIG_BLK_DEV_DM=m
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_CRYPT=m
> CONFIG_DM_SNAPSHOT=m
> CONFIG_DM_MIRROR=m
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
> # CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
> # CONFIG_IEEE1394_EXPORT_FULL_API is not set
>
> #
> # Device Drivers
> #
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=m
>
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> # CONFIG_IEEE1394_SBP2 is not set
> # CONFIG_IEEE1394_ETH1394 is not set
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
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
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
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
>
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> CONFIG_NE2K_PCI=m
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_NET_POCKET is not set
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
> # CONFIG_QLA3XXX is not set
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
> CONFIG_NET_RADIO=y
> # CONFIG_NET_WIRELESS_RTNETLINK is not set
>
> #
> # Obsolete Wireless cards support (pre-802.11)
> #
> # CONFIG_STRIP is not set
> # CONFIG_ARLAN is not set
> # CONFIG_WAVELAN is not set
>
> #
> # Wireless 802.11b ISA/PCI cards support
> #
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_AIRO is not set
> # CONFIG_HERMES is not set
> # CONFIG_ATMEL is not set
>
> #
> # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
> #
> # CONFIG_PRISM54 is not set
> # CONFIG_USB_ZD1201 is not set
> # CONFIG_HOSTAP is not set
> # CONFIG_ACX is not set
> CONFIG_NET_WIRELESS=y
>
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>
> #
> # ATM drivers
> #
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E_MAYBE is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=m
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> # CONFIG_PPP_MPPE is not set
> CONFIG_PPPOE=m
> CONFIG_PPPOATM=m
> # CONFIG_SLIP is not set
> CONFIG_SLHC=m
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> CONFIG_NETCONSOLE=y
> CONFIG_NETPOLL=y
> # CONFIG_NETPOLL_RX is not set
> # CONFIG_NETPOLL_TRAP is not set
> CONFIG_NET_POLL_CONTROLLER=y
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
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
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
> # CONFIG_KEYBOARD_STOWAWAY is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
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
> # CONFIG_JOYSTICK_DB9 is not set
> # CONFIG_JOYSTICK_GAMECON is not set
> # CONFIG_JOYSTICK_TURBOGRAFX is not set
> # CONFIG_JOYSTICK_JOYDUMP is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=m
> # CONFIG_INPUT_WISTRON_BTNS is not set
> # CONFIG_INPUT_UINPUT is not set
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
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
> CONFIG_VT_HW_CONSOLE_BINDING=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=m
> # CONFIG_SERIAL_8250_PCI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=m
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_TIPAR is not set
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
> # CONFIG_NVRAM is not set
> CONFIG_RTC=m
> # CONFIG_GEN_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=m
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_AGP_VIA=m
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_DRM=m
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_DRM_VIA is not set
> # CONFIG_DRM_SAVAGE is not set
> # CONFIG_MWAVE is not set
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_NSC_GPIO is not set
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
> CONFIG_I2C_CHARDEV=m
>
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
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
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_ELEKTOR is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_ISA=m
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
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
> CONFIG_HWMON_VID=m
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_K8TEMP is not set
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
> CONFIG_SENSORS_LM80=m
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
> # CONFIG_SENSORS_SMSC47B397 is not set
> CONFIG_SENSORS_VIA686A=m
> # CONFIG_SENSORS_VT8231 is not set
> CONFIG_SENSORS_W83781D=m
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
> CONFIG_VIDEO_DEV=m
> # CONFIG_VIDEO_V4L1 is not set
> CONFIG_VIDEO_V4L1_COMPAT=y
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
> CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
> # CONFIG_VIDEO_VIVI is not set
> # CONFIG_VIDEO_SAA5246A is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_VIDEO_SAA7134 is not set
> # CONFIG_VIDEO_HEXIUM_ORION is not set
> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> # CONFIG_VIDEO_CX88 is not set
>
> #
> # V4L USB devices
> #
>
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_CADET is not set
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_SF16FMR2 is not set
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
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
> CONFIG_FB_DDC=m
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
> CONFIG_FB_NVIDIA=m
> CONFIG_FB_NVIDIA_I2C=y
> CONFIG_FB_RIVA=m
> CONFIG_FB_RIVA_I2C=y
> # CONFIG_FB_RIVA_DEBUG is not set
> # CONFIG_FB_I810 is not set
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
> # CONFIG_FB_CYBLA is not set
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
> # CONFIG_MDA_CONSOLE is not set
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
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
> #
> # Sound
> #
> CONFIG_SOUND=m
>
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_RAWMIDI=m
> CONFIG_SND_SEQUENCER=m
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_PCM_OSS_PLUGINS=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=m
> CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
> CONFIG_SND_DYNAMIC_MINORS=y
> # CONFIG_SND_SUPPORT_OLD_API is not set
> # CONFIG_SND_VERBOSE_PROCFS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>
> #
> # Generic devices
> #
> CONFIG_SND_AC97_CODEC=m
> CONFIG_SND_AC97_BUS=m
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>
> #
> # ISA devices
> #
> # CONFIG_SND_ADLIB is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_MIRO is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
> # CONFIG_SND_WAVEFRONT is not set
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
> # CONFIG_SND_CS5535AUDIO is not set
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
> CONFIG_SND_ENS1371=m
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDA_INTEL is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
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
> # CONFIG_SND_USB_AUDIO is not set
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
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_BANDWIDTH=y
> CONFIG_USB_DYNAMIC_MINORS=y
> CONFIG_USB_SUSPEND=y
> CONFIG_USB_MULTITHREAD_PROBE=y
> # CONFIG_USB_OTG is not set
>
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=m
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=m
> # CONFIG_USB_SL811_HCD is not set
>
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
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
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_LIBUSUAL is not set
>
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
>
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
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
> # CONFIG_USB_TRANCEVIBRATOR is not set
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
> # CONFIG_USB_USS720 is not set
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
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGET is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_GOTEMP is not set
>
> #
> # USB DSL modem support
> #
> CONFIG_USB_ATM=m
> # CONFIG_USB_SPEEDTOUCH is not set
> # CONFIG_USB_CXACRU is not set
> CONFIG_USB_UEAGLEATM=m
> # CONFIG_USB_XUSBATM is not set
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
> CONFIG_EDAC_AMD76X=m
> # CONFIG_EDAC_E7XXX is not set
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82875P is not set
> # CONFIG_EDAC_I82860 is not set
> # CONFIG_EDAC_K8 is not set
> # CONFIG_EDAC_R82600 is not set
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
> # CONFIG_INTEL_IOATDMA is not set
>
> #
> # Userspace I/O
> #
> # CONFIG_UIO is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> # CONFIG_EXT2_FS_POSIX_ACL is not set
> # CONFIG_EXT2_FS_SECURITY is not set
> CONFIG_EXT2_FS_XIP=y
> CONFIG_FS_XIP=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISER4_FS=m
> # CONFIG_REISER4_DEBUG is not set
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_INOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=y
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=m
> # CONFIG_FUSE_FS is not set
>
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=850
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> CONFIG_CONFIGFS_FS=m
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
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V3_ACL is not set
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS=y
> # CONFIG_CIFS_STATS2 is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_EXPERIMENTAL is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
>
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=m
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
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=m
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=m
>
> #
> # Distributed Lock Manager
> #
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
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_UNUSED_SYMBOLS=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_SHIRQ=y
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_SCHEDSTATS is not set
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SLAB_LEAK=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_PI_LIST=y
> # CONFIG_RT_MUTEX_TESTER is not set
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_LOCKDEP=y
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_STACKTRACE=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_LIST is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_UNWIND_INFO=y
> # CONFIG_STACK_UNWIND is not set
> # CONFIG_PROFILE_LIKELY is not set
> CONFIG_FORCED_INLINING=y
> # CONFIG_DEBUG_SYNCHRO_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACK_USAGE=y
>
> #
> # Page alloc debug is incompatible with Software Suspend on i386
> #
> CONFIG_DEBUG_RODATA=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> CONFIG_DOUBLEFAULT=y
>
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_INTEGRITY is not set
> # CONFIG_SECURITY is not set
>
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> CONFIG_CRYPTO_AES=m
> CONFIG_CRYPTO_AES_586=m
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> CONFIG_CRYPTO_ARC4=m
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> # CONFIG_CRYPTO_TEST is not set
>
> #
> # Hardware crypto devices
> #
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
> # CONFIG_CRYPTO_DEV_GEODE is not set
>
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=m
> CONFIG_TEXTSEARCH_BM=m
> CONFIG_TEXTSEARCH_FSM=m
> CONFIG_PLIST=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_KTIME_SCALAR=y


--
Joseph Fannin
jfannin@gmail.com

