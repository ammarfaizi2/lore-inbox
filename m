Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbUKEN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUKEN4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbUKEN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:56:08 -0500
Received: from [195.56.65.174] ([195.56.65.174]:43524 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S262692AbUKENtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:49:14 -0500
Subject: Re: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-SAFI4qvwaBBSH6ghgcDP"
Message-Id: <1099662531.28536.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 05 Nov 2004 14:48:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SAFI4qvwaBBSH6ghgcDP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


 hard to hit, but not impossible. :(  this time I've got oops:
http://innocence.nightwish.hu/dap/OopsOnFind-2.4.10rc1.jpg

 .config and dmesg attached. I've used a 3rd party module from
highpoint-tech.com for my hpt1820 card, but this driver's rock stable
under any other kernel

 the workload quite complex, slapd, mysql, proftpd (no sendfile
support), apache2 (with sendfile), all of them hardly used, and
sometimes the 'find' that could made the kernel crash.
 I'm using 2.6.9 now, I want to see that it's really stable and the bug
was introduced in the -rc1 patch as I think. if this crashing too, I'll
write immediately


EverDream:~# lsmod
Module                  Size  Used by
ipv6                  239072  525 
ipt_TOS                 2880  1 
ipt_LOG                 7104  1 
iptable_mangle          3040  1 
tun                     7424  1 
uhci_hcd               30832  0 
ohci_hcd               19812  0 
ehci_hcd               27684  0 
usbcore               105380  3 uhci_hcd,ohci_hcd,ehci_hcd
intel_agp              20544  1 
agpgart                29580  1 intel_agp
quota_v1                4032  3 
xfs                   585884  2 
sata_promise            8356  2 
hptmv                 215848  40 
w83627hf               29480  0 
i2c_sensor              3936  1 w83627hf
i2c_isa                 2624  0 
i2c_i801                8044  0 
iptable_filter          3104  1 
ip_tables              16992  4
ipt_TOS,ipt_LOG,iptable_mangle,iptable_filter
softdog                 5456  1 

EverDream:~# cat /proc/mdstat 
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] 
md7 : active raid5 sdai1[0] sdap1[6] sdan1[5] sdam1[4] sdak1[2] sdaj1[1]
      1194849792 blocks level 5, 32k chunk, algorithm 2 [7/6] [UUU_UUU]
      
md6 : active raid5 sdx1[0] sdah1[10] sdag1[9] sdaf1[8] sdae1[7] sdad1[6] sdac1[5] sdab1[4] sdaa1[3] sdz1[2] sdy1[1]
      1991416320 blocks level 5, 32k chunk, algorithm 2 [11/11] [UUUUUUUUUUU]
      
md1 : active raid5 sdq1[0] sdm1[13] sdb1[12] sdp1[11] sdo1[10] sdn1[9] sdi1[8] sdl1[7] sdk1[6] sdv1[5] sdu1[4] sdt1[3] sds1[2] sdw1[1]
      2031747328 blocks level 5, 64k chunk, algorithm 2 [14/14] [UUUUUUUUUUUUUU]
      [>....................]  resync =  3.7% (5832192/156288256) finish=2384.5min speed=1048K/sec
md2 : active raid1 hdc1[1] hda1[0]
      976640 blocks [2/2] [UU]
      
md4 : active raid1 hdc2[1] hda2[0]
      1951808 blocks [2/2] [UU]
      
md0 : active raid5 sde1[0] sdc1[10] sda1[9] sdar1[8] sdh1[7] sdaq1[6] hdb1[5] sdg1[4] sdj1[3] hdd1[2] sdf1[1]
      1200536320 blocks level 5, 128k chunk, algorithm 2 [11/11] [UUUUUUUUUUU]
      [==>..................]  resync = 12.3% (14782080/120053632) finish=847.7min speed=2067K/sec
unused devices: <none>


---

 I also can't reproduce it under another box, so I compiled the -rc1
kernel again with same config and I'm trying to crash the produtive
server with that, but seems like I can't.
 I'm confused, maybe this problem was caused by some kind of compile
problem due to memory error, maybe just the ftp workload changed and
it's a hard to hit bug, don't know.. anyway, I use the -rc1 by now and
I'll report if this happened again.. sorry for the early report


On Sun, 2004-10-31 at 11:57, Alexander Nyberg wrote:
> .config & dmesg please, I can't seem to be able to reproduce this under
> me own environment. Also a little more description of how the setup
> looks like would be nice, I've only gathered one or more raid5 arrays
> with xfs and ext3 involved.



-- 
dap

--=-SAFI4qvwaBBSH6ghgcDP
Content-Disposition: attachment; filename=.config
Content-Type: text/plain; name=.config; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc1
# Sun Oct 31 12:41:31 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=16
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
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
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BLACKLIST_YEAR=0

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

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
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=y
CONFIG_BLK_CPQ_CISS_DA=m
# CONFIG_CISS_SCSI_TAPE is not set
CONFIG_BLK_DEV_DAC960=m
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
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
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
CONFIG_SCSI_SATA_NV=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIS=m
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=y
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
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
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=m
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_CTL=m

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
# CONFIG_I2O_CONFIG is not set
CONFIG_I2O_BLOCK=m
# CONFIG_I2O_SCSI is not set
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=y

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
# CONFIG_IP_VS_PROTO_UDP is not set
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
# CONFIG_IP_VS_FTP is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_RAW is not set
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
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_AHESP is not set
# CONFIG_IP6_NF_MATCH_LENGTH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_IP6_NF_RAW is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
# CONFIG_BT_SCO is not set
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set
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
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
CONFIG_EPIC100=y
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
CONFIG_WAN=y
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_DSCC4 is not set
# CONFIG_LANMEDIA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_SBNI is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

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
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
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
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
# CONFIG_SND_SB16_CSP is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

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
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
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
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_GRKERNSEC_PROC_USER=y
CONFIG_GRKERNSEC_PROC_USERGROUP=y
CONFIG_GRKERNSEC_PROC_GID=4
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
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
CONFIG_NLS_DEFAULT="cp852"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
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
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
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
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--=-SAFI4qvwaBBSH6ghgcDP
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Linux version 2.6.9 (dap@dap) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)) #1 SMP Sat Oct 30 17:57:05 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32560 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e30
ACPI: RSDT (v001 A M I  OEMRSDT  0x11000321 MSFT 0x00000097) @ 0x3ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x11000321 MSFT 0x00000097) @ 0x3ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x11000321 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x11000321 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4CED P4CED096 0x00000096 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTek  Product ID:  APIC at: 0xFEE00000
I/O APIC #1 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=l26 ro root=902 3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2399.979 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032848k/1047744k available (2587k kernel code, 14316k reserved, 1088k data, 220k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS (lpj=2367488)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.99 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (4734.97 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I1,P0) -> 18
PCI->APIC IRQ transform: (B3,I4,P0) -> 23
PCI->APIC IRQ transform: (B3,I9,P0) -> 21
PCI->APIC IRQ transform: (B3,I10,P0) -> 22
PCI->APIC IRQ transform: (B3,I11,P0) -> 23
PCI->APIC IRQ transform: (B3,I12,P0) -> 20
PCI->APIC IRQ transform: (B3,I13,P0) -> 21
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.6.0)
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: Maxtor 6Y120L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y120L0, ATA DISK drive
hdd: Maxtor 6Y120L0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdb: max request size: 128KiB
hdb: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: max request size: 128KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4
hdd: max request size: 128KiB
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hdd: cache flushes supported
 hdd: hdd1
Red Hat/Adaptec aacraid driver (1.1.2-lk2 Oct 30 2004)
3ware Storage Controller device driver for Linux v1.26.00.039.
3w-xxxx: No cards found.
libata version 1.02 loaded.
ata_piix version 1.02
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF90 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF98 irq 18
ata1: dev 0 cfg 49:2f00 82:74eb 83:5bea 84:4000 85:7469 86:1802 87:4003 88:003f
ata1: dev 0 ATA, max UDMA/100, 241254720 sectors:
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:003f
ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : ata_piix
  Vendor: ATA       Model: IC35L120AVVA07-0  Rev: VA6O
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SV1604N   Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3096.000 MB/sec
raid5: using function: pIII_sse (3096.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdc2 ...
md:  adding hdc2 ...
md: hdc1 has different UUID to hdc2
md:  adding hda2 ...
md: hda1 has different UUID to hdc2
md: created md4
md: bind<hda2>
md: bind<hdc2>
md: running: <hdc2><hda2>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md2
md: bind<hda1>
md: bind<hdc1>
md: running: <hdc1><hda1>
raid1: raid set md2 active with 2 out of 2 mirrors
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding 249976k swap on /dev/hdc3.  Priority:-1 extents:1
EXT3 FS on md2, internal journal
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
ip_tables: (C) 2000-2002 Netfilter core team
hptmv: module license 'Proprietary' taints kernel.
RocketRAID 182x SATA Controller driver
Version 1.11, Compiled Oct 30 2004 18:27:35
RR182x [0]: start channel (0)
RR182x [0,0]: channel started successfully
RR182x [0]: start channel (1)
RR182x [0,1]: channel started successfully
RR182x [0]: start channel (2)
RR182x [0,2]: channel started successfully
RR182x [0]: start channel (3)
RR182x [0,3]: channel started successfully
RR182x [0]: start channel (4)
RR182x [0,4]: channel started successfully
RR182x [0]: start channel (5)
RR182x [0,5]: channel started successfully
RR182x [0]: start channel (6)
RR182x [0,6]: channel started successfully
RR182x [0]: start channel (7)
RR182x [0,7]: channel started successfully
RR182x: RAID5 write-back enabled
RR182x [1]: start channel (0)
RR182x [1,0]: channel started successfully
RR182x [1]: start channel (1)
RR182x [1,1]: channel started successfully
RR182x [1]: start channel (2)
RR182x [1,2]: channel started successfully
RR182x [1]: start channel (3)
RR182x [1,3]: channel started successfully
RR182x [1]: start channel (4)
RR182x [1,4]: channel started successfully
RR182x [1]: start channel (5)
RR182x [1,5]: channel started successfully
RR182x [1]: start channel (6)
RR182x [1,6]: channel started successfully
RR182x [1]: start channel (7)
RR182x [1,7]: channel started successfully
RR182x: RAID5 write-back enabled
RR182x [2]: start channel (0)
RR182x [2,0]: channel started successfully
RR182x [2]: start channel (1)
RR182x [2,1]: channel started successfully
RR182x [2]: start channel (2)
RR182x [2,2]: channel started successfully
RR182x [2]: start channel (3)
RR182x [2,3]: channel started successfully
RR182x [2]: start channel (4)
RR182x [2,4]: channel started successfully
RR182x [2]: start channel (5)
RR182x [2,5]: channel started successfully
RR182x [2]: start channel (6)
RR182x [2,6]: channel started successfully
RR182x [2]: start channel (7)
RR182x [2,7]: channel started successfully
RR182x: RAID5 write-back enabled
RR182x [3]: start channel (0)
RR182x [3,0]: channel started successfully
RR182x [3]: start channel (1)
RR182x [3,1]: channel started successfully
RR182x [3]: start channel (2)
RR182x [3,2]: channel started successfully
RR182x [3]: start channel (3)
RR182x [3,3]: channel started successfully
RR182x [3]: start channel (4)
RR182x [3,4]: channel started successfully
RR182x [3]: start channel (5)
RR182x [3,5]: channel started successfully
RR182x [3]: start channel (6)
RR182x [3,6]: channel started successfully
RR182x [3]: start channel (7)
RR182x [3,7]: channel started successfully
RR182x: RAID5 write-back enabled
RR182x [4]: start channel (0)
RR182x [4,0]: channel started successfully
RR182x [4]: start channel (1)
RR182x [4,1]: channel started successfully
RR182x [4]: start channel (2)
RR182x [4,2]: channel started successfully
RR182x [4]: start channel (3)
RR182x [4,3]: channel started successfully
RR182x [4]: start channel (4)
RR182x [4,4]: channel started successfully
RR182x [4]: start channel (5)
RR182x [4,5]: channel started successfully
RR182x [4]: start channel (6)
RR182x [4,6]: channel started successfully
RR182x [4]: start channel (7)
RR182x [4,7]: channel started successfully
RR182x: RAID5 write-back enabled
scsi2 : hptmv
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
  Vendor: Maxtor 7  Model: Y250M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdd: 490234741 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1
Attached scsi disk sdd at scsi2, channel 0, id 1, lun 0
Attached scsi generic sg3 at scsi2, channel 0, id 1, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sde: drive cache: write through
 sde: sde1
Attached scsi disk sde at scsi2, channel 0, id 2, lun 0
Attached scsi generic sg4 at scsi2, channel 0, id 2, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdf: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sdf: drive cache: write through
 sdf: sdf1
Attached scsi disk sdf at scsi2, channel 0, id 3, lun 0
Attached scsi generic sg5 at scsi2, channel 0, id 3, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdg: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sdg: drive cache: write through
 sdg: sdg1
Attached scsi disk sdg at scsi2, channel 0, id 4, lun 0
Attached scsi generic sg6 at scsi2, channel 0, id 4, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdh: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sdh: drive cache: write through
 sdh: sdh1
Attached scsi disk sdh at scsi2, channel 0, id 5, lun 0
Attached scsi generic sg7 at scsi2, channel 0, id 5, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdi: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdi: drive cache: write through
 sdi: sdi1
Attached scsi disk sdi at scsi2, channel 0, id 6, lun 0
Attached scsi generic sg8 at scsi2, channel 0, id 6, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y120L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdj: 240121717 512-byte hdwr sectors (122942 MB)
SCSI device sdj: drive cache: write through
 sdj: sdj1
Attached scsi disk sdj at scsi2, channel 0, id 7, lun 0
Attached scsi generic sg9 at scsi2, channel 0, id 7, lun 0,  type 0
scsi3 : hptmv
  Vendor: SAMSUNG   Model: SP1614C           Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdk: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdk: drive cache: write through
 sdk: sdk1
Attached scsi disk sdk at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg10 at scsi3, channel 0, id 0, lun 0,  type 0
  Vendor: SAMSUNG   Model: SP1614C           Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdl: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdl: drive cache: write through
 sdl: sdl1
Attached scsi disk sdl at scsi3, channel 0, id 1, lun 0
Attached scsi generic sg11 at scsi3, channel 0, id 1, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdm: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdm: drive cache: write through
 sdm: sdm1
Attached scsi disk sdm at scsi3, channel 0, id 2, lun 0
Attached scsi generic sg12 at scsi3, channel 0, id 2, lun 0,  type 0
  Vendor: SAMSUNG   Model: SP1614C           Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdn: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdn: drive cache: write through
 sdn: sdn1
Attached scsi disk sdn at scsi3, channel 0, id 3, lun 0
Attached scsi generic sg13 at scsi3, channel 0, id 3, lun 0,  type 0
  Vendor: SAMSUNG   Model: SP1614C           Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdo: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdo: drive cache: write through
 sdo: sdo1
Attached scsi disk sdo at scsi3, channel 0, id 4, lun 0
Attached scsi generic sg14 at scsi3, channel 0, id 4, lun 0,  type 0
  Vendor: SAMSUNG   Model: SP1614C           Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdp: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdp: drive cache: write through
 sdp: sdp1
Attached scsi disk sdp at scsi3, channel 0, id 5, lun 0
Attached scsi generic sg15 at scsi3, channel 0, id 5, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdq: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdq: drive cache: write through
 sdq: sdq1
Attached scsi disk sdq at scsi3, channel 0, id 6, lun 0
Attached scsi generic sg16 at scsi3, channel 0, id 6, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdr: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdr: drive cache: write through
 sdr: sdr1
Attached scsi disk sdr at scsi3, channel 0, id 7, lun 0
Attached scsi generic sg17 at scsi3, channel 0, id 7, lun 0,  type 0
scsi4 : hptmv
  Vendor: Maxtor 6  Model: Y160L0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sds: 320173045 512-byte hdwr sectors (163929 MB)
SCSI device sds: drive cache: write through
 sds: sds1
Attached scsi disk sds at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg18 at scsi4, channel 0, id 0, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdt: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdt: drive cache: write through
 sdt: sdt1
Attached scsi disk sdt at scsi4, channel 0, id 1, lun 0
Attached scsi generic sg19 at scsi4, channel 0, id 1, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: TR10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdu: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdu: drive cache: write through
 sdu: sdu1
Attached scsi disk sdu at scsi4, channel 0, id 2, lun 0
Attached scsi generic sg20 at scsi4, channel 0, id 2, lun 0,  type 0
  Vendor: SAMSUNG   Model: SV1604N           Rev: SD10
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdv: 312581797 512-byte hdwr sectors (160042 MB)
SCSI device sdv: drive cache: write through
 sdv: sdv1
Attached scsi disk sdv at scsi4, channel 0, id 3, lun 0
Attached scsi generic sg21 at scsi4, channel 0, id 3, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y160M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdw: 320173045 512-byte hdwr sectors (163929 MB)
SCSI device sdw: drive cache: write through
 sdw: sdw1
Attached scsi disk sdw at scsi4, channel 0, id 4, lun 0
Attached scsi generic sg22 at scsi4, channel 0, id 4, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdx: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdx: drive cache: write through
 sdx: sdx1
Attached scsi disk sdx at scsi4, channel 0, id 5, lun 0
Attached scsi generic sg23 at scsi4, channel 0, id 5, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdy: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdy: drive cache: write through
 sdy: sdy1
Attached scsi disk sdy at scsi4, channel 0, id 6, lun 0
Attached scsi generic sg24 at scsi4, channel 0, id 6, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdz: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdz: drive cache: write through
 sdz: sdz1
Attached scsi disk sdz at scsi4, channel 0, id 7, lun 0
Attached scsi generic sg25 at scsi4, channel 0, id 7, lun 0,  type 0
scsi5 : hptmv
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdaa: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdaa: drive cache: write through
 sdaa: sdaa1
Attached scsi disk sdaa at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg26 at scsi5, channel 0, id 0, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdab: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdab: drive cache: write through
 sdab: sdab1
Attached scsi disk sdab at scsi5, channel 0, id 1, lun 0
Attached scsi generic sg27 at scsi5, channel 0, id 1, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdac: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdac: drive cache: write through
 sdac: sdac1
Attached scsi disk sdac at scsi5, channel 0, id 2, lun 0
Attached scsi generic sg28 at scsi5, channel 0, id 2, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdad: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdad: drive cache: write through
 sdad: sdad1
Attached scsi disk sdad at scsi5, channel 0, id 3, lun 0
Attached scsi generic sg29 at scsi5, channel 0, id 3, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdae: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdae: drive cache: write through
 sdae: sdae1
Attached scsi disk sdae at scsi5, channel 0, id 4, lun 0
Attached scsi generic sg30 at scsi5, channel 0, id 4, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdaf: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdaf: drive cache: write through
 sdaf: sdaf1
Attached scsi disk sdaf at scsi5, channel 0, id 5, lun 0
Attached scsi generic sg31 at scsi5, channel 0, id 5, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdag: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdag: drive cache: write through
 sdag: sdag1
Attached scsi disk sdag at scsi5, channel 0, id 6, lun 0
Attached scsi generic sg32 at scsi5, channel 0, id 6, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdah: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdah: drive cache: write through
 sdah: sdah1
Attached scsi disk sdah at scsi5, channel 0, id 7, lun 0
Attached scsi generic sg33 at scsi5, channel 0, id 7, lun 0,  type 0
scsi6 : hptmv
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdai: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdai: drive cache: write through
 sdai: sdai1
Attached scsi disk sdai at scsi6, channel 0, id 0, lun 0
Attached scsi generic sg34 at scsi6, channel 0, id 0, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdaj: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdaj: drive cache: write through
 sdaj: sdaj1
Attached scsi disk sdaj at scsi6, channel 0, id 1, lun 0
Attached scsi generic sg35 at scsi6, channel 0, id 1, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdak: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdak: drive cache: write through
 sdak: sdak1
Attached scsi disk sdak at scsi6, channel 0, id 2, lun 0
Attached scsi generic sg36 at scsi6, channel 0, id 2, lun 0,  type 0
  Vendor: Maxtor 7  Model: Y250P0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdal: 490234741 512-byte hdwr sectors (251000 MB)
SCSI device sdal: drive cache: write through
 sdal: sdal1
Attached scsi disk sdal at scsi6, channel 0, id 3, lun 0
Attached scsi generic sg37 at scsi6, channel 0, id 3, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdam: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdam: drive cache: write through
 sdam: sdam1
Attached scsi disk sdam at scsi6, channel 0, id 4, lun 0
Attached scsi generic sg38 at scsi6, channel 0, id 4, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdan: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdan: drive cache: write through
 sdan: sdan1
Attached scsi disk sdan at scsi6, channel 0, id 5, lun 0
Attached scsi generic sg39 at scsi6, channel 0, id 5, lun 0,  type 0
  Vendor: Maxtor 7  Model: Y250M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdao: 490234741 512-byte hdwr sectors (251000 MB)
SCSI device sdao: drive cache: write through
 sdao: sdao1
Attached scsi disk sdao at scsi6, channel 0, id 6, lun 0
Attached scsi generic sg40 at scsi6, channel 0, id 6, lun 0,  type 0
  Vendor: Maxtor 6  Model: Y200M0            Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdap: 398297077 512-byte hdwr sectors (203928 MB)
SCSI device sdap: drive cache: write through
 sdap: sdap1
Attached scsi disk sdap at scsi6, channel 0, id 7, lun 0
Attached scsi generic sg41 at scsi6, channel 0, id 7, lun 0,  type 0
sata_promise version 1.00
ata3: SATA max UDMA/133 cmd 0xF886A200 ctl 0xF886A238 bmdma 0x0 irq 23
ata4: SATA max UDMA/133 cmd 0xF886A280 ctl 0xF886A2B8 bmdma 0x0 irq 23
ata3: dev 0 cfg 49:2f00 82:7c69 83:4f09 84:4003 85:7c69 86:0e01 87:4003 88:407f
ata3: dev 0 ATA, max UDMA/133, 240121728 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi7 : sata_promise
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata4: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata4: dev 0 configured for UDMA/133
scsi8 : sata_promise
  Vendor: ATA       Model: Maxtor 4G120J6    Rev: GAK8
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdaq: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdaq: drive cache: write back
 sdaq: sdaq1
Attached scsi disk sdaq at scsi7, channel 0, id 0, lun 0
Attached scsi generic sg42 at scsi7, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: Maxtor 6Y120L0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdar: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdar: drive cache: write back
 sdar: sdar1
Attached scsi disk sdar at scsi8, channel 0, id 0, lun 0
Attached scsi generic sg43 at scsi8, channel 0, id 0, lun 0,  type 0
md: md0 stopped.
md: bind<sdf1>
md: bind<hdd1>
md: bind<sdj1>
md: bind<sdg1>
md: bind<hdb1>
md: bind<sdaq1>
md: bind<sdh1>
md: bind<sdar1>
md: bind<sda1>
md: bind<sdc1>
md: bind<sde1>
md: md0: raid array is not clean -- starting background reconstruction
raid5: device sde1 operational as raid disk 0
raid5: device sdc1 operational as raid disk 10
raid5: device sda1 operational as raid disk 9
raid5: device sdar1 operational as raid disk 8
raid5: device sdh1 operational as raid disk 7
raid5: device sdaq1 operational as raid disk 6
raid5: device hdb1 operational as raid disk 5
raid5: device sdg1 operational as raid disk 4
raid5: device sdj1 operational as raid disk 3
raid5: device hdd1 operational as raid disk 2
raid5: device sdf1 operational as raid disk 1
raid5: allocated 11489kB for md0
raid5: raid level 5 set md0 active with 11 out of 11 devices, algorithm 2
RAID5 conf printout:
 --- rd:11 wd:11 fd:0
 disk 0, o:1, dev:sde1
 disk 1, o:1, dev:sdf1
 disk 2, o:1, dev:hdd1
 disk 3, o:1, dev:sdj1
 disk 4, o:1, dev:sdg1
 disk 5, o:1, dev:hdb1
 disk 6, o:1, dev:sdaq1
 disk 7, o:1, dev:sdh1
 disk 8, o:1, dev:sdar1
 disk 9, o:1, dev:sda1
 disk 10, o:1, dev:sdc1
md: md1 stopped.
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 120053632 blocks.
md: bind<sdw1>
md: bind<sds1>
md: bind<sdt1>
md: bind<sdu1>
md: bind<sdv1>
md: bind<sdk1>
md: bind<sdl1>
md: bind<sdi1>
md: bind<sdn1>
md: bind<sdo1>
md: bind<sdp1>
md: bind<sdb1>
md: bind<sdm1>
md: bind<sdq1>
md: md1: raid array is not clean -- starting background reconstruction
raid5: device sdq1 operational as raid disk 0
raid5: device sdm1 operational as raid disk 13
raid5: device sdb1 operational as raid disk 12
raid5: device sdp1 operational as raid disk 11
raid5: device sdo1 operational as raid disk 10
raid5: device sdn1 operational as raid disk 9
raid5: device sdi1 operational as raid disk 8
raid5: device sdl1 operational as raid disk 7
raid5: device sdk1 operational as raid disk 6
raid5: device sdv1 operational as raid disk 5
raid5: device sdu1 operational as raid disk 4
raid5: device sdt1 operational as raid disk 3
raid5: device sds1 operational as raid disk 2
raid5: device sdw1 operational as raid disk 1
raid5: allocated 14612kB for md1
raid5: raid level 5 set md1 active with 14 out of 14 devices, algorithm 2
RAID5 conf printout:
 --- rd:14 wd:14 fd:0
 disk 0, o:1, dev:sdq1
 disk 1, o:1, dev:sdw1
 disk 2, o:1, dev:sds1
 disk 3, o:1, dev:sdt1
 disk 4, o:1, dev:sdu1
 disk 5, o:1, dev:sdv1
 disk 6, o:1, dev:sdk1
 disk 7, o:1, dev:sdl1
 disk 8, o:1, dev:sdi1
 disk 9, o:1, dev:sdn1
 disk 10, o:1, dev:sdo1
 disk 11, o:1, dev:sdp1
 disk 12, o:1, dev:sdb1
 disk 13, o:1, dev:sdm1
md: md6 stopped.
md: syncing RAID array md1
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 156288256 blocks.
md: bind<sdy1>
md: bind<sdz1>
md: bind<sdaa1>
md: bind<sdab1>
md: bind<sdac1>
md: bind<sdad1>
md: bind<sdae1>
md: bind<sdaf1>
md: bind<sdag1>
md: bind<sdah1>
md: bind<sdx1>
raid5: device sdx1 operational as raid disk 0
raid5: device sdah1 operational as raid disk 10
raid5: device sdag1 operational as raid disk 9
raid5: device sdaf1 operational as raid disk 8
raid5: device sdae1 operational as raid disk 7
raid5: device sdad1 operational as raid disk 6
raid5: device sdac1 operational as raid disk 5
raid5: device sdab1 operational as raid disk 4
raid5: device sdaa1 operational as raid disk 3
raid5: device sdz1 operational as raid disk 2
raid5: device sdy1 operational as raid disk 1
raid5: allocated 11489kB for md6
raid5: raid level 5 set md6 active with 11 out of 11 devices, algorithm 2
RAID5 conf printout:
 --- rd:11 wd:11 fd:0
 disk 0, o:1, dev:sdx1
 disk 1, o:1, dev:sdy1
 disk 2, o:1, dev:sdz1
 disk 3, o:1, dev:sdaa1
 disk 4, o:1, dev:sdab1
 disk 5, o:1, dev:sdac1
 disk 6, o:1, dev:sdad1
 disk 7, o:1, dev:sdae1
 disk 8, o:1, dev:sdaf1
 disk 9, o:1, dev:sdag1
 disk 10, o:1, dev:sdah1
md: md7 stopped.
md: bind<sdaj1>
md: bind<sdak1>
md: bind<sdam1>
md: bind<sdan1>
md: bind<sdap1>
md: bind<sdai1>
md: md7: raid array is not clean -- starting background reconstruction
raid5: device sdai1 operational as raid disk 0
raid5: device sdap1 operational as raid disk 6
raid5: device sdan1 operational as raid disk 5
raid5: device sdam1 operational as raid disk 4
raid5: device sdak1 operational as raid disk 2
raid5: device sdaj1 operational as raid disk 1
raid5: cannot start dirty degraded array for md7
RAID5 conf printout:
 --- rd:7 wd:6 fd:1
 disk 0, o:1, dev:sdai1
 disk 1, o:1, dev:sdaj1
 disk 2, o:1, dev:sdak1
 disk 4, o:1, dev:sdam1
 disk 5, o:1, dev:sdan1
 disk 6, o:1, dev:sdap1
raid5: failed to run raid set md7
md: pers->run() failed ...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-16, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-17, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-15, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with large block numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem dm-21
Starting XFS recovery on filesystem: dm-21 (dev: dm-21)
Ending XFS recovery on filesystem: dm-21 (dev: dm-21)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-18, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xf0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex

--=-SAFI4qvwaBBSH6ghgcDP--

