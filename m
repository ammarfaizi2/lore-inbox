Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSA2Rvi>; Tue, 29 Jan 2002 12:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289792AbSA2Rv3>; Tue, 29 Jan 2002 12:51:29 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:45244 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289789AbSA2RvT>; Tue, 29 Jan 2002 12:51:19 -0500
Date: Tue, 29 Jan 2002 12:55:33 -0500
To: linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net
Subject: repeatable oops on 2.5.3-pre6 from LTP socket01 test
Message-ID: <20020129125533.A20077@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First oops came during LTP runalltests.sh.
I tracked it down to specifically the socket01 test.
2.5.3-pre3 passed the socket01 test.

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01cd795>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: c0276cf8   ebx: d7fa93c0   ecx: c0264f08   edx: 00000000
esi: 00000000   edi: 00000000   ebp: cc19218c   esp: cc2a7f4c
ds: 0018   es: 0018   ss: 0018
Process socket01 (pid: 60, stackpage=cc2a7000)
Stack: cc19218c 00000008 c0263f00 0000004b c01a3c85 cc19218c 00000000 00000000
       400140d4 bffffa64 bffff9fc c01a3cca 00000002 0000004b 00000000 cc2a7f90
       00000000 bffffa64 c01a4921 00000002 0000004b 00000000 cc2a6000 00000002
Call Trace: [<c01a3c85>] [<c01a3cca>] [<c01a4921>] [<c0106a63>]
Code: 8b 47 0c 39 c6 75 06 85 f6 75 0a eb de 85 f6 74 4a 85 c0 75

>>EIP; c01cd794 <inet_create+5c/208>   <=====
Trace; c01a3c84 <sock_create+a0/cc>
Trace; c01a3cca <sys_socket+1a/54>
Trace; c01a4920 <sys_socketcall+60/1d4>
Trace; c0106a62 <system_call+32/40>
Code;  c01cd794 <inet_create+5c/208>
00000000 <_EIP>:
Code;  c01cd794 <inet_create+5c/208>   <=====
   0:   8b 47 0c                  mov    0xc(%edi),%eax   <=====
Code;  c01cd796 <inet_create+5e/208>
   3:   39 c6                     cmp    %eax,%esi
Code;  c01cd798 <inet_create+60/208>
   5:   75 06                     jne    d <_EIP+0xd> c01cd7a0 <inet_create+68/208>
Code;  c01cd79a <inet_create+62/208>
   7:   85 f6                     test   %esi,%esi
Code;  c01cd79c <inet_create+64/208>
   9:   75 0a                     jne    15 <_EIP+0x15> c01cd7a8 <inet_create+70/208>
Code;  c01cd79e <inet_create+66/208>
   b:   eb de                     jmp    ffffffeb <_EIP+0xffffffeb> c01cd77e <inet_create+46/208>
Code;  c01cd7a0 <inet_create+68/208>
   d:   85 f6                     test   %esi,%esi
Code;  c01cd7a2 <inet_create+6a/208>
   f:   74 4a                     je     5b <_EIP+0x5b> c01cd7ee <inet_create+b6/208>
Code;  c01cd7a4 <inet_create+6c/208>
  11:   85 c0                     test   %eax,%eax
Code;  c01cd7a6 <inet_create+6e/208>
  13:   75 00                     jne    15 <_EIP+0x15> c01cd7a8 <inet_create+70/208>

Kernel panic: Aiee, killing interrupt handler!

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
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
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
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
CONFIG_MAGIC_SYSRQ=y

Hardware is k6-2
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

No modules, proprietary or otherwise.

Linux Test Project suite available at:
http://prdownloads.sourceforge.net/ltp/ltp-20020108.tgz

-- 
Randy Hron

