Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263770AbSIQG5k>; Tue, 17 Sep 2002 02:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263787AbSIQG5k>; Tue, 17 Sep 2002 02:57:40 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:28113 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S263770AbSIQG5S>;
	Tue, 17 Sep 2002 02:57:18 -0400
To: Alan Cox <alan@redhat.com>
Cc: bunk@fs.tum.de (Adrian Bunk), hpj@urpla.net (Hans-Peter Jansen),
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
References: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 17 Sep 2002 00:12:51 +0200
In-Reply-To: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
Message-ID: <m3elbth9cs.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Alan Cox <alan@redhat.com> writes:

> > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > problem reproducible without any non-free module loaded _ever_ since the
> > last reboot?
> 
> I've seen this trace without nvidia etc loaded too. Right now the problem
> I have is that I can't duplicate it. If my box would jut blow up the same
> way all would be well 8)
> 
> What compilers are being used by the folks who see the problem ?

Back on the same track again, I've managed to get a oops dump from the
DVD related oops I was having:

Sep 17 00:03:33 lapper kernel: kernel BUG at /home/alexh/src/linux/linux-2.4-ac-new/include/linux/blkdev.h:153!
Sep 17 00:03:33 lapper kernel: invalid operand: 0000
Sep 17 00:03:33 lapper kernel: CPU:    0
Sep 17 00:03:33 lapper kernel: EIP:    0010:[<c01f83e8>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 17 00:03:33 lapper kernel: EFLAGS: 00010206
Sep 17 00:03:33 lapper kernel: eax: 00000059   ebx: 00000000   ecx: eda6ea80   edx: 00000001
Sep 17 00:03:33 lapper kernel: esi: c0331824   edi: 00000000   ebp: eda6ea80   esp: e769bb58
Sep 17 00:03:33 lapper kernel: ds: 0018   es: 0018   ss: 0018
Sep 17 00:03:33 lapper kernel: Process mount (pid: 2217, stackpage=e769b000)
Sep 17 00:03:33 lapper kernel: Stack: e769bb58 e769bb58 c01ecf73 e7fba780 00000000 efdb8000 efdbb000 c0331824
Sep 17 00:03:33 lapper kernel:        00000000 eda6ea80 c01f873c c0331774 eda6ea80 c0331824 00000000 c0331774
Sep 17 00:03:33 lapper kernel:        c0331774 c0331824 eda6ea80 eda6ea80 c01f8cc7 c0331824 eda6ea80 e9b9b33a
Sep 17 00:03:33 lapper kernel: Call Trace:    [<c01ecf73>] [<c01f873c>] [<c01f8cc7>] [<f0932c81>] [<c01ec6e1>]
Sep 17 00:03:33 lapper kernel:   [<c01ec879>] [<c01ed050>] [<c01ecf73>] [<f0933727>] [<f091686a>] [<f091dde0>]
Sep 17 00:03:33 lapper kernel:   [<f091db10>] [<f091fa56>] [<f4d57620>] [<c01cba06>] [<c012387a>] [<c0145ccc>]
Sep 17 00:03:33 lapper kernel:   [<c01471dc>] [<f4d6bc01>] [<f4d66dfb>] [<f4d6dfdd>] [<c011e3b8>] [<f4d689b0>]
Sep 17 00:03:33 lapper kernel:   [<f4d693b2>] [<f4d6e19b>] [<f091a3e1>] [<f4d53100>] [<c01fffff>] [<c014bf78>]
Sep 17 00:03:33 lapper kernel:   [<c014ab0d>] [<f4d70c60>] [<c014aed1>] [<f4d70c60>] [<c015fe23>] [<c0160150>]
Sep 17 00:03:33 lapper kernel:   [<c015ff99>] [<c016053f>] [<c01091a7>]
Sep 17 00:03:33 lapper kernel: Code: 0f 0b 99 00 a0 5a 2b c0 ba ff ff ff ff 31 c0 85 d2 8b 74 24


>>EIP; c01f83e8 <ide_build_sglist+48/1d0>   <=====

>>ecx; eda6ea80 <_end+2d736dc4/305233a4>
>>esi; c0331824 <ide_hwifs+524/2c88>
>>ebp; eda6ea80 <_end+2d736dc4/305233a4>
>>esp; e769bb58 <_end+27363e9c/305233a4>

Trace; c01ecf73 <ide_init_drive_cmd+23/40>
Trace; c01f873c <ide_build_dmatable+4c/1a0>
Trace; c01f8cc7 <__ide_dma_read+37/140>
Trace; f0932c81 <[ide-scsi]idescsi_issue_pc+201/210>
Trace; c01ec6e1 <start_request+1b1/230>
Trace; c01ec879 <ide_do_request+c9/1c0>
Trace; c01ed050 <ide_do_drive_cmd+c0/120>
Trace; c01ecf73 <ide_init_drive_cmd+23/40>
Trace; f0933727 <[ide-scsi]idescsi_queue+1b7/2e0>
Trace; f091686a <[scsi_mod]scsi_dispatch_cmd+25a/420>
Trace; f091dde0 <[scsi_mod]scsi_old_done+0/670>
Trace; f091db10 <[scsi_mod]scsi_old_times_out+0/160>
Trace; f091fa56 <[scsi_mod]scsi_request_fn+1c6/3b0>
Trace; f4d57620 <[sr_mod]sr_template+0/0>
Trace; c01cba06 <generic_unplug_device+56/60>
Trace; c012387a <__run_task_queue+6a/80>
Trace; c0145ccc <__wait_on_buffer+9c/a0>
Trace; c01471dc <bread+8c/a0>
Trace; f4d6bc01 <[udf]udf_tread+41/60>
Trace; f4d66dfb <[udf]udf_vrs+db/3c0>
Trace; f4d6dfdd <[udf].rodata.end+456/4fe>
Trace; c011e3b8 <printk+118/180>
Trace; f4d689b0 <[udf]udf_check_valid+60/c0>
Trace; f4d693b2 <[udf]udf_read_super+1c2/760>
Trace; f4d6e19b <[udf].LC6+116/2a1b>
Trace; f091a3e1 <[scsi_mod]scsi_ioctl+101/3e0>
Trace; f4d53100 <[sr_mod]sr_release+a0/c0>
Trace; c01fffff <cdrom_switch_blocksize+4f/b0>
Trace; c014bf78 <check_disk_change+48/90>
Trace; c014ab0d <get_sb_bdev+18d/280>
Trace; f4d70c60 <[udf]udf_fstype+0/20>
Trace; c014aed1 <do_kern_mount+121/140>
Trace; f4d70c60 <[udf]udf_fstype+0/20>
Trace; c015fe23 <do_add_mount+93/190>
Trace; c0160150 <do_mount+160/1b0>
Trace; c015ff99 <copy_mount_options+79/d0>
Trace; c016053f <sys_mount+cf/140>
Trace; c01091a7 <system_call+33/38>

Code;  c01f83e8 <ide_build_sglist+48/1d0>
00000000 <_EIP>:
Code;  c01f83e8 <ide_build_sglist+48/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01f83ea <ide_build_sglist+4a/1d0>
   2:   99                        cltd
   Code;  c01f83eb <ide_build_sglist+4b/1d0>
   3:   00 a0 5a 2b c0 ba         add    %ah,0xbac02b5a(%eax)
Code;  c01f83f1 <ide_build_sglist+51/1d0>
   9:   ff                        (bad)
  Code;  c01f83f2 <ide_build_sglist+52/1d0>
   a:   ff                        (bad)
  Code;  c01f83f3 <ide_build_sglist+53/1d0>
   b:   ff                        (bad)
  Code;  c01f83f4 <ide_build_sglist+54/1d0>
   c:   ff 31                     pushl  (%ecx)
Code;  c01f83f6 <ide_build_sglist+56/1d0>
   e:   c0 85 d2 8b 74 24 00      rolb   $0x0,0x24748bd2(%ebp)

I'll try and see if I can get the same dump out of an untainted kernel
(non-vmware) and also while not using preempt. The same crash DOES
happen on same version less vmware and preempt as well.

Usually it would crash if I had a DVD in while logging into gnome2
(rawhide, everything up to date), but if I mount it manually after
logging in I can now catch the oops from dmesg/syslog.

More info:

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=versions
Content-Transfer-Encoding: base64

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4g
b2xkIHZlcnNpb24uCkNvbXBhcmUgdG8gdGhlIGN1cnJlbnQgbWluaW1hbCByZXF1aXJlbWVudHMg
aW4gRG9jdW1lbnRhdGlvbi9DaGFuZ2VzLgogCkxpbnV4IGxhcHBlciAyLjQuMjAtcHJlNS1hYzQt
cHJlZW1wdCAjMSBs+HIgc2VwIDcgMjI6Mzk6MjMgQ0VTVCAyMDAyIGk2ODYgaTY4NiBpMzg2IEdO
VS9MaW51eAogCkdudSBDICAgICAgICAgICAgICAgICAgMy4yCkdudSBtYWtlICAgICAgICAgICAg
ICAgMy43OS4xCnV0aWwtbGludXggICAgICAgICAgICAgMi4xMXIKbW91bnQgICAgICAgICAgICAg
ICAgICAyLjExcgptb2R1dGlscyAgICAgICAgICAgICAgIDIuNC4xOAplMmZzcHJvZ3MgICAgICAg
ICAgICAgIDEuMjcKamZzdXRpbHMgICAgICAgICAgICAgICAxLjAuMTcKcmVpc2VyZnNwcm9ncyAg
ICAgICAgICAzLjYuMgpwY21jaWEtY3MgICAgICAgICAgICAgIDMuMS4zMQpQUFAgICAgICAgICAg
ICAgICAgICAgIDIuNC4xCmlzZG40ay11dGlscyAgICAgICAgICAgMy4xcHJlNApMaW51eCBDIExp
YnJhcnkgICAgICAgIDIuMi45MApEeW5hbWljIGxpbmtlciAobGRkKSAgIDIuMi45MApQcm9jcHMg
ICAgICAgICAgICAgICAgIDIuMC43Ck5ldC10b29scyAgICAgICAgICAgICAgMS42MApLYmQgICAg
ICAgICAgICAgICAgICAgIDY3OgpTaC11dGlscyAgICAgICAgICAgICAgIDIuMC4xMgpNb2R1bGVz
IExvYWRlZCAgICAgICAgIHVkZiBzcl9tb2QgYXV0b2ZzNCB2bW5ldCBwYXJwb3J0X3BjIHBhcnBv
cnQgdm1tb24gbnNjLWlyY2MgaXJkYSBhZl9wYWNrZXQgaXBjaGFpbnMgbWljcm9jb2RlIGlkZS1z
Y3NpIHNjc2lfbW9kIHNlcmlhbCBoY2lfdXNiIGJsdWV6IGJsdWV0b290aCBubHNfaXNvODg1OS0x
IG50ZnMgaTgxMF9hdWRpbyBzb3VuZGNvcmUgYWM5N19jb2RlYyBmbG9wcHkgbW91c2VkZXYga2V5
YmRldiBoaWQgaW5wdXQgZWhjaS1oY2QgdXNiLW9oY2kgdXNiY29yZSBydGMgdW5peAo=
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=.config

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
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_CPU_FREQ=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_SPEEDSTEP=y
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
# CONFIG_PCI_NAMES is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_H2999 is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IKCONFIG=y
CONFIG_PM=y
CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=m
CONFIG_MTD_CONCAT=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# CONFIG_MTD_OBSOLETE_CHIPS is not set
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PNC2000=m
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_ELAN_104NC=m
# CONFIG_MTD_DILNETPC is not set
# CONFIG_MTD_MIXMEM is not set
# CONFIG_MTD_OCTAGON is not set
# CONFIG_MTD_VMAX is not set
CONFIG_MTD_L440GX=m
CONFIG_MTD_AMD766ROM=m
CONFIG_MTD_ICH2ROM=m
CONFIG_MTD_PCI=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLKMTD=m
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOCPROBE is not set

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_VERIFY_WRITE=y

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
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
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

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
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m
CONFIG_BLK_DEV_DM=m

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
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
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=y

#
#   IPv6: Netfilter Configuration
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
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_LLC=m
CONFIG_LLC_UI=y
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m

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
CONFIG_HAZARD_READ=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_BAILOUT=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
# CONFIG_BLK_DEV_CMD640 is not set
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
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
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
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
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
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
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
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

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
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

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
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
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
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
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
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
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
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCI_HERMES=m
# CONFIG_PCMCIA_HERMES is not set
# CONFIG_AIRO_CS is not set
CONFIG_NET_WIRELESS=y

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
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
# CONFIG_DONGLE is not set
# CONFIG_USB_IRDA is not set
CONFIG_NSC_FIR=m
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

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
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

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
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I810_TCO=y
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_AMD_RNG is not set
CONFIG_INTEL_RNG=m
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
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
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_QIFACE_COMPAT is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS_PROC_FS=y
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
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
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
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
CONFIG_ZISOFS_FS=m

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
CONFIG_NLS_CODEPAGE_865=m
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
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

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
# CONFIG_SPEAKUP is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=m
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
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=m
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_BLUETOOTH=m
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_BNEP=m
CONFIG_BNEP_MC_FILTER=y
CONFIG_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_USB_ZERO_PACKET=y
CONFIG_BLUEZ_HCIUART=m
CONFIG_BLUEZ_HCIUART_H4=y
CONFIG_BLUEZ_HCIDTL1=m
CONFIG_BLUEZ_HCIBT3C=m
CONFIG_BLUEZ_HCIBLUECARD=m
CONFIG_BLUEZ_HCIVHCI=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_PANIC_MORSE is not set
# CONFIG_DEBUG_SPINLOCK is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=modules.conf

keep

# path[pcmcia]=/lib/modules/`uname -r`/
# path[misc]=/lib/modules/`uname -r`/

alias usb-controller usb-ohci
alias usb-controller1 ehci-hcd
alias usb-controller2 ehci-hcd

alias bt-proto-0   l2cap

# options p4-clockmod stock_freq=17000000
# options irport		io=0x3e8,irq=11
# options smc-ircc	ircc_cfg=0xe0,ircc_fir=0x100,ircc_sir=0x3e8,ircc_dma=0x2
# options smc-ircc	ircc_dma=0x1 ircc_irq=0x8
# options parport_pc 	io=0x378,0x278 irq=7,auto
# options sound dmabuf=1
# alias /dev/ppp ppp_generic
options nsc-ircc dma=3 irq=3,13 io=0x3e8 
options orinoco_cs irq_list=6,13 

alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate

alias tty-ldisc-3 ppp_async
alias tty-ldisc-11 nsc-ircc
alias tty-ldisc-14 ppp_synctty
alias tty-ldisc-15 hci_uart

alias parport_lowlevel parport_pc

alias block-major-2 floppy
alias block-major-22 ide-cd

# alias char-major-10-134 apm
alias char-major-10-135 rtc
alias char-major-10-144 nvram
alias char-major-10-150 atkbd
alias char-major-10-165 vmmon
alias char-major-10-175 agpgart
alias char-major-10-187 irnet
alias char-major-10-200 tun
alias char-major-10-250 hci_vhci
alias char-major-13-32 psmouse
alias char-major-13-63 mousedev
alias char-major-14 i810_audio
alias char-major-14-3 i810_audio
alias char-major-21 sg
alias char-major-36-0 netlink_dev
alias char-major-60 ircomm_tty
alias char-major-62 ltmodem
alias char-major-89 i2c-dev
alias char-major-97 off
alias char-major-108 ppp_generic
# alias char-major-161 ircomm-tty
alias char-major-188 pl2303
alias char-major-226 hci_uart
alias char-major-226 radeon

alias sound-slot-0 i810_audio
alias sound-slot-1 i810_audio
alias sound-service-1-0 i810_audio
alias sound-service-1-1 i810_audio
alias sound-service-1-2 i810_audio
alias sound-service-1-3 i810_audio
alias sound-service-1-4 i810_audio

alias net-pf-1 unix
alias net-pf-3 off
alias net-pf-4 off
alias net-pf-5 off
alias net-pf-10 ipv6
alias net-pf-17 af_packet
alias net-pf-31 hci_usb

alias eth0 eepro100
alias wvlan0 orinoco_cs
alias irda0 nsc-ircc
alias irlan0 irlan

alias loop-xfer-gen-0 loop_gen
alias loop-xfer-gen-10 loop_gen

alias cipher-2 des
alias cipher-4 blowfish
alias cipher-6 idea
alias cipher-7 serp6f
alias cipher-8 mars6
alias cipher-11 rc62
alias cipher-15 dfc2
alias cipher-16 rijndael
alias cipher-17 rc5

# install ltmodem insmod "-f" "-k" "ltmodem"
pre-install ircomm /sbin/modprobe nsc-ircc
post-install nsc-ircc echo `hostname` > /proc/sys/net/irda/devname
post-install nsc-ircc echo 115200 > /proc/sys/net/irda/max_baud_rate
post-install nsc-ircc echo 1 > /proc/sys/net/irda/discovery

# options ide-cd ignore=hdc 
alias scd0 sr_mod
#pre-install sg modprobe ide-scsi
#pre-install sr_mod modprobe ide-scsi
#pre-install ide-cd modprobe cdrom
#pre-install ide-scsi modprobe ide-cd

# pre-install radeon /sbin/modprobe agpgart
pre-install psmouse /sbin/modprobe mousedev

post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :


--=-=-=


mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

--=-=-=--
