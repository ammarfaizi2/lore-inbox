Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBHUZ4>; Sat, 8 Feb 2003 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTBHUZz>; Sat, 8 Feb 2003 15:25:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:51896 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267091AbTBHUZV>; Sat, 8 Feb 2003 15:25:21 -0500
Date: Sat, 08 Feb 2003 12:34:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 327] New: kernel BUG at drivers/scsi/scsi_error.c:1523! 
Message-ID: <20430000.1044736478@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=327

           Summary: kernel BUG at drivers/scsi/scsi_error.c:1523!
    Kernel Version: 2.5.59-bk2
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: tamaguci@katamail.com


Distribution: Debian Sid  
Hardware Environment: athlon XP 2000, asus a7v8x (kt-400),  
ide-cd writer lg 40x12x40 
Software Environment: gcc-3.2.2 
Problem Description: 
ksymoops 2.4.8 on i686 2.5.59.  Options used 
     -V (default) 
     -k /proc/ksyms (default) 
     -l /proc/modules (default) 
     -o /lib/modules/2.5.59/ (default) 
     -m /boot/System.map-2.5.59 (default) 
 
Warning: You did not tell me where to find symbol information.  I will 
assume that the log matches the kernel and modules that are running 
right now and I'll use the default options above for symbol resolution. 
If the current kernel and/or modules do not match the log, you can get 
more accurate output by telling me the kernel version and where to find 
map, modules, ksyms etc.  ksymoops -h explains the options. 
 
Error (regular_file): read_ksyms stat /proc/ksyms failed 
ksymoops: No such file or directory 
No modules in ksyms, skipping objects 
No ksyms, skipping lsmod 
kernel BUG at drivers/scsi/scsi_error.c:1523! 
invalid operand: 0000 
CPU:    0 
EIP:    0060:[<d092e26b>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386 
EFLAGS: 00010202 
eax: 00000001   ebx: c13dee00   ecx: c0309454   edx: 00000000 
esi: cf0b1fd4   edi: cf0b0000   ebp: 00000000   esp: cf0b1fb0 
ds: 007b   es: 007b   ss: 0068 
Stack: 00000000 c13dee00 c0108357 00000000 c13dee00 d092e3c8 c13dee00 
d0934f3e  
       00000000 00000000 00000000 cf0b1fdc cf0b1fdc d092e2d0 00000000
00000000          c0107129 c13dee00 00000000 00000000  
Call Trace: [<c0108357>]  [<d092e3c8>]  [<d0934f3e>]  [<d092e2d0>]
[<c0107129>]   Code: 0f 0b f3 05 10 4f 93 d0 eb a8 8b 44 24 0c 89 5c 24 04
89 04    
 
>> EIP; d092e26b <__crc_journal_wipe+8720c/38a2a0>   <===== 
 
>> ebx; c13dee00 <__crc_memcpy_tokerneliovec+180d78/2a6d41> 
>> ecx; c0309454 <console_sem+0/10> 
>> esi; cf0b1fd4 <__crc_devfs_put+307a37/629489> 
>> edi; cf0b0000 <__crc_devfs_put+305a63/629489> 
>> esp; cf0b1fb0 <__crc_devfs_put+307a13/629489> 
 
Trace; c0108357 <__down_failed_interruptible+7/c> 
Trace; d092e3c8 <__crc_journal_wipe+87369/38a2a0> 
Trace; d0934f3e <__crc_journal_wipe+8dedf/38a2a0> 
Trace; d092e2d0 <__crc_journal_wipe+87271/38a2a0> 
Trace; c0107129 <kernel_thread_helper+5/c> 
 
Code;  d092e26b <__crc_journal_wipe+8720c/38a2a0> 
00000000 <_EIP>: 
Code;  d092e26b <__crc_journal_wipe+8720c/38a2a0>   <===== 
   0:   0f 0b                     ud2a      <===== 
Code;  d092e26d <__crc_journal_wipe+8720e/38a2a0> 
   2:   f3 05 10 4f 93 d0         repz add $0xd0934f10,%eax 
Code;  d092e273 <__crc_journal_wipe+87214/38a2a0> 
   8:   eb a8                     jmp    ffffffb2 <_EIP+0xffffffb2> 
Code;  d092e275 <__crc_journal_wipe+87216/38a2a0> 
   a:   8b 44 24 0c               mov    0xc(%esp,1),%eax 
Code;  d092e279 <__crc_journal_wipe+8721a/38a2a0> 
   e:   89 5c 24 04               mov    %ebx,0x4(%esp,1) 
Code;  d092e27d <__crc_journal_wipe+8721e/38a2a0> 
  12:   89 04 00                  mov    %eax,(%eax,%eax,1) 
 
 
1 warning and 1 error issued.  Results may not be reliable. 
 
Steps to reproduce: 
boot up the system with a kernel compiled using the config reported below 
(bug is reproducible. i haven't tried a kernel without devfs support). 
 
# 
# Automatically generated make config: don't edit 
# 
CONFIG_X86=y 
CONFIG_MMU=y 
CONFIG_SWAP=y 
CONFIG_UID16=y 
CONFIG_GENERIC_ISA_DMA=y 
 
# 
# Code maturity level options 
# 
CONFIG_EXPERIMENTAL=y 
 
# 
# General setup 
# 
CONFIG_SYSVIPC=y 
CONFIG_BSD_PROCESS_ACCT=y 
CONFIG_SYSCTL=y 
CONFIG_LOG_BUF_SHIFT=14 
 
# 
# Loadable module support 
# 
CONFIG_MODULES=y 
CONFIG_MODULE_UNLOAD=y 
# CONFIG_MODULE_FORCE_UNLOAD is not set 
CONFIG_OBSOLETE_MODPARM=y 
CONFIG_MODVERSIONS=y 
CONFIG_KMOD=y 
 
# 
# Processor type and features 
# 
CONFIG_X86_PC=y 
# CONFIG_X86_VOYAGER is not set 
# CONFIG_X86_NUMAQ is not set 
# CONFIG_X86_SUMMIT is not set 
# CONFIG_X86_BIGSMP is not set 
# CONFIG_M386 is not set 
# CONFIG_M486 is not set 
# CONFIG_M586 is not set 
# CONFIG_M586TSC is not set 
# CONFIG_M586MMX is not set 
# CONFIG_M686 is not set 
# CONFIG_MPENTIUMII is not set 
# CONFIG_MPENTIUMIII is not set 
# CONFIG_MPENTIUM4 is not set 
# CONFIG_MK6 is not set 
CONFIG_MK7=y 
# CONFIG_MK8 is not set 
# CONFIG_MELAN is not set 
# CONFIG_MCRUSOE is not set 
# CONFIG_MWINCHIPC6 is not set 
# CONFIG_MWINCHIP2 is not set 
# CONFIG_MWINCHIP3D is not set 
# CONFIG_MCYRIXIII is not set 
CONFIG_X86_CMPXCHG=y 
CONFIG_X86_XADD=y 
CONFIG_X86_L1_CACHE_SHIFT=6 
CONFIG_RWSEM_XCHGADD_ALGORITHM=y 
CONFIG_X86_WP_WORKS_OK=y 
CONFIG_X86_INVLPG=y 
CONFIG_X86_BSWAP=y 
CONFIG_X86_POPAD_OK=y 
CONFIG_X86_TSC=y 
CONFIG_X86_GOOD_APIC=y 
CONFIG_X86_USE_PPRO_CHECKSUM=y 
CONFIG_X86_USE_3DNOW=y 
# CONFIG_HUGETLB_PAGE is not set 
# CONFIG_SMP is not set 
CONFIG_PREEMPT=y 
CONFIG_X86_UP_APIC=y 
CONFIG_X86_UP_IOAPIC=y 
CONFIG_X86_LOCAL_APIC=y 
CONFIG_X86_IO_APIC=y 
CONFIG_X86_MCE=y 
CONFIG_X86_MCE_NONFATAL=y 
# CONFIG_X86_MCE_P4THERMAL is not set 
# CONFIG_TOSHIBA is not set 
# CONFIG_I8K is not set 
# CONFIG_MICROCODE is not set 
# CONFIG_X86_MSR is not set 
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
CONFIG_PM=y 
CONFIG_SOFTWARE_SUSPEND=y 
 
# 
# ACPI Support 
# 
CONFIG_ACPI=y 
# CONFIG_ACPI_HT_ONLY is not set 
CONFIG_ACPI_BOOT=y 
# CONFIG_ACPI_SLEEP is not set 
CONFIG_ACPI_AC=y 
CONFIG_ACPI_BATTERY=y 
CONFIG_ACPI_BUTTON=y 
CONFIG_ACPI_FAN=y 
CONFIG_ACPI_PROCESSOR=y 
CONFIG_ACPI_THERMAL=y 
# CONFIG_ACPI_TOSHIBA is not set 
# CONFIG_ACPI_DEBUG is not set 
CONFIG_ACPI_BUS=y 
CONFIG_ACPI_INTERPRETER=y 
CONFIG_ACPI_EC=y 
CONFIG_ACPI_POWER=y 
CONFIG_ACPI_PCI=y 
CONFIG_ACPI_SYSTEM=y 
# CONFIG_APM is not set 
# CONFIG_CPU_FREQ is not set 
 
# 
# Bus options (PCI, PCMCIA, EISA, MCA, ISA) 
# 
CONFIG_PCI=y 
# CONFIG_PCI_GOBIOS is not set 
# CONFIG_PCI_GODIRECT is not set 
CONFIG_PCI_GOANY=y 
CONFIG_PCI_BIOS=y 
CONFIG_PCI_DIRECT=y 
# CONFIG_SCx200 is not set 
# CONFIG_PCI_LEGACY_PROC is not set 
CONFIG_PCI_NAMES=y 
# CONFIG_ISA is not set 
# CONFIG_MCA is not set 
CONFIG_HOTPLUG=y 
 
# 
# PCMCIA/CardBus support 
# 
# CONFIG_PCMCIA is not set 
 
# 
# PCI Hotplug Support 
# 
# CONFIG_HOTPLUG_PCI is not set 
 
# 
# Executable file formats 
# 
CONFIG_KCORE_ELF=y 
# CONFIG_KCORE_AOUT is not set 
CONFIG_BINFMT_AOUT=y 
CONFIG_BINFMT_ELF=y 
CONFIG_BINFMT_MISC=y 
 
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
CONFIG_PARPORT_SERIAL=m 
CONFIG_PARPORT_PC_FIFO=y 
CONFIG_PARPORT_PC_SUPERIO=y 
CONFIG_PARPORT_OTHER=y 
CONFIG_PARPORT_1284=y 
 
# 
# Plug and Play support 
# 
CONFIG_PNP=y 
CONFIG_PNP_NAMES=y 
CONFIG_PNP_CARD=y 
# CONFIG_PNP_DEBUG is not set 
 
# 
# Protocols 
# 
# CONFIG_ISAPNP is not set 
CONFIG_PNPBIOS=y 
 
# 
# Block devices 
# 
CONFIG_BLK_DEV_FD=m 
# CONFIG_PARIDE is not set 
# CONFIG_BLK_CPQ_DA is not set 
# CONFIG_BLK_CPQ_CISS_DA is not set 
# CONFIG_BLK_DEV_DAC960 is not set 
# CONFIG_BLK_DEV_UMEM is not set 
CONFIG_BLK_DEV_LOOP=m 
# CONFIG_BLK_DEV_NBD is not set 
# CONFIG_BLK_DEV_RAM is not set 
# CONFIG_LBD is not set 
 
# 
# ATA/ATAPI/MFM/RLL device support 
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
CONFIG_BLK_DEV_IDECD=y 
# CONFIG_BLK_DEV_IDEFLOPPY is not set 
CONFIG_BLK_DEV_IDESCSI=m 
# CONFIG_IDE_TASK_IOCTL is not set 
 
# 
# IDE chipset support/bugfixes 
# 
# CONFIG_BLK_DEV_CMD640 is not set 
CONFIG_BLK_DEV_IDEPCI=y 
# CONFIG_BLK_DEV_GENERIC is not set 
CONFIG_IDEPCI_SHARE_IRQ=y 
CONFIG_BLK_DEV_IDEDMA_PCI=y 
# CONFIG_BLK_DEV_IDE_TCQ is not set 
# CONFIG_BLK_DEV_OFFBOARD is not set 
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set 
CONFIG_IDEDMA_PCI_AUTO=y 
# CONFIG_IDEDMA_ONLYDISK is not set 
CONFIG_BLK_DEV_IDEDMA=y 
# CONFIG_IDEDMA_PCI_WIP is not set 
CONFIG_BLK_DEV_ADMA=y 
# CONFIG_BLK_DEV_AEC62XX is not set 
# CONFIG_BLK_DEV_ALI15X3 is not set 
# CONFIG_BLK_DEV_AMD74XX is not set 
# CONFIG_BLK_DEV_CMD64X is not set 
# CONFIG_BLK_DEV_TRIFLEX is not set 
# CONFIG_BLK_DEV_CY82C693 is not set 
# CONFIG_BLK_DEV_CS5520 is not set 
# CONFIG_BLK_DEV_HPT34X is not set 
# CONFIG_BLK_DEV_HPT366 is not set 
# CONFIG_BLK_DEV_SC1200 is not set 
CONFIG_BLK_DEV_PIIX=y 
# CONFIG_BLK_DEV_NS87415 is not set 
# CONFIG_BLK_DEV_OPTI621 is not set 
# CONFIG_BLK_DEV_PDC202XX_OLD is not set 
# CONFIG_BLK_DEV_PDC202XX_NEW is not set 
# CONFIG_BLK_DEV_RZ1000 is not set 
# CONFIG_BLK_DEV_SVWKS is not set 
# CONFIG_BLK_DEV_SIIMAGE is not set 
# CONFIG_BLK_DEV_SIS5513 is not set 
# CONFIG_BLK_DEV_SLC90E66 is not set 
# CONFIG_BLK_DEV_TRM290 is not set 
CONFIG_BLK_DEV_VIA82CXXX=y 
CONFIG_IDEDMA_AUTO=y 
# CONFIG_IDEDMA_IVB is not set 
CONFIG_BLK_DEV_IDE_MODES=y 
 
# 
# SCSI device support 
# 
CONFIG_SCSI=m 
 
# 
# SCSI support type (disk, tape, CD-ROM) 
# 
CONFIG_BLK_DEV_SD=m 
# CONFIG_CHR_DEV_ST is not set 
# CONFIG_CHR_DEV_OSST is not set 
CONFIG_BLK_DEV_SR=m 
# CONFIG_BLK_DEV_SR_VENDOR is not set 
CONFIG_CHR_DEV_SG=m 
 
# 
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs 
# 
CONFIG_SCSI_MULTI_LUN=y 
# CONFIG_SCSI_REPORT_LUNS is not set 
CONFIG_SCSI_CONSTANTS=y 
# CONFIG_SCSI_LOGGING is not set 
 
# 
# SCSI low-level drivers 
# 
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set 
# CONFIG_SCSI_ACARD is not set 
# CONFIG_SCSI_AACRAID is not set 
# CONFIG_SCSI_AIC7XXX is not set 
# CONFIG_SCSI_AIC7XXX_OLD is not set 
# CONFIG_SCSI_AIC79XX is not set 
# CONFIG_SCSI_DPT_I2O is not set 
# CONFIG_SCSI_ADVANSYS is not set 
# CONFIG_SCSI_IN2000 is not set 
# CONFIG_SCSI_AM53C974 is not set 
# CONFIG_SCSI_MEGARAID is not set 
# CONFIG_SCSI_BUSLOGIC is not set 
# CONFIG_SCSI_CPQFCTS is not set 
# CONFIG_SCSI_DMX3191D is not set 
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
# CONFIG_SCSI_NCR53C7xx is not set 
# CONFIG_SCSI_SYM53C8XX_2 is not set 
# CONFIG_SCSI_NCR53C8XX is not set 
# CONFIG_SCSI_SYM53C8XX is not set 
# CONFIG_SCSI_PCI2000 is not set 
# CONFIG_SCSI_PCI2220I is not set 
# CONFIG_SCSI_QLOGIC_ISP is not set 
# CONFIG_SCSI_QLOGIC_FC is not set 
# CONFIG_SCSI_QLOGIC_1280 is not set 
# CONFIG_SCSI_DC390T is not set 
# CONFIG_SCSI_U14_34F is not set 
# CONFIG_SCSI_NSP32 is not set 
# CONFIG_SCSI_DEBUG is not set 
 
# 
# Multi-device support (RAID and LVM) 
# 
# CONFIG_MD is not set 
 
# 
# Fusion MPT device support 
# 
# CONFIG_FUSION is not set 
 
# 
# IEEE 1394 (FireWire) support (EXPERIMENTAL) 
# 
# CONFIG_IEEE1394 is not set 
 
# 
# I2O device support 
# 
# CONFIG_I2O is not set 
 
# 
# Networking support 
# 
CONFIG_NET=y 
 
# 
# Networking options 
# 
CONFIG_PACKET=y 
# CONFIG_PACKET_MMAP is not set 
# CONFIG_NETLINK_DEV is not set 
CONFIG_NETFILTER=y 
# CONFIG_NETFILTER_DEBUG is not set 
# CONFIG_FILTER is not set 
CONFIG_UNIX=y 
# CONFIG_NET_KEY is not set 
CONFIG_INET=y 
CONFIG_IP_MULTICAST=y 
# CONFIG_IP_ADVANCED_ROUTER is not set 
# CONFIG_IP_PNP is not set 
# CONFIG_NET_IPIP is not set 
# CONFIG_NET_IPGRE is not set 
# CONFIG_IP_MROUTE is not set 
# CONFIG_ARPD is not set 
# CONFIG_INET_ECN is not set 
# CONFIG_SYN_COOKIES is not set 
# CONFIG_INET_AH is not set 
# CONFIG_INET_ESP is not set 
# CONFIG_XFRM_USER is not set 
 
# 
# IP: Netfilter Configuration 
# 
CONFIG_IP_NF_CONNTRACK=m 
CONFIG_IP_NF_FTP=m 
CONFIG_IP_NF_IRC=m 
CONFIG_IP_NF_QUEUE=m 
CONFIG_IP_NF_IPTABLES=m 
CONFIG_IP_NF_MATCH_LIMIT=m 
CONFIG_IP_NF_MATCH_MAC=m 
CONFIG_IP_NF_MATCH_PKTTYPE=m 
CONFIG_IP_NF_MATCH_MARK=m 
CONFIG_IP_NF_MATCH_MULTIPORT=m 
CONFIG_IP_NF_MATCH_TOS=m 
CONFIG_IP_NF_MATCH_ECN=m 
CONFIG_IP_NF_MATCH_DSCP=m 
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
CONFIG_IP_NF_NAT_LOCAL=y 
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
CONFIG_IP_NF_ARPTABLES=m 
CONFIG_IP_NF_ARPFILTER=m 
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set 
# CONFIG_IP_NF_COMPAT_IPFWADM is not set 
CONFIG_IPV6=m 
 
# 
# IPv6: Netfilter Configuration 
# 
CONFIG_IP6_NF_QUEUE=m 
CONFIG_IP6_NF_IPTABLES=m 
CONFIG_IP6_NF_MATCH_LIMIT=m 
CONFIG_IP6_NF_MATCH_MAC=m 
CONFIG_IP6_NF_MATCH_MULTIPORT=m 
CONFIG_IP6_NF_MATCH_OWNER=m 
CONFIG_IP6_NF_MATCH_MARK=m 
CONFIG_IP6_NF_MATCH_LENGTH=m 
CONFIG_IP6_NF_MATCH_EUI64=m 
CONFIG_IP6_NF_FILTER=m 
CONFIG_IP6_NF_TARGET_LOG=m 
CONFIG_IP6_NF_MANGLE=m 
CONFIG_IP6_NF_TARGET_MARK=m 
 
# 
# SCTP Configuration (EXPERIMENTAL) 
# 
CONFIG_IPV6_SCTP__=y 
# CONFIG_IP_SCTP is not set 
# CONFIG_ATM is not set 
# CONFIG_VLAN_8021Q is not set 
# CONFIG_LLC is not set 
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
# Network testing 
# 
# CONFIG_NET_PKTGEN is not set 
CONFIG_NETDEVICES=y 
 
# 
# ARCnet devices 
# 
# CONFIG_ARCNET is not set 
CONFIG_DUMMY=m 
# CONFIG_BONDING is not set 
# CONFIG_EQUALIZER is not set 
CONFIG_TUN=m 
CONFIG_ETHERTAP=m 
 
# 
# Ethernet (10 or 100Mbit) 
# 
CONFIG_NET_ETHERNET=y 
# CONFIG_MII is not set 
# CONFIG_HAPPYMEAL is not set 
# CONFIG_SUNGEM is not set 
# CONFIG_NET_VENDOR_3COM is not set 
 
# 
# Tulip family network device support 
# 
# CONFIG_NET_TULIP is not set 
# CONFIG_HP100 is not set 
CONFIG_NET_PCI=y 
# CONFIG_PCNET32 is not set 
# CONFIG_AMD8111_ETH is not set 
# CONFIG_ADAPTEC_STARFIRE is not set 
CONFIG_B44=m 
# CONFIG_DGRS is not set 
# CONFIG_EEPRO100 is not set 
# CONFIG_E100 is not set 
# CONFIG_FEALNX is not set 
# CONFIG_NATSEMI is not set 
# CONFIG_NE2K_PCI is not set 
CONFIG_8139CP=m 
CONFIG_8139TOO=m 
# CONFIG_8139TOO_PIO is not set 
# CONFIG_8139TOO_TUNE_TWISTER is not set 
# CONFIG_8139TOO_8129 is not set 
# CONFIG_8139_OLD_RX_RESET is not set 
# CONFIG_SIS900 is not set 
# CONFIG_EPIC100 is not set 
# CONFIG_SUNDANCE is not set 
# CONFIG_TLAN is not set 
# CONFIG_VIA_RHINE is not set 
 
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
# CONFIG_SK98LIN is not set 
# CONFIG_TIGON3 is not set 
# CONFIG_FDDI is not set 
# CONFIG_HIPPI is not set 
CONFIG_PLIP=m 
CONFIG_PPP=m 
CONFIG_PPP_MULTILINK=y 
CONFIG_PPP_ASYNC=m 
CONFIG_PPP_SYNC_TTY=m 
CONFIG_PPP_DEFLATE=m 
CONFIG_PPP_BSDCOMP=m 
CONFIG_PPPOE=m 
CONFIG_SLIP=m 
# CONFIG_SLIP_COMPRESSED is not set 
# CONFIG_SLIP_SMART is not set 
# CONFIG_SLIP_MODE_SLIP6 is not set 
 
# 
# Wireless LAN (non-hamradio) 
# 
# CONFIG_NET_RADIO is not set 
 
# 
# Token Ring devices (depends on LLC=y) 
# 
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
# CONFIG_INPUT_EVDEV is not set 
# CONFIG_INPUT_EVBUG is not set 
 
# 
# Input I/O drivers 
# 
# CONFIG_GAMEPORT is not set 
CONFIG_SOUND_GAMEPORT=y 
CONFIG_SERIO=y 
CONFIG_SERIO_I8042=y 
CONFIG_SERIO_SERPORT=y 
# CONFIG_SERIO_CT82C710 is not set 
# CONFIG_SERIO_PARKBD is not set 
 
# 
# Input Device Drivers 
# 
CONFIG_INPUT_KEYBOARD=y 
CONFIG_KEYBOARD_ATKBD=y 
# CONFIG_KEYBOARD_SUNKBD is not set 
# CONFIG_KEYBOARD_XTKBD is not set 
# CONFIG_KEYBOARD_NEWTON is not set 
CONFIG_INPUT_MOUSE=y 
CONFIG_MOUSE_PS2=y 
# CONFIG_MOUSE_SERIAL is not set 
# CONFIG_INPUT_JOYSTICK is not set 
# CONFIG_INPUT_TOUCHSCREEN is not set 
CONFIG_INPUT_MISC=y 
CONFIG_INPUT_PCSPKR=m 
CONFIG_INPUT_UINPUT=m 
 
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
# CONFIG_SERIAL_8250_CONSOLE is not set 
# CONFIG_SERIAL_8250_EXTENDED is not set 
 
# 
# Non-8250 serial port support 
# 
CONFIG_SERIAL_CORE=y 
CONFIG_UNIX98_PTYS=y 
CONFIG_UNIX98_PTY_COUNT=256 
CONFIG_PRINTER=m 
CONFIG_LP_CONSOLE=y 
CONFIG_PPDEV=m 
# CONFIG_TIPAR is not set 
 
# 
# I2C support 
# 
# CONFIG_I2C is not set 
 
# 
# I2C Hardware Sensors Mainboard support 
# 
 
# 
# I2C Hardware Sensors Chip support 
# 
 
# 
# Mice 
# 
# CONFIG_BUSMOUSE is not set 
# CONFIG_QIC02_TAPE is not set 
 
# 
# IPMI 
# 
# CONFIG_IPMI_HANDLER is not set 
 
# 
# Watchdog Cards 
# 
CONFIG_WATCHDOG=y 
# CONFIG_WATCHDOG_NOWAYOUT is not set 
# CONFIG_SOFT_WATCHDOG is not set 
# CONFIG_WDT is not set 
# CONFIG_WDTPCI is not set 
# CONFIG_PCWATCHDOG is not set 
# CONFIG_ACQUIRE_WDT is not set 
# CONFIG_ADVANTECH_WDT is not set 
# CONFIG_EUROTECH_WDT is not set 
# CONFIG_IB700_WDT is not set 
# CONFIG_I810_TCO is not set 
# CONFIG_MIXCOMWD is not set 
# CONFIG_SCx200_WDT is not set 
# CONFIG_60XX_WDT is not set 
# CONFIG_W83877F_WDT is not set 
# CONFIG_MACHZ_WDT is not set 
# CONFIG_SC520_WDT is not set 
# CONFIG_ALIM7101_WDT is not set 
# CONFIG_SC1200_WDT is not set 
# CONFIG_WAFER_WDT is not set 
# CONFIG_INTEL_RNG is not set 
# CONFIG_AMD_RNG is not set 
# CONFIG_NVRAM is not set 
# CONFIG_RTC is not set 
# CONFIG_GEN_RTC is not set 
# CONFIG_DTLK is not set 
# CONFIG_R3964 is not set 
# CONFIG_APPLICOM is not set 
# CONFIG_SONYPI is not set 
 
# 
# Ftape, the floppy tape device driver 
# 
# CONFIG_FTAPE is not set 
CONFIG_AGP=y 
CONFIG_AGP3=y 
# CONFIG_AGP_INTEL is not set 
CONFIG_AGP_VIA=y 
CONFIG_AGP_VIA_KT400=y 
# CONFIG_AGP_AMD is not set 
# CONFIG_AGP_SIS is not set 
# CONFIG_AGP_ALI is not set 
# CONFIG_AGP_SWORKS is not set 
# CONFIG_AGP_AMD_8151 is not set 
# CONFIG_AGP_I7505 is not set 
CONFIG_DRM=y 
# CONFIG_DRM_TDFX is not set 
# CONFIG_DRM_R128 is not set 
# CONFIG_DRM_RADEON is not set 
# CONFIG_DRM_I810 is not set 
# CONFIG_DRM_I830 is not set 
CONFIG_DRM_MGA=y 
# CONFIG_MWAVE is not set 
# CONFIG_RAW_DRIVER is not set 
# CONFIG_HANGCHECK_TIMER is not set 
 
# 
# Multimedia devices 
# 
# CONFIG_VIDEO_DEV is not set 
 
# 
# File systems 
# 
# CONFIG_QUOTA is not set 
# CONFIG_AUTOFS_FS is not set 
# CONFIG_AUTOFS4_FS is not set 
CONFIG_REISERFS_FS=y 
# CONFIG_REISERFS_CHECK is not set 
# CONFIG_REISERFS_PROC_INFO is not set 
# CONFIG_ADFS_FS is not set 
# CONFIG_AFFS_FS is not set 
# CONFIG_HFS_FS is not set 
# CONFIG_BEFS_FS is not set 
# CONFIG_BFS_FS is not set 
CONFIG_EXT3_FS=y 
# CONFIG_EXT3_FS_XATTR is not set 
CONFIG_JBD=y 
# CONFIG_JBD_DEBUG is not set 
CONFIG_FAT_FS=m 
CONFIG_MSDOS_FS=m 
CONFIG_VFAT_FS=m 
# CONFIG_EFS_FS is not set 
# CONFIG_CRAMFS is not set 
CONFIG_TMPFS=y 
CONFIG_RAMFS=y 
CONFIG_ISO9660_FS=m 
CONFIG_JOLIET=y 
CONFIG_ZISOFS=y 
# CONFIG_JFS_FS is not set 
# CONFIG_MINIX_FS is not set 
# CONFIG_VXFS_FS is not set 
# CONFIG_NTFS_FS is not set 
# CONFIG_HPFS_FS is not set 
CONFIG_PROC_FS=y 
CONFIG_DEVFS_FS=y 
CONFIG_DEVFS_MOUNT=y 
# CONFIG_DEVFS_DEBUG is not set 
CONFIG_DEVPTS_FS=y 
# CONFIG_QNX4FS_FS is not set 
# CONFIG_ROMFS_FS is not set 
CONFIG_EXT2_FS=y 
# CONFIG_EXT2_FS_XATTR is not set 
# CONFIG_SYSV_FS is not set 
CONFIG_UDF_FS=m 
# CONFIG_UFS_FS is not set 
# CONFIG_XFS_FS is not set 
 
# 
# Network File Systems 
# 
CONFIG_CODA_FS=m 
CONFIG_INTERMEZZO_FS=m 
CONFIG_NFS_FS=y 
# CONFIG_NFS_V3 is not set 
# CONFIG_NFS_V4 is not set 
CONFIG_NFSD=y 
# CONFIG_NFSD_V3 is not set 
# CONFIG_NFSD_TCP is not set 
CONFIG_SUNRPC=y 
CONFIG_SUNRPC_GSS=m 
CONFIG_LOCKD=y 
CONFIG_EXPORTFS=y 
CONFIG_CIFS=m 
CONFIG_SMB_FS=m 
# CONFIG_SMB_NLS_DEFAULT is not set 
CONFIG_NCP_FS=m 
# CONFIG_NCPFS_PACKET_SIGNING is not set 
# CONFIG_NCPFS_IOCTL_LOCKING is not set 
# CONFIG_NCPFS_STRONG is not set 
# CONFIG_NCPFS_NFS_NS is not set 
# CONFIG_NCPFS_OS2_NS is not set 
# CONFIG_NCPFS_SMALLDOS is not set 
# CONFIG_NCPFS_NLS is not set 
# CONFIG_NCPFS_EXTRAS is not set 
CONFIG_AFS_FS=m 
CONFIG_RXRPC=m 
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
# Graphics support 
# 
# CONFIG_FB is not set 
CONFIG_VIDEO_SELECT=y 
 
# 
# Console display driver support 
# 
CONFIG_VGA_CONSOLE=y 
# CONFIG_MDA_CONSOLE is not set 
CONFIG_DUMMY_CONSOLE=y 
 
# 
# Sound 
# 
CONFIG_SOUND=y 
 
# 
# Advanced Linux Sound Architecture 
# 
CONFIG_SND=m 
CONFIG_SND_SEQUENCER=m 
CONFIG_SND_SEQ_DUMMY=m 
CONFIG_SND_OSSEMUL=y 
CONFIG_SND_MIXER_OSS=m 
CONFIG_SND_PCM_OSS=m 
CONFIG_SND_SEQUENCER_OSS=y 
CONFIG_SND_VERBOSE_PRINTK=y 
CONFIG_SND_DEBUG=y 
CONFIG_SND_DEBUG_MEMORY=y 
CONFIG_SND_DEBUG_DETECT=y 
 
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
CONFIG_SND_VIA82XX=m 
 
# 
# ALSA USB devices 
# 
# CONFIG_SND_USB_AUDIO is not set 
 
# 
# Open Sound System 
# 
# CONFIG_SOUND_PRIME is not set 
 
# 
# USB support 
# 
CONFIG_USB=m 
# CONFIG_USB_DEBUG is not set 
 
# 
# Miscellaneous USB options 
# 
CONFIG_USB_DEVICEFS=y 
CONFIG_USB_BANDWIDTH=y 
# CONFIG_USB_DYNAMIC_MINORS is not set 
 
# 
# USB Host Controller Drivers 
# 
CONFIG_USB_EHCI_HCD=m 
# CONFIG_USB_OHCI_HCD is not set 
CONFIG_USB_UHCI_HCD=m 
 
# 
# USB Device Class drivers 
# 
CONFIG_USB_AUDIO=m 
CONFIG_USB_BLUETOOTH_TTY=m 
CONFIG_USB_MIDI=m 
CONFIG_USB_ACM=m 
CONFIG_USB_PRINTER=m 
CONFIG_USB_STORAGE=m 
CONFIG_USB_STORAGE_DEBUG=y 
CONFIG_USB_STORAGE_DATAFAB=y 
CONFIG_USB_STORAGE_FREECOM=y 
CONFIG_USB_STORAGE_ISD200=y 
CONFIG_USB_STORAGE_DPCM=y 
CONFIG_USB_STORAGE_HP8200e=y 
CONFIG_USB_STORAGE_SDDR09=y 
CONFIG_USB_STORAGE_SDDR55=y 
CONFIG_USB_STORAGE_JUMPSHOT=y 
 
# 
# USB Human Interface Devices (HID) 
# 
CONFIG_USB_HID=m 
CONFIG_USB_HIDINPUT=y 
CONFIG_HID_FF=y 
CONFIG_HID_PID=y 
CONFIG_LOGITECH_FF=y 
CONFIG_USB_HIDDEV=y 
 
# 
# USB HID Boot Protocol drivers 
# 
# CONFIG_USB_KBD is not set 
# CONFIG_USB_MOUSE is not set 
CONFIG_USB_AIPTEK=m 
CONFIG_USB_WACOM=m 
CONFIG_USB_POWERMATE=m 
CONFIG_USB_XPAD=m 
 
# 
# USB Imaging devices 
# 
CONFIG_USB_MDC800=m 
CONFIG_USB_SCANNER=m 
CONFIG_USB_MICROTEK=m 
CONFIG_USB_HPUSBSCSI=m 
 
# 
# USB Multimedia devices 
# 
CONFIG_USB_DABUSB=m 
 
# 
# Video4Linux support is needed for USB Multimedia device support 
# 
 
# 
# USB Network adaptors 
# 
CONFIG_USB_CATC=m 
CONFIG_USB_CDCETHER=m 
CONFIG_USB_KAWETH=m 
CONFIG_USB_PEGASUS=m 
CONFIG_USB_RTL8150=m 
CONFIG_USB_USBNET=m 
 
# 
# USB port drivers 
# 
CONFIG_USB_USS720=m 
 
# 
# USB Serial Converter support 
# 
CONFIG_USB_SERIAL=m 
CONFIG_USB_SERIAL_GENERIC=y 
CONFIG_USB_SERIAL_BELKIN=m 
CONFIG_USB_SERIAL_WHITEHEAT=m 
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m 
CONFIG_USB_SERIAL_EMPEG=m 
CONFIG_USB_SERIAL_FTDI_SIO=m 
CONFIG_USB_SERIAL_VISOR=m 
CONFIG_USB_SERIAL_IPAQ=m 
CONFIG_USB_SERIAL_IR=m 
CONFIG_USB_SERIAL_EDGEPORT=m 
CONFIG_USB_SERIAL_EDGEPORT_TI=m 
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set 
# CONFIG_USB_SERIAL_KEYSPAN is not set 
CONFIG_USB_SERIAL_KLSI=m 
CONFIG_USB_SERIAL_KOBIL_SCT=m 
CONFIG_USB_SERIAL_MCT_U232=m 
CONFIG_USB_SERIAL_PL2303=m 
# CONFIG_USB_SERIAL_SAFE is not set 
CONFIG_USB_SERIAL_CYBERJACK=m 
CONFIG_USB_SERIAL_XIRCOM=m 
CONFIG_USB_SERIAL_OMNINET=m 
CONFIG_USB_EZUSB=y 
 
# 
# USB Miscellaneous drivers 
# 
CONFIG_USB_EMI26=m 
CONFIG_USB_TIGL=m 
CONFIG_USB_AUERSWALD=m 
CONFIG_USB_RIO500=m 
CONFIG_USB_BRLVGER=m 
CONFIG_USB_LCD=m 
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
CONFIG_DEBUG_KERNEL=y 
CONFIG_DEBUG_STACKOVERFLOW=y 
CONFIG_DEBUG_SLAB=y 
# CONFIG_DEBUG_IOVIRT is not set 
CONFIG_MAGIC_SYSRQ=y 
# CONFIG_DEBUG_SPINLOCK is not set 
CONFIG_KALLSYMS=y 
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set 
CONFIG_FRAME_POINTER=y 
CONFIG_X86_EXTRA_IRQS=y 
CONFIG_X86_FIND_SMP_CONFIG=y 
CONFIG_X86_MPPARSE=y 
 
# 
# Security options 
# 
# CONFIG_SECURITY is not set 
 
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
CONFIG_X86_BIOS_REBOOT=y


