Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUC0QnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUC0QnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 11:43:22 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:28683 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261817AbUC0Qlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 11:41:55 -0500
Date: Sat, 27 Mar 2004 17:41:53 +0100
To: linux-kernel@vger.kernel.org, ext3-users@redhat.com,
       linux-raid@vger.kernel.org
Subject: Oops with md/ext3 on 2.4.25 on alpha architecture
Message-ID: <20040327164153.GA7324@gamma.logic.tuwien.ac.at>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

HI list!

We regularly experience kernel Ooops on our alpha SX164 with ext3 on md
on ide controller:

No modules loaded, lsmod empty, self compiled kernel


ksymoops 2.4.5 on alpha 2.4.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25/ (default)
     -m /boot/System.map-2.4.25 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Mar 27 06:33:36 beta kernel: Unable to handle kernel paging request at virtual address 0000440003af267c
Mar 27 06:33:36 beta kernel: find(826): Oops 0
Mar 27 06:33:36 beta kernel: pc = [raid1_read_balance+384/512]  ra = [raid1_make_request+476/1152]  ps = 0000    Not tainted
Mar 27 06:33:36 beta kernel: v0 = 0000000000001068  t0 = fffffffffff7fff0  t1 = 0000000000080010
Mar 27 06:33:36 beta kernel: t2 = 0000440003af269c  t3 = 0000000000000000  t4 = 0000440003af267c
Mar 27 06:33:36 beta kernel: t5 = 0000440003af2674  t6 = 0000000000000002  t7 = fffffc000ec04000
Mar 27 06:33:36 beta kernel: s0 = fffffc000cb419c0  s1 = 0000000000000900  s2 = fffffc0000221000
Mar 27 06:33:36 beta kernel: s3 = fffffc000cb419c0  s4 = fffffc000fe94cc0  s5 = 0000000000000000
Mar 27 06:33:36 beta kernel: s6 = fffffc000098d8a0
Mar 27 06:33:36 beta kernel: a0 = fffffc0000221000  a1 = fffffc000cb419c0  a2 = fffffc000cb419c0
Mar 27 06:33:36 beta kernel: a3 = 0000000000001000  a4 = 0000000000000008  a5 = fffffc0000221018
Mar 27 06:33:36 beta kernel: t8 = 0000000000000000  t9 = 00004800038d1680  t10= 0000000000080010
Mar 27 06:33:36 beta kernel: t11= fffffc0000221020  pv = fffffc00004a8ba0  at = fffffc000022101c
Mar 27 06:33:36 beta kernel: gp = fffffc000062fbe8  sp = fffffc000ec07c18
Mar 27 06:33:36 beta kernel: Trace:fffffc00004ab950 fffffc0000355ba0 fffffc0000392abc fffffc000043fba4 fffffc000043fcac fffffc000044000c fffffc0000355ba0 fffffc0000392b04 fffffc000036b5e0 fffffc000038ee28 fffffc000036ac28 fffffc000036b5e0 fffffc000036489c fffffc00003648f8 fffffc00003634b4 fffffc000036b5e0 fffffc000036b808 fffffc0000310c40 
Mar 27 06:33:36 beta kernel: Code: 42fc0403  2ffe0000  42f90405  a0f003d8  40a49525  40c49526 <a0250000> 40649523 
Using defaults from ksymoops -t elf64-alpha -a alpha


Trace; fffffc00004ab950 <md_make_request+90/120>
Trace; fffffc0000355ba0 <end_buffer_io_sync+0/80>
Trace; fffffc0000392abc <ext3_bread+1c/e0>
Trace; fffffc000043fba4 <generic_make_request+204/240>
Trace; fffffc000043fcac <submit_bh+cc/1e0>
Trace; fffffc000044000c <ll_rw_block+24c/320>
Trace; fffffc0000355ba0 <end_buffer_io_sync+0/80>
Trace; fffffc0000392b04 <ext3_bread+64/e0>
Trace; fffffc000036b5e0 <filldir64+0/1c0>
Trace; fffffc000038ee28 <ext3_readdir+a8/4c0>
Trace; fffffc000036ac28 <vfs_readdir+e8/1c0>
Trace; fffffc000036b5e0 <filldir64+0/1c0>
Trace; fffffc000036489c <link_path_walk+d7c/dc0>
Trace; fffffc00003648f8 <path_walk+18/40>
Trace; fffffc00003634b4 <permission+34/40>
Trace; fffffc000036b5e0 <filldir64+0/1c0>
Trace; fffffc000036b808 <sys_getdents64+68/120>
Trace; fffffc0000310c40 <entSys+a8/c0>

Code;  ffffffffffffffe8 <END_OF_CODE+3ffff98e430/????>
0000000000000000 <_PC>:
Code;  ffffffffffffffe8 <END_OF_CODE+3ffff98e430/????>
   0:   03 04 fc 42       addq t9,at,t2
Code;  ffffffffffffffec <END_OF_CODE+3ffff98e434/????>
   4:   00 00 fe 2f       unop 
Code;  fffffffffffffff0 <END_OF_CODE+3ffff98e438/????>
   8:   05 04 f9 42       addq t9,t11,t4
Code;  fffffffffffffff4 <END_OF_CODE+3ffff98e43c/????>
   c:   d8 03 f0 a0       ldl  t6,984(a0)
Code;  fffffffffffffff8 <END_OF_CODE+3ffff98e440/????>
  10:   25 95 a4 40       subq t4,0x24,t4
Code;  fffffffffffffffc <END_OF_CODE+3ffff98e444/????>
  14:   26 95 c4 40       subq t5,0x24,t5
Code;  0000000000000000 Before first symbol
  18:   00 00 25 a0       ldl  t0,0(t4)
Code;  0000000000000004 Before first symbol
  1c:   23 95 64 40       subq t2,0x24,t2


2 warnings issued.  Results may not be reliable.


Can you help us with this oops and how to fix it?

Attached is the config file and the output of dmesg.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AHENNY (adj.)
The way people stand when examining other people's bookshelves.
			--- Douglas Adams, The Meaning of Liff

--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.25"

#
# Automatically generated make config: don't edit
#
CONFIG_ALPHA=y
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# General setup
#
# CONFIG_ALPHA_GENERIC is not set
# CONFIG_ALPHA_ALCOR is not set
# CONFIG_ALPHA_XL is not set
# CONFIG_ALPHA_BOOK1 is not set
# CONFIG_ALPHA_AVANTI is not set
# CONFIG_ALPHA_CABRIOLET is not set
# CONFIG_ALPHA_DP264 is not set
# CONFIG_ALPHA_EB164 is not set
# CONFIG_ALPHA_EB64P is not set
# CONFIG_ALPHA_EB66 is not set
# CONFIG_ALPHA_EB66P is not set
# CONFIG_ALPHA_EIGER is not set
# CONFIG_ALPHA_JENSEN is not set
# CONFIG_ALPHA_LX164 is not set
# CONFIG_ALPHA_LYNX is not set
# CONFIG_ALPHA_MARVEL is not set
# CONFIG_ALPHA_MIATA is not set
# CONFIG_ALPHA_MIKASA is not set
# CONFIG_ALPHA_NAUTILUS is not set
# CONFIG_ALPHA_NONAME is not set
# CONFIG_ALPHA_NORITAKE is not set
# CONFIG_ALPHA_PC164 is not set
# CONFIG_ALPHA_P2K is not set
# CONFIG_ALPHA_RAWHIDE is not set
# CONFIG_ALPHA_RUFFIAN is not set
# CONFIG_ALPHA_RX164 is not set
CONFIG_ALPHA_SX164=y
# CONFIG_ALPHA_SABLE is not set
# CONFIG_ALPHA_SHARK is not set
# CONFIG_ALPHA_TAKARA is not set
# CONFIG_ALPHA_TITAN is not set
# CONFIG_ALPHA_WILDFIRE is not set
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
CONFIG_PCI=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_EV56=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_PYXIS=y
CONFIG_ALPHA_SRM=y
CONFIG_VERBOSE_MCHECK=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DISCONTIGMEM is not set
# CONFIG_ALPHA_LARGE_VMALLOC is not set
CONFIG_PCI_NAMES=y
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_SRM_ENV=y
CONFIG_BINFMT_AOUT=m
# CONFIG_OSF4_COMPAT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_BINFMT_EM86=y

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y
MAX_HWIFS=4

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
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
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
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

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
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
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
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
# CONFIG_NE2000 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
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
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
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
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_SMB_UNIX=y
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
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
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_ALPHA_LEGACY_START_ADDRESS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MATHEMU=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_RWLOCK is not set
# CONFIG_DEBUG_SEMAPHORE is not set
CONFIG_LOG_BUF_SHIFT=17

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.25 (root@beta) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 Thu Mar 25 16:35:34 CET 2004
Booting on EB164 variation SX164 using machine vector SX164 from SRM
Major Options: EV56 LEGACY_START MAGIC_SYSRQ 
Command line: ro root=/dev/sda1
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    32758
memcluster 2, usage 1, start    32758, end    32768
freeing pages 256:384
freeing pages 827:32758
reserving pages 827:828
pci: cia revision 1 (pyxis)
On node 0 totalpages: 32758
zone(0): 32758 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda1
Using epoch = 1952
Console: colour VGA+ 80x25
Calibrating delay loop... 1055.68 BogoMIPS
Memory: 253616k/262064k available (2175k kernel code, 6400k reserved, 577k data, 368k init)
Dentry cache hash table entries: 32768 (order: 6, 524288 bytes)
Inode cache hash table entries: 16384 (order: 5, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
pci: tbia workaround enabled
pci: enabling save/restore of SRM state
SMC37c669 Super I/O Controller found @ 0x3f0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
srm_env: version 0.0.5 loaded successfully
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: Digital UNIX epoch (1952) detected
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 0000 status 780d advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xfffffc880a104000, 00:40:05:36:50:D4, IRQ 25.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 00:06.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133 
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: HDS722516VLAT80, ATA DISK drive
blk: queue fffffc0000609c58, no I/O memory limit
hdc: HDS722516VLAT80, ATA DISK drive
blk: queue fffffc000060a3c0, no I/O memory limit
ide0 at 0xfffffc880a102080-0xfffffc880a102087,0xfffffc880a10208a on irq 27
ide1 at 0xfffffc880a1020c0-0xfffffc880a1020c7,0xfffffc880a1020ca on irq 27
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 321672960 sectors (164697 MB) w/7938KiB Cache, CHS=20023/255/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 321672960 sectors (164697 MB) w/7938KiB Cache, CHS=20023/255/63, UDMA(100)
Partition check:
 hda: hda1
 hdc: hdc1
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 7, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Symbios NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 7 function 0 irq 26
sym53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xa100000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
blk: queue fffffc000098d2d0, no I/O memory limit
  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc000098d4d0, no I/O memory limit
  Vendor: IBM       Model: DDYS-T36950N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue fffffc000098d6d0, no I/O memory limit
sym53c875-0-<0,0>: tagged command queue depth set to 8
sym53c875-0-<2,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
sym53c875-0-<0,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 15)
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
 sda: sda1 sda2 sda3
sym53c875-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 16)
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 sdb: sdb1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000001]
 [events: 00000001]
md: autorun ...
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md0
md: bind<hda1,1>
md: bind<hdc1,2>
md: running: <hdc1><hda1>
md: hdc1's event counter: 00000001
md: hda1's event counter: 00000001
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 248k
md0: 1 data-disks, max readahead per data-disk: 248k
raid1: device hdc1 operational as mirror 0
raid1: device hda1 operational as mirror 1
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdc1 [events: 00000002]<6>(write) hdc1's sb offset: 160834624
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 248k window, over a total of 160834624 blocks.
md: hda1 [events: 00000002]<6>(write) hda1's sb offset: 160834624
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 368k freed
Adding Swap: 265848k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting full-duplex based on MII#0 link partner capability of 01e1.
md: md0: sync done.
Unable to handle kernel paging request at virtual address 0000440003af267c
find(826): Oops 0
pc = [<fffffc00004a8b20>]  ra = [<fffffc00004a8d7c>]  ps = 0000    Not tainted
v0 = 0000000000001068  t0 = fffffffffff7fff0  t1 = 0000000000080010
t2 = 0000440003af269c  t3 = 0000000000000000  t4 = 0000440003af267c
t5 = 0000440003af2674  t6 = 0000000000000002  t7 = fffffc000ec04000
s0 = fffffc000cb419c0  s1 = 0000000000000900  s2 = fffffc0000221000
s3 = fffffc000cb419c0  s4 = fffffc000fe94cc0  s5 = 0000000000000000
s6 = fffffc000098d8a0
a0 = fffffc0000221000  a1 = fffffc000cb419c0  a2 = fffffc000cb419c0
a3 = 0000000000001000  a4 = 0000000000000008  a5 = fffffc0000221018
t8 = 0000000000000000  t9 = 00004800038d1680  t10= 0000000000080010
t11= fffffc0000221020  pv = fffffc00004a8ba0  at = fffffc000022101c
gp = fffffc000062fbe8  sp = fffffc000ec07c18
Trace:fffffc00004ab950 fffffc0000355ba0 fffffc0000392abc fffffc000043fba4 fffffc000043fcac fffffc000044000c fffffc0000355ba0 fffffc0000392b04 fffffc000036b5e0 fffffc000038ee28 fffffc000036ac28 fffffc000036b5e0 fffffc000036489c fffffc00003648f8 fffffc00003634b4 fffffc000036b5e0 fffffc000036b808 fffffc0000310c40 
Code: 42fc0403  2ffe0000  42f90405  a0f003d8  40a49525  40c49526 <a0250000> 40649523 

--oj4kGyHlBMXGt3Le--
