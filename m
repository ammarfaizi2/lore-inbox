Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbRFHCLC>; Thu, 7 Jun 2001 22:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFHCKw>; Thu, 7 Jun 2001 22:10:52 -0400
Received: from mx.digitalfountain.com ([209.219.233.39]:52367 "HELO
	mx.webfountain.com") by vger.kernel.org with SMTP
	id <S263793AbRFHCKj>; Thu, 7 Jun 2001 22:10:39 -0400
From: "Michael Walfish" <mwalfish@digitalfountain.com>
To: <linux-kernel@vger.kernel.org>
Subject: oops in 2.4.2: in d_instantiate(),  inode->i_dentry.next was 0
Date: Thu, 7 Jun 2001 19:22:25 -0700
Message-ID: <NDBBIAJJGJIJCJJIKLKMIEKICMAA.mwalfish@digitalfountain.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Received an oops in the 2.4.2 kernel on an x86 SMP system, 640 MB RAM
(Compaq DL380 Server). The line of code this crashed on is in fs/dcache.c:
void d_instantiate(struct dentry *entry, struct inode * inode)
[snip]
-->        list_add(&entry->d_alias, &inode->i_dentry);

Believe inode->i_dentry.next was equal to 0.

Sadly, am unable to reproduce this. Relevant part of .config at the end of
this message. Oops is below. I have a memory dump (from the lkcd utilities)
if anyone is interested. Please let me know if you would like more
information.

Please include me in replies as I am not on the mailing list. Thank you in
advance.

-Mike Walfish

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Unable to handle kernel NULL pointer dereference at virtual address 00
000004
c01463b0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01463b0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: e7936a58   ebx: e7936a20   ecx: d33a5a40   edx: 00000000
esi: c2fdc1e0   edi: c574bf60   ebp: 00000007   esp: c574bf38
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 1628, stackpage=c574b000)
Stack: e7936a20 c01c782f e7936a20 d33a5a40 00000000 080b7310 080ab1c2
bfffe134
       3131315b 005d3538 c0145aa9 c05a4740 c0258cd8 c2fdc1e0 e7d478c0
c0133b71
       c574bf58 00000007 00002bb1 c01c8330 d33a5b44 00000000 d33a5b44
c01c8f8c
Call Trace: [<c01c782f>] [<c0145aa9>] [<c0133b71>] [<c01c8330>] [<c01c8f8c>]
[<c
010907c>] [<c0108f4b>]
Code: 89 42 04 89 53 38 8d 51 10 89 50 04 89 41 10 89 4b 08 c6 05

>>EIP; c01463b0 <d_instantiate+20/3c>   <=====
Trace; c01c782f <sock_map_fd+11b/1bc>
Trace; c0145aa9 <dput+19/164>
Trace; c0133b71 <fput+79/e8>
Trace; c01c8330 <sys_socket+30/54>
Trace; c01c8f8c <sys_socketcall+64/200>
Code;  c01463b0 <d_instantiate+20/3c>
00000000 <_EIP>:
Code;  c01463b0 <d_instantiate+20/3c>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01463b3 <d_instantiate+23/3c>
   3:   89 53 38                  mov    %edx,0x38(%ebx)
Code;  c01463b6 <d_instantiate+26/3c>
   6:   8d 51 10                  lea    0x10(%ecx),%edx
Code;  c01463b9 <d_instantiate+29/3c>
   9:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c01463bc <d_instantiate+2c/3c>
   c:   89 41 10                  mov    %eax,0x10(%ecx)
Code;  c01463bf <d_instantiate+2f/3c>
   f:   89 4b 08                  mov    %ecx,0x8(%ebx)
Code;  c01463c2 <d_instantiate+32/3c>
  12:   c6 05 00 00 00 00 00      movb   $0x0,0x0

============================================================================
======

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_CPQ_DA=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=32
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=80
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VMDUMP=y

