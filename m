Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSGRSMT>; Thu, 18 Jul 2002 14:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSGRSMT>; Thu, 18 Jul 2002 14:12:19 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:12499 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S318284AbSGRSMN>; Thu, 18 Jul 2002 14:12:13 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.19-rc2-ac1
Date: Thu, 18 Jul 2002 20:19:59 +0200
X-Mailer: KMail [version 1.3.2]
References: <200207181545.g6IFjgG24953@devserv.devel.redhat.com>
In-Reply-To: <200207181545.g6IFjgG24953@devserv.devel.redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020718181213Z318284-686+2229@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 17:45, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
>
> Linux 2.4.19rc2-ac1
> o       Merge with 2.4.19-rc2
> o       Minor HP merge fixup
> o       Orinoco build fix                               (Adrian Bunk)
> o       Vaio C1VE/N frame buffer console mode           (Marcel Wijlaars)
> o       Fix an inverted test in sym53c8xx_2             (Grant Grundler)
> o       Fix aic7xxx build without PCI enabled           (me)
> o       Clear allocated gendisk in IDE                  (Kurt Garloff)

build ok, but panics at boot.

panic occured after these messages:
<snip>
hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdc: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

decoded oops and system info follows

	Rudmer


oops through ksymoops (note: oops was written down by hand):
# ksymoops -V -K -L -o /lib/modules/2.4.19-rc2-ac1 -m 
/boot/System.map-2.4.19-rc2-ac1 <oops
ksymoops 2.4.3 on i686 2.4.19-pre10-ac2.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.19-rc2-ac1 (specified)
     -m /boot/System.map-2.4.19-rc2-ac1 (specified)

No modules in ksyms, skipping objects
unable to handle kernel NULL pointer dereference at virtual address 00000000
c01bf838
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01bf838>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cffed580   ecx: 00000880   edx: c1345450
esi: cff31000   edi: 00000000   ebp: cffe8e00   esp: cffe7f00
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=cffe7000)
Stack: c02d1355 c02d1020 c02d1020 0008e000 c02adcc1 cffe8c00 c0118ac5 c02d12ec
       c02d1020 c1363080 00000002 c01bf764 c023cc23 c02d1355 c02d1020 c02d1020
       0008e000 0000000e c1363080 c02d1355 00000292 00000000 c01bfc9e c02d1020
Call Trace:    [<c0118ac5>] [<c01bf764>] [<c01bfc9e>] [<c01bfe6f>] 
[<c0105027>]   [<c0106f68>]
Code: f3 ab 8b 54 24 5c 8b 4c 24 14 31 ff 0f b6 82 34 03 00 00 89

>>EIP; c01bf838 <init_gendisk+b8/310>   <=====
Trace; c0118ac4 <printk+104/120>
Trace; c01bf764 <init_irq+2f4/310>
Trace; c01bfc9e <hwif_init+20e/270>
Trace; c01bfe6e <ideprobe_init+6e/a0>
Trace; c0105026 <init+6/110>
Trace; c0106f68 <kernel_thread+28/40>
Code;  c01bf838 <init_gendisk+b8/310>
00000000 <_EIP>:
Code;  c01bf838 <init_gendisk+b8/310>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c01bf83a <init_gendisk+ba/310>
   2:   8b 54 24 5c               mov    0x5c(%esp,1),%edx
Code;  c01bf83e <init_gendisk+be/310>
   6:   8b 4c 24 14               mov    0x14(%esp,1),%ecx
Code;  c01bf842 <init_gendisk+c2/310>
   a:   31 ff                     xor    %edi,%edi
Code;  c01bf844 <init_gendisk+c4/310>
   c:   0f b6 82 34 03 00 00      movzbl 0x334(%edx),%eax
Code;  c01bf84a <init_gendisk+ca/310>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Attempted to kill init!

# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux gandalf 2.4.19-pre10-ac2 #1 Wed Jun 5 20:46:37 CEST 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11q
mount                  2.11q
modutils               2.4.16
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

# /sbin/lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev
01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)

.config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=512
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=20
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_SIS=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m

====

if more info is needed please ask
