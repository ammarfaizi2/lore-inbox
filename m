Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317958AbSGWGDb>; Tue, 23 Jul 2002 02:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317959AbSGWGDb>; Tue, 23 Jul 2002 02:03:31 -0400
Received: from [196.26.86.1] ([196.26.86.1]:24511 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317958AbSGWGD3>; Tue, 23 Jul 2002 02:03:29 -0400
Date: Tue, 23 Jul 2002 08:24:30 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd memory corruption in 2.5.27?
In-Reply-To: <Pine.LNX.4.44.0207230822040.32636-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0207230824010.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Hmm this is wild pointer #2, whats -really- freaky is that its the same 
address 0x14(00000078), this was also over NFS.

Unable to handle kernel NULL pointer dereference at virtual address 0000008c
c014cd1d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014cd1d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: ccefb4c0   ebx: 00000078   ecx: 00000003   edx: ccf30000
esi: ccefb39c   edi: 00000003   ebp: bfffe998   esp: ccf31f5c
ds: 0018   es: 0018   ss: 0018
Stack: ccf31f7c fffffff7 c0154970 ccf31f7c bfffe9e0 c0154ed1 00000003 ccf31f7c
       00000246 00000246 c4ca7000 00000001 00000000 00000000 00000400 00000078
       00000003 c4ca7000 bfffe9c8 c014b066 c16b6a30 c4ca7000 ccf30000 bfffe9e0
Call Trace: [<c0154970>] [<c0154ed1>] [<c014b066>] [<c01075db>]
Code: f0 ff 43 14 f0 ff 46 04 ff 4a 10 8b 42 08 83 e0 08 74 05 e8

>>EIP; c014cd1d <fget+4d/70>   <=====
Trace; c0154970 <vfs_fstat+10/40>
Trace; c0154ed1 <sys_fstat64+11/30>
Trace; c014b066 <sys_open+66/70>
Trace; c01075db <syscall_call+7/b>
Code;  c014cd1d <fget+4d/70>
00000000 <_EIP>:
Code;  c014cd1d <fget+4d/70>   <=====
   0:   f0 ff 43 14               lock incl 0x14(%ebx)   <=====
Code;  c014cd21 <fget+51/70>
   4:   f0 ff 46 04               lock incl 0x4(%esi)
Code;  c014cd25 <fget+55/70>
   8:   ff 4a 10                  decl   0x10(%edx)
Code;  c014cd28 <fget+58/70>
   b:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c014cd2b <fget+5b/70>
   e:   83 e0 08                  and    $0x8,%eax
Code;  c014cd2e <fget+5e/70>
  11:   74 05                     je     18 <_EIP+0x18> c014cd35 <fget+65/70>
Code;  c014cd30 <fget+60/70>

-- 
function.linuxpower.ca

