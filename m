Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291493AbSBACkK>; Thu, 31 Jan 2002 21:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291495AbSBACkB>; Thu, 31 Jan 2002 21:40:01 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:57537 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S291493AbSBACjt>; Thu, 31 Jan 2002 21:39:49 -0500
Date: Thu, 31 Jan 2002 21:43:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Oops immediately following dbench 192 on 2.5.3
Message-ID: <20020201024337.GA5932@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System has reiserfs root filesystem and other filesystems, except
for the ext2 filesystem that was running dbench 192.  IDE.

Oops occured right after dbench 192 completed, but before
"sync;sync;sync" completed in the "runtests" wrapper script executing 
dbench.  (CLIENTS directory was still on system, after e2fsck 
- this directory is removed when dbench terminates)  An echo
statement did print that dbench 192 completed though.

Earlier, dbench 64 completed without a problem.

Here is the oops:

PAP-5580: reiserfs_cut_from_item: item to convert does not exist ([6 17330 0x1 IND])invalid operand: 0000
CPU:    0
EIP:    0010:[<c015e919>]    Not tainted
EFLAGS: 00010286
eax: 00000057   ebx: c01f69c0   ecx: 00000001   edx: d7014000
esi: d7ea2800   edi: 00000000   ebp: d69c5e40   esp: d69c5c44
ds: 0018   es: 0018   ss: 0018
Process runtests (pid: 68, stackpage=d69c5000)
Stack: c01f553a c0265360 c01f69c0 d69c5c68 d69c5ca0 00000000 c01658ab d7ea2800
       c01f69c0 d69c5e80 c0840de0 00000003 00000000 00000002 00001000 00000000
       00000001 d69c5ca4 00000f60 00000001 00000f60 d7ea2800 63eb2120 00000000
Call Trace: [<c01658ab>] [<c0165e89>] [<c0157cc8>] [<c0158a3c>] [<c012bd64>]
   [<c012af0b>] [<c0135f73>] [<c01085f3>]

Code: 0f 0b 68 60 53 26 c0 b8 40 55 1f c0 85 f6 74 06 8d 86 cc 00
CPU:    0
EIP:    0010:[<c015e919>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000057   ebx: c01f69c0   ecx: 00000001   edx: d7014000
esi: d7ea2800   edi: 00000000   ebp: d69c5e40   esp: d69c5c44
ds: 0018   es: 0018   ss: 0018
Process runtests (pid: 68, stackpage=d69c5000)
Stack: c01f553a c0265360 c01f69c0 d69c5c68 d69c5ca0 00000000 c01658ab d7ea2800
       c01f69c0 d69c5e80 c0840de0 00000003 00000000 00000002 00001000 00000000
       00000001 d69c5ca4 00000f60 00000001 00000f60 d7ea2800 63eb2120 00000000
Call Trace: [<c01658ab>] [<c0165e89>] [<c0157cc8>] [<c0158a3c>] [<c012bd64>]
   [<c012af0b>] [<c0135f73>] [<c01085f3>]
Code: 0f 0b 68 60 53 26 c0 b8 40 55 1f c0 85 f6 74 06 8d 86 cc 00

>>EIP; c015e918 <reiserfs_panic+28/4c>   <=====
Trace; c01658aa <reiserfs_cut_from_item+1b2/450>
Trace; c0165e88 <reiserfs_do_truncate+2f8/424>
Trace; c0157cc8 <reiserfs_truncate_file+c4/158>
Trace; c0158a3c <reiserfs_file_release+31c/340>
Trace; c012bd64 <fput+4c/d0>
Trace; c012af0a <filp_close+5e/68>
Trace; c0135f72 <sys_dup2+8a/b0>
Trace; c01085f2 <syscall_traced+6/a>
Code;  c015e918 <reiserfs_panic+28/4c>
00000000 <_EIP>:
Code;  c015e918 <reiserfs_panic+28/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015e91a <reiserfs_panic+2a/4c>
   2:   68 60 53 26 c0            push   $0xc0265360
Code;  c015e91e <reiserfs_panic+2e/4c>
   7:   b8 40 55 1f c0            mov    $0xc01f5540,%eax
Code;  c015e924 <reiserfs_panic+34/4c>
   c:   85 f6                     test   %esi,%esi
Code;  c015e926 <reiserfs_panic+36/4c>
   e:   74 06                     je     16 <_EIP+0x16> c015e92e <reiserfs_panic+3e/4c>
Code;  c015e928 <reiserfs_panic+38/4c>
  10:   8d 86 cc 00 00 00         lea    0xcc(%esi),%eax

K6-2/475
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_EXPERIMENTAL=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_REISERFS_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

I'll try 2.5.3-dj1, which I see has some reiserfs fixes.
-- 
Randy Hron

