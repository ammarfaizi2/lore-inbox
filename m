Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbRLKLCN>; Tue, 11 Dec 2001 06:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284965AbRLKLCD>; Tue, 11 Dec 2001 06:02:03 -0500
Received: from [213.196.40.44] ([213.196.40.44]:45517 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S284966AbRLKLB4>;
	Tue, 11 Dec 2001 06:01:56 -0500
Date: Tue, 11 Dec 2001 09:14:44 +0100 (CET)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre8 oopses on non existing acorn partition
Message-ID: <Pine.LNX.4.33.0112110910350.1461-100000@laptop.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.1-pre8 oopses in adfspart_check_ICS (probably the put_dev_sector, 
not entirely sure, since there doesn't seem to be anything wrong).
I've enabled advanced partitions, and all the partition types.
Disabling advanced partitions fixes it.

I'm including the output of ksymoops, and hope that it helps,

Bas Vermeulen

ksymoops 2.4.1 on i686 2.5.0.  Options used
     -v /usr/src/linux-2.5.1/vmlinux (specified)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /lib/modules/2.5.1-pre8 (specified)
     -m /usr/src/linux-2.5.1/System.map (specified)

Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012d113>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a83
eax: 00000000   ebx: 00000000   ecx: 506230c2   edx: 000001fc
esi: c1571124   edi: 00000001   ebp: 00000001   esp: d3fe1e9a
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=d3fe1000)
Stack: c1055b80 c01517b1 c1055b80 0000003f c1055b80 00000246 0000115c 00000246 
       00000000 c1571124 c02d0270 00000001 00000000 c015190e d3fe75cc c1571124 
       00000000 00000001 c02d0244 c1571124 d3fe75cc 00000000 c0150fd2 d3fe75cc 
Call Trace: [<c01517b1>] [<c015190e>] [<c0150fd2>] [<c01dfa58>] [<c01ea5d2>] 
   [<c0151161>] [<c01dd328>] [<c0105000>] [<c0105039>] [<c0105000>] [<c01055f6>]
   [<c0105030>]
Code: 8b 43 18 a9 00 40 00 00 75 23 ff 4b 14 0f 94 c0 84 c0 74 19 

>>EIP; c012d113 <page_cache_release+3/40>   <=====
Trace; c01517b1 <adfspart_check_ICS+71/f0>
Trace; c015190e <acorn_partition+2e/60>
Trace; c0150fd2 <check_partition+f2/170>
Trace; c01dfa58 <ide_add_setting+88/120>
Trace; c01ea5d2 <ide_cdrom_add_settings+b2/c0>
Trace; c0151161 <grok_partitions+d1/110>
Trace; c01dd328 <ide_geninit+68/90>
Trace; c0105000 <_stext+0/0>
Trace; c0105039 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c01055f6 <kernel_thread+26/30>
Trace; c0105030 <init+0/140>
Code;  c012d113 <page_cache_release+3/40>
00000000 <_EIP>:
Code;  c012d113 <page_cache_release+3/40>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c012d116 <page_cache_release+6/40>
   3:   a9 00 40 00 00            test   $0x4000,%eax
Code;  c012d11b <page_cache_release+b/40>
   8:   75 23                     jne    2d <_EIP+0x2d> c012d140 <page_cache_release+30/40>
Code;  c012d11d <page_cache_release+d/40>
   a:   ff 4b 14                  decl   0x14(%ebx)
Code;  c012d120 <page_cache_release+10/40>
   d:   0f 94 c0                  sete   %al
Code;  c012d123 <page_cache_release+13/40>
  10:   84 c0                     test   %al,%al
Code;  c012d125 <page_cache_release+15/40>
  12:   74 19                     je     2d <_EIP+0x2d> c012d140 <page_cache_release+30/40>


1 error issued.  Results may not be reliable.

