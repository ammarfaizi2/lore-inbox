Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbRE2REw>; Tue, 29 May 2001 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbRE2REn>; Tue, 29 May 2001 13:04:43 -0400
Received: from falka.mfa.kfki.hu ([148.6.72.6]:54535 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id <S261302AbRE2RE3>;
	Tue, 29 May 2001 13:04:29 -0400
Date: Tue, 29 May 2001 19:03:49 +0200 (CEST)
From: Gergely Tamas <dice@mfa.kfki.hu>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS with 2.4.5 [kernel BUG at inode.c:486]
Message-ID: <Pine.LNX.4.32.0105291858050.4085-100000@falka.mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel 2.4.5 & ReiserFS umount-fix patch
2 CPU SMP, 1 Gb memory

During working on an NFS mounted drive ``/mnt/somewhere'' I got this
oops (multiple times, so it is reproducable).

Thanks in advance,
Gergely

---
somewhere % pwd
/mnt/somewhere

somewhere % ls -l
<...OOPS...>

---
ksymoops 2.4.1 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /boot/System.map-2.4.5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01c4020, System.map says c0154160.  Ignoring ksyms_base entry
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0147db7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: d4f41660   ecx: 00000001   edx: 00000001
esi: f8e6c9e0   edi: e878ae00   ebp: c7a7dfa4   esp: c7a7def0
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 2110, stackpage=c7a7d000)
Stack: c021ed6c c021ee0b 000001e6 d4f41660 c0148891 d4f41660 e87e67c0 d4f41660
       f8e607f0 d4f41660 e87e67c0 c0145e4b e87e67c0 d4f41660 e87e67c0 00000000
       c013d9e8 e87e67c0 c7a7df68 c013e242 f77edac0 c7a7df68 00000000 c3604000
Call Trace: [<c0148891>] [<f8e607f0>] [<c0145e4b>] [<c013d9e8>] [<c013e242>] [<c013d73a>] [<c013e998>]
       [<c013b446>] [<c0106c5b>]
Code: 0f 0b 83 c4 0c 8d 74 26 00 f6 83 f4 00 00 00 10 75 19 68 e8

>>EIP; c0147db7 <clear_inode+33/11c>   <=====
Trace; c0148891 <iput+15d/16c>
Trace; f8e607f0 <[nfs]nfs_dentry_iput+78/80>
Trace; c0145e4b <dput+eb/154>
Trace; c013d9e8 <cached_lookup+48/54>
Trace; c013e242 <path_walk+5e6/844>
Trace; c013d73a <getname+5a/98>
Trace; c013e998 <__user_walk+3c/58>
Trace; c013b446 <sys_lstat64+16/70>
Trace; c0106c5b <system_call+33/38>
Code;  c0147db7 <clear_inode+33/11c>
00000000 <_EIP>:
Code;  c0147db7 <clear_inode+33/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0147db9 <clear_inode+35/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0147dbc <clear_inode+38/11c>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0147dc0 <clear_inode+3c/11c>
   9:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  c0147dc7 <clear_inode+43/11c>
  10:   75 19                     jne    2b <_EIP+0x2b> c0147de2 <clear_inode+5e/11c>
Code;  c0147dc9 <clear_inode+45/11c>
  12:   68 e8 00 00 00            push   $0xe8


2 warnings issued.  Results may not be reliable.

