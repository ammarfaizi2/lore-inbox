Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUAUStK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUAUStJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:49:09 -0500
Received: from grendel.firewall.com ([66.28.58.176]:13515 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S266071AbUAUSql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:46:41 -0500
Date: Wed, 21 Jan 2004 19:46:35 +0100
From: Marek Habersack <grendel@caudium.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.4.24+XFS+grsecurity2+SATA+HIPAC
Message-ID: <20040121184635.GA1479@thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

  As you can see, it's a heavily patched kernel running on the following
hardware:

  P4, 2GB of RAM, 2x80GB SATA drives on the ICH5R chipset SATA controller:

$ lspci
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (re=
v 02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
02:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:0a.0 Ethernet controller: Intel Corp.: Unknown device 1013
02:0b.0 Ethernet controller: Intel Corp.: Unknown device 1013

The software config is in short:

 softraid (all partitions, including /),sata,hipac packet filter,xfs on all
partitions except / which has ext3.=20

The oops happens shortly after booting the machine and results in=20
broken raid (up to the point no raid partition mounts except for /) and,=20
once, in slightly messed up data on /. The oops is as follows:

-------
ksymoops 2.4.9 on i686 2.4.24-xfs-gr2-sata-hipac-p4-up.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-xfs-gr2-sata-hipac-p4-up/ (default)
     -m /boot/System.map-2.4.24-xfs-gr2-sata-hipac-p4-up (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address a6069a94
c01c5010
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01c5010>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: f7153800   ebx: f352c000   ecx: 00000079   edx: a6069a80
esi: fffffff7   edi: 00000002   ebp: 59bfec1c   esp: f352df94
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 3725, stackpage=3Df352d000)
Stack: c01c3e85 00000003 00000022 ffffffff 00000000 f352c000 00000006 f352c=
000=20
       59bfec04 00000002 59bfec1c c01935d3 00000079 00000000 00000000 59bfe=
c04=20
       00000002 59bfec1c 0000008c 0000002b 0000002b 0000008c 25739315 00000=
023=20
Call Trace:    [<c01c3e85>] [<c01935d3>]
Code: ff 42 14 89 d0 c3 8d 76 00 8d bc 27 00 00 00 00 8b 4c 24 04=20


>>EIP; c01c5010 <fget+20/30>   <=3D=3D=3D=3D=3D

>>eax; f7153800 <_end+36d73bf8/384b6458>
>>ebx; f352c000 <_end+3314c3f8/384b6458>
>>esp; f352df94 <_end+3314e38c/384b6458>

Trace; c01c3e85 <sys_llseek+15/c0>
Trace; c01935d3 <system_call+33/40>

Code;  c01c5010 <fget+20/30>
00000000 <_EIP>:
Code;  c01c5010 <fget+20/30>   <=3D=3D=3D=3D=3D
   0:   ff 42 14                  incl   0x14(%edx)   <=3D=3D=3D=3D=3D
Code;  c01c5013 <fget+23/30>
   3:   89 d0                     mov    %edx,%eax
Code;  c01c5015 <fget+25/30>
   5:   c3                        ret   =20
Code;  c01c5016 <fget+26/30>
   6:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c01c5019 <fget+29/30>
   9:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  c01c5020 <put_filp+0/40>
  10:   8b 4c 24 04               mov    0x4(%esp,1),%ecx

 <1>Unable to handle kernel paging request at virtual address 0002e476
c01c35c7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c35c7>]    Not tainted
EFLAGS: 00010282
eax: f7153800   ebx: 0002e462   ecx: 00000003   edx: 0002e462
esi: f7169980   edi: f7169980   ebp: 00000004   esp: f7057e80
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 625, stackpage=3Df7057000)
Stack: f5e95900 f7169980 000000ff 00000078 f7169980 c01a3574 0002e462 f7169=
980=20
       f7aa2c80 00000000 f7056000 00000009 c01a3c77 f7169980 00000009 f7056=
000=20
       00000000 f7057f08 00000009 c01aa18c 00000009 c01aa365 00000009 00000=
009=20
Call Trace:    [<c01a3574>] [<c01a3c77>] [<c01aa18c>] [<c01aa365>] [<c01933=
0a>]
  [<c01d426c>] [<c01d4070>] [<c030c784>] [<c0191d06>] [<c019d925>] [<c01a46=
4d>]
  [<c0192506>] [<c01935d3>]
Code: 8b 43 14 85 c0 74 52 8b 43 10 31 ff 85 c0 74 07 8b 50 24 85=20


>>EIP; c01c35c7 <filp_close+17/80>   <=3D=3D=3D=3D=3D

>>eax; f7153800 <_end+36d73bf8/384b6458>
>>esi; f7169980 <_end+36d89d78/384b6458>
>>edi; f7169980 <_end+36d89d78/384b6458>
>>esp; f7057e80 <_end+36c78278/384b6458>

Trace; c01a3574 <put_files_struct+64/d0>
Trace; c01a3c77 <do_exit+b7/280>
Trace; c01aa18c <sig_exit+ac/b0>
Trace; c01aa365 <dequeue_signal+65/d0>
Trace; c019330a <do_signal+1ca/2c0>
Trace; c01d426c <sys_getdents64+ac/c0>
Trace; c01d4070 <filldir64+0/150>
Trace; c030c784 <netif_receive_skb+c4/190>
Trace; c0191d06 <__switch_to+26/d0>
Trace; c019d925 <schedule+215/350>
Trace; c01a464d <do_setitimer+ed/110>
Trace; c0192506 <sys_rt_sigsuspend+c6/e0>
Trace; c01935d3 <system_call+33/40>

Code;  c01c35c7 <filp_close+17/80>
00000000 <_EIP>:
Code;  c01c35c7 <filp_close+17/80>   <=3D=3D=3D=3D=3D
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=3D=3D=3D=3D=3D
Code;  c01c35ca <filp_close+1a/80>
   3:   85 c0                     test   %eax,%eax
Code;  c01c35cc <filp_close+1c/80>
   5:   74 52                     je     59 <_EIP+0x59>
Code;  c01c35ce <filp_close+1e/80>
   7:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c01c35d1 <filp_close+21/80>
   a:   31 ff                     xor    %edi,%edi
Code;  c01c35d3 <filp_close+23/80>
   c:   85 c0                     test   %eax,%eax
Code;  c01c35d5 <filp_close+25/80>
   e:   74 07                     je     17 <_EIP+0x17>
Code;  c01c35d7 <filp_close+27/80>
  10:   8b 50 24                  mov    0x24(%eax),%edx
Code;  c01c35da <filp_close+2a/80>
  13:   85 00                     test   %eax,(%eax)


1 warning issued.  Results may not be reliable.
------

In all cases, the oops is preceeded by the following line in the logs:

get_unused_fd: slot 120 not NULL!


The patches I used were:

xfs-2.4.23-split*
nf-hipac-0.8rev3
2.4.24-pre2-libata1
grsecurity-2.0-rc4-2.4.23


The full kernel config is attached.

If you need more detailed information, please let me know.

TIA,

marek

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="config-2.4.24-xfs-gr2-sata-hipac-p4-up"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

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
CONFIG_MPENTIUM4=3Dy
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
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_ALIGNMENT_16=3Dy
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_F00F_WORKS_OK=3Dy
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
# CONFIG_HIGHIO is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_ISA=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

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
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dy
CONFIG_MD_RAID0=3Dy
CONFIG_MD_RAID1=3Dy
CONFIG_MD_RAID5=3Dy
CONFIG_MD_MULTIPATH=3Dy
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dy
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dy
CONFIG_IP_NF_MATCH_MAC=3Dy
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=3Dy
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
CONFIG_IP_NF_MATCH_TOS=3Dy
CONFIG_IP_NF_MATCH_RECENT=3Dy
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=3Dy
CONFIG_IP_NF_MATCH_TTL=3Dy
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_STEALTH is not set
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dy
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dy
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=3Dy
CONFIG_IP_NF_TARGET_LOG=3Dy
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
# CONFIG_IP_NF_ARP_MANGLE is not set

#
#   IP: NF-HIPAC Configuration
#
CONFIG_IP_NF_HIPAC=3Dm
CONFIG_IP_NF_HIPAC_CTHELP=3Dm

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
# =20
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
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_SD_EXTRA_DEVS=3D40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
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
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=3D0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
CONFIG_SCSI_SATA=3Dy
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=3Dy
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_VIA is not set
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
CONFIG_NETDEVICES=3Dy

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
CONFIG_NET_ETHERNET=3Dy
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
CONFIG_NET_PCI=3Dy
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
CONFIG_EEPRO100=3Dy
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
CONFIG_E1000=3Dy
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

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

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
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

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
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=3Dy
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
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
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
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
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D0

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=3Dy
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

#
# Grsecurity
#
CONFIG_GRKERNSEC=3Dy
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_SHA256=3Dy
# CONFIG_GRKERNSEC_LOW is not set
# CONFIG_GRKERNSEC_MID is not set
# CONFIG_GRKERNSEC_HI is not set
CONFIG_GRKERNSEC_CUSTOM=3Dy

#
# Address Space Protection
#
CONFIG_GRKERNSEC_PAX_NOEXEC=3Dy
# CONFIG_GRKERNSEC_PAX_PAGEEXEC is not set
CONFIG_GRKERNSEC_PAX_SEGMEXEC=3Dy
# CONFIG_GRKERNSEC_PAX_EMUTRAMP is not set
CONFIG_GRKERNSEC_PAX_MPROTECT=3Dy
CONFIG_GRKERNSEC_PAX_NOELFRELOCS=3Dy
CONFIG_GRKERNSEC_PAX_ASLR=3Dy
# CONFIG_GRKERNSEC_PAX_RANDKSTACK is not set
CONFIG_GRKERNSEC_PAX_RANDUSTACK=3Dy
CONFIG_GRKERNSEC_PAX_RANDMMAP=3Dy
# CONFIG_GRKERNSEC_PAX_RANDEXEC is not set
CONFIG_GRKERNSEC_KMEM=3Dy
CONFIG_GRKERNSEC_IO=3Dy
CONFIG_RTC=3Dy
# CONFIG_GRKERNSEC_PROC_MEMMAP is not set
# CONFIG_GRKERNSEC_HIDESYM is not set

#
# Role Based Access Control Options
#
CONFIG_GRKERNSEC_ACL_HIDEKERN=3Dy
CONFIG_GRKERNSEC_ACL_MAXTRIES=3D3
CONFIG_GRKERNSEC_ACL_TIMEOUT=3D30

#
# Filesystem Protections
#
CONFIG_GRKERNSEC_PROC=3Dy
# CONFIG_GRKERNSEC_PROC_USER is not set
CONFIG_GRKERNSEC_PROC_USERGROUP=3Dy
CONFIG_GRKERNSEC_PROC_GID=3D4
CONFIG_GRKERNSEC_PROC_ADD=3Dy
CONFIG_GRKERNSEC_LINK=3Dy
CONFIG_GRKERNSEC_FIFO=3Dy
CONFIG_GRKERNSEC_CHROOT=3Dy
CONFIG_GRKERNSEC_CHROOT_MOUNT=3Dy
CONFIG_GRKERNSEC_CHROOT_DOUBLE=3Dy
CONFIG_GRKERNSEC_CHROOT_PIVOT=3Dy
CONFIG_GRKERNSEC_CHROOT_CHDIR=3Dy
CONFIG_GRKERNSEC_CHROOT_CHMOD=3Dy
CONFIG_GRKERNSEC_CHROOT_FCHDIR=3Dy
CONFIG_GRKERNSEC_CHROOT_MKNOD=3Dy
CONFIG_GRKERNSEC_CHROOT_SHMAT=3Dy
CONFIG_GRKERNSEC_CHROOT_UNIX=3Dy
CONFIG_GRKERNSEC_CHROOT_FINDTASK=3Dy
CONFIG_GRKERNSEC_CHROOT_NICE=3Dy
CONFIG_GRKERNSEC_CHROOT_SYSCTL=3Dy
CONFIG_GRKERNSEC_CHROOT_CAPS=3Dy

#
# Kernel Auditing
#
CONFIG_GRKERNSEC_AUDIT_GROUP=3Dy
CONFIG_GRKERNSEC_AUDIT_GID=3D100
# CONFIG_GRKERNSEC_EXECLOG is not set
CONFIG_GRKERNSEC_RESLOG=3Dy
# CONFIG_GRKERNSEC_CHROOT_EXECLOG is not set
# CONFIG_GRKERNSEC_AUDIT_CHDIR is not set
CONFIG_GRKERNSEC_AUDIT_MOUNT=3Dy
CONFIG_GRKERNSEC_AUDIT_IPC=3Dy
# CONFIG_GRKERNSEC_SIGNAL is not set
CONFIG_GRKERNSEC_FORKFAIL=3Dy
CONFIG_GRKERNSEC_TIME=3Dy
CONFIG_GRKERNSEC_PROC_IPADDR=3Dy

#
# Executable Protections
#
CONFIG_GRKERNSEC_EXECVE=3Dy
CONFIG_GRKERNSEC_DMESG=3Dy
CONFIG_GRKERNSEC_RANDPID=3Dy
# CONFIG_GRKERNSEC_TPE is not set

#
# Network Protections
#
CONFIG_GRKERNSEC_RANDNET=3Dy
CONFIG_GRKERNSEC_RANDISN=3Dy
CONFIG_GRKERNSEC_RANDID=3Dy
CONFIG_GRKERNSEC_RANDSRC=3Dy
# CONFIG_GRKERNSEC_RANDRPC is not set
CONFIG_GRKERNSEC_SOCKET=3Dy
# CONFIG_GRKERNSEC_SOCKET_ALL is not set
# CONFIG_GRKERNSEC_SOCKET_CLIENT is not set
CONFIG_GRKERNSEC_SOCKET_SERVER=3Dy
CONFIG_GRKERNSEC_SOCKET_SERVER_GID=3D100

#
# Sysctl support
#
CONFIG_GRKERNSEC_SYSCTL=3Dy

#
# Logging options
#
CONFIG_GRKERNSEC_FLOODTIME=3D10
CONFIG_GRKERNSEC_FLOODBURST=3D4

--GvXjxJ+pjyke8COw--

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADskLq3909GIf5uoRAteEAJ40P745gRL/2lfMHf720sYUZ8G+tgCeP+Ln
l587ntZOLbxLsPowrtQqQ4k=
=pcBh
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
