Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263744AbTCVRVd>; Sat, 22 Mar 2003 12:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbTCVRVd>; Sat, 22 Mar 2003 12:21:33 -0500
Received: from home.wiggy.net ([213.84.101.140]:13782 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263744AbTCVRVM>;
	Sat, 22 Mar 2003 12:21:12 -0500
Date: Sat, 22 Mar 2003 18:32:14 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65 Oopses on scsi initialisation
Message-ID: <20030322173214.GB21175@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030319113323.GY2802@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319113323.GY2802@wiggy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I just retried booting with the SYM53C8XX_2 driver and that
seems to be working properly.

Wichert.

Previously Wichert Akkerman wrote:
> I tried booting a stock 2.5.65 kernel on my desktop but it oopsed during
> boot. Unfortunately the first few lines of the oops scrolled off the
> screen; I hope the info below contains enough useful information.
> 
> The kernel was compiled using gcc version 3.2.3 20030309 (Debian
> prerelease), and the SCSI driver is SYM53C8XX. I've put the full .config
> info below as well.
> 
> 
> esi: 00000000   edi: c41ecf80   ebp: c41ec00  esp: c40fbe24
> ds: 007b   es: 007b   ss:  0068
> Process swapper (pid: 1, threadinfo=40fa000 task=c40f8040)
> Stack: d7e4a800 c40f8640 cf1fec00 c41fea8c c41fec00 00000202 c01e46b6 c41fec00
>        c41fea8c c41fea8c c41fea8c c40fa000 c01e6d11 c41fec00 c41fea8c 00000001
>        00000000 00000000 c40fbeb0 c41fea00 c40fbef0 c41fea00 c020f7c2 c41fec00
> Call Trace:
>  [<c01e46b6>] __elv_add_request+0x36/0x60
>  [<c01e6d11>] blk_insert_request+0x71/0xb0
>  [<c020f7c2>] scsi_insert_special_req+0x32/0x40
>  [<c020fa29>] scsi_wait_req+0x69/0xb0
>  [<c020f930>] scsi_wait_done+0x0/0x90
>  [<c021175c>] scsi_probe_lun+0x6c/0x1f0
>  [<c0211ceb>] scsi_probe_and_add_lun+0x7b/0x130
>  [<c021234c>] scsi_scan_target+0x5c/0xe0
>  [<c0212421>] scsi_scan_host+0x51/0x90
>  [<c020c38d>] scsi_add_host+0x4d/0x90
>  [<c020c797>] scsi_register_host+0x57/0xa0
>  [<c0105093>] init+0x2e/0x190
>  [<c0105070>] init+0x0/0x190
>  [<c01071dd>] kernel_thread_helper+0x5/0x18
> 
> Code: 89 58 04 89 03 89 53 04 89 1a eb 8b 8b 47 20 8b 50 04 eb ea
>  <0>Kernel panic:Attempted to kill init!
> 
> 
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=14
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODULE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMII=y
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_NUMA is not set
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_EDD is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_SOFTWARE_SUSPEND is not set
> 
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> # CONFIG_APM_CPU_IDLE is not set
> # CONFIG_APM_DISPLAY_BLANK is not set
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
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
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_SCx200 is not set
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> CONFIG_HOTPLUG=y
> 
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
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
> # CONFIG_PNP_NAMES is not set
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> CONFIG_PNPBIOS=y
> 
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL device support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> # CONFIG_BLK_DEV_IDEDISK is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_BLK_DEV_GENERIC is not set
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_REPORT_LUNS=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> CONFIG_SCSI_SYM53C8XX=y
> CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
> CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
> CONFIG_SCSI_NCR53C8XX_SYNC=20
> # CONFIG_SCSI_NCR53C8XX_PROFILE is not set
> # CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
> # CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
> # CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
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
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_BLK_DEV_DM is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> # CONFIG_NETLINK_DEV is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_FILTER=y
> CONFIG_UNIX=y
> CONFIG_NET_KEY=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE=y
> # CONFIG_NET_IPGRE_BROADCAST is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> CONFIG_INET_AH=y
> CONFIG_INET_ESP=y
> CONFIG_XFRM_USER=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=y
> # CONFIG_IP_NF_FTP is not set
> # CONFIG_IP_NF_IRC is not set
> CONFIG_IP_NF_QUEUE=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=y
> CONFIG_IP_NF_MATCH_MAC=y
> # CONFIG_IP_NF_MATCH_PKTTYPE is not set
> CONFIG_IP_NF_MATCH_MARK=y
> CONFIG_IP_NF_MATCH_MULTIPORT=y
> CONFIG_IP_NF_MATCH_TOS=y
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_DSCP is not set
> # CONFIG_IP_NF_MATCH_AH_ESP is not set
> # CONFIG_IP_NF_MATCH_LENGTH is not set
> # CONFIG_IP_NF_MATCH_TTL is not set
> # CONFIG_IP_NF_MATCH_TCPMSS is not set
> # CONFIG_IP_NF_MATCH_HELPER is not set
> CONFIG_IP_NF_MATCH_STATE=y
> # CONFIG_IP_NF_MATCH_CONNTRACK is not set
> CONFIG_IP_NF_MATCH_UNCLEAN=y
> CONFIG_IP_NF_MATCH_OWNER=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> # CONFIG_IP_NF_TARGET_MIRROR is not set
> # CONFIG_IP_NF_NAT is not set
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_TOS=y
> # CONFIG_IP_NF_TARGET_ECN is not set
> # CONFIG_IP_NF_TARGET_DSCP is not set
> CONFIG_IP_NF_TARGET_MARK=y
> CONFIG_IP_NF_TARGET_LOG=y
> # CONFIG_IP_NF_TARGET_ULOG is not set
> # CONFIG_IP_NF_TARGET_TCPMSS is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_PRIVACY is not set
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_IP6_NF_QUEUE is not set
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_LIMIT=y
> # CONFIG_IP6_NF_MATCH_MAC is not set
> # CONFIG_IP6_NF_MATCH_RT is not set
> # CONFIG_IP6_NF_MATCH_OPTS is not set
> # CONFIG_IP6_NF_MATCH_FRAG is not set
> # CONFIG_IP6_NF_MATCH_HL is not set
> CONFIG_IP6_NF_MATCH_MULTIPORT=y
> # CONFIG_IP6_NF_MATCH_OWNER is not set
> CONFIG_IP6_NF_MATCH_MARK=y
> # CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
> # CONFIG_IP6_NF_MATCH_AHESP is not set
> # CONFIG_IP6_NF_MATCH_LENGTH is not set
> # CONFIG_IP6_NF_MATCH_EUI64 is not set
> CONFIG_IP6_NF_FILTER=y
> CONFIG_IP6_NF_TARGET_LOG=y
> CONFIG_IP6_NF_MANGLE=y
> CONFIG_IP6_NF_TARGET_MARK=y
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=y
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
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
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MII is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL1 is not set
> # CONFIG_EL2 is not set
> # CONFIG_ELPLUS is not set
> # CONFIG_EL16 is not set
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
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
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=y
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
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
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices (depends on LLC=y)
> #
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
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
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=m
> # CONFIG_INPUT_UINPUT is not set
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
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # I2C Hardware Sensors Mainboard support
> #
> 
> #
> # I2C Hardware Sensors Chip support
> #
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set
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
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_SOFT_WATCHDOG=m
> # CONFIG_WDT is not set
> # CONFIG_WDTPCI is not set
> # CONFIG_PCWATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_I810_TCO is not set
> # CONFIG_MIXCOMWD is not set
> # CONFIG_SCx200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SC520_WDT is not set
> # CONFIG_AMD7XX_TCO is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_FAT_FS is not set
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
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
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFSD is not set
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> # CONFIG_EXPORTFS is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> CONFIG_SUNRPC=m
> # CONFIG_SUNRPC_GSS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
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
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
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
> CONFIG_SND_SEQUENCER=y
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_RTCTIMER=y
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> 
> #
> # ISA devices
> #
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> CONFIG_SND_EMU10K1=m
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set
> CONFIG_KALLSYMS=y
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_NULL is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> # CONFIG_CRYPTO_SHA512 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_BLOWFISH is not set
> CONFIG_CRYPTO_TWOFISH=y
> # CONFIG_CRYPTO_SERPENT is not set
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> CONFIG_X86_BIOS_REBOOT=y
> 
> -- 
> Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
> A random hacker
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
