Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUD3Gxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUD3Gxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUD3Gxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:53:45 -0400
Received: from potato.cts.ucla.edu ([149.142.36.49]:62930 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S265087AbUD3GwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:52:00 -0400
Date: Thu, 29 Apr 2004 23:51:57 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: now happening with 2.4.26, Re: two lockups with 2.4.25
In-Reply-To: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.58.0404292322460.16175@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm now locking up with 2.4.26.  The same two machines, locked up again
within hours of each other.  One of them crashed approximately 30 hours
ago, the other crashed about 20 minutes ago.  Both machines have serial
console, but were locked hard and did not respond to SysRq.  I couldn't
get any output.

Restating:  the 2 machines are under constant network, cpu, and disk load.
Typical memory usage after a few days of uptime is (this is from one of
the machines that has been up for a couple of days):

cbs@begonia:~ > cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  4175241216 3919155200 256086016        0 19951616 3196432384
Swap: 9606946816  2809856 9604136960
MemTotal:      4077384 kB
MemFree:        250084 kB
MemShared:           0 kB
Buffers:         19484 kB
Cached:        3118896 kB
SwapCached:       2620 kB
Active:         827284 kB
Inactive:      2667956 kB
HighTotal:     3211264 kB
HighFree:        59084 kB
LowTotal:       866120 kB
LowFree:        191000 kB
SwapTotal:     9381784 kB
SwapFree:      9379040 kB


The machines are mail scanners and each handle between 500k to 750k pieces
of mail per day.  The scanning is performed by mimedefang with
spamassassin and sophie (wrapper around sophos antivirus).  Viruses are
quarantined to a RAID5 that is JFS and built from sdb1, sdc1, and sdd1.
Roughly 2000 to 4000 messages are quarantined per hour.  The temporary
directory used by mimedefang is tmpfs mounted with size=512m. The rest of
the system is spread out over sda.

cbs@begonia:~ > cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/sda2 /usr ext2 rw 0 0
/dev/sda5 /var ext2 rw 0 0
/dev/sda6 /tmp ext2 rw 0 0
/dev/sda7 /home ext2 rw 0 0
/dev/sda8 /usr/local ext2 rw 0 0
/dev/md0 /var/spool/web/vscan jfs rw,noatime 0 0
tmpfs /var/spool/MIMEDefang tmpfs rw 0 0


Given enough time, the crashing seems to be fairly reliable across three
different machines.  The two that were started at roughly the same time
have been crashing within hours of each other.  There is a third machine
that is not synchronized with the other two that also crashes with a
similar frequency.  If one of the machines remains idle and does not
participate in the scanning, it doesn't crash.

Any hints as to what might be causing the problem?  Anything that I should
look at, or kernel options to enable?  Thanks.


The only oops data I've been able to collect so far is from 2.4.25 and is
included in my original mail at the very bottom of this message.
/proc/cpuinfo, lspci, ver_linux, and my .config are all included below.



-Chris


cbs@pansy:~ > cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1400MHz
stepping        : 1
cpu MHz         : 1395.628
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 2785.28

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1400MHz
stepping        : 1
cpu MHz         : 1395.628
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 2785.28




cbs@pansy:/usr/src/linux-2.4.26/scripts > sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pansy 2.4.26 #1 SMP Wed Apr 14 07:48:53 PDT 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
jfsutils               1.1.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         eepro100 mii




cbs@pansy:/usr/src/linux-2.4.26 > lspci
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:05.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:06.0 SCSI storage controller: Adaptec 7899P (rev 01)
01:06.1 SCSI storage controller: Adaptec 7899P (rev 01)




cbs@pansy:/usr/src/linux-2.4.26 > cat .config
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
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
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

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
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
# CONFIG_IP_ROUTE_NAT is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
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
CONFIG_BRIDGE=m

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
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
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
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
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
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
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
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
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=24
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_MEGARAID=y
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
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

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
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_FORCEDETH is not set
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
CONFIG_TLAN=m
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
CONFIG_SK98LIN=m
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
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

#
# Wan interfaces
#
# CONFIG_WAN is not set

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
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
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
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set


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
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
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
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
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
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
# CONFIG_MINIX_FS is not set
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
CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
# CONFIG_SMB_FS is not set
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
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

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
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_FRAME_POINTER=y
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set






On Tue, 20 Apr 2004, Chris Stromsoe wrote:

> I had two different machines lock up within hours of each other this
> morning.  They have the exact same hardware and had very similar uptimes
> (within hours of each other).
>
> Both machines have a single SCSI disk on an onboard adaptec controller.
> All partitions are ext3.  There are 3 other disks arranged in a RAID5
> partition that are formatted JFS.
>
> The machines run as virus quarantine servers, writing about 50k messages
> to disk per day.  The files are written out into directories as
> year/month/day/hour/filename.  There are usually around 2k to 3k files
> per directory.
>
> Both machines locked up hard.  I was able to get sysrq+t output from one
> machine, but nothing from the other (it has no serial console).  I ran
> the output through ksymoops.  It's listed below.
>
>
>
> -Chris
>
>
> ksymoops 2.4.5 on i686 2.4.25.  Options used
>      -V (default)
>      -k /proc/ksyms (specified)
>      -l /proc/modules (specified)
>      -o /lib/modules/2.4.25/ (specified)
>      -m /boot/System.map-2.4.25 (specified)
>
> Pid: 26885, comm:               sophie
> EIP: 0010:[<c0110ed7>] CPU: 1 EFLAGS: 00000202    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EAX: 00000001 EBX: 00000001 ECX: 00000202 EDX: 01000000
> ESI: f4762cc0 EDI: 081a1d28 EBP: e806fe94 DS: 0018 ES: 0018
> Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register line ignored
> CR0: 8005003b CR2: 081a1d28 CR3: 14c2c000 CR4: 00000690
> Call Trace:    [<c011100f>] [<c01259b7>] [<c01260de>] [<c01132f9>] [<c0113158>]
>   [<c0224ce1>] [<c01145e3>] [<c0106fc4>]
> Warning (Oops_read): Code line not seen, dumping what data is available
>
>
> >>EIP; c0110ed7 <flush_tlb_others+9b/bc>   <=====
>
> >>EDX; 01000000 Before first symbol
> >>ESI; f4762cc0 <_end+343c85cc/3896e90c>
> >>EDI; 081a1d28 Before first symbol
> >>EBP; e806fe94 <_end+27cd57a0/3896e90c>
>
> Trace; c011100f <flush_tlb_page+6f/7c>
> Trace; c01259b7 <do_wp_page+223/284>
> Trace; c01260de <handle_mm_fault+82/b8>
> Trace; c01132f9 <do_page_fault+1a1/4ed>
> Trace; c0113158 <do_page_fault+0/4ed>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c01145e3 <schedule+45b/520>
> Trace; c0106fc4 <error_code+34/3c>
>
> init          R C3FFBF28     0     1      0 18517               (NOTLB)
> Call Trace:    [<c0130fc1>] [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>]
>   [<c0106ed3>]
> keventd       S C3FEC000     0     2      1             3       (L-TLB)
> Call Trace:    [<c012418c>] [<c0105680>]
> ksoftirqd_CPU R C3FEA000     0     3      1             4     2 (L-TLB)
> Call Trace:    [<c011c47e>] [<c0105680>]
> ksoftirqd_CPU R C3FE8000     0     4      1             5     3 (L-TLB)
> Call Trace:    [<c011c47e>] [<c0105680>]
> kswapd        S C3FD8000     0     5      1             6     4 (L-TLB)
> Call Trace:    [<c01307fb>] [<c0105680>]
> bdflush       R 00000286     0     6      1             7     5 (L-TLB)
> Call Trace:    [<c0114a3e>] [<c013cb93>] [<c0105680>]
> kupdated      R C3FB5F30     0     7      1             8     6 (L-TLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c013cc74>] [<c01705ff>] [<c01708b1>]
>   [<c0172345>] [<c01723d9>] [<c0106e86>] [<c013cb98>] [<c0105680>]
> jfsIO         S C3FA2000     0     8      1             9     7 (L-TLB)
> Call Trace:    [<c0194c68>] [<c0105680>]
> jfsCommit     D F70C0CC0     0     9      1            10     8 (L-TLB)
> Call Trace:    [<c019776b>] [<c0197960>] [<c0105680>]
> jfsSync       S C0366180   376    10      1            11     9 (L-TLB)
> Call Trace:    [<c0197ed3>] [<c0105680>]
> ahc_dv_0      S F7AD3F2C  5944    11      1            12    10 (L-TLB)
> Call Trace:    [<c0105c2c>] [<c0105d22>] [<c01e9fba>] [<c0105680>]
> ahc_dv_1      S C3FE2D0C  6172    12      1            13    11 (L-TLB)
> Call Trace:    [<c0105c2c>] [<c0105d22>] [<c01e9fba>] [<c0105680>]
> scsi_eh_0     S F7ABDFD8    36    13      1            14    12 (L-TLB)
> Call Trace:    [<c0105c2c>] [<c0105d22>] [<c01def72>] [<c0105680>]
> scsi_eh_1     S F7AB7FD8    36    14      1            15    13 (L-TLB)
> Call Trace:    [<c0105c2c>] [<c0105d22>] [<c01def72>] [<c0105680>]
> mdrecoveryd   S F7A0E000     0    15      1            16    14 (L-TLB)
> Call Trace:    [<c021fd31>] [<c0105680>]
> raid5d        S F7A02000     0    16      1           190    15 (L-TLB)
> Call Trace:    [<c021fd31>] [<c0105680>]
> syslogd       R 7FFFFFFF     0   190      1           194    16 (NOTLB)
> Call Trace:    [<c0114077>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> klogd         R F6FDA000     0   194      1           199   190 (NOTLB)
> Call Trace:    [<c011740f>] [<c015b3fa>] [<c013836d>] [<c0106ed3>]
> inetd         R F6FD3FAC  1376   199      1           317   194 (NOTLB)
> Call Trace:    [<c0106017>] [<c0106ed3>]
> sendmail      R F6F7BF28    68   317      1           323   199 (NOTLB)
> Call Trace:    [<c0147930>] [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>]
>   [<c0106ed3>]
> sendmail      R 00000000     0   323      1   324     335   317 (NOTLB)
> Call Trace:    [<c011af34>] [<c0106ed3>]
> sendmail      R F6F5E000   132   324    323                     (NOTLB)
> Call Trace:    [<c010c9ed>] [<c0106ed3>]
> sendmail      R 00000000     0   335      1   336     338   323 (NOTLB)
> Call Trace:    [<c011af34>] [<c0106ed3>]
> sendmail      R F6F46000     4   336    335                     (NOTLB)
> Call Trace:    [<c010c9ed>] [<c0106ed3>]
> sshd          R 7FFFFFFF     0   338      1 29552     343   335 (NOTLB)
> Call Trace:    [<c0114077>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> ntpd          R 7FFFFFFF     8   343      1           350   338 (NOTLB)
> Call Trace:    [<c0114077>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mdadm         R F6F25F88     0   350      1           354   343 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c011fb08>] [<c0106ed3>]
> cron          R F6E5FF88     0   354      1           363   350 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c011fb08>] [<c0106ed3>]
> apache        R F6B7FF28    32   363      1 13135     417   354 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> getty         R 7FFFFFFF  2400   417      1           418   363 (NOTLB)
> Call Trace:    [<c0114077>] [<c01a4553>] [<c01a0008>] [<c013836d>] [<c0106ed3>]
> getty         R 7FFFFFFF  1376   418      1           419   417 (NOTLB)
> Call Trace:    [<c0114077>] [<c01a4553>] [<c01a0008>] [<c013836d>] [<c0106ed3>]
> getty         R 7FFFFFFF     0   419      1         12367   418 (NOTLB)
> Call Trace:    [<c0114077>] [<c01a4553>] [<c01b1c65>] [<c01a0008>] [<c013836d>]
>   [<c0106ed3>]
> logger        R F6A5E000     8   425    363           426       (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> logger        R F6A32000     0   426    363         18988   425 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> sophie        R C7DF3F88  2400 12367      1 26885   12393   419 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c011fb08>] [<c0106ed3>]
> mimedefang-mu R D065DF28     0 12393      1 26392   12404 12367 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R D84B3FAC     0 12404      1 12405   18514 12393 (NOTLB)
> Call Trace:    [<c0106017>] [<c0106ed3>]
> mimedefang    R D0EC0000   160 12405  12404 26890               (NOTLB)
> Call Trace:    [<c0106f81>]
> mimedefang    R E3B3DFAC     0 12406  12405         14117       (NOTLB)
> Call Trace:    [<c0106017>] [<c0106ed3>]
> sophie        R C9857F28    84  8398  12367         26884       (NOTLB)
> Call Trace:    [<c0141c47>] [<c01140da>] [<c0114000>] [<c01481a0>] [<c01483bd>]
>   [<c0106ed3>]
> sshd          R 7FFFFFFF     0 29552    338 29556               (NOTLB)
> Call Trace:    [<c0114077>] [<c0271ac6>] [<c0271ca1>] [<c0221713>] [<c022180f>]
>   [<c013836d>] [<c0106ed3>]
> sshd          R 7FFFFFFF     0 29556  29552 29557               (NOTLB)
> Call Trace:    [<c0114077>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> tcsh          R 7FFFFFFF    48 29557  29556                     (NOTLB)
> Call Trace:    [<c0114077>] [<c01a4553>] [<c01a0008>] [<c013836d>] [<c0106ed3>]
> apache        R 00000001    80 18988    363         15030   426 (NOTLB)
> Call Trace:    [<c019cd05>] [<c0221000>] [<c0248577>] [<c0224b3f>] [<c0224b56>]
>   [<c0224ce1>] [<c024c369>] [<c0131497>] [<c02539fe>] [<c0223a93>] [<c0244711>]
>   [<c014c8ec>] [<c014b37b>] [<c01218f6>] [<c010c605>] [<c0106ed3>]
> apache        R 00000001     0 15030    363         16181 18988 (NOTLB)
> Call Trace:    [<c019cd05>] [<c0231403>] [<c024c89c>] [<c024c944>] [<c024d429>]
>   [<c024e16a>] [<c02441c5>] [<c0224b56>] [<c0224ce1>] [<c0228cab>] [<c011bf3d>]
>   [<c010c605>] [<c0106ed3>]
> apache        R 7FFFFFFF   144 16181    363         31860 15030 (NOTLB)
> Call Trace:    [<c0114077>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> apache        R 00000001     0 31860    363          6914 16181 (NOTLB)
> Call Trace:    [<c0228795>] [<c019cd05>] [<c0231403>] [<c024c89c>] [<c024c944>]
>   [<c0224b3f>] [<c024d429>] [<c024e16a>] [<c02441c5>] [<c014c8ec>] [<c014b37b>]
>   [<c01218f6>] [<c010c605>] [<c0106ed3>]
> apache        R 00000001    28  6914    363         31487 31860 (NOTLB)
> Call Trace:    [<c019cd05>] [<c02395fc>] [<c0231000>] [<c02395b5>] [<c0239730>]
>   [<c0228edb>] [<c0228f8a>] [<c02290c3>] [<c011bf3d>] [<c010890e>] [<c0140018>]
>   [<c012ebf3>] [<c014b37b>] [<c01218f6>] [<c010c605>] [<c0106ed3>]
> apache        R 00000001    12 31487    363         13089  6914 (NOTLB)
> Call Trace:    [<c019cd05>] [<c0231403>] [<c024c89c>] [<c024c944>] [<c0224b3f>]
>   [<c024d429>] [<c024e16a>] [<c0224b56>] [<c0224ce1>] [<c0228cab>] [<c011bf3d>]
>   [<c010890e>] [<c019c7b5>] [<c010c605>] [<c0106ed3>]
> hostmon-clien R C4425F88     0 18514      1         18517 12404 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c011fb08>] [<c0106ed3>]
> hostmon-clien R 7FFFFFFF   144 18517      1               18514 (NOTLB)
> Call Trace:    [<c0114077>] [<c0244bc1>] [<c0244d4a>] [<c025eb4a>] [<c0222271>]
>   [<c0224b56>] [<c0224ce1>] [<c0228cab>] [<c0222d1b>] [<c0106ed3>]
> apache        R 00000001    68 13089    363         13135 31487 (NOTLB)
> Call Trace:    [<c019cd05>] [<c0221000>] [<c0248577>] [<c0224b3f>] [<c0224b56>]
>   [<c0224ce1>] [<c024c369>] [<c0131497>] [<c02539fe>] [<c0223a93>] [<c0244711>]
>   [<c014c8ec>] [<c014b37b>] [<c01218f6>] [<c010c605>] [<c0106ed3>]
> apache        R 00000001     8 13135    363               13089 (NOTLB)
> Call Trace:    [<c019cd05>] [<f8d0c83d>] [<c0231403>] [<c022648d>] [<c0224b3f>]
>   [<c0224b56>] [<c0224ce1>] [<c0253926>] [<c0223a93>] [<c0244711>] [<c014c8ec>]
>   [<c014b37b>] [<c01218f6>] [<c010c605>] [<c0106ed3>]
> mimedefang    R E127DF28     0 14117  12405         15166 12406 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C9433F28    80 15166  12405         15168 14117 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DB6F3F28     0 15168  12405         15611 15166 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CCF53F28    40 15611  12405         16920 15168 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C6FEFF28     0 16920  12405         16921 15611 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C8305F28     0 16921  12405           561 16920 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R D9D99F28    80   561  12405           628 16921 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CC561F28     0   628  12405         13814   561 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E4281F28    64 13814  12405         18268   628 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E71C3F28   132 18268  12405         19336 13814 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang.pl R CCE82000     0 19234  12393         19235       (NOTLB)
> Call Trace:    [<c0106f81>]
> mimedefang.pl R 7FFFFFFF     0 19235  12393         19242 19234 (NOTLB)
> Call Trace:    [<c0114077>] [<c0271ac6>] [<c0271ca1>] [<c0221713>] [<c022180f>]
>   [<c013836d>] [<c0106ed3>]
> mimedefang.pl R F04B0000     0 19242  12393         21612 19235 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang    R E34E7F28     4 19336  12405         19849 18268 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F6CE3F28     0 19849  12405         19870 19336 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F135BF28     0 19870  12405         19872 19849 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R EADB7F28     0 19872  12405         20723 19870 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C9C29F28    12 20723  12405         20993 19872 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R ED4C5F28     4 20993  12405         22071 20723 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang.pl R E5C96000    80 21612  12393         22136 19242 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang    R C4B55F28     0 22071  12405         22383 20993 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang.pl R EE658000     4 22136  12393         22137 21612 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R EBF06000     0 22137  12393         22140 22136 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R E74FC000     0 22140  12393         22142 22137 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R E4BBE000  2400 22142  12393         22146 22140 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R EE172000    96 22146  12393         22159 22142 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R E853E000  1376 22159  12393         24159 22146 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang    R E03F9F28   100 22383  12405         22521 22071 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R ED0D3F28     0 22521  12405         22522 22383 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F4933F28    80 22522  12405         22775 22521 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DBE89F28    32 22775  12405         24871 22522 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang.pl R D9166000   104 24159  12393         24160 22159 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R E0390000   304 24160  12393         26390 24159 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang    R CDF47F28    80 24871  12405         25252 22775 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F4E75F28   100 25252  12405         25477 24871 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DE085F28     0 25477  12405         26006 25252 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R EEB7FF28     0 26006  12405         26016 25477 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DB0A1F28   104 26016  12405         26029 26006 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R EDF07F28     0 26029  12405         26281 26016 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R D3E27F28     4 26281  12405         26507 26029 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang.pl R E3A48000     0 26390  12393         26392 24160 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang.pl R C67D0000    16 26392  12393               26390 (NOTLB)
> Call Trace:    [<c014171a>] [<c0141807>] [<c013836d>] [<c0106ed3>]
> mimedefang    R C5E21F28   272 26507  12405         26540 26281 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C418FF28    68 26540  12405         26541 26507 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R D2C1FF28    68 26541  12405         26637 26540 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E914BF28     0 26637  12405         26756 26541 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DC941F28     0 26756  12405         26761 26637 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E5ACDF28     0 26761  12405         26772 26756 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DB6C3F28   400 26772  12405         26793 26761 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R D022FF28    80 26793  12405         26795 26772 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DE591F28    68 26795  12405         26801 26793 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E0923F28    16 26801  12405         26812 26795 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F318BF28    64 26812  12405         26818 26801 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R 7FFFFFFF     0 26818  12405         26824 26812 (NOTLB)
> Call Trace:    [<c0114077>] [<c0271ac6>] [<c0271ca1>] [<c0221713>] [<c022180f>]
>   [<c013836d>] [<c0106ed3>]
> mimedefang    R F3E77F28    80 26824  12405         26826 26818 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E03F7F28    80 26826  12405         26830 26824 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DD0ABF28     0 26830  12405         26844 26826 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E4E85F28     0 26844  12405         26846 26830 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R C8E6FF28    40 26846  12405         26848 26844 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CF007F28     4 26848  12405         26851 26846 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CE075F28    68 26851  12405         26859 26848 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R 7FFFFFFF     0 26859  12405         26871 26851 (NOTLB)
> Call Trace:    [<c0114077>] [<c0271ac6>] [<c0271ca1>] [<c0221713>] [<c022180f>]
>   [<c013836d>] [<c0106ed3>]
> mimedefang    R F51CBF28    80 26871  12405         26872 26859 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CDD91F28     0 26872  12405         26876 26871 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R DD759F28  2400 26876  12405         26879 26872 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E8A9DF28     0 26879  12405         26886 26876 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> sophie        Z C3F74200    80 26884  12367         26885  8398 (L-TLB)
> Call Trace:    [<c011ab7c>] [<c011abb4>] [<c0106ed3>]
> sophie        R current      0 26885  12367               26884 (NOTLB)
> Call Trace:    [<c0106fc4>]
> mimedefang    R DA151F28     4 26886  12405         26887 26879 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R EF435F28  2408 26887  12405         26888 26886 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R CC989F28     0 26888  12405         26889 26887 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R E5A83F28     0 26889  12405         26890 26888 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> mimedefang    R F67E5F28     0 26890  12405               26889 (NOTLB)
> Call Trace:    [<c01140da>] [<c0114000>] [<c0147bac>] [<c0147f38>] [<c0106ed3>]
> Warning (Oops_read): Code line not seen, dumping what data is available
>
> Proc;  init
>
> >>EIP; c3ffbf28 <_end+3c61834/3896e90c>   <=====
>
> Trace; c0130fc1 <_alloc_pages+19/20>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  keventd
>
> >>EIP; c3fec000 <_end+3c5190c/3896e90c>   <=====
>
> Trace; c012418c <context_thread+11c/1d8>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  ksoftirqd_CPU
>
> >>EIP; c3fea000 <_end+3c4f90c/3896e90c>   <=====
>
> Trace; c011c47e <ksoftirqd+92/cc>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  ksoftirqd_CPU
>
> >>EIP; c3fe8000 <_end+3c4d90c/3896e90c>   <=====
>
> Trace; c011c47e <ksoftirqd+92/cc>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  kswapd
>
> >>EIP; c3fd8000 <_end+3c3d90c/3896e90c>   <=====
>
> Trace; c01307fb <kswapd+7f/b6>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  bdflush
>
> >>EIP; 00000286 Before first symbol   <=====
>
> Trace; c0114a3e <interruptible_sleep_on+4a/78>
> Trace; c013cb93 <bdflush+c7/cc>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  kupdated
>
> >>EIP; c3fb5f30 <_end+3c1b83c/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c013cc74 <kupdate+dc/194>
> Trace; c01705ff <ext2_check_page+3b/1ec>
> Trace; c01708b1 <ext2_readdir+1d/278>
> Trace; c0172345 <ext2_get_block+9/390>
> Trace; c01723d9 <ext2_get_block+9d/390>
> Trace; c0106e86 <ret_from_fork+6/20>
> Trace; c013cb98 <kupdate+0/194>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  jfsIO
>
> >>EIP; c3fa2000 <_end+3c0790c/3896e90c>   <=====
>
> Trace; c0194c68 <jfsIOWait+13c/168>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  jfsCommit
>
> >>EIP; f70c0cc0 <_end+36d265cc/3896e90c>   <=====
>
> Trace; c019776b <txLazyCommit+23/ac>
> Trace; c0197960 <jfs_lazycommit+16c/1f4>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  jfsSync
>
> >>EIP; c0366180 <TxAnchor+40/60>   <=====
>
> Trace; c0197ed3 <jfs_sync+25b/28c>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  ahc_dv_0
>
> >>EIP; f7ad3f2c <_end+37739838/3896e90c>   <=====
>
> Trace; c0105c2c <__down_interruptible+6c/ec>
> Trace; c0105d22 <__down_failed_interruptible+a/10>
> Trace; c01e9fba <.text.lock.aic7xxx_osm+115/29b>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  ahc_dv_1
>
> >>EIP; c3fe2d0c <_end+3c48618/3896e90c>   <=====
>
> Trace; c0105c2c <__down_interruptible+6c/ec>
> Trace; c0105d22 <__down_failed_interruptible+a/10>
> Trace; c01e9fba <.text.lock.aic7xxx_osm+115/29b>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  scsi_eh_0
>
> >>EIP; f7abdfd8 <_end+377238e4/3896e90c>   <=====
>
> Trace; c0105c2c <__down_interruptible+6c/ec>
> Trace; c0105d22 <__down_failed_interruptible+a/10>
> Trace; c01def72 <.text.lock.scsi_error+e5/103>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  scsi_eh_1
>
> >>EIP; f7ab7fd8 <_end+3771d8e4/3896e90c>   <=====
>
> Trace; c0105c2c <__down_interruptible+6c/ec>
> Trace; c0105d22 <__down_failed_interruptible+a/10>
> Trace; c01def72 <.text.lock.scsi_error+e5/103>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  mdrecoveryd
>
> >>EIP; f7a0e000 <_end+3767390c/3896e90c>   <=====
>
> Trace; c021fd31 <md_thread+11d/1a4>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  raid5d
>
> >>EIP; f7a02000 <_end+3766790c/3896e90c>   <=====
>
> Trace; c021fd31 <md_thread+11d/1a4>
> Trace; c0105680 <arch_kernel_thread+28/38>
> Proc;  syslogd
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  klogd
>
> >>EIP; f6fda000 <_end+36c3f90c/3896e90c>   <=====
>
> Trace; c011740f <do_syslog+cf/3c4>
> Trace; c015b3fa <kmsg_read+12/18>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  inetd
>
> >>EIP; f6fd3fac <_end+36c398b8/3896e90c>   <=====
>
> Trace; c0106017 <sys_rt_sigsuspend+fb/118>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sendmail
>
> >>EIP; f6f7bf28 <_end+36be1834/3896e90c>   <=====
>
> Trace; c0147930 <__pollwait+88/90>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sendmail
>
> >>EIP; 00000000 Before first symbol
>
> Trace; c011af34 <sys_wait4+380/3b8>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sendmail
>
> >>EIP; f6f5e000 <_end+36bc390c/3896e90c>   <=====
>
> Trace; c010c9ed <sys_pause+15/1e>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sendmail
>
> >>EIP; 00000000 Before first symbol
>
> Trace; c011af34 <sys_wait4+380/3b8>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sendmail
>
> >>EIP; f6f46000 <_end+36bab90c/3896e90c>   <=====
>
> Trace; c010c9ed <sys_pause+15/1e>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sshd
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  ntpd
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mdadm
>
> >>EIP; f6f25f88 <_end+36b8b894/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c011fb08 <sys_nanosleep+108/1d3>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  cron
>
> >>EIP; f6e5ff88 <_end+36ac5894/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c011fb08 <sys_nanosleep+108/1d3>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; f6b7ff28 <_end+367e5834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  getty
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c01a4553 <read_chan+34f/6e0>
> Trace; c01a0008 <tty_read+cc/120>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  getty
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c01a4553 <read_chan+34f/6e0>
> Trace; c01a0008 <tty_read+cc/120>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  getty
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c01a4553 <read_chan+34f/6e0>
> Trace; c01b1c65 <do_softint+49/50>
> Trace; c01a0008 <tty_read+cc/120>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  logger
>
> >>EIP; f6a5e000 <_end+366c390c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  logger
>
> >>EIP; f6a32000 <_end+3669790c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sophie
>
> >>EIP; c7df3f88 <_end+7a59894/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c011fb08 <sys_nanosleep+108/1d3>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang-mu
>
> >>EIP; d065df28 <_end+102c3834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d84b3fac <_end+181198b8/3896e90c>   <=====
>
> Trace; c0106017 <sys_rt_sigsuspend+fb/118>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d0ec0000 <_end+10b2590c/3896e90c>   <=====
>
> Trace; c0106f81 <reschedule+5/c>
> Proc;  mimedefang
>
> >>EIP; e3b3dfac <_end+237a38b8/3896e90c>   <=====
>
> Trace; c0106017 <sys_rt_sigsuspend+fb/118>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sophie
>
> >>EIP; c9857f28 <_end+94bd834/3896e90c>   <=====
>
> Trace; c0141c47 <pipe_poll+27/68>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c01481a0 <do_poll+a8/cc>
> Trace; c01483bd <sys_poll+1f9/2fd>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sshd
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0271ac6 <unix_stream_data_wait+c2/108>
> Trace; c0271ca1 <unix_stream_recvmsg+195/3e4>
> Trace; c0221713 <sock_recvmsg+37/a8>
> Trace; c022180f <sock_read+8b/94>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sshd
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  tcsh
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c01a4553 <read_chan+34f/6e0>
> Trace; c01a0008 <tty_read+cc/120>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c0221000 <md_geninit+8c/98>
> Trace; c0248577 <tcp_clean_rtx_queue+18f/2fc>
> Trace; c0224b3f <skb_release_data+6b/74>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c024c369 <tcp_rcv_state_process+9e5/9f1>
> Trace; c0131497 <__free_pages+1f/24>
> Trace; c02539fe <tcp_v4_destroy_sock+15a/170>
> Trace; c0223a93 <sk_free+6f/78>
> Trace; c0244711 <tcp_close+815/820>
> Trace; c014c8ec <destroy_inode+5c/64>
> Trace; c014b37b <dput+1b/15c>
> Trace; c01218f6 <sys_rt_sigaction+92/13c>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c0231403 <nf_hook_slow+103/180>
> Trace; c024c89c <tcp_transmit_skb+414/568>
> Trace; c024c944 <tcp_transmit_skb+4bc/568>
> Trace; c024d429 <tcp_write_xmit+209/2bc>
> Trace; c024e16a <tcp_send_fin+1a6/280>
> Trace; c02441c5 <tcp_close+2c9/820>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c0228cab <net_tx_action+57/120>
> Trace; c011bf3d <do_softirq+7d/e0>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c0228795 <dev_queue_xmit+121/314>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c0231403 <nf_hook_slow+103/180>
> Trace; c024c89c <tcp_transmit_skb+414/568>
> Trace; c024c944 <tcp_transmit_skb+4bc/568>
> Trace; c0224b3f <skb_release_data+6b/74>
> Trace; c024d429 <tcp_write_xmit+209/2bc>
> Trace; c024e16a <tcp_send_fin+1a6/280>
> Trace; c02441c5 <tcp_close+2c9/820>
> Trace; c014c8ec <destroy_inode+5c/64>
> Trace; c014b37b <dput+1b/15c>
> Trace; c01218f6 <sys_rt_sigaction+92/13c>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c02395fc <ip_local_deliver_finish+0/134>
> Trace; c0231000 <nf_setsockopt+1c/2c>
> Trace; c02395b5 <ip_rcv+38d/3d4>
> Trace; c0239730 <ip_rcv_finish+0/1de>
> Trace; c0228edb <netif_receive_skb+167/194>
> Trace; c0228f8a <process_backlog+82/128>
> Trace; c02290c3 <net_rx_action+93/154>
> Trace; c011bf3d <do_softirq+7d/e0>
> Trace; c010890e <do_IRQ+da/ec>
> Trace; c0140018 <copy_strings+64/260>
> Trace; c012ebf3 <kmem_cache_free+73/80>
> Trace; c014b37b <dput+1b/15c>
> Trace; c01218f6 <sys_rt_sigaction+92/13c>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c0231403 <nf_hook_slow+103/180>
> Trace; c024c89c <tcp_transmit_skb+414/568>
> Trace; c024c944 <tcp_transmit_skb+4bc/568>
> Trace; c0224b3f <skb_release_data+6b/74>
> Trace; c024d429 <tcp_write_xmit+209/2bc>
> Trace; c024e16a <tcp_send_fin+1a6/280>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c0228cab <net_tx_action+57/120>
> Trace; c011bf3d <do_softirq+7d/e0>
> Trace; c010890e <do_IRQ+da/ec>
> Trace; c019c7b5 <sys_semtimedop+1/684>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  hostmon-clien
>
> >>EIP; c4425f88 <_end+408b894/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c011fb08 <sys_nanosleep+108/1d3>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  hostmon-clien
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0244bc1 <wait_for_connect+101/1cc>
> Trace; c0244d4a <tcp_accept+be/240>
> Trace; c025eb4a <inet_accept+2a/1c4>
> Trace; c0222271 <sys_accept+61/100>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c0228cab <net_tx_action+57/120>
> Trace; c0222d1b <sys_socketcall+9f/198>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; c0221000 <md_geninit+8c/98>
> Trace; c0248577 <tcp_clean_rtx_queue+18f/2fc>
> Trace; c0224b3f <skb_release_data+6b/74>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c024c369 <tcp_rcv_state_process+9e5/9f1>
> Trace; c0131497 <__free_pages+1f/24>
> Trace; c02539fe <tcp_v4_destroy_sock+15a/170>
> Trace; c0223a93 <sk_free+6f/78>
> Trace; c0244711 <tcp_close+815/820>
> Trace; c014c8ec <destroy_inode+5c/64>
> Trace; c014b37b <dput+1b/15c>
> Trace; c01218f6 <sys_rt_sigaction+92/13c>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  apache
>
> >>EIP; 00000001 Before first symbol   <=====
>
> Trace; c019cd05 <sys_semtimedop+551/684>
> Trace; f8d0c83d <[eepro100]speedo_start_xmit+16d/1f4>
> Trace; c0231403 <nf_hook_slow+103/180>
> Trace; c022648d <memcpy_toiovec+35/64>
> Trace; c0224b3f <skb_release_data+6b/74>
> Trace; c0224b56 <kfree_skbmem+e/70>
> Trace; c0224ce1 <__kfree_skb+129/134>
> Trace; c0253926 <tcp_v4_destroy_sock+82/170>
> Trace; c0223a93 <sk_free+6f/78>
> Trace; c0244711 <tcp_close+815/820>
> Trace; c014c8ec <destroy_inode+5c/64>
> Trace; c014b37b <dput+1b/15c>
> Trace; c01218f6 <sys_rt_sigaction+92/13c>
> Trace; c010c605 <sys_ipc+3d/238>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e127df28 <_end+20ee3834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c9433f28 <_end+9099834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; db6f3f28 <_end+1b359834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; ccf53f28 <_end+cbb9834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c6feff28 <_end+6c55834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c8305f28 <_end+7f6b834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d9d99f28 <_end+199ff834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; cc561f28 <_end+c1c7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e4281f28 <_end+23ee7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e71c3f28 <_end+26e29834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; cce82000 <_end+cae790c/3896e90c>   <=====
>
> Trace; c0106f81 <reschedule+5/c>
> Proc;  mimedefang.pl
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0271ac6 <unix_stream_data_wait+c2/108>
> Trace; c0271ca1 <unix_stream_recvmsg+195/3e4>
> Trace; c0221713 <sock_recvmsg+37/a8>
> Trace; c022180f <sock_read+8b/94>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; f04b0000 <_end+3011590c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e34e7f28 <_end+2314d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f6ce3f28 <_end+36949834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f135bf28 <_end+30fc1834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; eadb7f28 <_end+2aa1d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c9c29f28 <_end+988f834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; ed4c5f28 <_end+2d12b834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e5c96000 <_end+258fb90c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c4b55f28 <_end+47bb834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; ee658000 <_end+2e2bd90c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; ebf06000 <_end+2bb6b90c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e74fc000 <_end+2716190c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e4bbe000 <_end+2482390c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; ee172000 <_end+2ddd790c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e853e000 <_end+281a390c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e03f9f28 <_end+2005f834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; ed0d3f28 <_end+2cd39834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f4933f28 <_end+34599834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; dbe89f28 <_end+1baef834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; d9166000 <_end+18dcb90c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e0390000 <_end+1fff590c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; cdf47f28 <_end+dbad834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f4e75f28 <_end+34adb834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; de085f28 <_end+1dceb834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; eeb7ff28 <_end+2e7e5834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; db0a1f28 <_end+1ad07834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; edf07f28 <_end+2db6d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d3e27f28 <_end+13a8d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; e3a48000 <_end+236ad90c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang.pl
>
> >>EIP; c67d0000 <_end+643590c/3896e90c>   <=====
>
> Trace; c014171a <pipe_wait+7a/a8>
> Trace; c0141807 <pipe_read+bf/220>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c5e21f28 <_end+5a87834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c418ff28 <_end+3df5834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d2c1ff28 <_end+12885834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e914bf28 <_end+28db1834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; dc941f28 <_end+1c5a7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e5acdf28 <_end+25733834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; db6c3f28 <_end+1b329834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; d022ff28 <_end+fe95834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; de591f28 <_end+1e1f7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e0923f28 <_end+20589834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f318bf28 <_end+32df1834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0271ac6 <unix_stream_data_wait+c2/108>
> Trace; c0271ca1 <unix_stream_recvmsg+195/3e4>
> Trace; c0221713 <sock_recvmsg+37/a8>
> Trace; c022180f <sock_read+8b/94>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f3e77f28 <_end+33add834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e03f7f28 <_end+2005d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; dd0abf28 <_end+1cd11834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e4e85f28 <_end+24aeb834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; c8e6ff28 <_end+8ad5834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; cf007f28 <_end+ec6d834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; ce075f28 <_end+dcdb834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; 7fffffff Before first symbol   <=====
>
> Trace; c0114077 <schedule_timeout+17/9c>
> Trace; c0271ac6 <unix_stream_data_wait+c2/108>
> Trace; c0271ca1 <unix_stream_recvmsg+195/3e4>
> Trace; c0221713 <sock_recvmsg+37/a8>
> Trace; c022180f <sock_read+8b/94>
> Trace; c013836d <sys_read+91/110>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f51cbf28 <_end+34e31834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; cdd91f28 <_end+d9f7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; dd759f28 <_end+1d3bf834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e8a9df28 <_end+28703834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sophie
>
> >>EIP; c3f74200 <_end+3bd9b0c/3896e90c>   <=====
>
> Trace; c011ab7c <do_exit+2d4/2e4>
> Trace; c011abb4 <sys_wait4+0/3b8>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  sophie
>
> >>EIP; 0000000c Before first symbol   <=====
>
> Trace; c0106fc4 <error_code+34/3c>
> Proc;  mimedefang
>
> >>EIP; da151f28 <_end+19db7834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; ef435f28 <_end+2f09b834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; cc989f28 <_end+c5ef834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; e5a83f28 <_end+256e9834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
> Proc;  mimedefang
>
> >>EIP; f67e5f28 <_end+3644b834/3896e90c>   <=====
>
> Trace; c01140da <schedule_timeout+7a/9c>
> Trace; c0114000 <process_timeout+0/60>
> Trace; c0147bac <do_select+1c4/1fc>
> Trace; c0147f38 <sys_select+328/454>
> Trace; c0106ed3 <system_call+33/38>
>
>
> 3 warnings issued.  Results may not be reliable.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
