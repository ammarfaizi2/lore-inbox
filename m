Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGQRVZ>; Wed, 17 Jul 2002 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSGQRVY>; Wed, 17 Jul 2002 13:21:24 -0400
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:17556 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315457AbSGQRVX>; Wed, 17 Jul 2002 13:21:23 -0400
Date: Wed, 17 Jul 2002 13:23:36 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.26] Reproducable oops with X Font Server
Message-ID: <Pine.LNX.4.43.0207171311150.7414-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can reproducably oops my 2.5.26 kernel by stopping and starting the X
font server on my Debian Sid machine; the decoded oops always looks very
similar. I can't reproduce this on 2.4.x

Note: this kernel has ACPI support built in, but the machine doesn't have
ACPI.

Linux version 2.5.26 (root@razor) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Wed Jul 17 10:58:47 EST 2002

Unable to handle kernel paging request at virtual address 5a5a5ace
c011083f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011083f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010813
eax: c1e02000   ebx: c1df1580   ecx: c1a92040   edx: 5a5a5a5a
esi: c1efa270   edi: c1a92040   ebp: c1e03ed8   esp: c1e03ec8
ds: 0018   es: 0018   ss: 0018
Stack: 7fffffff c1f003ec c1e03f60 c1a92040 c1eff000 c011afe0 00000008 c1f003ec
       00000000 00000246 c1eff980 c1f003ec c01eced4 c01ecf24 c1eff000 c1f003ec
       c1f0c5e0 c1f0040c c1effbfc c1eff980 40014009 c1eff974 7fffffff 00000000
Call Trace: [<c011afe0>] [<c01eced4>] [<c01ecf24>] [<c0110974>] [<c0110974>]
            [<c01e8c74>] [<c0133af0>] [<c0133ca6>] [<c0106c8f>]
Code: 0f ba 6a 74 00 8b 42 0c 05 00 00 00 40 0f 22 d8 8b 8a 80 00


>>EIP; c011083f <schedule+1b7/2b4>   <=====

>>eax; c1e02000 <END_OF_CODE+1a84844/????>
>>ebx; c1df1580 <END_OF_CODE+1a73dc4/????>
>>ecx; c1a92040 <END_OF_CODE+1714884/????>
>>edx; 5a5a5a5a Before first symbol
>>esi; c1efa270 <END_OF_CODE+1b7cab4/????>
>>edi; c1a92040 <END_OF_CODE+1714884/????>
>>ebp; c1e03ed8 <END_OF_CODE+1a8671c/????>
>>esp; c1e03ec8 <END_OF_CODE+1a8670c/????>

Trace; c011afe0 <schedule_timeout+14/a4>
Trace; c01eced4 <read_chan+340/760>
Trace; c01ecf24 <read_chan+390/760>
Trace; c0110974 <default_wake_function+0/34>
Trace; c0110974 <default_wake_function+0/34>
Trace; c01e8c74 <tty_read+d0/128>
Trace; c0133af0 <vfs_read+94/110>
Trace; c0133ca6 <sys_read+2a/3c>
Trace; c0106c8f <syscall_call+7/b>

Code;  c011083f <schedule+1b7/2b4>
00000000 <_EIP>:
Code;  c011083f <schedule+1b7/2b4>   <=====
   0:   0f ba 6a 74 00            btsl   $0x0,0x74(%edx)   <=====
Code;  c0110844 <schedule+1bc/2b4>
   5:   8b 42 0c                  mov    0xc(%edx),%eax
Code;  c0110847 <schedule+1bf/2b4>
   8:   05 00 00 00 40            add    $0x40000000,%eax
Code;  c011084c <schedule+1c4/2b4>
   d:   0f 22 d8                  mov    %eax,%cr3
Code;  c011084f <schedule+1c7/2b4>
  10:   8b 8a 80 00 00 00         mov    0x80(%edx),%ecx



--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


