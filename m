Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264695AbSJ3ONK>; Wed, 30 Oct 2002 09:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264696AbSJ3ONK>; Wed, 30 Oct 2002 09:13:10 -0500
Received: from secondary.dns.nitric.com ([64.81.197.162]:57236 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id <S264695AbSJ3OMA>; Wed, 30 Oct 2002 09:12:00 -0500
To: linux-kernel@vger.kernel.org
From: merlin hughes <merlin@merlin.org>
Subject: kernel BUG at drivers/scsi/scsi_lib.c:819 with 2.5.44-ac5
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <4224.1035987454.0@merlin.org>
Date: Wed, 30 Oct 2002 09:18:12 -0500
Message-Id: <20021030141812.BF07786921@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4224.1035987454.1@merlin.org>

Hi,

Tyan Tiger S2466-4M, 2xAthlon MP, Adaptec 29160, Adaptec 2940u2w,
software RAID 5, gcc 2.95.4. The core drives are on the 29160. Works
fine under 2.4.19.

2.5.44 panics during boot with SCSI problems; I didn't catch what the
error was.

2.5.44-ac5 boots but bugs after a few seconds.

Attached: config, syslog, lspci (under 2.4.19)

Oct 28 12:36:09 badb kernel: Incorrect number of segments after building list
Oct 28 12:36:09 badb kernel: counted 2, received 1
Oct 28 12:36:09 badb kernel: req nr_sec 8, cur_nr_sec 8
Oct 28 12:36:09 badb kernel: end_request: I/O error, dev 08:40, sector 6784528
Oct 28 12:36:09 badb kernel: raid5: Disk failure on scsi/host0/bus0/target4/lun0/part7, disabling device. Operation continuing on 4 devices
Oct 28 12:36:09 badb kernel: blk: request botched
Oct 28 12:36:09 badb kernel: ------------[ cut here ]------------
Oct 28 12:36:09 badb kernel: kernel BUG at drivers/scsi/scsi_lib.c:819!
Oct 28 12:36:09 badb kernel: invalid operand: 0000
Oct 28 12:36:09 badb kernel: mousedev hid nfs lockd sunrpc ohci-hcd usbcore parport_pc lp parport sg st sr_mod cdrom floppy iptable_filter ip_tables emu10k1 sound soundcore ac97_codec 3c59x rtc
Oct 28 12:36:09 badb kernel: CPU:    1
Oct 28 12:36:09 badb kernel: EIP:    0060:[scsi_init_io+279/304]    Not tainted
Oct 28 12:36:09 badb kernel: EFLAGS: 00010286
Oct 28 12:36:09 badb kernel: EIP is at scsi_init_io+0x117/0x130
Oct 28 12:36:09 badb kernel: eax: f5bcda00   ebx: f5bcda00   ecx: 00000001   edx: f7f51580
Oct 28 12:36:09 badb kernel: esi: 00000002   edi: f7ed62c0   ebp: f78c9f90   esp: f78c9f60
Oct 28 12:36:09 badb kernel: ds: 0068   es: 0068   ss: 0068
Oct 28 12:36:09 badb kernel: Process raid5d (pid: 17, threadinfo=f78c8000 task=f7e0cd00)
Oct 28 12:36:09 badb kernel: Stack: f7ed62c0 f5bcda00 f7ef3400 c01aa8bb f5bcda00 f7ef34c8 f7ef3428 f7ea3680
Oct 28 12:36:09 badb kernel:        f7f56800 f78c8000 c031fb20 c019d88e 00000001 c019eb5d f7ef3428 f7df434c
Oct 28 12:36:09 badb kernel:        f78c9fb4 c019ed80 f7ef3428 f78c8000 f78c8000 f78c9fb4 f78c9fb4 c01d6abf
Oct 28 12:36:09 badb kernel: Call Trace:
Oct 28 12:36:09 badb kernel:  [scsi_request_fn+779/1136] scsi_request_fn+0x30b/0x470
Oct 28 12:36:09 badb kernel:  [elv_queue_empty+14/32] elv_queue_empty+0xe/0x20
Oct 28 12:36:09 badb kernel:  [generic_unplug_device+141/192] generic_unplug_device+0x8d/0xc0
Oct 28 12:36:09 badb kernel:  [blk_run_queues+176/192] blk_run_queues+0xb0/0xc0
Oct 28 12:36:09 badb kernel:  [md_thread+415/528] md_thread+0x19f/0x210
Oct 28 12:36:09 badb kernel:  [md_thread+0/528] md_thread+0x0/0x210
Oct 28 12:36:09 badb kernel:  [default_wake_function+0/64] default_wake_function+0x0/0x40
Oct 28 12:36:09 badb kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Oct 28 12:36:09 badb kernel:
Oct 28 12:36:09 badb kernel: Code: 0f 0b 33 03 42 b0 24 c0 90 31 c0 5b 5e 5f c3 8d 76 00 8d bc
Oct 28 12:36:09 badb kernel:  <6>md: updating md2 RAID superblock on device
Oct 28 12:36:09 badb kernel: md: (skipping faulty scsi/host0/bus0/target4/lun0/part7 )
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target3/lun0/part7 [events: 000000ac]<6>(write) scsi/host0/bus0/target3/lun0/part7's sb offset: 4200896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target2/lun0/part7 [events: 000000ac]<6>(write) scsi/host0/bus0/target2/lun0/part7's sb offset: 4200896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target1/lun0/part7 [events: 000000ac]<6>(write) scsi/host0/bus0/target1/lun0/part7's sb offset: 4200896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target0/lun0/part7 [events: 000000ac]<6>(write) scsi/host0/bus0/target0/lun0/part7's sb offset: 4200896

I trust that the 'disk failure' is just a side-effect of the bug; the
system runs fine on 2.4.19 after I raidhotadd it back.

merlin

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="config-2.5.44-ac5"; charset="us-ascii"
Content-ID: <4224.1035987454.2@merlin.org>
Content-Description: config-2.5.44-ac5

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_GEODE is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_X86_HAVE_CMOV is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_HAVE_CMOV=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_NR_CPUS=2
# CONFIG_X86_NUMA is not set
# CONFIG_X86_MCE is not set
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
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

#
# ACPI Support
#
# CONFIG_ACPI is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_MCA is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_EISA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
CONFIG_I82365=m
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

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
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
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
# CONFIG_SCSI_EATA_DMA is not set
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
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
# CONFIG_IP_NF_MATCH_DSCP is not set
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DEV_APPLETALK is not set
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
# Network device support
#
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
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000_NAPI is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
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
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_NET_PCMCIA_RADIO is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
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
# CONFIG_SERIAL_8250 is not set
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_AMD_RNG=m
# CONFIG_NVRAM is not set
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
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
# CONFIG_CIFS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
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
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_ACCEL=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS46XX_NEW_DSP is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
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
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_LONG_TIMEOUT=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD_ALT is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
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
# CONFIG_HID_PID is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
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
#   Video4Linux support is needed for USB Multimedia device support
#
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
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
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_SPEEDTOUCH is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
# CONFIG_X86_STACK_CHECK is not set
CONFIG_IOMMU_DEBUG=y

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
# CONFIG_ZLIB_DEFLATE is not set
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TSC=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="syslog"; charset="iso-8859-1"
Content-ID: <4224.1035987454.3@merlin.org>
Content-Description: syslog
Content-Transfer-Encoding: quoted-printable

Oct 28 12:27:53 badb syslogd 1.4.1#10: restart.
Oct 28 12:27:53 badb kernel: klogd 1.4.1#10, log source =3D /proc/kmsg sta=
rted.
Oct 28 12:27:53 badb kernel: Inspecting /boot/System.map-2.5.44-ac5
Oct 28 12:27:53 badb kernel: Loaded 16349 symbols from /boot/System.map-2.=
5.44-ac5.
Oct 28 12:27:53 badb kernel: Symbols match kernel version 2.5.44.
Oct 28 12:27:53 badb kernel: Error seeking in /dev/kmem =

Oct 28 12:27:53 badb kernel: Symbol #nfs, value f8ade000 =

Oct 28 12:27:53 badb kernel: Error adding kernel module table entry. =

Oct 28 12:27:53 badb kernel: I NVS)
Oct 28 12:27:53 badb kernel:  user: 000000003ff00000 - 000000003ff80000 (u=
sable)
Oct 28 12:27:53 badb kernel:  user: 000000003ff80000 - 0000000040000000 (r=
eserved)
Oct 28 12:27:53 badb kernel:  user: 00000000fec00000 - 00000000fec04000 (r=
eserved)
Oct 28 12:27:53 badb kernel:  user: 00000000fee00000 - 00000000fee01000 (r=
eserved)
Oct 28 12:27:53 badb kernel:  user: 00000000fff80000 - 0000000100000000 (r=
eserved)
Oct 28 12:27:53 badb kernel: Warning only 896MB will be used.
Oct 28 12:27:53 badb kernel: Use a HIGHMEM enabled kernel.
Oct 28 12:27:53 badb kernel: 896MB LOWMEM available.
Oct 28 12:27:53 badb kernel: found SMP MP-table at 000f7170
Oct 28 12:27:53 badb kernel: hm, page 000f7000 reserved twice.
Oct 28 12:27:53 badb kernel: hm, page 000f8000 reserved twice.
Oct 28 12:27:53 badb kernel: hm, page 0009f000 reserved twice.
Oct 28 12:27:53 badb kernel: hm, page 000a0000 reserved twice.
Oct 28 12:27:53 badb kernel: On node 0 totalpages: 229376
Oct 28 12:27:53 badb kernel:   DMA zone: 4096 pages
Oct 28 12:27:53 badb kernel:   Normal zone: 225280 pages
Oct 28 12:27:53 badb kernel:   HighMem zone: 0 pages
Oct 28 12:27:53 badb kernel: Intel MultiProcessor Specification v1.4
Oct 28 12:27:53 badb kernel:     Virtual Wire compatibility mode.
Oct 28 12:27:53 badb kernel: OEM ID: TYAN     Product ID: PAULANER     API=
C at: 0xFEE00000
Oct 28 12:27:53 badb kernel: Processor #1 6:6 APIC version 16
Oct 28 12:27:53 badb kernel: Processor #0 6:6 APIC version 16
Oct 28 12:27:53 badb kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Oct 28 12:27:53 badb kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Oct 28 12:27:53 badb kernel: Processors: 2
Oct 28 12:27:53 badb kernel: Building zonelist for node : 0
Oct 28 12:27:53 badb kernel: Kernel command line: auto BOOT_IMAGE=3DLinux =
ro root=3D901 mem=3D1024M
Oct 28 12:27:53 badb kernel: Initializing CPU#0
Oct 28 12:27:53 badb kernel: Detected 1666.359 MHz processor.
Oct 28 12:27:53 badb kernel: Console: colour VGA+ 80x60
Oct 28 12:27:53 badb kernel: Calibrating delay loop... 3284.99 BogoMIPS
Oct 28 12:27:53 badb kernel: Memory: 905328k/917504k available (1195k kern=
el code, 11788k reserved, 1050k data, 104k init, 0k highmem)
Oct 28 12:27:53 badb kernel: Security Scaffold v1.0.0 initialized
Oct 28 12:27:53 badb kernel: Dentry cache hash table entries: 131072 (orde=
r: 8, 1048576 bytes)
Oct 28 12:27:53 badb kernel: Inode-cache hash table entries: 65536 (order:=
 7, 524288 bytes)
Oct 28 12:27:53 badb kernel: Mount-cache hash table entries: 512 (order: 0=
, 4096 bytes)
Oct 28 12:27:53 badb kernel: CPU: Before vendor init, caps: 0383fbff c1cbf=
bff 00000000, vendor =3D 2
Oct 28 12:27:53 badb kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache=
 64K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: After vendor init, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:     After generic, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:             Common caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: Enabling fast FPU save and restore... done.
Oct 28 12:27:53 badb kernel: Enabling unmasked SIMD FPU exception support.=
.. done.
Oct 28 12:27:53 badb kernel: Checking 'hlt' instruction... OK.
Oct 28 12:27:53 badb kernel: POSIX conformance testing by UNIFIX
Oct 28 12:27:53 badb kernel: CPU: Before vendor init, caps: 0383fbff c1cbf=
bff 00000000, vendor =3D 2
Oct 28 12:27:53 badb kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache=
 64K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: After vendor init, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:     After generic, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:             Common caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU0: AMD Athlon(tm) MP 2000+ stepping 02
Oct 28 12:27:53 badb kernel: per-CPU timeslice cutoff: 731.44 usecs.
Oct 28 12:27:53 badb kernel: task migration cache decay timeout: 1 msecs.
Oct 28 12:27:53 badb kernel: masked ExtINT on CPU#0
Oct 28 12:27:53 badb kernel: ESR value before enabling vector: 00000000
Oct 28 12:27:53 badb kernel: ESR value after enabling vector: 00000000
Oct 28 12:27:53 badb kernel: Booting processor 1/0 eip 2000
Oct 28 12:27:53 badb kernel: Initializing CPU#1
Oct 28 12:27:53 badb kernel: masked ExtINT on CPU#1
Oct 28 12:27:53 badb kernel: ESR value before enabling vector: 00000000
Oct 28 12:27:53 badb kernel: ESR value after enabling vector: 00000000
Oct 28 12:27:53 badb kernel: Calibrating delay loop... 3325.95 BogoMIPS
Oct 28 12:27:53 badb kernel: CPU: Before vendor init, caps: 0383fbff c1cbf=
bff 00000000, vendor =3D 2
Oct 28 12:27:53 badb kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache=
 64K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: L2 Cache: 256K (64 bytes/line)
Oct 28 12:27:53 badb kernel: CPU: After vendor init, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:     After generic, caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU:             Common caps: 0383fbff c1cbfb=
ff 00000000 00000000
Oct 28 12:27:53 badb kernel: CPU1: AMD Athlon(tm) Processor stepping 02
Oct 28 12:27:53 badb kernel: Total of 2 processors activated (6610.94 Bogo=
MIPS).
Oct 28 12:27:53 badb kernel: ENABLING IO-APIC IRQs
Oct 28 12:27:53 badb kernel: Setting 2 in the phys_id_present_map
Oct 28 12:27:53 badb kernel: ...changing IO-APIC physical APIC ID to 2 ...=
 ok.
Oct 28 12:27:53 badb kernel: init IO_APIC IRQs
Oct 28 12:27:53 badb kernel:  IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2=
-16, 2-20, 2-21, 2-22, 2-23 not connected.
Oct 28 12:27:53 badb kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
Oct 28 12:27:53 badb kernel: number of MP IRQ sources: 20.
Oct 28 12:27:53 badb kernel: number of IO-APIC #2 registers: 24.
Oct 28 12:27:53 badb kernel: testing the IO APIC.......................
Oct 28 12:27:53 badb kernel: =

Oct 28 12:27:53 badb kernel: IO APIC #2......
Oct 28 12:27:53 badb kernel: .... register #00: 02000000
Oct 28 12:27:53 badb kernel: .......    : physical APIC id: 02
Oct 28 12:27:53 badb kernel: .......    : Delivery Type: 0
Oct 28 12:27:53 badb kernel: .......    : LTS          : 0
Oct 28 12:27:53 badb kernel: .... register #01: 00170011
Oct 28 12:27:53 badb kernel: .......     : max redirection entries: 0017
Oct 28 12:27:53 badb kernel: .......     : PRQ implemented: 0
Oct 28 12:27:53 badb kernel: .......     : IO APIC version: 0011
Oct 28 12:27:53 badb kernel: .... register #02: 00000000
Oct 28 12:27:53 badb kernel: .......     : arbitration: 00
Oct 28 12:27:53 badb kernel: .... IRQ redirection table:
Oct 28 12:27:53 badb kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli =
Vect:   =

Oct 28 12:27:53 badb kernel:  00 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  01 001 01  0    0    0   0   0    1    1    =
39
Oct 28 12:27:53 badb kernel:  02 001 01  0    0    0   0   0    1    1    =
31
Oct 28 12:27:53 badb kernel:  03 001 01  0    0    0   0   0    1    1    =
41
Oct 28 12:27:53 badb kernel:  04 001 01  0    0    0   0   0    1    1    =
49
Oct 28 12:27:53 badb kernel:  05 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  06 001 01  0    0    0   0   0    1    1    =
51
Oct 28 12:27:53 badb kernel:  07 001 01  0    0    0   0   0    1    1    =
59
Oct 28 12:27:53 badb kernel:  08 001 01  0    0    0   0   0    1    1    =
61
Oct 28 12:27:53 badb kernel:  09 001 01  0    0    0   0   0    1    1    =
69
Oct 28 12:27:53 badb kernel:  0a 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  0b 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  0c 001 01  0    0    0   0   0    1    1    =
71
Oct 28 12:27:53 badb kernel:  0d 001 01  0    0    0   0   0    1    1    =
79
Oct 28 12:27:53 badb kernel:  0e 001 01  0    0    0   0   0    1    1    =
81
Oct 28 12:27:53 badb kernel:  0f 001 01  0    0    0   0   0    1    1    =
89
Oct 28 12:27:53 badb kernel:  10 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  11 001 01  1    1    0   1   0    1    1    =
91
Oct 28 12:27:53 badb kernel:  12 001 01  1    1    0   1   0    1    1    =
99
Oct 28 12:27:53 badb kernel:  13 001 01  1    1    0   1   0    1    1    =
A1
Oct 28 12:27:53 badb kernel:  14 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  15 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  16 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel:  17 000 00  1    0    0   0   0    0    0    =
00
Oct 28 12:27:53 badb kernel: IRQ to pin mappings:
Oct 28 12:27:53 badb kernel: IRQ0 -> 0:2
Oct 28 12:27:53 badb kernel: IRQ1 -> 0:1
Oct 28 12:27:53 badb kernel: IRQ3 -> 0:3
Oct 28 12:27:53 badb kernel: IRQ4 -> 0:4
Oct 28 12:27:53 badb kernel: IRQ6 -> 0:6
Oct 28 12:27:53 badb kernel: IRQ7 -> 0:7
Oct 28 12:27:53 badb kernel: IRQ8 -> 0:8
Oct 28 12:27:53 badb kernel: IRQ9 -> 0:9
Oct 28 12:27:53 badb kernel: IRQ12 -> 0:12
Oct 28 12:27:53 badb kernel: IRQ13 -> 0:13
Oct 28 12:27:53 badb kernel: IRQ14 -> 0:14
Oct 28 12:27:53 badb kernel: IRQ15 -> 0:15
Oct 28 12:27:53 badb kernel: IRQ17 -> 0:17
Oct 28 12:27:53 badb kernel: IRQ18 -> 0:18
Oct 28 12:27:53 badb kernel: IRQ19 -> 0:19
Oct 28 12:27:53 badb kernel: .................................... done.
Oct 28 12:27:53 badb kernel: Using local APIC timer interrupts.
Oct 28 12:27:53 badb kernel: calibrating APIC timer ...
Oct 28 12:27:53 badb kernel: ..... CPU clock speed is 1666.0407 MHz.
Oct 28 12:27:53 badb kernel: ..... host bus clock speed is 266.0625 MHz.
Oct 28 12:27:53 badb kernel: checking TSC synchronization across 2 CPUs: p=
assed.
Oct 28 12:27:53 badb kernel: Starting migration thread for cpu 0
Oct 28 12:27:53 badb kernel: Bringing up 1
Oct 28 12:27:53 badb kernel: CPU 1 IS NOW UP!
Oct 28 12:27:53 badb kernel: Starting migration thread for cpu 1
Oct 28 12:27:53 badb kernel: CPUS done 2
Oct 28 12:27:53 badb kernel: Linux NET4.0 for Linux 2.4
Oct 28 12:27:53 badb kernel: Based upon Swansea University Computer Societ=
y NET3.039
Oct 28 12:27:53 badb kernel: Initializing RT netlink socket
Oct 28 12:27:53 badb kernel: mtrr: v2.0 (20020519)
Oct 28 12:27:53 badb kernel: mtrr: your CPUs had inconsistent fixed MTRR s=
ettings
Oct 28 12:27:53 badb kernel: mtrr: probably your BIOS does not setup all C=
PUs
Oct 28 12:27:53 badb kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7d0,=
 last bus=3D2
Oct 28 12:27:53 badb kernel: PCI: Using configuration type 1
Oct 28 12:27:53 badb kernel: Registering system device cpu0
Oct 28 12:27:53 badb kernel: adding '' to cpu class interfaces
Oct 28 12:27:53 badb kernel: Registering system device cpu1
Oct 28 12:27:53 badb kernel: adding '' to cpu class interfaces
Oct 28 12:27:53 badb kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Oct 28 12:27:53 badb kernel: biovec pool[0]:   1 bvecs: 256 entries (12 by=
tes)
Oct 28 12:27:53 badb kernel: biovec pool[1]:   4 bvecs: 256 entries (48 by=
tes)
Oct 28 12:27:53 badb kernel: biovec pool[2]:  16 bvecs: 256 entries (192 b=
ytes)
Oct 28 12:27:53 badb kernel: biovec pool[3]:  64 bvecs: 256 entries (768 b=
ytes)
Oct 28 12:27:53 badb kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 =
bytes)
Oct 28 12:27:53 badb kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 =
bytes)
Oct 28 12:27:53 badb kernel: PCI: Probing PCI hardware
Oct 28 12:27:53 badb kernel: PCI: Probing PCI hardware (bus 00)
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 17
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B1,I5,P0) -> 18
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B2,I0,P3) -> 19
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B2,I5,P0) -> 17
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B2,I6,P0) -> 18
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B2,I7,P0) -> 19
Oct 28 12:27:53 badb kernel: PCI->APIC IRQ transform: (B2,I8,P0) -> 19
Oct 28 12:27:53 badb kernel: Registering system device pic0
Oct 28 12:27:53 badb kernel: Registering system device rtc0
Oct 28 12:27:53 badb kernel: Starting kswapd
Oct 28 12:27:53 badb kernel: aio_setup: sizeof(struct page) =3D 40
Oct 28 12:27:53 badb kernel: devfs: v1.21 (20020820) Richard Gooch (rgooch=
@atnf.csiro.au)
Oct 28 12:27:53 badb kernel: devfs: boot_options: 0x1
Oct 28 12:27:53 badb kernel: Capability LSM initialized
Oct 28 12:27:53 badb kernel: BIOS failed to enable PCI standards complianc=
e, fixing this error.
Oct 28 12:27:53 badb kernel: pty: 256 Unix98 ptys configured
Oct 28 12:27:53 badb kernel: block request queues:
Oct 28 12:27:53 badb kernel:  128 requests per read queue
Oct 28 12:27:53 badb kernel:  128 requests per write queue
Oct 28 12:27:53 badb kernel:  8 requests per batch
Oct 28 12:27:53 badb kernel:  enter congestion at 31
Oct 28 12:27:53 badb kernel:  exit congestion at 33
Oct 28 12:27:53 badb kernel: SCSI subsystem driver Revision: 1.00
Oct 28 12:27:53 badb kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA=
 DRIVER, Rev 6.2.4
Oct 28 12:27:53 badb kernel:         <Adaptec 29160 Ultra160 SCSI adapter>
Oct 28 12:27:53 badb kernel:         aic7892: Ultra160 Wide Channel A, SCS=
I Id=3D7, 32/253 SCBs
Oct 28 12:27:53 badb kernel: =

Oct 28 12:27:53 badb kernel: (scsi0:A:0): 160.000MB/s transfers (80.000MHz=
 DT, offset 127, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY367J  =
Rev: DA40
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: (scsi0:A:1): 160.000MB/s transfers (80.000MHz=
 DT, offset 127, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY367J  =
Rev: DA40
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: (scsi0:A:2): 160.000MB/s transfers (80.000MHz=
 DT, offset 127, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY367J  =
Rev: DA40
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi0:A:2:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: (scsi0:A:3): 160.000MB/s transfers (80.000MHz=
 DT, offset 127, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY367J  =
Rev: DA40
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi0:A:3:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: (scsi0:A:4): 160.000MB/s transfers (80.000MHz=
 DT, offset 127, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY367J  =
Rev: DA40
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi0:A:4:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA=
 DRIVER, Rev 6.2.4
Oct 28 12:27:53 badb kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Oct 28 12:27:53 badb kernel:         aic7890/91: Ultra2 Wide Channel A, SC=
SI Id=3D7, 32/253 SCBs
Oct 28 12:27:53 badb kernel: =

Oct 28 12:27:53 badb kernel: (scsi1:A:0): 80.000MB/s transfers (40.000MHz,=
 offset 31, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: QUANTUM   Model: ATLAS 10K 18WLS   =
Rev: UCH0
Oct 28 12:27:53 badb kernel:   Type:   Direct-Access                      =
ANSI SCSI revision: 03
Oct 28 12:27:53 badb kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 2=
53
Oct 28 12:27:53 badb kernel: (scsi1:A:3): 40.000MB/s transfers (20.000MHz,=
 offset 32, 16bit)
Oct 28 12:27:53 badb kernel:   Vendor: HP        Model: C5683A            =
Rev: C908
Oct 28 12:27:53 badb kernel:   Type:   Sequential-Access                  =
ANSI SCSI revision: 02
Oct 28 12:27:53 badb kernel: (scsi1:A:4): 20.000MB/s transfers (20.000MHz,=
 offset 8)
Oct 28 12:27:53 badb kernel:   Vendor: PIONEER   Model: DVD-ROM DVD-303   =
Rev: 1.09
Oct 28 12:27:53 badb kernel:   Type:   CD-ROM                             =
ANSI SCSI revision: 02
Oct 28 12:27:53 badb kernel: (scsi1:A:6): 10.000MB/s transfers (10.000MHz,=
 offset 15)
Oct 28 12:27:53 badb kernel:   Vendor: HP        Model: CD-Writer+ 9200   =
Rev: 1.0c
Oct 28 12:27:53 badb kernel:   Type:   CD-ROM                             =
ANSI SCSI revision: 04
Oct 28 12:27:53 badb kernel: Attached scsi disk sda at scsi0, channel 0, i=
d 0, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi disk sdb at scsi0, channel 0, i=
d 1, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi disk sdc at scsi0, channel 0, i=
d 2, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi disk sdd at scsi0, channel 0, i=
d 3, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi disk sde at scsi0, channel 0, i=
d 4, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi disk sdf at scsi1, channel 0, i=
d 0, lun 0
Oct 28 12:27:53 badb kernel: SCSI device sda: drive cache: write through
Oct 28 12:27:53 badb kernel: SCSI device sda: 71132959 512-byte hdwr secto=
rs (36420 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 < p5 p=
6 p7 p8 >
Oct 28 12:27:53 badb kernel: SCSI device sdb: drive cache: write through
Oct 28 12:27:53 badb kernel: SCSI device sdb: 71132959 512-byte hdwr secto=
rs (36420 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host0/bus0/target1/lun0: p1 < p5 p=
6 p7 p8 >
Oct 28 12:27:53 badb kernel: SCSI device sdc: drive cache: write through
Oct 28 12:27:53 badb kernel: SCSI device sdc: 71132959 512-byte hdwr secto=
rs (36420 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host0/bus0/target2/lun0: p1 < p5 p=
6 p7 p8 >
Oct 28 12:27:53 badb kernel: SCSI device sdd: drive cache: write through
Oct 28 12:27:53 badb kernel: SCSI device sdd: 71132959 512-byte hdwr secto=
rs (36420 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host0/bus0/target3/lun0: p1 < p5 p=
6 p7 p8 >
Oct 28 12:27:53 badb kernel: SCSI device sde: drive cache: write through
Oct 28 12:27:53 badb kernel: SCSI device sde: 71132959 512-byte hdwr secto=
rs (36420 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host0/bus0/target4/lun0: p1 < p5 p=
6 p7 p8 >
Oct 28 12:27:53 badb kernel: SCSI device sdf: drive cache: write back
Oct 28 12:27:53 badb kernel: SCSI device sdf: 35877972 512-byte hdwr secto=
rs (18370 MB)
Oct 28 12:27:53 badb kernel:  /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p=
5 p6 p7 p8 p9 p10 p11 p12 >
Oct 28 12:27:53 badb kernel: md: raid0 personality registered as nr 2
Oct 28 12:27:53 badb kernel: md: raid1 personality registered as nr 3
Oct 28 12:27:53 badb kernel: md: raid5 personality registered as nr 4
Oct 28 12:27:53 badb kernel: raid5: measuring checksumming speed
Oct 28 12:27:53 badb kernel:    8regs     :  2524.000 MB/sec
Oct 28 12:27:53 badb kernel:    32regs    :  2296.000 MB/sec
Oct 28 12:27:53 badb kernel:    pIII_sse  :  3548.000 MB/sec
Oct 28 12:27:53 badb kernel:    pII_mmx   :  3904.000 MB/sec
Oct 28 12:27:53 badb kernel:    p5_mmx    :  4988.000 MB/sec
Oct 28 12:27:53 badb kernel: raid5: using function: pIII_sse (3548.000 MB/=
sec)
Oct 28 12:27:53 badb kernel: md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB=
_DISKS=3D27
Oct 28 12:27:53 badb kernel: md: Autodetecting RAID arrays.
Oct 28 12:27:53 badb kernel:  [events: 000000b5]
Oct 28 12:27:53 badb kernel:  [events: 000000b0]
Oct 28 12:27:53 badb kernel:  [events: 000000aa]
Oct 28 12:27:53 badb kernel:  [events: 000000a6]
Oct 28 12:27:53 badb kernel:  [events: 000000b5]
Oct 28 12:27:53 badb kernel:  [events: 000000b0]
Oct 28 12:27:53 badb kernel:  [events: 000000aa]
Oct 28 12:27:53 badb kernel:  [events: 000000a6]
Oct 28 12:27:53 badb kernel:  [events: 000000b0]
Oct 28 12:27:53 badb kernel:  [events: 000000aa]
Oct 28 12:27:53 badb kernel:  [events: 000000a6]
Oct 28 12:27:53 badb kernel:  [events: 000000b0]
Oct 28 12:27:53 badb kernel:  [events: 000000aa]
Oct 28 12:27:53 badb kernel:  [events: 000000a6]
Oct 28 12:27:53 badb kernel:  [events: 000000b0]
Oct 28 12:27:53 badb kernel:  [events: 000000aa]
Oct 28 12:27:53 badb kernel:  [events: 000000a6]
Oct 28 12:27:53 badb kernel: md: autorun ...
Oct 28 12:27:53 badb kernel: md: considering scsi/host0/bus0/target4/lun0/=
part8 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target4/lun0/part=
8 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target3/lun0/part=
8 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target2/lun0/part=
8 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target1/lun0/part=
8 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target0/lun0/part=
8 ...
Oct 28 12:27:53 badb kernel: md: created md3
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target0/lun0/part8>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target1/lun0/part8>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target2/lun0/part8>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target3/lun0/part8>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target4/lun0/part8>
Oct 28 12:27:53 badb kernel: md: running: <scsi/host0/bus0/target4/lun0/pa=
rt8><scsi/host0/bus0/target3/lun0/part8><scsi/host0/bus0/target2/lun0/part=
8><scsi/host0/bus0/target1/lun0/part8><scsi/host0/bus0/target0/lun0/part8>
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part8's even=
t counter: 000000a6
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part8's even=
t counter: 000000a6
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part8's even=
t counter: 000000a6
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part8's even=
t counter: 000000a6
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part8's even=
t counter: 000000a6
Oct 28 12:27:53 badb kernel: md3: max total readahead window set to 992k
Oct 28 12:27:53 badb kernel: md3: 4 data-disks, max readahead per data-dis=
k: 248k
Oct 28 12:27:53 badb kernel: md3: setting max_sectors to 64, segment bound=
ary to 16383
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target4/lun0/pa=
rt8 operational as raid disk 4
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target3/lun0/pa=
rt8 operational as raid disk 3
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target2/lun0/pa=
rt8 operational as raid disk 2
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target1/lun0/pa=
rt8 operational as raid disk 1
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target0/lun0/pa=
rt8 operational as raid disk 0
Oct 28 12:27:53 badb kernel: raid5: allocated 5223kB for md3
Oct 28 12:27:53 badb kernel: raid5: raid level 5 set md3 active with 5 out=
 of 5 devices, algorithm 0
Oct 28 12:27:53 badb kernel: RAID5 conf printout:
Oct 28 12:27:53 badb kernel:  --- rd:5 wd:5 fd:0
Oct 28 12:27:53 badb kernel:  disk 0, o:1, dev:scsi/host0/bus0/target0/lun=
0/part8
Oct 28 12:27:53 badb kernel:  disk 1, o:1, dev:scsi/host0/bus0/target1/lun=
0/part8
Oct 28 12:27:53 badb kernel:  disk 2, o:1, dev:scsi/host0/bus0/target2/lun=
0/part8
Oct 28 12:27:53 badb kernel:  disk 3, o:1, dev:scsi/host0/bus0/target3/lun=
0/part8
Oct 28 12:27:53 badb kernel:  disk 4, o:1, dev:scsi/host0/bus0/target4/lun=
0/part8
Oct 28 12:27:53 badb kernel: md: updating md3 RAID superblock on device
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part8 [event=
s: 000000a7]<6>(write) scsi/host0/bus0/target4/lun0/part8's sb offset: 282=
01984
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part8 [event=
s: 000000a7]<6>(write) scsi/host0/bus0/target3/lun0/part8's sb offset: 282=
01984
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part8 [event=
s: 000000a7]<6>(write) scsi/host0/bus0/target2/lun0/part8's sb offset: 282=
01984
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part8 [event=
s: 000000a7]<6>(write) scsi/host0/bus0/target1/lun0/part8's sb offset: 282=
01984
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part8 [event=
s: 000000a7]<6>(write) scsi/host0/bus0/target0/lun0/part8's sb offset: 282=
01984
Oct 28 12:27:53 badb kernel: md: considering scsi/host0/bus0/target4/lun0/=
part7 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target4/lun0/part=
7 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target3/lun0/part=
7 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target2/lun0/part=
7 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target1/lun0/part=
7 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target0/lun0/part=
7 ...
Oct 28 12:27:53 badb kernel: md: created md2
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target0/lun0/part7>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target1/lun0/part7>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target2/lun0/part7>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target3/lun0/part7>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target4/lun0/part7>
Oct 28 12:27:53 badb kernel: md: running: <scsi/host0/bus0/target4/lun0/pa=
rt7><scsi/host0/bus0/target3/lun0/part7><scsi/host0/bus0/target2/lun0/part=
7><scsi/host0/bus0/target1/lun0/part7><scsi/host0/bus0/target0/lun0/part7>
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part7's even=
t counter: 000000aa
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part7's even=
t counter: 000000aa
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part7's even=
t counter: 000000aa
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part7's even=
t counter: 000000aa
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part7's even=
t counter: 000000aa
Oct 28 12:27:53 badb kernel: md2: max total readahead window set to 992k
Oct 28 12:27:53 badb kernel: md2: 4 data-disks, max readahead per data-dis=
k: 248k
Oct 28 12:27:53 badb kernel: md2: setting max_sectors to 64, segment bound=
ary to 16383
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target4/lun0/pa=
rt7 operational as raid disk 4
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target3/lun0/pa=
rt7 operational as raid disk 3
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target2/lun0/pa=
rt7 operational as raid disk 2
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target1/lun0/pa=
rt7 operational as raid disk 1
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target0/lun0/pa=
rt7 operational as raid disk 0
Oct 28 12:27:53 badb kernel: raid5: allocated 5223kB for md2
Oct 28 12:27:53 badb kernel: raid5: raid level 5 set md2 active with 5 out=
 of 5 devices, algorithm 0
Oct 28 12:27:53 badb kernel: RAID5 conf printout:
Oct 28 12:27:53 badb kernel:  --- rd:5 wd:5 fd:0
Oct 28 12:27:53 badb kernel:  disk 0, o:1, dev:scsi/host0/bus0/target0/lun=
0/part7
Oct 28 12:27:53 badb kernel:  disk 1, o:1, dev:scsi/host0/bus0/target1/lun=
0/part7
Oct 28 12:27:53 badb kernel:  disk 2, o:1, dev:scsi/host0/bus0/target2/lun=
0/part7
Oct 28 12:27:53 badb kernel:  disk 3, o:1, dev:scsi/host0/bus0/target3/lun=
0/part7
Oct 28 12:27:53 badb kernel:  disk 4, o:1, dev:scsi/host0/bus0/target4/lun=
0/part7
Oct 28 12:27:53 badb kernel: md: updating md2 RAID superblock on device
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part7 [event=
s: 000000ab]<6>(write) scsi/host0/bus0/target4/lun0/part7's sb offset: 420=
0896
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part7 [event=
s: 000000ab]<6>(write) scsi/host0/bus0/target3/lun0/part7's sb offset: 420=
0896
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part7 [event=
s: 000000ab]<6>(write) scsi/host0/bus0/target2/lun0/part7's sb offset: 420=
0896
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part7 [event=
s: 000000ab]<6>(write) scsi/host0/bus0/target1/lun0/part7's sb offset: 420=
0896
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part7 [event=
s: 000000ab]<6>(write) scsi/host0/bus0/target0/lun0/part7's sb offset: 420=
0896
Oct 28 12:27:53 badb kernel: md: considering scsi/host0/bus0/target4/lun0/=
part6 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target4/lun0/part=
6 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target3/lun0/part=
6 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target2/lun0/part=
6 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target1/lun0/part=
6 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target0/lun0/part=
6 ...
Oct 28 12:27:53 badb kernel: md: created md1
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target0/lun0/part6>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target1/lun0/part6>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target2/lun0/part6>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target3/lun0/part6>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target4/lun0/part6>
Oct 28 12:27:53 badb kernel: md: running: <scsi/host0/bus0/target4/lun0/pa=
rt6><scsi/host0/bus0/target3/lun0/part6><scsi/host0/bus0/target2/lun0/part=
6><scsi/host0/bus0/target1/lun0/part6><scsi/host0/bus0/target0/lun0/part6>
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part6's even=
t counter: 000000b0
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part6's even=
t counter: 000000b0
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part6's even=
t counter: 000000b0
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part6's even=
t counter: 000000b0
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part6's even=
t counter: 000000b0
Oct 28 12:27:53 badb kernel: md1: max total readahead window set to 992k
Oct 28 12:27:53 badb kernel: md1: 4 data-disks, max readahead per data-dis=
k: 248k
Oct 28 12:27:53 badb kernel: md1: setting max_sectors to 64, segment bound=
ary to 16383
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target4/lun0/pa=
rt6 operational as raid disk 4
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target3/lun0/pa=
rt6 operational as raid disk 3
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target2/lun0/pa=
rt6 operational as raid disk 2
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target1/lun0/pa=
rt6 operational as raid disk 1
Oct 28 12:27:53 badb kernel: raid5: device scsi/host0/bus0/target0/lun0/pa=
rt6 operational as raid disk 0
Oct 28 12:27:53 badb kernel: raid5: allocated 5223kB for md1
Oct 28 12:27:53 badb kernel: raid5: raid level 5 set md1 active with 5 out=
 of 5 devices, algorithm 0
Oct 28 12:27:53 badb kernel: RAID5 conf printout:
Oct 28 12:27:53 badb kernel:  --- rd:5 wd:5 fd:0
Oct 28 12:27:53 badb kernel:  disk 0, o:1, dev:scsi/host0/bus0/target0/lun=
0/part6
Oct 28 12:27:53 badb kernel:  disk 1, o:1, dev:scsi/host0/bus0/target1/lun=
0/part6
Oct 28 12:27:53 badb kernel:  disk 2, o:1, dev:scsi/host0/bus0/target2/lun=
0/part6
Oct 28 12:27:53 badb kernel:  disk 3, o:1, dev:scsi/host0/bus0/target3/lun=
0/part6
Oct 28 12:27:53 badb kernel:  disk 4, o:1, dev:scsi/host0/bus0/target4/lun=
0/part6
Oct 28 12:27:53 badb kernel: md: updating md1 RAID superblock on device
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target4/lun0/part6 [event=
s: 000000b1]<6>(write) scsi/host0/bus0/target4/lun0/part6's sb offset: 210=
4384
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target3/lun0/part6 [event=
s: 000000b1]<6>(write) scsi/host0/bus0/target3/lun0/part6's sb offset: 210=
4384
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target2/lun0/part6 [event=
s: 000000b1]<6>(write) scsi/host0/bus0/target2/lun0/part6's sb offset: 210=
4384
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part6 [event=
s: 000000b1]<6>(write) scsi/host0/bus0/target1/lun0/part6's sb offset: 210=
4384
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part6 [event=
s: 000000b1]<6>(write) scsi/host0/bus0/target0/lun0/part6's sb offset: 210=
4384
Oct 28 12:27:53 badb kernel: md: considering scsi/host0/bus0/target1/lun0/=
part5 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target1/lun0/part=
5 ...
Oct 28 12:27:53 badb kernel: md:  adding scsi/host0/bus0/target0/lun0/part=
5 ...
Oct 28 12:27:53 badb kernel: md: created md0
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target0/lun0/part5>
Oct 28 12:27:53 badb kernel: md: bind<scsi/host0/bus0/target1/lun0/part5>
Oct 28 12:27:53 badb kernel: md: running: <scsi/host0/bus0/target1/lun0/pa=
rt5><scsi/host0/bus0/target0/lun0/part5>
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part5's even=
t counter: 000000b5
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part5's even=
t counter: 000000b5
Oct 28 12:27:53 badb kernel: md0: max total readahead window set to 128k
Oct 28 12:27:53 badb kernel: md0: 1 data-disks, max readahead per data-dis=
k: 128k
Oct 28 12:27:53 badb kernel: md0: setting max_sectors to 64, segment bound=
ary to 16383
Oct 28 12:27:53 badb kernel: raid1: raid set md0 active with 2 out of 2 mi=
rrors
Oct 28 12:27:53 badb kernel: md: updating md0 RAID superblock on device
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target1/lun0/part5 [event=
s: 000000b6]<6>(write) scsi/host0/bus0/target1/lun0/part5's sb offset: 105=
2096
Oct 28 12:27:53 badb kernel: md: scsi/host0/bus0/target0/lun0/part5 [event=
s: 000000b6]<6>(write) scsi/host0/bus0/target0/lun0/part5's sb offset: 105=
2096
Oct 28 12:27:53 badb kernel: md: ... autorun DONE.
Oct 28 12:27:53 badb kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct 28 12:27:53 badb kernel: IP: routing cache hash table of 8192 buckets,=
 64Kbytes
Oct 28 12:27:53 badb kernel: TCP: Hash tables configured (established 2621=
44 bind 65536)
Oct 28 12:27:53 badb kernel: Linux IP multicast router 0.06 plus PIM-SM
Oct 28 12:27:53 badb kernel: NET4: Unix domain sockets 1.0/SMP for Linux N=
ET4.0.
Oct 28 12:27:53 badb kernel: VFS: Mounted root (ext2 filesystem) readonly.
Oct 28 12:27:53 badb kernel: Mounted devfs on /dev
Oct 28 12:27:53 badb kernel: Freeing unused kernel memory: 104k freed
Oct 28 12:27:53 badb kernel: Adding 1052184k swap on /dev/scsi/host0/bus0/=
target2/lun0/part5.  Priority:1 extents:1
Oct 28 12:27:53 badb kernel: Adding 1052184k swap on /dev/scsi/host0/bus0/=
target3/lun0/part5.  Priority:1 extents:1
Oct 28 12:27:53 badb kernel: Adding 1052184k swap on /dev/scsi/host0/bus0/=
target4/lun0/part5.  Priority:1 extents:1
Oct 28 12:27:53 badb kernel: Real Time Clock Driver v1.11
Oct 28 12:27:53 badb kernel: 3c59x: Donald Becker and others. www.scyld.co=
m/network/vortex.html
Oct 28 12:27:53 badb kernel: 02:06.0: 3Com PCI 3c905C Tornado at 0x2400. V=
ers LK1.1.18
Oct 28 12:27:53 badb kernel: phy=3D0, phyx=3D24, mii_status=3D0x782d
Oct 28 12:27:53 badb kernel: 02:08.0: 3Com PCI 3c905C Tornado at 0x2480. V=
ers LK1.1.18
Oct 28 12:27:53 badb kernel: phy=3D0, phyx=3D24, mii_status=3D0x782d
Oct 28 12:27:53 badb kernel: Creative EMU10K1 PCI Audio Driver, version 0.=
16, 12:20:43 Oct 28 2002
Oct 28 12:27:53 badb kernel: emu10k1: EMU10K1 rev 5 model 0x8040 found, IO=
 at 0x2800-0x281f, IRQ 17
Oct 28 12:27:53 badb kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x76=
09 (SigmaTel STAC9721/23)
Oct 28 12:27:53 badb kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 28 12:27:53 badb kernel: inserting floppy driver for 2.5.44-ac5
Oct 28 12:27:53 badb kernel: FDC 0 is a post-1991 82077
Oct 28 12:27:53 badb kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0,=
 id 4, lun 0
Oct 28 12:27:53 badb kernel: Attached scsi CD-ROM sr1 at scsi1, channel 0,=
 id 6, lun 0
Oct 28 12:27:53 badb kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cd=
da tray
Oct 28 12:27:53 badb kernel: Uniform CD-ROM driver Revision: 3.12
Oct 28 12:27:53 badb kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa=
/form2 cdda tray
Oct 28 12:27:53 badb kernel: st: Version 20021015, fixed bufsize 32768, wr=
t 30720, s/g segs 256
Oct 28 12:27:53 badb kernel: Attached scsi tape st0 at scsi1, channel 0, i=
d 3, lun 0
Oct 28 12:27:53 badb kernel: st0: try direct i/o: yes, max page reachable =
by HBA 1048575
Oct 28 12:27:53 badb kernel: st0: Block limits 1 - 16777215 bytes.
Oct 28 12:27:53 badb kernel: st0: Mode 0 options: buffer writes: 1, async =
writes: 1, read ahead: 1
Oct 28 12:27:53 badb kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0=
, auto lock: 1,
Oct 28 12:27:53 badb kernel: st0:    defs for wr: 0, no block limits: 0, p=
artitions: 1, s2 log: 1
Oct 28 12:27:53 badb kernel: st0:    sysv: 0 nowait: 0
Oct 28 12:27:53 badb kernel: st0: Default block size set to 0 bytes.
Oct 28 12:27:53 badb kernel: st0: Compression default set to 1
Oct 28 12:27:53 badb kernel: st0: Mode 1 options: buffer writes: 1, async =
writes: 1, read ahead: 1
Oct 28 12:27:53 badb kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0=
, auto lock: 1,
Oct 28 12:27:53 badb kernel: st0:    defs for wr: 0, no block limits: 0, p=
artitions: 1, s2 log: 1
Oct 28 12:27:53 badb kernel: st0:    sysv: 0 nowait: 0
Oct 28 12:27:53 badb kernel: st0: Default block size set to 1024 bytes.
Oct 28 12:27:53 badb kernel: st0: Compression default set to 1
Oct 28 12:27:53 badb kernel: st0: Mode 2 options: buffer writes: 1, async =
writes: 1, read ahead: 1
Oct 28 12:27:53 badb kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0=
, auto lock: 1,
Oct 28 12:27:53 badb kernel: st0:    defs for wr: 0, no block limits: 0, p=
artitions: 1, s2 log: 1
Oct 28 12:27:53 badb kernel: st0:    sysv: 0 nowait: 0
Oct 28 12:27:53 badb kernel: st0: Default block size set to 0 bytes.
Oct 28 12:27:53 badb kernel: st0: Compression default set to 0
Oct 28 12:27:53 badb kernel: st0: Mode 3 options: buffer writes: 1, async =
writes: 1, read ahead: 1
Oct 28 12:27:53 badb kernel: st0:    can bsr: 1, two FMs: 0, fast mteom: 0=
, auto lock: 1,
Oct 28 12:27:53 badb kernel: st0:    defs for wr: 0, no block limits: 0, p=
artitions: 1, s2 log: 1
Oct 28 12:27:53 badb kernel: st0:    sysv: 0 nowait: 0
Oct 28 12:27:53 badb kernel: st0: Default block size set to 1024 bytes.
Oct 28 12:27:53 badb kernel: st0: Compression default set to 0
Oct 28 12:27:53 badb kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TR=
ISTATE,EPP]
Oct 28 12:27:53 badb kernel: parport0: irq 7 detected
Oct 28 12:27:53 badb kernel: parport0: cpp_mux: aa55f00f52ad51(87)
Oct 28 12:27:53 badb kernel: parport0: cpp_daisy: aa5500ff(80)
Oct 28 12:27:53 badb kernel: parport0: assign_addrs: aa5500ff(80)
Oct 28 12:27:53 badb kernel: parport0: cpp_mux: aa55f00f52ad51(87)
Oct 28 12:27:53 badb kernel: parport0: cpp_daisy: aa5500ff(80)
Oct 28 12:27:53 badb kernel: parport0: assign_addrs: aa5500ff(80)
Oct 28 12:27:53 badb kernel: lp0: using parport0 (polling).
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: registered new driver=
 usbfs
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: registered new driver=
 hub
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-pci.c: 2002-Sep-17 USB =
1.1 'Open' Host Controller (OHCI) Driver (PCI)
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-pci.c: block sizes: ed =
64 td 64
Oct 28 12:27:53 badb kernel: drivers/usb/core/hcd-pci.c: ohci-hcd @ 02:00.=
0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
Oct 28 12:27:53 badb kernel: drivers/usb/core/hcd-pci.c: irq 19, pci mem f=
8ab0000
Oct 28 12:27:53 badb kernel: drivers/usb/core/hcd.c: new USB bus registere=
d, assigned bus number 1
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-hcd.c: USB HC TakeOver =
from SMM
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-hcd.c: USB HC reset_hc =
02:00.0: ctrl =3D 0x683 ;
Oct 28 12:27:53 badb kernel: drivers/usb/core/hcd.c: 02:00.0 root hub devi=
ce address 1
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: new device strings: M=
fr=3D3, Product=3D2, SerialNumber=3D1
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_new_device_Rsmp_6=
d928d58 - registering 1-0:0
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e - got id
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: USB hub found at 0
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: 4 ports detected
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: standalone hub
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: ganged power switchin=
g
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: global over-current p=
rotection
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: Port indicators are n=
ot supported
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: power on to power goo=
d time: 2ms
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub controller curren=
t requirement: 0mA
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: local power source is=
 good
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: no over-current condi=
tion exists
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: enabling power on all=
 ports
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: 02:00.0: created=
 debug files
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: OHCI controller =
02:00.0 state
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: OHCI 1.0, with l=
egacy support registers
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: control: 0x00000=
68f RWE RWC HCFS=3Doperational IE PLE CBSR=3D3
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: cmdstatus: 0x000=
00000 SOC=3D0
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: intrstatus: 0x00=
000044 RHSC SF
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: intrenable: 0x80=
000002 MIE WDH
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: hcca frame #0017
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: roothub.a: 01000=
204 POTPGT=3D1 NPS NDP=3D4
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: roothub.b: 00000=
000 PPCM=3D0000 DR=3D0000
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: roothub.status: =
00000000
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: 02:00.0:  roothu=
b.portstatus [0] =3D 0x00000100 PPS
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: 02:00.0:  roothu=
b.portstatus [1] =3D 0x00010101 CSC PPS CCS
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: 02:00.0:  roothu=
b.portstatus [2] =3D 0x00000100 PPS
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-dbg.c: 02:00.0:  roothu=
b.portstatus [3] =3D 0x00000100 PPS
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 1, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-hub.c: 02:00.0: GetStat=
us roothub.portstatus [2] =3D 0x00010101 CSC PPS CCS
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 10=
1, change 1, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 0 port 2 connecti=
on change
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 0 port 2, portsta=
tus 101, change 1, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 10=
1, change 0, 12 Mb/s
Oct 28 12:27:53 badb last message repeated 3 times
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-hub.c: 02:00.0: GetStat=
us roothub.portstatus [2] =3D 0x00100103 PRSC PPS PES CCS
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 10=
3, change 10, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: new USB device 02:00.=
0-2, assigned address 2
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: new device strings: M=
fr=3D0, Product=3D0, SerialNumber=3D0
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_new_device_Rsmp_6=
d928d58 - registering 1-2:0
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e - got id
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: USB hub found at 2
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: 4 ports detected
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: standalone hub
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: individual port power=
 switching
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: individual port over-=
current protection
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: Port indicators are n=
ot supported
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: power on to power goo=
d time: 100ms
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub controller curren=
t requirement: 100mA
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: local power source is=
 good
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: no over-current condi=
tion exists
Oct 28 12:27:53 badb kernel: drivers/usb/host/ohci-q.c: 02:00.0: link ed f=
5c8f040 branch 0 [11us.], interval 32
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: enabling power on all=
 ports
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 3, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 4, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 1, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 30=
1, change 1, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 2 port 2 connecti=
on change
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 2 port 2, portsta=
tus 301, change 1, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 30=
1, change 0, 1.5 Mb/s
Oct 28 12:27:53 badb last message repeated 3 times
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 30=
3, change 10, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: new USB device 02:00.=
0-2.2, assigned address 3
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: new device strings: M=
fr=3D4, Product=3D12, SerialNumber=3D0
Oct 28 12:27:53 badb kernel: Product: ELLIPSE
Oct 28 12:27:53 badb kernel: Manufacturer: MGE
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_new_device_Rsmp_6=
d928d58 - registering 1-2.2:0
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 3, portstatus 30=
1, change 1, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 2 port 3 connecti=
on change
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: hub 2 port 3, portsta=
tus 301, change 1, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 3, portstatus 30=
1, change 0, 1.5 Mb/s
Oct 28 12:27:53 badb last message repeated 3 times
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 3, portstatus 30=
3, change 10, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: new USB device 02:00.=
0-2.3, assigned address 4
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: new device strings: M=
fr=3D1, Product=3D2, SerialNumber=3D0
Oct 28 12:27:53 badb kernel: Product: Microsoft Wireless Intellimouse Expl=
orer=AE 1.0A
Oct 28 12:27:53 badb kernel: Manufacturer: Microsoft
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_new_device_Rsmp_6=
d928d58 - registering 1-2.3:0
Oct 28 12:27:53 badb kernel: drivers/usb/core/usb.c: usb_hotplug
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 4, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 1, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 2, portstatus 30=
3, change 0, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 3, portstatus 30=
3, change 0, 1.5 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: port 4, portstatus 10=
0, change 0, 12 Mb/s
Oct 28 12:27:53 badb kernel: drivers/usb/core/hub.c: usb_hub_thread exitin=
g
Oct 28 12:27:54 badb slapd[605]: daemon: socket() failed errno=3D97 (Addre=
ss family not supported by protocol) =

Oct 28 12:27:55 badb /etc/hotplug/usb.agent: Setup hid for USB product 463=
/ffff/1
Oct 28 12:27:55 badb kernel: drivers/usb/core/usb.c: registered new driver=
 hiddev
Oct 28 12:27:55 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e
Oct 28 12:27:55 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e - got id
Oct 28 12:27:55 badb root: spamd starting =

Oct 28 12:27:56 badb /etc/hotplug/usb.agent: Setup usbmouse hid for USB pr=
oduct 45e/59/d
Oct 28 12:27:56 badb /etc/hotplug/usb.agent: Setup mousedev for USB produc=
t 45e/59/d
Oct 28 12:27:56 badb kernel: register interface 'mouse' with class 'input
Oct 28 12:27:56 badb kernel: mice: PS/2 mouse device common for all mice
Oct 28 12:27:56 badb named[656]: starting BIND 9.2.1
Oct 28 12:27:56 badb named[656]: using 2 CPUs
Oct 28 12:27:56 badb named[658]: loading configuration from '/etc/bind/nam=
ed.conf'
Oct 28 12:27:56 badb authdaemond.plain: authdaemon: modules=3D"authpam", d=
aemons=3D1 =

Oct 28 12:27:56 badb named[658]: no IPv6 interfaces found
Oct 28 12:27:56 badb named[658]: listening on IPv4 interface lo, 127.0.0.1=
#53
Oct 28 12:27:56 badb named[658]: listening on IPv4 interface eth0, 10.13.0=
.103#53
Oct 28 12:27:56 badb named[658]: listening on IPv4 interface eth1, 10.14.0=
.162#53
Oct 28 12:27:56 badb named[658]: command channel listening on 127.0.0.1#95=
3
Oct 28 12:27:57 badb named[658]: zone 0.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: zone 10.in-addr.arpa/IN: loaded serial 20=
02091901
Oct 28 12:27:57 badb named[658]: zone 127.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: zone 255.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: zone merlin.org/IN: loaded serial 2002091=
101
Oct 28 12:27:57 badb named[658]: zone 0.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: zone 127.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: zone 255.in-addr.arpa/IN: loaded serial 1
Oct 28 12:27:57 badb named[658]: running
Oct 28 12:27:57 badb lwresd[766]: starting BIND 9.2.1
Oct 28 12:27:57 badb lwresd[766]: using 2 CPUs
Oct 28 12:27:57 badb lwresd[769]: loading configuration from '/etc/bind/lw=
resd.conf'
Oct 28 12:27:57 badb lwresd[769]: none:0: open: /etc/bind/lwresd.conf: fil=
e not found
Oct 28 12:27:57 badb lwresd[769]: loading configuration from '/etc/resolv.=
conf'
Oct 28 12:27:57 badb lwresd[769]: no IPv6 interfaces found
Oct 28 12:27:57 badb lwresd[769]: couldn't add command channel 127.0.0.1#9=
53: address in use
Oct 28 12:27:57 badb lwresd[769]: lwres listening on 127.0.0.1#921
Oct 28 12:27:57 badb lwresd[769]: running
Oct 28 12:27:57 badb upsd[785]: Warning: Data for UPS [lugh] is stale - ch=
eck driver
Oct 28 12:27:57 badb upsd[786]: Startup successful
Oct 28 12:27:58 badb cardmgr[812]: starting, version is 3.1.33
Oct 28 12:27:58 badb cardmgr[812]: no pcmcia driver in /proc/devices
Oct 28 12:27:58 badb cardmgr[812]: exiting
Oct 28 12:27:59 badb named[658]: socket.c:1100: unexpected error:
Oct 28 12:27:59 badb named[658]: internal_send: 10.15.0.2#53: Invalid argu=
ment
Oct 28 12:27:59 badb kernel: udp cork app bug 1
Oct 28 12:27:59 badb named[659]: socket.c:1100: unexpected error:
Oct 28 12:27:59 badb named[659]: internal_send: 10.13.0.105#53: Invalid ar=
gument
Oct 28 12:27:59 badb kernel: udp cork app bug 1
Oct 28 12:27:59 badb named[658]: socket.c:1100: unexpected error:
Oct 28 12:27:59 badb named[658]: internal_send: 10.14.0.162#53: Invalid ar=
gument
Oct 28 12:27:59 badb kernel: udp cork app bug 1
Oct 28 12:28:01 badb kernel: drivers/usb/core/file.c: asking for 1 minors,=
 starting at 96
Oct 28 12:28:01 badb kernel: drivers/usb/core/file.c: found a minor chunk =
free, starting at 96
Oct 28 12:28:01 badb kernel: hiddev96: USB HID v1.00 Device [MGE ELLIPSE] =
on usb-02:00.0-2.2
Oct 28 12:28:01 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e
Oct 28 12:28:01 badb kernel: drivers/usb/core/usb.c: usb_device_probe_Rsmp=
_baeeec4e - got id
Oct 28 12:28:01 badb kernel: drivers/usb/host/ohci-q.c: urb f30a8cc0 usb-0=
2:00.0-2.3 ep-0-OUT cc 4 --> status -32
Oct 28 12:28:01 badb kernel: drivers/usb/core/hcd.c: giveback urb f30a8cc0=
 status -32 len 0
Oct 28 12:28:01 badb kernel: drivers/usb/host/ohci-q.c: urb f30a8cc0 usb-0=
2:00.0-2.3 ep-0-OUT cc 4 --> status -32
Oct 28 12:28:01 badb kernel: drivers/usb/core/hcd.c: giveback urb f30a8cc0=
 status -32 len 0
Oct 28 12:28:01 badb kernel: input: USB HID v1.10 Mouse [Microsoft Microso=
ft Wireless Intellimouse Explorer=AE 1.0A] on usb-02:00.0-2.3
Oct 28 12:28:01 badb kernel: drivers/usb/core/usb.c: registered new driver=
 hid
Oct 28 12:28:01 badb kernel: drivers/usb/input/hid-core.c: v2.0:USB HID co=
re driver
Oct 28 12:28:01 badb /sbin/hotplug: no runnable /etc/hotplug/input.agent i=
s installed
Oct 28 12:28:01 badb spamd[625]: server started on port 783 (running versi=
on 2.42) =

Oct 28 12:28:03 badb postfix/postfix-script: starting the Postfix mail sys=
tem
Oct 28 12:28:03 badb postfix/master[913]: daemon started
Oct 28 12:28:03 badb postfix/nqmgr[916]: 84D0986E42: from=3D<>, size=3D550=
4, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: C2CDD867F1: from=3D<>, size=3D115=
17, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: 725BD8682D: from=3D<>, size=3D357=
7, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: A992086A90: from=3D<>, size=3D392=
7, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: 6B75C86824: from=3D<>, size=3D205=
29, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: D6411868F0: from=3D<>, size=3D887=
3, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: B7477867B9: from=3D<>, size=3D525=
5, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: B5E62867B3: from=3D<>, size=3D238=
5, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb postfix/nqmgr[916]: 371E786937: from=3D<>, size=3D344=
5, nrcpt=3D1 (queue active)
Oct 28 12:28:03 badb named[658]: socket.c:1100: unexpected error:
Oct 28 12:28:03 badb named[658]: internal_send: 10.15.0.38#53: Invalid arg=
ument
Oct 28 12:28:03 badb kernel: udp cork app bug 1
Oct 28 12:28:03 badb rpc.statd[951]: Version 1.0.2 Starting
Oct 28 12:28:04 badb chronyd[974]: chronyd version V1_14 starting
Oct 28 12:28:04 badb chronyd[974]: Linux kernel major=3D2 minor=3D5 patch=3D=
44 =

Oct 28 12:28:04 badb chronyd[974]: Fatal error : Kernel version not suppor=
ted yet, sorry. =

Oct 28 12:28:04 badb chronyd[974]: Unexpected condition [File handler not =
registered] at sched.c:190, core dumped =

Oct 28 12:28:04 badb /usr/sbin/cron[980]: (CRON) INFO (pidfile fd =3D 3)
Oct 28 12:28:04 badb /usr/sbin/cron[981]: (CRON) STARTUP (fork ok)
Oct 28 12:28:04 badb /usr/sbin/cron[981]: (CRON) INFO (Running @reboot job=
s)
Oct 28 12:28:04 badb /USR/SBIN/CRON[985]: (root) CMD (test -x /usr/sbin/lo=
gcheck && nice -n10 /usr/sbin/logcheck)
Oct 28 12:28:14 badb named[658]: socket.c:1100: unexpected error:
Oct 28 12:28:14 badb named[658]: internal_send: 10.15.0.1#53: Invalid argu=
ment
Oct 28 12:28:14 badb kernel: udp cork app bug 1
Oct 28 12:28:14 badb modprobe: modprobe: Can't locate module char-major-11=
9
Oct 28 12:28:15 badb named[658]: socket.c:1100: unexpected error:
Oct 28 12:28:15 badb named[658]: internal_send: 10.15.0.1#53: Invalid argu=
ment
Oct 28 12:28:15 badb kernel: udp cork app bug 1
Oct 28 12:28:15 badb named[659]: socket.c:1100: unexpected error:
Oct 28 12:28:15 badb named[659]: internal_send: 10.15.0.1#53: Invalid argu=
ment
Oct 28 12:28:15 badb kernel: udp cork app bug 1
Oct 28 12:28:17 badb named[659]: socket.c:1100: unexpected error:
Oct 28 12:28:17 badb named[659]: internal_send: 10.15.0.3#53: Invalid argu=
ment
Oct 28 12:28:17 badb kernel: udp cork app bug 1
Oct 28 12:28:18 badb named[659]: socket.c:1100: unexpected error:
Oct 28 12:28:18 badb named[659]: internal_send: 10.15.0.38#53: Invalid arg=
ument
Oct 28 12:28:18 badb kernel: udp cork app bug 1
Oct 28 12:36:09 badb kernel: Incorrect number of segments after building l=
ist
Oct 28 12:36:09 badb kernel: counted 2, received 1
Oct 28 12:36:09 badb kernel: req nr_sec 8, cur_nr_sec 8
Oct 28 12:36:09 badb kernel: end_request: I/O error, dev 08:40, sector 678=
4528
Oct 28 12:36:09 badb kernel: raid5: Disk failure on scsi/host0/bus0/target=
4/lun0/part7, disabling device. Operation continuing on 4 devices
Oct 28 12:36:09 badb kernel: blk: request botched
Oct 28 12:36:09 badb kernel: ------------[ cut here ]------------
Oct 28 12:36:09 badb kernel: kernel BUG at drivers/scsi/scsi_lib.c:819!
Oct 28 12:36:09 badb kernel: invalid operand: 0000
Oct 28 12:36:09 badb kernel: mousedev hid nfs lockd sunrpc ohci-hcd usbcor=
e parport_pc lp parport sg st sr_mod cdrom floppy iptable_filter ip_tables=
 emu10k1 sound soundcore ac97_codec 3c59x rtc  =

Oct 28 12:36:09 badb kernel: CPU:    1
Oct 28 12:36:09 badb kernel: EIP:    0060:[scsi_init_io+279/304]    Not ta=
inted
Oct 28 12:36:09 badb kernel: EFLAGS: 00010286
Oct 28 12:36:09 badb kernel: EIP is at scsi_init_io+0x117/0x130
Oct 28 12:36:09 badb kernel: eax: f5bcda00   ebx: f5bcda00   ecx: 00000001=
   edx: f7f51580
Oct 28 12:36:09 badb kernel: esi: 00000002   edi: f7ed62c0   ebp: f78c9f90=
   esp: f78c9f60
Oct 28 12:36:09 badb kernel: ds: 0068   es: 0068   ss: 0068
Oct 28 12:36:09 badb kernel: Process raid5d (pid: 17, threadinfo=3Df78c800=
0 task=3Df7e0cd00)
Oct 28 12:36:09 badb kernel: Stack: f7ed62c0 f5bcda00 f7ef3400 c01aa8bb f5=
bcda00 f7ef34c8 f7ef3428 f7ea3680 =

Oct 28 12:36:09 badb kernel:        f7f56800 f78c8000 c031fb20 c019d88e 00=
000001 c019eb5d f7ef3428 f7df434c =

Oct 28 12:36:09 badb kernel:        f78c9fb4 c019ed80 f7ef3428 f78c8000 f7=
8c8000 f78c9fb4 f78c9fb4 c01d6abf =

Oct 28 12:36:09 badb kernel: Call Trace:
Oct 28 12:36:09 badb kernel:  [scsi_request_fn+779/1136] scsi_request_fn+0=
x30b/0x470
Oct 28 12:36:09 badb kernel:  [elv_queue_empty+14/32] elv_queue_empty+0xe/=
0x20
Oct 28 12:36:09 badb kernel:  [generic_unplug_device+141/192] generic_unpl=
ug_device+0x8d/0xc0
Oct 28 12:36:09 badb kernel:  [blk_run_queues+176/192] blk_run_queues+0xb0=
/0xc0
Oct 28 12:36:09 badb kernel:  [md_thread+415/528] md_thread+0x19f/0x210
Oct 28 12:36:09 badb kernel:  [md_thread+0/528] md_thread+0x0/0x210
Oct 28 12:36:09 badb kernel:  [default_wake_function+0/64] default_wake_fu=
nction+0x0/0x40
Oct 28 12:36:09 badb kernel:  [kernel_thread_helper+5/24] kernel_thread_he=
lper+0x5/0x18
Oct 28 12:36:09 badb kernel: =

Oct 28 12:36:09 badb kernel: Code: 0f 0b 33 03 42 b0 24 c0 90 31 c0 5b 5e =
5f c3 8d 76 00 8d bc =

Oct 28 12:36:09 badb kernel:  <6>md: updating md2 RAID superblock on devic=
e
Oct 28 12:36:09 badb kernel: md: (skipping faulty scsi/host0/bus0/target4/=
lun0/part7 )
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target3/lun0/part7 [event=
s: 000000ac]<6>(write) scsi/host0/bus0/target3/lun0/part7's sb offset: 420=
0896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target2/lun0/part7 [event=
s: 000000ac]<6>(write) scsi/host0/bus0/target2/lun0/part7's sb offset: 420=
0896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target1/lun0/part7 [event=
s: 000000ac]<6>(write) scsi/host0/bus0/target1/lun0/part7's sb offset: 420=
0896
Oct 28 12:36:09 badb kernel: md: scsi/host0/bus0/target0/lun0/part7 [event=
s: 000000ac]<6>(write) scsi/host0/bus0/target0/lun0/part7's sb offset: 420=
0896

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="lspci"; charset="us-ascii"
Content-ID: <4224.1035987454.4@merlin.org>
Content-Description: lspci

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4400] (rev a2)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07)
02:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
02:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
02:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
02:06.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
02:07.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

------- =_aaaaaaaaaa0--
