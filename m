Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUALMmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUALMl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:41:59 -0500
Received: from mail.netbeat.de ([193.254.185.26]:11160 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S266162AbUALMkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:40:37 -0500
Subject: Re: 2.6.1-mm2: BUG in kswapd?
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: maneesh@in.ibm.com
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040112120038.GE1404@in.ibm.com>
References: <1073842387.3720.5.camel@JHome.uni-bonn.de>
	 <20040112120038.GE1404@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-p5sL3fm2v4jElTMlyQkI"
Message-Id: <1073911233.4742.20.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 13:40:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p5sL3fm2v4jElTMlyQkI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Maneesh,

I've tried here my fstab:

/dev/hda3       /               ext3   defaults,errors=remount-ro  0  1
/dev/hda8       none            swap    sw                         0  0
/dev/hda9       none            swap    sw                         0  0
/dev/hda6       /home           ext3    defaults,errors=remount-ro
/dev/hda2       /dos            ntfs    defaults
/dev/hda5       /dos2           vfat    defaults,user
/dev/hda7       /dos3           vfat    defaults,user
proc            /proc           proc    defaults              0      0
sysfs           /sys            sysfs
/dev/fd0        /floppy         auto    defaults,user,noauto  0     0
/dev/cdrom  /cdrom      iso9660 defaults,utf8,ro,user,noauto           
/dev/cdroms/cdrom1  /cdrw       iso9660 defaults,utf8,ro,user,noauto

The .config, a list of loaded modules, lspci and a 2.6.1-mm2 dmesg
output are attached. 

As you see from the dmesg, there are some other problems too, like
AGPGART, ATKBD and USB sometimes reconnecting devices (USB Mouse), but I
don't think that they are related with the above bug.

If you need more stuff, or want to test a patch, please tell me.

Jan


Am Mo, den 12.01.2004 schrieb Maneesh Soni um 13:00:
> On Sun, Jan 11, 2004 at 08:13:40PM +0000, Jan Ischebeck wrote:
> > Hi Andrew,
> > 
> > After 24 hours running 2.6.1-mm2 I got the following BUG in kswapd:
> > 
> > Jan 11 06:27:41 JHome kernel: ------------[ cut here ]------------
> > Jan 11 06:27:41 JHome kernel: kernel BUG at include/linux/list.h:148!
> > Jan 11 06:27:41 JHome kernel: invalid operand: 0000 [#1]
> > Jan 11 06:27:41 JHome kernel: PREEMPT 
> > Jan 11 06:27:41 JHome kernel: CPU:    0
> > Jan 11 06:27:41 JHome kernel: EIP:    0060:[<c016fc36>]    Tainted: GF  VLI
> > Jan 11 06:27:41 JHome kernel: EFLAGS: 00010206
> > Jan 11 06:27:41 JHome kernel: EIP is at prune_dcache+0x1d6/0x1f0
> > Jan 11 06:27:41 JHome kernel: eax: 00000000   ebx: dc3b06c0   ecx: dc3b06d4   edx: dca6585c
> > Jan 11 06:27:41 JHome kernel: esi: dc3b0730   edi: dfdd8000   ebp: 00000067   esp: dfdd9e7c
> > Jan 11 06:27:41 JHome kernel: ds: 007b   es: 007b   ss: 0068
> > Jan 11 06:27:41 JHome kernel: Process kswapd0 (pid: 8, threadinfo=dfdd8000 task=dfddece0)
> > Jan 11 06:27:41 JHome kernel: Stack: df683cc0 00000000 00000080 dfdd8000 000001ac dffeeb60 c01700f3 00000080 
> > Jan 11 06:27:41 JHome kernel: c0146dde 00000080 000000d0 000159b5 07a9b6c8 00000000 000005ac 00000000 
> > Jan 11 06:27:41 JHome kernel: 00000162 c034d674 00000001 ffffff4f c01481b2 00000162 000000d0 000000d0 
> > Jan 11 06:27:41 JHome kernel: Call Trace:
> > Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
> > Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
> > Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
> > Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
> > Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
> > Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
> > Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
> > Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
> > Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
> > Jan 11 06:27:41 JHome kernel: 
> 
> Hi Jan,
> 
> I guess you are getting this without tainters also.
> Can you give some more details like .config, what filesystems
> you have etc. 
> 
> Thanks
> Maneesh
-- 
Jan Ischebeck <mail@jan-ischebeck.de>

--=-p5sL3fm2v4jElTMlyQkI
Content-Disposition: attachment; filename=.config
Content-Type: text/plain; name=.config; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
# CONFIG_STANDALONE is not set
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
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
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
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
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda8"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
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
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

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
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_MAX_SD_DISKS=256
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_VIA=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_IOCTL_V4=y

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

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
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
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
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

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
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_PCI_HERMES is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

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
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=m
# CONFIG_ISDN_NET_SIMPLE is not set
# CONFIG_ISDN_NET_CISCO is not set
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
# CONFIG_ISDN_DRV_LOOP is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
# CONFIG_ISDN_DRV_AVMB1_B1ISA is not set
# CONFIG_ISDN_DRV_AVMB1_B1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_T1ISA is not set
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set
# CONFIG_ISDN_DRV_AVMB1_T1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_C4 is not set

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
# CONFIG_HISAX_16_0 is not set
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_AVM_A1 is not set
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_ASUSCOM is not set
# CONFIG_HISAX_TELEINT is not set
# CONFIG_HISAX_HFCS is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_SPORTSTER is not set
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_ISURF is not set
# CONFIG_HISAX_HSTSAPHIR is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
# CONFIG_HISAX_DEBUG is not set
# CONFIG_HISAX_ST5481 is not set
CONFIG_HISAX_FRITZ_PCIPNP=m
# CONFIG_HISAX_FRITZ_CLASSIC is not set
# CONFIG_HISAX_HFCPCI is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_HYSDN is not set

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
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=y

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
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m

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
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_ALI=m
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
CONFIG_MWAVE=m
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

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
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_ALI5451=m
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
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
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
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
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
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

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--=-p5sL3fm2v4jElTMlyQkI
Content-Disposition: attachment; filename=modlist
Content-Type: text/plain; name=modlist; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
sr_mod                 17252  0 
ipt_TOS                 2368  22 
ipt_limit               2368  1 
ipt_MASQUERADE          3712  2 
ip_nat_irc              4208  0 
ip_conntrack_irc       71284  1 ip_nat_irc
ipt_state               1856  3 
ipt_LOG                 5696  7 
ipt_REJECT              6720  8 
snd_seq_oss            37056  0 
snd_seq_midi_event      7936  1 snd_seq_oss
snd_seq                61968  4 snd_seq_oss,snd_seq_midi_event
ppp_deflate             6144  0 
zlib_deflate           22168  1 ppp_deflate
zlib_inflate           22336  1 ppp_deflate
bsd_comp                5952  0 
snd_pcm_oss            62948  0 
snd_intel8x0           32196  1 
snd_ac97_codec         63620  1 snd_intel8x0
snd_pcm               110884  2 snd_pcm_oss,snd_intel8x0
snd_timer              27908  2 snd_seq,snd_pcm
snd_page_alloc         12548  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         8064  1 snd_intel8x0
snd_rawmidi            26656  1 snd_mpu401_uart
snd_seq_device          8584  3 snd_seq_oss,snd_seq,snd_rawmidi
ppp_async              12224  1 
md5                     4096  1 
ipv6                  251840  13 
ppp_generic            27280  7 ppp_deflate,bsd_comp,ppp_async
iptable_nat            23148  3 ipt_MASQUERADE,ip_nat_irc
ip_conntrack           32624  5 ipt_MASQUERADE,ip_nat_irc,ip_conntrack_irc,ipt_state,iptable_nat
iptable_mangle          2752  1 
iptable_filter          2752  1 
ip_tables              17984  9 ipt_TOS,ipt_limit,ipt_MASQUERADE,ipt_state,ipt_LOG,ipt_REJECT,iptable_nat,iptable_mangle,iptable_filter
snd_mixer_oss          21440  2 snd_pcm_oss
snd                    61988  12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_mixer_oss
binfmt_misc            10440  1 
uhci_hcd               32908  0 
ehci_hcd               35780  0 
parport_pc             34284  1 
lp                     10436  0 
parport                28832  2 parport_pc,lp
nls_cp437               5632  2 
nls_iso8859_1           3968  3 
ntfs                   91084  1 
sd_mod                 14048  0 
dm_mod                 40480  0 
video1394              18048  0 
ohci1394               36036  1 video1394
sbp2                   24520  0 
scsi_mod              112056  3 sr_mod,sd_mod,sbp2
ieee1394               82540  3 video1394,ohci1394,sbp2
it87                   23304  0 
eeprom                  7240  0 
i2c_sensor              2944  2 it87,eeprom
i2c_isa                 1920  0 
mga                   115712  0 
capidrv                31828  0 
isdn                  217760  1 capidrv
slhc                    7808  2 ppp_generic,isdn
capi                   19008  0 
capifs                  6472  1 capi
kernelcapi             46560  2 capidrv,capi
sis900                 19972  0 
vfat                   15680  2 
fat                    46720  1 vfat

--=-p5sL3fm2v4jElTMlyQkI
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
00:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
00:0f.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
00:11.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
00:13.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:13.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:13.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

--=-p5sL3fm2v4jElTMlyQkI
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

RQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured

DoubleTalk PC - not found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
hdb: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
request_module: failed /sbin/modprobe -- char-major-29-0. error = 256
Adding 2097136k swap on /dev/hda8.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
sis900.c: v1.08.07 11/02/2003
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 10, 00:0a:e6:82:80:1d.
CAPI Subsystem Rev 1.21.6.8
capifs: Rev 1.14.6.8
capi20: Rev 1.1.4.1.2.2: started up with major 68 (middleware+capifs)
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem initialized
capi20_register: 
kcapi: appl 1 up
capidrv: Rev 1.39.6.7: loaded
[drm:mga_probe] *ERROR* Cannot initialize the agpgart module.
registering 0-0290
SCSI subsystem initialized
sbp2: $Rev: 1082 $ Ben Collins <bcollins@debian.org>
ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[cfffc800-cfffcfff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0050625600010705]
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
eth0: Media Link On 100mbps full-duplex 
cdrom: open failed.
request_module: failed /sbin/modprobe -- block-major-22-0. error = 256
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.5 [Flags: R/O MODULE].
NTFS volume version 3.0.
request_module: failed /sbin/modprobe -- char-major-29-0. error = 256
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
lp0: console ready
ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: reset hcs_params 0x2204 dbg=0 cc=2 pcc=2 ordered !ppc ports=4
ehci_hcd 0000:00:13.2: reset hcc_params 0002 thresh 0 uframes 256/512/1024
ehci_hcd 0000:00:13.2: irq 10, pci mem e0951600
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:13.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
ehci_hcd 0000:00:13.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.1-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:13.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 0ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:13.0: UHCI Host Controller
uhci_hcd 0000:00:13.0: irq 11, io base 0000c800
uhci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:13.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.1-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:13.0
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
uhci_hcd 0000:00:13.1: UHCI Host Controller
ehci_hcd 0000:00:13.2: GetStatus port 1 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 1, status 501, change 1, 480 Mb/s
uhci_hcd 0000:00:13.1: irq 11, io base 0000cc00
uhci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:13.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.1-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:13.1
drivers/usb/core/usb.c: usb_hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:13.2: port 1 full speed --> companion
ehci_hcd 0000:00:13.2: GetStatus port 1 status 003801 POWER OWNER sig=j  CONNECT
hub 2-0:1.0: port 1, status 101, change 3, 12 Mb/s
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:1.0: new USB device on port 1, assigned address 2
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: registering 2-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-1:1.0: usb_probe_interface
hub 2-1:1.0: usb_probe_interface - got id
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
hub 2-1:1.0: standalone hub
hub 2-1:1.0: individual port power switching
hub 2-1:1.0: individual port over-current protection
hub 2-1:1.0: Port indicators are not supported
hub 2-1:1.0: power on to power good time: 500ms
hub 2-1:1.0: hub controller current requirement: 100mA
hub 2-1:1.0: local power source is good
hub 2-1:1.0: no over-current condition exists
hub 2-1:1.0: enabling power on all ports
hub 2-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 2-1:1.0: port 2, status 301, change 1, 1.5 Mb/s
hub 2-1:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-1:1.0: new USB device on port 2, assigned address 3
usb 2-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 2-1.2: Product: PS2/USB Browser Combo Mouse
usb 2-1.2: Manufacturer: Cypress Sem
drivers/usb/core/usb.c: usb_hotplug
usb 2-1.2: registering 2-1.2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hid 2-1.2:1.0: usb_probe_interface
hid 2-1.2:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Cypress Sem PS2/USB Browser Combo Mouse] on usb-0000:00:13.0-1.2
hub 2-0:1.0: port 2 enable change, status 100
hub 3-0:1.0: port 1, status 300, change 3, 1.5 Mb/s
hub 3-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 3-0:1.0: port 1 enable change, status 300
hub 3-0:1.0: port 2 enable change, status 100
drivers/usb/host/uhci-hcd.c: cc00: suspend_hc
request_module: failed /sbin/modprobe -- char-major-29-0. error = 256
request_module: failed /sbin/modprobe -- block-major-22-0. error = 256
request_module: failed /sbin/modprobe -- char-major-29-0. error = 256
request_module: failed /sbin/modprobe -- sound-slot-0. error = 256
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
PPP generic driver version 2.4.2
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0383ac0(lo)
IPv6 over IPv4 tunneling driver
intel8x0_measure_ac97_clock: measured 49981 usecs
intel8x0: clocking to 48000
ALSA sound/pci/intel8x0.c:2695: joystick(s) found
PPP BSD Compression module registered
PPP Deflate Compression module registered
request_module: failed /sbin/modprobe -- snd-card-1. error = 256
eth0: no IPv6 routers present
request_module: failed /sbin/modprobe -- isdneftd. error = 256
request_module: failed /sbin/modprobe -- char-major-10-134. error = 256
request_module: failed /sbin/modprobe -- char-major-226-0. error = 256
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
hub 2-1:1.0: port 2 enable change, status 301
hub 2-1:1.0: port 2 disabled by hub (EMI?), re-enabling...<7>hub 2-1:1.0: port 2, status 301, change 2, 1.5 Mb/s
usb 2-1.2: USB disconnect, address 3
usb 2-1.2: usb_disable_device nuking all URBs
uhci_hcd 0000:00:13.0: shutdown urb df6eff40 pipe 40408380 ep1in-intr
usb 2-1.2: unregistering interface 2-1.2:1.0
usb 2-1.2: hcd_unlink_urb df6eff40 fail -16
usb 2-1.2: hcd_unlink_urb df6efec0 fail -22
usb 2-1.2: hcd_unlink_urb df6eff40 fail -16
drivers/usb/core/usb.c: usb_hotplug
usb 2-1.2: unregistering device
drivers/usb/core/usb.c: usb_hotplug
hub 2-1:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-1:1.0: new USB device on port 2, assigned address 4
usb 2-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 4 default language ID 0x409
usb 2-1.2: Product: PS2/USB Browser Combo Mouse
usb 2-1.2: Manufacturer: Cypress Sem
drivers/usb/core/usb.c: usb_hotplug
usb 2-1.2: registering 2-1.2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hid 2-1.2:1.0: usb_probe_interface
hid 2-1.2:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Cypress Sem PS2/USB Browser Combo Mouse] on usb-0000:00:13.0-1.2
request_module: failed /sbin/modprobe -- block-major-11-1. error = 256
cdrom: This disc doesn't have any tracks I recognize!
request_module: failed /sbin/modprobe -- block-major-11-1. error = 256
cdrom: This disc doesn't have any tracks I recognize!
request_module: failed /sbin/modprobe -- char-major-10-134. error = 256
request_module: failed /sbin/modprobe -- block-major-11-1. error = 256
cdrom: This disc doesn't have any tracks I recognize!
request_module: failed /sbin/modprobe -- char-major-10-134. error = 256
request_module: failed /sbin/modprobe -- char-major-226-0. error = 256
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
request_module: failed /sbin/modprobe -- block-major-11-1. error = 256
cdrom: This disc doesn't have any tracks I recognize!
request_module: failed /sbin/modprobe -- char-major-10-134. error = 256

--=-p5sL3fm2v4jElTMlyQkI--

