Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUDGGI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDGGI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:08:27 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:28052 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S264101AbUDGGH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:07:27 -0400
Message-ID: <40739A96.6010604@cs.up.ac.za>
Date: Wed, 07 Apr 2004 08:07:18 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS in  __alloc_pages on x86
References: <4072E822.9040304@kroon.co.za>
In-Reply-To: <4072E822.9040304@kroon.co.za>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: b54c452f32d2702a8ea4e5c1caa0194e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And on 2.6.5:

ifconfig: page allocation failure. order:0, mode:0x20
Call Trace:
[<c013df67>] __alloc_pages+0x2d7/0x390
[<c013e042>] __get_free_pages+0x22/0x60
[<c014216f>] cache_grow+0x11f/0x470
[<c014262f>] cache_alloc_refill+0x16f/0x4e0
[<c014306f>] kmem_cache_alloc+0x19f/0x1c0
[<c0260dfc>] alloc_skb+0x1c/0xe0
[<c023cb41>] tulip_init_ring+0xa1/0x160
[<c023c6f6>] tulip_open+0x36/0x50
[<c0265437>] dev_open+0xb7/0xf0
[<c0266cf8>] dev_change_flags+0x58/0x140
[<c02a4b27>] devinet_ioctl+0x2b7/0x6a0
[<c02a6cf0>] inet_ioctl+0xb0/0xf0
[<c025d93c>] sock_ioctl+0xac/0x260
[<c0174a1d>] sys_ioctl+0x8d/0x220
[<c0107a77>] syscall_call+0x7/0xb

When configuring the network card upon boot.

Jaco Kroon wrote:

> Hello all
>
> I'm getting lot's of these today:
>
> kswapd0: page allocation failure. order:0, mode:0x20
> Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c0127153>] do_timer+0xf3/0x100
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c013fe7d>] free_hot_cold_page+0x1d/0xf0
> [<c01405fc>] __pagevec_free+0x1c/0x30
> [<c0147f67>] __pagevec_release_nonlru+0x67/0x90
> [<c013b9bd>] unlock_page+0xd/0x50
> [<c01494ac>] shrink_list+0x61c/0x890
> [<c0154ccd>] __pte_chain_free+0x3d/0x50
> [<c01498f2>] shrink_cache+0x1d2/0x530
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
> in dmesg.  Most of them are similar but they differ a bit here and 
> there (see attached dmesg file).  This is kernel 2.6.4, find config 
> attached as well.
>
> So far it doesn't seem to cause any real harm, except that I'm also 
> getting segfaults in gcc. I suspect this might be related.
>
> Jaco
>
>------------------------------------------------------------------------
>
>#
># Automatically generated make config: don't edit
>#
>CONFIG_X86=y
>CONFIG_MMU=y
>CONFIG_UID16=y
>CONFIG_GENERIC_ISA_DMA=y
>
>#
># Code maturity level options
>#
>CONFIG_EXPERIMENTAL=y
>CONFIG_CLEAN_COMPILE=y
>CONFIG_STANDALONE=y
>CONFIG_BROKEN_ON_SMP=y
>
>#
># General setup
>#
>CONFIG_SWAP=y
>CONFIG_SYSVIPC=y
># CONFIG_BSD_PROCESS_ACCT is not set
>CONFIG_SYSCTL=y
>CONFIG_LOG_BUF_SHIFT=14
># CONFIG_HOTPLUG is not set
>CONFIG_IKCONFIG=y
>CONFIG_IKCONFIG_PROC=y
># CONFIG_EMBEDDED is not set
>CONFIG_KALLSYMS=y
>CONFIG_FUTEX=y
>CONFIG_EPOLL=y
>CONFIG_IOSCHED_NOOP=y
>CONFIG_IOSCHED_AS=y
>CONFIG_IOSCHED_DEADLINE=y
># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>
>#
># Loadable module support
>#
>CONFIG_MODULES=y
>CONFIG_MODULE_UNLOAD=y
>CONFIG_MODULE_FORCE_UNLOAD=y
>CONFIG_OBSOLETE_MODPARM=y
>CONFIG_MODVERSIONS=y
>CONFIG_KMOD=y
>
>#
># Processor type and features
>#
>CONFIG_X86_PC=y
># CONFIG_X86_ELAN is not set
># CONFIG_X86_VOYAGER is not set
># CONFIG_X86_NUMAQ is not set
># CONFIG_X86_SUMMIT is not set
># CONFIG_X86_BIGSMP is not set
># CONFIG_X86_VISWS is not set
># CONFIG_X86_GENERICARCH is not set
># CONFIG_X86_ES7000 is not set
># CONFIG_M386 is not set
># CONFIG_M486 is not set
># CONFIG_M586 is not set
>CONFIG_M586TSC=y
># CONFIG_M586MMX is not set
># CONFIG_M686 is not set
># CONFIG_MPENTIUMII is not set
># CONFIG_MPENTIUMIII is not set
># CONFIG_MPENTIUMM is not set
># CONFIG_MPENTIUM4 is not set
># CONFIG_MK6 is not set
># CONFIG_MK7 is not set
># CONFIG_MK8 is not set
># CONFIG_MELAN is not set
># CONFIG_MCRUSOE is not set
># CONFIG_MWINCHIPC6 is not set
># CONFIG_MWINCHIP2 is not set
># CONFIG_MWINCHIP3D is not set
># CONFIG_MCYRIXIII is not set
># CONFIG_MVIAC3_2 is not set
># CONFIG_X86_GENERIC is not set
>CONFIG_X86_CMPXCHG=y
>CONFIG_X86_XADD=y
>CONFIG_X86_L1_CACHE_SHIFT=5
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_X86_PPRO_FENCE=y
>CONFIG_X86_F00F_BUG=y
>CONFIG_X86_WP_WORKS_OK=y
>CONFIG_X86_INVLPG=y
>CONFIG_X86_BSWAP=y
>CONFIG_X86_POPAD_OK=y
>CONFIG_X86_ALIGNMENT_16=y
># CONFIG_HPET_TIMER is not set
># CONFIG_HPET_EMULATE_RTC is not set
># CONFIG_SMP is not set
># CONFIG_PREEMPT is not set
># CONFIG_X86_UP_APIC is not set
>CONFIG_X86_TSC=y
>CONFIG_X86_MCE=y
># CONFIG_X86_MCE_NONFATAL is not set
># CONFIG_TOSHIBA is not set
># CONFIG_I8K is not set
># CONFIG_MICROCODE is not set
># CONFIG_X86_MSR is not set
># CONFIG_X86_CPUID is not set
># CONFIG_EDD is not set
>CONFIG_NOHIGHMEM=y
># CONFIG_HIGHMEM4G is not set
># CONFIG_HIGHMEM64G is not set
># CONFIG_MATH_EMULATION is not set
># CONFIG_MTRR is not set
># CONFIG_REGPARM is not set
>
>#
># Power management options (ACPI, APM)
>#
># CONFIG_PM is not set
>
>#
># ACPI (Advanced Configuration and Power Interface) Support
>#
># CONFIG_ACPI is not set
>CONFIG_ACPI_BOOT=y
>
>#
># CPU Frequency scaling
>#
># CONFIG_CPU_FREQ is not set
>
>#
># Bus options (PCI, PCMCIA, EISA, MCA, ISA)
>#
>CONFIG_PCI=y
># CONFIG_PCI_GOBIOS is not set
># CONFIG_PCI_GOMMCONFIG is not set
># CONFIG_PCI_GODIRECT is not set
>CONFIG_PCI_GOANY=y
>CONFIG_PCI_BIOS=y
>CONFIG_PCI_DIRECT=y
>CONFIG_PCI_MMCONFIG=y
>CONFIG_PCI_LEGACY_PROC=y
>CONFIG_PCI_NAMES=y
>CONFIG_ISA=y
>CONFIG_EISA=y
># CONFIG_EISA_VLB_PRIMING is not set
>CONFIG_EISA_PCI_EISA=y
># CONFIG_EISA_VIRTUAL_ROOT is not set
>CONFIG_EISA_NAMES=y
># CONFIG_MCA is not set
># CONFIG_SCx200 is not set
>
>#
># Executable file formats
>#
>CONFIG_BINFMT_ELF=y
># CONFIG_BINFMT_AOUT is not set
># CONFIG_BINFMT_MISC is not set
>
>#
># Device Drivers
>#
>
>#
># Generic Driver Options
>#
># CONFIG_DEBUG_DRIVER is not set
>
>#
># Memory Technology Devices (MTD)
>#
># CONFIG_MTD is not set
>
>#
># Parallel port support
>#
>CONFIG_PARPORT=y
>CONFIG_PARPORT_PC=y
>CONFIG_PARPORT_PC_CML1=y
>CONFIG_PARPORT_SERIAL=y
>CONFIG_PARPORT_PC_FIFO=y
># CONFIG_PARPORT_PC_SUPERIO is not set
># CONFIG_PARPORT_OTHER is not set
>CONFIG_PARPORT_1284=y
>
>#
># Plug and Play support
>#
># CONFIG_PNP is not set
>
>#
># Block devices
>#
>CONFIG_BLK_DEV_FD=y
># CONFIG_BLK_DEV_XD is not set
># CONFIG_PARIDE is not set
># CONFIG_BLK_CPQ_DA is not set
># CONFIG_BLK_CPQ_CISS_DA is not set
># CONFIG_BLK_DEV_DAC960 is not set
># CONFIG_BLK_DEV_UMEM is not set
>CONFIG_BLK_DEV_LOOP=m
>CONFIG_BLK_DEV_CRYPTOLOOP=m
>CONFIG_BLK_DEV_NBD=m
>CONFIG_BLK_DEV_RAM=m
>CONFIG_BLK_DEV_RAM_SIZE=4096
># CONFIG_LBD is not set
>
>#
># ATA/ATAPI/MFM/RLL support
>#
>CONFIG_IDE=y
>CONFIG_BLK_DEV_IDE=y
>
>#
># Please see Documentation/ide.txt for help/info on IDE drives
>#
># CONFIG_BLK_DEV_HD_IDE is not set
>CONFIG_BLK_DEV_IDEDISK=y
>CONFIG_IDEDISK_MULTI_MODE=y
># CONFIG_IDEDISK_STROKE is not set
># CONFIG_BLK_DEV_IDECD is not set
># CONFIG_BLK_DEV_IDETAPE is not set
># CONFIG_BLK_DEV_IDEFLOPPY is not set
># CONFIG_IDE_TASK_IOCTL is not set
># CONFIG_IDE_TASKFILE_IO is not set
>
>#
># IDE chipset support/bugfixes
>#
>CONFIG_IDE_GENERIC=y
># CONFIG_BLK_DEV_CMD640 is not set
>CONFIG_BLK_DEV_IDEPCI=y
># CONFIG_IDEPCI_SHARE_IRQ is not set
># CONFIG_BLK_DEV_OFFBOARD is not set
>CONFIG_BLK_DEV_GENERIC=y
># CONFIG_BLK_DEV_OPTI621 is not set
># CONFIG_BLK_DEV_RZ1000 is not set
>CONFIG_BLK_DEV_IDEDMA_PCI=y
># CONFIG_BLK_DEV_IDEDMA_FORCED is not set
>CONFIG_IDEDMA_PCI_AUTO=y
># CONFIG_IDEDMA_ONLYDISK is not set
>CONFIG_BLK_DEV_ADMA=y
># CONFIG_BLK_DEV_AEC62XX is not set
># CONFIG_BLK_DEV_ALI15X3 is not set
># CONFIG_BLK_DEV_AMD74XX is not set
># CONFIG_BLK_DEV_CMD64X is not set
># CONFIG_BLK_DEV_TRIFLEX is not set
># CONFIG_BLK_DEV_CY82C693 is not set
># CONFIG_BLK_DEV_CS5520 is not set
># CONFIG_BLK_DEV_CS5530 is not set
># CONFIG_BLK_DEV_HPT34X is not set
># CONFIG_BLK_DEV_HPT366 is not set
># CONFIG_BLK_DEV_SC1200 is not set
># CONFIG_BLK_DEV_PIIX is not set
># CONFIG_BLK_DEV_NS87415 is not set
># CONFIG_BLK_DEV_PDC202XX_OLD is not set
># CONFIG_BLK_DEV_PDC202XX_NEW is not set
># CONFIG_BLK_DEV_SVWKS is not set
># CONFIG_BLK_DEV_SIIMAGE is not set
># CONFIG_BLK_DEV_SIS5513 is not set
># CONFIG_BLK_DEV_SLC90E66 is not set
># CONFIG_BLK_DEV_TRM290 is not set
>CONFIG_BLK_DEV_VIA82CXXX=y
># CONFIG_IDE_CHIPSETS is not set
>CONFIG_BLK_DEV_IDEDMA=y
># CONFIG_IDEDMA_IVB is not set
>CONFIG_IDEDMA_AUTO=y
># CONFIG_DMA_NONPCI is not set
># CONFIG_BLK_DEV_HD is not set
>
>#
># SCSI device support
>#
># CONFIG_SCSI is not set
>
>#
># Old CD-ROM drivers (not SCSI, not IDE)
>#
># CONFIG_CD_NO_IDESCSI is not set
>
>#
># Multi-device support (RAID and LVM)
>#
># CONFIG_MD is not set
>
>#
># Fusion MPT device support
>#
>
>#
># IEEE 1394 (FireWire) support
>#
># CONFIG_IEEE1394 is not set
>
>#
># I2O device support
>#
># CONFIG_I2O is not set
>
>#
># Macintosh device drivers
>#
>
>#
># Networking support
>#
>CONFIG_NET=y
>
>#
># Networking options
>#
>CONFIG_PACKET=y
># CONFIG_PACKET_MMAP is not set
># CONFIG_NETLINK_DEV is not set
>CONFIG_UNIX=y
># CONFIG_NET_KEY is not set
>CONFIG_INET=y
># CONFIG_IP_MULTICAST is not set
># CONFIG_IP_ADVANCED_ROUTER is not set
># CONFIG_IP_PNP is not set
># CONFIG_NET_IPIP is not set
># CONFIG_NET_IPGRE is not set
># CONFIG_ARPD is not set
># CONFIG_INET_ECN is not set
>CONFIG_SYN_COOKIES=y
># CONFIG_INET_AH is not set
># CONFIG_INET_ESP is not set
># CONFIG_INET_IPCOMP is not set
>
>#
># IP: Virtual Server Configuration
>#
># CONFIG_IP_VS is not set
># CONFIG_IPV6 is not set
># CONFIG_DECNET is not set
># CONFIG_BRIDGE is not set
>CONFIG_NETFILTER=y
># CONFIG_NETFILTER_DEBUG is not set
>
>#
># IP: Netfilter Configuration
>#
>CONFIG_IP_NF_CONNTRACK=m
>CONFIG_IP_NF_FTP=m
>CONFIG_IP_NF_IRC=m
>CONFIG_IP_NF_TFTP=m
>CONFIG_IP_NF_AMANDA=m
>CONFIG_IP_NF_QUEUE=m
>CONFIG_IP_NF_IPTABLES=y
>CONFIG_IP_NF_MATCH_LIMIT=m
>CONFIG_IP_NF_MATCH_IPRANGE=m
>CONFIG_IP_NF_MATCH_MAC=y
>CONFIG_IP_NF_MATCH_PKTTYPE=m
>CONFIG_IP_NF_MATCH_MARK=m
>CONFIG_IP_NF_MATCH_MULTIPORT=m
>CONFIG_IP_NF_MATCH_TOS=m
>CONFIG_IP_NF_MATCH_RECENT=m
>CONFIG_IP_NF_MATCH_ECN=m
>CONFIG_IP_NF_MATCH_DSCP=m
>CONFIG_IP_NF_MATCH_AH_ESP=m
>CONFIG_IP_NF_MATCH_LENGTH=m
>CONFIG_IP_NF_MATCH_TTL=m
>CONFIG_IP_NF_MATCH_TCPMSS=m
># CONFIG_IP_NF_MATCH_HELPER is not set
># CONFIG_IP_NF_MATCH_STATE is not set
># CONFIG_IP_NF_MATCH_CONNTRACK is not set
>CONFIG_IP_NF_MATCH_OWNER=m
>CONFIG_IP_NF_FILTER=y
>CONFIG_IP_NF_TARGET_REJECT=y
># CONFIG_IP_NF_NAT is not set
>CONFIG_IP_NF_MANGLE=m
>CONFIG_IP_NF_TARGET_TOS=m
>CONFIG_IP_NF_TARGET_ECN=m
>CONFIG_IP_NF_TARGET_DSCP=m
>CONFIG_IP_NF_TARGET_MARK=m
>CONFIG_IP_NF_TARGET_CLASSIFY=m
>CONFIG_IP_NF_TARGET_LOG=m
>CONFIG_IP_NF_TARGET_ULOG=m
>CONFIG_IP_NF_TARGET_TCPMSS=m
>CONFIG_IP_NF_ARPTABLES=m
>CONFIG_IP_NF_ARPFILTER=m
>CONFIG_IP_NF_ARP_MANGLE=m
>
>#
># SCTP Configuration (EXPERIMENTAL)
>#
>CONFIG_IPV6_SCTP__=y
># CONFIG_IP_SCTP is not set
># CONFIG_ATM is not set
># CONFIG_VLAN_8021Q is not set
># CONFIG_LLC2 is not set
># CONFIG_IPX is not set
># CONFIG_ATALK is not set
># CONFIG_X25 is not set
># CONFIG_LAPB is not set
># CONFIG_NET_DIVERT is not set
># CONFIG_ECONET is not set
># CONFIG_WAN_ROUTER is not set
># CONFIG_NET_FASTROUTE is not set
># CONFIG_NET_HW_FLOWCONTROL is not set
>
>#
># QoS and/or fair queueing
>#
># CONFIG_NET_SCHED is not set
>
>#
># Network testing
>#
># CONFIG_NET_PKTGEN is not set
>CONFIG_NETDEVICES=y
>
>#
># ARCnet devices
>#
># CONFIG_ARCNET is not set
># CONFIG_DUMMY is not set
># CONFIG_BONDING is not set
># CONFIG_EQUALIZER is not set
># CONFIG_TUN is not set
>
>#
># Ethernet (10 or 100Mbit)
>#
>CONFIG_NET_ETHERNET=y
>CONFIG_MII=y
># CONFIG_HAPPYMEAL is not set
># CONFIG_SUNGEM is not set
># CONFIG_NET_VENDOR_3COM is not set
># CONFIG_LANCE is not set
># CONFIG_NET_VENDOR_SMC is not set
># CONFIG_NET_VENDOR_RACAL is not set
>
>#
># Tulip family network device support
>#
>CONFIG_NET_TULIP=y
># CONFIG_DE2104X is not set
>CONFIG_TULIP=y
># CONFIG_TULIP_MWI is not set
># CONFIG_TULIP_MMIO is not set
># CONFIG_TULIP_NAPI is not set
># CONFIG_DE4X5 is not set
># CONFIG_WINBOND_840 is not set
># CONFIG_DM9102 is not set
># CONFIG_AT1700 is not set
># CONFIG_DEPCA is not set
># CONFIG_HP100 is not set
># CONFIG_NET_ISA is not set
># CONFIG_NET_PCI is not set
># CONFIG_NET_POCKET is not set
>
>#
># Ethernet (1000 Mbit)
>#
># CONFIG_ACENIC is not set
># CONFIG_DL2K is not set
># CONFIG_E1000 is not set
># CONFIG_NS83820 is not set
># CONFIG_HAMACHI is not set
># CONFIG_YELLOWFIN is not set
># CONFIG_R8169 is not set
># CONFIG_SIS190 is not set
># CONFIG_SK98LIN is not set
># CONFIG_TIGON3 is not set
>
>#
># Ethernet (10000 Mbit)
>#
># CONFIG_IXGB is not set
># CONFIG_FDDI is not set
># CONFIG_HIPPI is not set
># CONFIG_PLIP is not set
># CONFIG_PPP is not set
># CONFIG_SLIP is not set
>
>#
># Wireless LAN (non-hamradio)
>#
># CONFIG_NET_RADIO is not set
>
>#
># Token Ring devices
>#
># CONFIG_TR is not set
># CONFIG_RCPCI is not set
># CONFIG_SHAPER is not set
>
>#
># Wan interfaces
>#
># CONFIG_WAN is not set
>
>#
># Amateur Radio support
>#
># CONFIG_HAMRADIO is not set
>
>#
># IrDA (infrared) support
>#
># CONFIG_IRDA is not set
>
>#
># Bluetooth support
>#
># CONFIG_BT is not set
>
>#
># ISDN subsystem
>#
># CONFIG_ISDN is not set
>
>#
># Telephony Support
>#
># CONFIG_PHONE is not set
>
>#
># Input device support
>#
>CONFIG_INPUT=y
>
>#
># Userland interfaces
>#
>CONFIG_INPUT_MOUSEDEV=y
>CONFIG_INPUT_MOUSEDEV_PSAUX=y
>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
># CONFIG_INPUT_JOYDEV is not set
># CONFIG_INPUT_TSDEV is not set
># CONFIG_INPUT_EVDEV is not set
># CONFIG_INPUT_EVBUG is not set
>
>#
># Input I/O drivers
>#
># CONFIG_GAMEPORT is not set
>CONFIG_SOUND_GAMEPORT=y
>CONFIG_SERIO=y
>CONFIG_SERIO_I8042=y
># CONFIG_SERIO_SERPORT is not set
># CONFIG_SERIO_CT82C710 is not set
># CONFIG_SERIO_PARKBD is not set
># CONFIG_SERIO_PCIPS2 is not set
>
>#
># Input Device Drivers
>#
>CONFIG_INPUT_KEYBOARD=y
>CONFIG_KEYBOARD_ATKBD=y
># CONFIG_KEYBOARD_SUNKBD is not set
># CONFIG_KEYBOARD_XTKBD is not set
># CONFIG_KEYBOARD_NEWTON is not set
>CONFIG_INPUT_MOUSE=y
># CONFIG_MOUSE_PS2 is not set
>CONFIG_MOUSE_SERIAL=y
># CONFIG_MOUSE_INPORT is not set
># CONFIG_MOUSE_LOGIBM is not set
># CONFIG_MOUSE_PC110PAD is not set
># CONFIG_INPUT_JOYSTICK is not set
># CONFIG_INPUT_TOUCHSCREEN is not set
>CONFIG_INPUT_MISC=y
>CONFIG_INPUT_PCSPKR=y
># CONFIG_INPUT_UINPUT is not set
>
>#
># Character devices
>#
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
># CONFIG_SERIAL_NONSTANDARD is not set
>
>#
># Serial drivers
>#
>CONFIG_SERIAL_8250=y
># CONFIG_SERIAL_8250_CONSOLE is not set
>CONFIG_SERIAL_8250_NR_UARTS=4
># CONFIG_SERIAL_8250_EXTENDED is not set
>
>#
># Non-8250 serial port support
>#
>CONFIG_SERIAL_CORE=y
>CONFIG_UNIX98_PTYS=y
># CONFIG_LEGACY_PTYS is not set
>CONFIG_PRINTER=y
># CONFIG_LP_CONSOLE is not set
># CONFIG_PPDEV is not set
># CONFIG_TIPAR is not set
>
>#
># Mice
>#
># CONFIG_BUSMOUSE is not set
># CONFIG_QIC02_TAPE is not set
>
>#
># IPMI
>#
># CONFIG_IPMI_HANDLER is not set
>
>#
># Watchdog Cards
>#
># CONFIG_WATCHDOG is not set
># CONFIG_HW_RANDOM is not set
># CONFIG_NVRAM is not set
>CONFIG_RTC=y
># CONFIG_DTLK is not set
># CONFIG_R3964 is not set
># CONFIG_APPLICOM is not set
># CONFIG_SONYPI is not set
>
>#
># Ftape, the floppy tape device driver
>#
># CONFIG_FTAPE is not set
># CONFIG_AGP is not set
># CONFIG_DRM is not set
># CONFIG_MWAVE is not set
># CONFIG_RAW_DRIVER is not set
># CONFIG_HANGCHECK_TIMER is not set
>
>#
># I2C support
>#
># CONFIG_I2C is not set
>
>#
># Misc devices
>#
># CONFIG_IBM_ASM is not set
>
>#
># Multimedia devices
>#
># CONFIG_VIDEO_DEV is not set
>
>#
># Digital Video Broadcasting Devices
>#
># CONFIG_DVB is not set
>
>#
># Graphics support
>#
># CONFIG_FB is not set
>CONFIG_VIDEO_SELECT=y
>
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=y
># CONFIG_MDA_CONSOLE is not set
>CONFIG_DUMMY_CONSOLE=y
>
>#
># Sound
>#
>CONFIG_SOUND=m
>
>#
># Advanced Linux Sound Architecture
>#
>CONFIG_SND=m
>CONFIG_SND_SEQUENCER=m
># CONFIG_SND_SEQ_DUMMY is not set
>CONFIG_SND_OSSEMUL=y
>CONFIG_SND_MIXER_OSS=m
>CONFIG_SND_PCM_OSS=m
>CONFIG_SND_SEQUENCER_OSS=y
>CONFIG_SND_RTCTIMER=m
># CONFIG_SND_VERBOSE_PRINTK is not set
># CONFIG_SND_DEBUG is not set
>
>#
># Generic devices
>#
># CONFIG_SND_DUMMY is not set
># CONFIG_SND_VIRMIDI is not set
># CONFIG_SND_MTPAV is not set
># CONFIG_SND_SERIAL_U16550 is not set
># CONFIG_SND_MPU401 is not set
>
>#
># ISA devices
>#
># CONFIG_SND_AD1848 is not set
># CONFIG_SND_CS4231 is not set
># CONFIG_SND_CS4232 is not set
># CONFIG_SND_CS4236 is not set
># CONFIG_SND_ES1688 is not set
># CONFIG_SND_ES18XX is not set
># CONFIG_SND_GUSCLASSIC is not set
># CONFIG_SND_GUSEXTREME is not set
># CONFIG_SND_GUSMAX is not set
># CONFIG_SND_INTERWAVE is not set
># CONFIG_SND_INTERWAVE_STB is not set
># CONFIG_SND_OPTI92X_AD1848 is not set
># CONFIG_SND_OPTI92X_CS4231 is not set
># CONFIG_SND_OPTI93X is not set
># CONFIG_SND_SB8 is not set
>CONFIG_SND_SB16=m
>CONFIG_SND_SBAWE=m
># CONFIG_SND_SB16_CSP is not set
># CONFIG_SND_WAVEFRONT is not set
># CONFIG_SND_CMI8330 is not set
># CONFIG_SND_OPL3SA2 is not set
># CONFIG_SND_SGALAXY is not set
># CONFIG_SND_SSCAPE is not set
>
>#
># PCI devices
>#
># CONFIG_SND_ALI5451 is not set
># CONFIG_SND_AZT3328 is not set
># CONFIG_SND_BT87X is not set
># CONFIG_SND_CS46XX is not set
># CONFIG_SND_CS4281 is not set
># CONFIG_SND_EMU10K1 is not set
># CONFIG_SND_KORG1212 is not set
># CONFIG_SND_NM256 is not set
># CONFIG_SND_RME32 is not set
># CONFIG_SND_RME96 is not set
># CONFIG_SND_RME9652 is not set
># CONFIG_SND_HDSP is not set
># CONFIG_SND_TRIDENT is not set
># CONFIG_SND_YMFPCI is not set
># CONFIG_SND_ALS4000 is not set
># CONFIG_SND_CMIPCI is not set
># CONFIG_SND_ENS1370 is not set
># CONFIG_SND_ENS1371 is not set
># CONFIG_SND_ES1938 is not set
># CONFIG_SND_ES1968 is not set
># CONFIG_SND_MAESTRO3 is not set
># CONFIG_SND_FM801 is not set
># CONFIG_SND_ICE1712 is not set
># CONFIG_SND_ICE1724 is not set
># CONFIG_SND_INTEL8X0 is not set
># CONFIG_SND_SONICVIBES is not set
># CONFIG_SND_VIA82XX is not set
># CONFIG_SND_VX222 is not set
>
>#
># Open Sound System
>#
># CONFIG_SOUND_PRIME is not set
>
>#
># USB support
>#
># CONFIG_USB is not set
>
>#
># USB Gadget Support
>#
># CONFIG_USB_GADGET is not set
>
>#
># File systems
>#
># CONFIG_EXT2_FS is not set
>CONFIG_EXT3_FS=y
># CONFIG_EXT3_FS_XATTR is not set
>CONFIG_JBD=y
># CONFIG_JBD_DEBUG is not set
># CONFIG_REISERFS_FS is not set
># CONFIG_JFS_FS is not set
># CONFIG_XFS_FS is not set
># CONFIG_MINIX_FS is not set
># CONFIG_ROMFS_FS is not set
># CONFIG_QUOTA is not set
># CONFIG_AUTOFS_FS is not set
># CONFIG_AUTOFS4_FS is not set
>
>#
># CD-ROM/DVD Filesystems
>#
># CONFIG_ISO9660_FS is not set
># CONFIG_UDF_FS is not set
>
>#
># DOS/FAT/NT Filesystems
>#
># CONFIG_FAT_FS is not set
># CONFIG_NTFS_FS is not set
>
>#
># Pseudo filesystems
>#
>CONFIG_PROC_FS=y
>CONFIG_PROC_KCORE=y
>CONFIG_DEVFS_FS=y
>CONFIG_DEVFS_MOUNT=y
># CONFIG_DEVFS_DEBUG is not set
># CONFIG_DEVPTS_FS_XATTR is not set
>CONFIG_TMPFS=y
># CONFIG_HUGETLBFS is not set
># CONFIG_HUGETLB_PAGE is not set
>CONFIG_RAMFS=y
>
>#
># Miscellaneous filesystems
>#
># CONFIG_ADFS_FS is not set
># CONFIG_AFFS_FS is not set
># CONFIG_HFS_FS is not set
># CONFIG_HFSPLUS_FS is not set
># CONFIG_BEFS_FS is not set
># CONFIG_BFS_FS is not set
># CONFIG_EFS_FS is not set
># CONFIG_CRAMFS is not set
># CONFIG_VXFS_FS is not set
># CONFIG_HPFS_FS is not set
># CONFIG_QNX4FS_FS is not set
># CONFIG_SYSV_FS is not set
># CONFIG_UFS_FS is not set
>
>#
># Network File Systems
>#
>CONFIG_NFS_FS=y
>CONFIG_NFS_V3=y
># CONFIG_NFS_V4 is not set
># CONFIG_NFS_DIRECTIO is not set
>CONFIG_NFSD=y
>CONFIG_NFSD_V3=y
># CONFIG_NFSD_V4 is not set
># CONFIG_NFSD_TCP is not set
>CONFIG_LOCKD=y
>CONFIG_LOCKD_V4=y
>CONFIG_EXPORTFS=y
>CONFIG_SUNRPC=y
>CONFIG_SUNRPC_GSS=m
>CONFIG_SMB_FS=m
># CONFIG_SMB_NLS_DEFAULT is not set
>CONFIG_CIFS=m
># CONFIG_NCP_FS is not set
># CONFIG_CODA_FS is not set
># CONFIG_AFS_FS is not set
>
>#
># Partition Types
>#
># CONFIG_PARTITION_ADVANCED is not set
>CONFIG_MSDOS_PARTITION=y
>
>#
># Native Language Support
>#
>CONFIG_NLS=m
>CONFIG_NLS_DEFAULT="iso8859-1"
># CONFIG_NLS_CODEPAGE_437 is not set
># CONFIG_NLS_CODEPAGE_737 is not set
># CONFIG_NLS_CODEPAGE_775 is not set
># CONFIG_NLS_CODEPAGE_850 is not set
># CONFIG_NLS_CODEPAGE_852 is not set
># CONFIG_NLS_CODEPAGE_855 is not set
># CONFIG_NLS_CODEPAGE_857 is not set
># CONFIG_NLS_CODEPAGE_860 is not set
># CONFIG_NLS_CODEPAGE_861 is not set
># CONFIG_NLS_CODEPAGE_862 is not set
># CONFIG_NLS_CODEPAGE_863 is not set
># CONFIG_NLS_CODEPAGE_864 is not set
># CONFIG_NLS_CODEPAGE_865 is not set
># CONFIG_NLS_CODEPAGE_866 is not set
># CONFIG_NLS_CODEPAGE_869 is not set
># CONFIG_NLS_CODEPAGE_936 is not set
># CONFIG_NLS_CODEPAGE_950 is not set
># CONFIG_NLS_CODEPAGE_932 is not set
># CONFIG_NLS_CODEPAGE_949 is not set
># CONFIG_NLS_CODEPAGE_874 is not set
># CONFIG_NLS_ISO8859_8 is not set
># CONFIG_NLS_CODEPAGE_1250 is not set
># CONFIG_NLS_CODEPAGE_1251 is not set
>CONFIG_NLS_ISO8859_1=m
># CONFIG_NLS_ISO8859_2 is not set
># CONFIG_NLS_ISO8859_3 is not set
># CONFIG_NLS_ISO8859_4 is not set
># CONFIG_NLS_ISO8859_5 is not set
># CONFIG_NLS_ISO8859_6 is not set
># CONFIG_NLS_ISO8859_7 is not set
># CONFIG_NLS_ISO8859_9 is not set
># CONFIG_NLS_ISO8859_13 is not set
># CONFIG_NLS_ISO8859_14 is not set
># CONFIG_NLS_ISO8859_15 is not set
># CONFIG_NLS_KOI8_R is not set
># CONFIG_NLS_KOI8_U is not set
># CONFIG_NLS_UTF8 is not set
>
>#
># Profiling support
>#
># CONFIG_PROFILING is not set
>
>#
># Kernel hacking
>#
>CONFIG_DEBUG_KERNEL=y
>CONFIG_EARLY_PRINTK=y
>CONFIG_DEBUG_STACKOVERFLOW=y
>CONFIG_DEBUG_STACK_USAGE=y
>CONFIG_DEBUG_SLAB=y
>CONFIG_DEBUG_IOVIRT=y
>CONFIG_MAGIC_SYSRQ=y
>CONFIG_DEBUG_SPINLOCK=y
>CONFIG_DEBUG_PAGEALLOC=y
>CONFIG_DEBUG_INFO=y
>CONFIG_DEBUG_SPINLOCK_SLEEP=y
>CONFIG_FRAME_POINTER=y
>
>#
># Security options
>#
># CONFIG_SECURITY is not set
>
>#
># Cryptographic options
>#
>CONFIG_CRYPTO=y
># CONFIG_CRYPTO_HMAC is not set
># CONFIG_CRYPTO_NULL is not set
># CONFIG_CRYPTO_MD4 is not set
># CONFIG_CRYPTO_MD5 is not set
># CONFIG_CRYPTO_SHA1 is not set
># CONFIG_CRYPTO_SHA256 is not set
># CONFIG_CRYPTO_SHA512 is not set
># CONFIG_CRYPTO_DES is not set
># CONFIG_CRYPTO_BLOWFISH is not set
># CONFIG_CRYPTO_TWOFISH is not set
># CONFIG_CRYPTO_SERPENT is not set
># CONFIG_CRYPTO_AES is not set
># CONFIG_CRYPTO_CAST5 is not set
># CONFIG_CRYPTO_CAST6 is not set
># CONFIG_CRYPTO_ARC4 is not set
># CONFIG_CRYPTO_DEFLATE is not set
># CONFIG_CRYPTO_TEST is not set
>
>#
># Library routines
>#
>CONFIG_CRC32=y
>CONFIG_X86_BIOS_REBOOT=y
>CONFIG_PC=y
>  
>
>------------------------------------------------------------------------
>
>9f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023ba4f>] tulip_rx+0x2af/0x3f0
> [<c023c44b>] tulip_interrupt+0x8bb/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c02684fd>] process_backlog+0x6d/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023ba4f>] tulip_rx+0x2af/0x3f0
> [<c023c44b>] tulip_interrupt+0x8bb/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c02684fd>] process_backlog+0x6d/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c02684fd>] process_backlog+0x6d/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c02684fd>] process_backlog+0x6d/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c041>] tulip_interrupt+0x4b1/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c02684fd>] process_backlog+0x6d/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0263208>] skb_clone+0x18/0x180
> [<c02b6b0c>] packet_rcv_spkt+0x3fc/0x430
> [<c010b9a4>] do_IRQ+0x184/0x2f0
> [<c0268413>] netif_receive_skb+0xf3/0x170
> [<c0268503>] process_backlog+0x73/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c041>] tulip_interrupt+0x4b1/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c01453f9>] kmem_cache_alloc+0x49/0x1c0
> [<c0263208>] skb_clone+0x18/0x180
> [<c02b6b0c>] packet_rcv_spkt+0x3fc/0x430
> [<c010b9a4>] do_IRQ+0x184/0x2f0
> [<c0268413>] netif_receive_skb+0xf3/0x170
> [<c0268503>] process_backlog+0x73/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c041>] tulip_interrupt+0x4b1/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014677a>] reap_timer_fnc+0x15a/0x3d0
> [<c0146620>] reap_timer_fnc+0x0/0x3d0
> [<c0126e2b>] run_timer_softirq+0x14b/0x370
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0126cac>] update_process_times+0x2c/0x40
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0263208>] skb_clone+0x18/0x180
> [<c02b6b0c>] packet_rcv_spkt+0x3fc/0x430
> [<c0268413>] netif_receive_skb+0xf3/0x170
> [<c0268503>] process_backlog+0x73/0x120
> [<c0268613>] net_rx_action+0x63/0x100
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c010ba15>] do_IRQ+0x1f5/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c014a1fc>] refill_inactive_zone+0x5ac/0x910
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>printk: 1 messages suppressed.
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c01457ac>] __kmalloc+0x1dc/0x210
> [<c0262f0e>] alloc_skb+0x3e/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c0149db5>] refill_inactive_zone+0x165/0x910
> [<c01498f2>] shrink_cache+0x1d2/0x530
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c01457ac>] __kmalloc+0x1dc/0x210
> [<c0262f0e>] alloc_skb+0x3e/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c041>] tulip_interrupt+0x4b1/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c0149db5>] refill_inactive_zone+0x165/0x910
> [<c01498f2>] shrink_cache+0x1d2/0x530
> [<c01222a3>] do_softirq+0xa3/0xb0
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>printk: 8 messages suppressed.
>emerge: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c01c5d2a>] nfs_read_rpcsetup+0x7a/0x140
> [<c01c5f0d>] nfs_pagein_one+0x5d/0xa0
> [<c01c5f93>] nfs_pagein_list+0x43/0x70
> [<c01c63ca>] nfs_readpages+0x7a/0x90
> [<c014290e>] read_pages+0x10e/0x120
> [<c01162ed>] kernel_map_pages+0x1d/0x60
> [<c0140463>] __alloc_pages+0x2f3/0x390
> [<c0142d64>] __do_page_cache_readahead+0x134/0x2d0
> [<c0142b3c>] page_cache_readahead+0x16c/0x1b0
> [<c013c338>] do_generic_mapping_read+0x98/0x380
> [<c013c620>] file_read_actor+0x0/0x130
> [<c013c8be>] __generic_file_aio_read+0x16e/0x1b0
> [<c013c620>] file_read_actor+0x0/0x130
> [<c01166d3>] try_to_wake_up+0x173/0x260
> [<c013c93d>] generic_file_aio_read+0x3d/0x50
> [<c01c0046>] nfs_file_read+0x86/0xe0
> [<c01609ab>] do_sync_read+0x7b/0xb0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c0116e4b>] scheduler_tick+0x1b/0x600
> [<c0126cac>] update_process_times+0x2c/0x40
> [<c0126b5d>] update_wall_time+0xd/0x40
> [<c0127153>] do_timer+0xf3/0x100
> [<c0160a7e>] vfs_read+0x9e/0xf0
> [<c0160c9e>] sys_read+0x2e/0x50
> [<c0109aa7>] syscall_call+0x7/0xb
>
>printk: 25 messages suppressed.
>emerge: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c01457ac>] __kmalloc+0x1dc/0x210
> [<c0262f0e>] alloc_skb+0x3e/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
>
>printk: 9 messages suppressed.
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> [<c0127153>] do_timer+0xf3/0x100
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c013fe7d>] free_hot_cold_page+0x1d/0xf0
> [<c01405fc>] __pagevec_free+0x1c/0x30
> [<c0147f67>] __pagevec_release_nonlru+0x67/0x90
> [<c013b9bd>] unlock_page+0xd/0x50
> [<c01494ac>] shrink_list+0x61c/0x890
> [<c0154ccd>] __pte_chain_free+0x3d/0x50
> [<c01498f2>] shrink_cache+0x1d2/0x530
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>kswapd0: page allocation failure. order:0, mode:0x20
>Call Trace:
> [<c0140447>] __alloc_pages+0x2d7/0x390
> [<c0140522>] __get_free_pages+0x22/0x60
> [<c014464f>] cache_grow+0x11f/0x470
> [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0262eec>] alloc_skb+0x1c/0xe0
> [<c023b731>] tulip_refill_rx+0x91/0x100
> [<c023c041>] tulip_interrupt+0x4b1/0x8e0
> [<c0127153>] do_timer+0xf3/0x100
> [<c010b433>] handle_IRQ_event+0x33/0x60
> [<c010b92d>] do_IRQ+0x10d/0x2f0
> [<c0109cc8>] common_interrupt+0x18/0x20
> [<c013fe7d>] free_hot_cold_page+0x1d/0xf0
> [<c01405fc>] __pagevec_free+0x1c/0x30
> [<c0147f67>] __pagevec_release_nonlru+0x67/0x90
> [<c013b9bd>] unlock_page+0xd/0x50
> [<c01494ac>] shrink_list+0x61c/0x890
> [<c0154ccd>] __pte_chain_free+0x3d/0x50
> [<c01498f2>] shrink_cache+0x1d2/0x530
> [<c014a5cf>] shrink_zone+0x6f/0xa0
> [<c014a979>] balance_pgdat+0x159/0x1f0
> [<c014aaee>] kswapd+0xde/0xf0
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c011a2c0>] autoremove_wake_function+0x0/0x40
> [<c014aa10>] kswapd+0x0/0xf0
> [<c01070f5>] kernel_thread_helper+0x5/0x10
>
>nfs: server pug.lan not responding, still trying
>nfs: server pug.lan OK
>  
>

-- 
But in our enthusiasm, we could not resist a radical overhaul of the
system, in which all of its major weaknesses have been exposed,
analyzed, and replaced with new weaknesses.
		-- Bruce Leverett, "Register Allocation in Optimizing Compilers"
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================

