Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293169AbSCJTVg>; Sun, 10 Mar 2002 14:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293189AbSCJTV1>; Sun, 10 Mar 2002 14:21:27 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:64719 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S293169AbSCJTVP>; Sun, 10 Mar 2002 14:21:15 -0500
Date: Sun, 10 Mar 2002 14:26:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Opss! on 2.5.6 with ReiserFS
Message-ID: <20020310142609.A22174@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have got oops at boot time from 2.5.6-pre3 and 2.5.6 on 
system with reiserfs root filesystem on ide.  Oops occurs
during attempt to mount /.   No modules in kernel.  
2.5.6-pre2 was okay.

2.5.6:
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c012cae6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012cae6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: d8802000   ebx: 0000000f   ecx: 00000009   edx: 00000000
esi: 00000009   edi: 00002012   ebp: 00000000   esp: c143bd7c
ds: 0018   es: 0018   ss: 0018
Stack: 00001000 00002012 00000000 d7e9a800 c0123f4b c012cfdb 00000000 00002012
       00001000 d7e9a800 d7e54000 d88133ec c012d19c 00000000 00002012 00001000
       d7e9a800 c018cb53 00000000 00002012 00001000 00000400 00000000 d7e9a954
Call Trace: [<c0123f4b>] [<c012cfdb>] [<c012d19c>] [<c018cb53>] [<c012c480>]
   [<c017f486>] [<c017fd43>] [<c0195402>] [<c0130329>] [<c0180112>] [<c017fc1c>]
   [<c01304cf>] [<c013ecb8>] [<c013ef6e>] [<c013edd4>] [<c013f2e0>] [<c01051e9>]
   [<c0105028>] [<c0105550>]
Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 25 ff ff 00 00 89 44

>>EIP; c012cae6 <__get_hash_table+1a/9c>   <=====
Trace; c0123f4b <__vmalloc+fb/1c0>
Trace; c012cfdb <__getblk+17/38>
Trace; c012d19c <__bread+14/6c>
Trace; c018cb53 <journal_init+eb/68c>
Trace; c012c480 <__wait_on_buffer+84/90>
Trace; c017f486 <read_bitmaps+ce/160>
Trace; c017fd43 <reiserfs_fill_super+127/490>
Trace; c0195402 <sprintf+12/18>
Trace; c0130329 <get_sb_bdev+22d/29c>
Trace; c0180112 <reiserfs_get_sb+1a/20>
Trace; c017fc1c <reiserfs_fill_super+0/490>
Trace; c01304cf <do_kern_mount+47/c4>
Trace; c013ecb8 <do_add_mount+64/130>
Trace; c013ef6e <do_mount+14a/164>
Trace; c013edd4 <copy_mount_options+50/a0>
Trace; c013f2e0 <sys_mount+7c/bc>
Trace; c01051e9 <prepare_namespace+a9/e0>
Trace; c0105028 <init+c/124>
Trace; c0105550 <kernel_thread+28/38>
Code;  c012cae6 <__get_hash_table+1a/9c>
00000000 <_EIP>:
Code;  c012cae6 <__get_hash_table+1a/9c>   <=====
   0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
Code;  c012caea <__get_hash_table+1e/9c>
   4:   b0 00                     mov    $0x0,%al
Code;  c012caec <__get_hash_table+20/9c>
   6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
Code;  c012caf1 <__get_hash_table+25/9c>
   b:   01 d0                     add    %edx,%eax
Code;  c012caf3 <__get_hash_table+27/9c>
   d:   25 ff ff 00 00            and    $0xffff,%eax
Code;  c012caf8 <__get_hash_table+2c/9c>
  12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)

 <0>Kernel panic: Attempted to kill init!


2.5.6-pre3 oops looks almost identical.  It is at
http://home.earthlink.net/~rwhron/kernel/2.5.6p3.ksymoops


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
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
CONFIG_SOUND_GAMEPORT=y
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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

-- 
Randy Hron

