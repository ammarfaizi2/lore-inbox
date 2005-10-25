Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVJYR6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVJYR6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVJYR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:58:20 -0400
Received: from andromeda.piekna.pl ([212.69.68.171]:22992 "EHLO
	andromeda.piekna.pl") by vger.kernel.org with ESMTP id S932263AbVJYR6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:58:19 -0400
Message-ID: <2625.217.17.33.242.1130264297.squirrel@webmail.piekna.pl>
Date: Tue, 25 Oct 2005 20:18:17 +0200 (CEST)
Subject: ip_conntrack_lock not readlocked
From: "Daniel Chojecki" <boka@piekna.pl>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi !

I have a firewall on Dell 1850 (3353540k of RAM) with:

- vanilla kernel: 2.4.31 with openwall patches - version 1 and pptp. -
iptables 1.3.3
- patch-o-matic-ng-20050904

Errors in /var/log/messages occurs when users (approx. 320) use internet
and dmz connection.

Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 08:24:06 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 08:24:58 router -- MARK --
Oct 21 08:44:58 router -- MARK --
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 08:59:50 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 09:04:58 router -- MARK --
Oct 21 09:24:58 router -- MARK --
Oct 21 09:44:58 router -- MARK --
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 09:52:27 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 10:04:58 router -- MARK --
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 10:09:18 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 10:21:30 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 10:24:58 router -- MARK --
Oct 21 10:44:58 router -- MARK --
Oct 21 11:04:58 router -- MARK --

Oct 21 11:24:58 router -- MARK --
Oct 21 11:44:58 router -- MARK --
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked

Oct 21 11:44:58 router -- MARK --
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 11:50:22 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 12:04:58 router -- MARK --
Oct 21 12:24:58 router -- MARK --
Oct 21 12:44:58 router -- MARK --
Oct 21 13:04:58 router -- MARK --
Oct 21 13:24:58 router -- MARK --

Oct 21 14:04:58 router -- MARK --
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 14:06:08 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked


Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 14:06:59 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 14:24:58 router -- MARK --
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:94
&ip_conntrack_lock readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_nat_core.c:740 &ip_conntrack_lock
not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:81
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:83
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT ip_conntrack_core.c:1086
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked
Oct 21 14:37:24 router kernel: ASSERT: ip_nat_core.c:843
&ip_conntrack_lock not readlocked

Clients can see timeouts to our lotus domino server during refresh
proccess - rest of the traffic is not slowed down,
i mean they did not said anything about, for example, about http traffic.

Any ideas what can be broken ?

I have also attached .config file

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

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
CONFIG_MPENTIUM4=y
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
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
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
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_SHPC=y
CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_AOUT=y
CONFIG_BINFMT_MISC=y
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_MMCONFIG=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y

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
CONFIG_PNP=y
CONFIG_ISAPNP=y

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
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_CT_PROTO_GRE=y
CONFIG_IP_NF_PPTP=y
CONFIG_IP_NF_PPTP_DEBUG=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_PPTP=y
CONFIG_IP_NF_NAT_PROTO_GRE=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_POLICE=y

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
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_DELKIN is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
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
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
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
CONFIG_SCSI_MEGARAID2=y
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
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
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
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
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
CONFIG_ETHERTAP=y
# CONFIG_NET_SB1000 is not set

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
CONFIG_EEPRO100=y
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
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
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
CONFIG_SHAPER=y

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
# CONFIG_SERIAL_CONSOLE is not set
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
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
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
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_K8 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_ATI is not set

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
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
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
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
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
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
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
CONFIG_ZISOFS_FS=y

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
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
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
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
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
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

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
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
CONFIG_USB_SL811HS_ALT=y
CONFIG_USB_SL811HS=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_BLUETOOTH=y
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Security options
#
CONFIG_HARDEN_STACK=y
CONFIG_HARDEN_STACK_SMART=y
CONFIG_HARDEN_LINK=y
CONFIG_HARDEN_FIFO=y
CONFIG_HARDEN_PROC=y
CONFIG_HARDEN_RLIMIT_NPROC=y
CONFIG_HARDEN_SHM=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_FW_LOADER=y

-- 
greetz
Daniel

