Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSATQmA>; Sun, 20 Jan 2002 11:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSATQlp>; Sun, 20 Jan 2002 11:41:45 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20800 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288810AbSATQl3>; Sun, 20 Jan 2002 11:41:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
Date: Sun, 20 Jan 2002 17:41:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120164118.D587513E3@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond et al.,

I can reliably reproduce this oops on my diskless with NFS_ALL applied,
but not with plain-pre4, just by quitting one of {StarOffice,VMware}.

Unable to handle kernel NULL pointer dereference at virtual address 0000005c
c0158fbf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[nfs_update_request+447/768]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: de25eab8
esi: de25e900   edi: 00000000   ebp: de25eab8   esp: e21d1ef0
ds: 0018   es: 0018   ss: 0018
Process soffice.bin (pid: 2030, stackpage=e21d1000)
Stack: de25e900 c17508c0 00000000 00001000 de25e9b4 de25e900 00000000 
de25e900 
       00001000 c01588a2 00000000 de25e900 c17508c0 00000000 00001000 
de25e9b4 
       de25e900 00000000 c17508c0 c0158a2b 00000000 de25e900 c17508c0 
00000000 
Call Trace: [nfs_writepage_async+34/224] [nfs_writepage+203/272] 
[nfs_writepage+0/272] [filemap_fdatasync+83/144] [msync_interval+105/208] 
Code: 8b 58 5c 85 db 74 1d 81 7b 18 f0 a4 4a 0f 74 14 68 b2 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 58 5c                  mov    0x5c(%eax),%ebx
Code;  00000002 Before first symbol
   3:   85 db                     test   %ebx,%ebx
Code;  00000004 Before first symbol
   5:   74 1d                     je     24 <_EIP+0x24> 00000024 Before first 
symbol
Code;  00000006 Before first symbol
   7:   81 7b 18 f0 a4 4a 0f      cmpl   $0xf4aa4f0,0x18(%ebx)
Code;  0000000e Before first symbol
   e:   74 14                     je     24 <_EIP+0x24> 00000024 Before first 
symbol
Code;  00000010 Before first symbol
  10:   68 b2 00 00 00            push   $0xb2


1 warning and 1 error issued.  Results may not be reliable.

Haven't used any funky nfs options:

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_ROOT_NFS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y

It is not related to the symlink fix, I reverted it, just to be sure.
After reverting NFS_ALL, oopsing went away. Any ideas other then trying
all patches one by one :-(

Cheers,
  Hans-Peter
