Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSG2PMy>; Mon, 29 Jul 2002 11:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSG2PMy>; Mon, 29 Jul 2002 11:12:54 -0400
Received: from mout0.freenet.de ([194.97.50.131]:50871 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317470AbSG2PMx>;
	Mon, 29 Jul 2002 11:12:53 -0400
Date: Mon, 29 Jul 2002 17:16:21 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: 2.5.29: Oops at boot after mount of root fs (JFS)
Message-ID: <20020729151621.GB661@prester.freenet.de>
Mail-Followup-To: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get an oops during boot of 2.5.29. Since I have problems with JFS I
guessed it might be related to JFS. It happens right after rw mount of my
jfs root filesystem. At another attempt to boot not the rm process oops but 
mount itself oopsed.

Checking root file system:
fsck 1.27 (18-Mar-2002)
fsck.jfs version 1.0.20, 21-Jun-2002
The current device is : /dev/hda3
Block size in bytes: 4096
File system size in blocks: 1492036
Phase 0 - Replay Journal Log
File System is clean.
Remounting root device with read-write enabled.
/dev/hda3 on / type jfs (rw)

Then I get this oops:

ksymoops 2.4.6 on i686 2.4.19-rc3-ac3.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.29/ (specified)
     -m /boot/System.map-2.5.29 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000005c
 c014f3c9
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014f3c9>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000 ebx: 00000000 ecx: 0000005c edx: 00000044
esi: cb926960 edi: cbb14eac ebp: cb926960 esp: cb8c9f60
ds: 0018  es: 0018  ss: 0018
Stack: cbb14eac cb926960 cbbd0000 cb926960 cb8c9f80 c014f627 cbb14eac
cb926960
       cbb1218c c11ed368 cbbd0005 00000004 01afef23 00000010 00000000
00000000
       00000000 3d451c26 00001000 00000008 cb8c8000 bfffff41 00000000
bffffc8c
Call Trace: [<c014f627>] [<c010765f>]
Code: ff 405c 0f 8e d4 16 00 00 85 db 74 04 89 d8 eb be 89 34 24


>>EIP; c014f3c9 <vfs_unlink+79/1c0>   <=====

Trace; c014f627 <sys_unlink+117/120>
Trace; c010765f <syscall_call+7/b>

Code;  c014f3c9 <vfs_unlink+79/1c0>
00000000 <_EIP>:
Code;  c014f3c9 <vfs_unlink+79/1c0>   <=====
   0:   ff 5c 40 0f               lcall  *0xf(%eax,%eax,2)   <=====
Code;  c014f3cd <vfs_unlink+7d/1c0>
   4:   8e d4                     mov    %esp,%ss
Code;  c014f3cf <vfs_unlink+7f/1c0>
   6:   16                        push   %ss
Code;  c014f3d0 <vfs_unlink+80/1c0>
   7:   00 00                     add    %al,(%eax)
Code;  c014f3d2 <vfs_unlink+82/1c0>
   9:   85 db                     test   %ebx,%ebx
Code;  c014f3d4 <vfs_unlink+84/1c0>
   b:   74 04                     je     11 <_EIP+0x11> c014f3da
<vfs_unlink+8a/1c0>
Code;  c014f3d6 <vfs_unlink+86/1c0>
   d:   89 d8                     mov    %ebx,%eax
Code;  c014f3d8 <vfs_unlink+88/1c0>
   f:   eb be                     jmp    ffffffcf <_EIP+0xffffffcf> c014f398
<vfs_unlink+48/1c0>
Code;  c014f3da <vfs_unlink+8a/1c0>
  11:   89 34 24                  mov    %esi,(%esp,1)

