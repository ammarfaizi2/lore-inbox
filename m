Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAKAOt>; Wed, 10 Jan 2001 19:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAKAOa>; Wed, 10 Jan 2001 19:14:30 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:34311 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S129584AbRAKAOS>;
	Wed, 10 Jan 2001 19:14:18 -0500
Date: Thu, 11 Jan 2001 01:13:28 +0100
From: Ulrich Schwarz <uschwarz@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 vm BUG (ksymoopsed)
Message-ID: <20010111011328.A2945@fruli.2y.net>
In-Reply-To: <20010111003132.A2134@fruli.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111003132.A2134@fruli.2y.net>; from uschwarz@gmx.net on Thu, Jan 11, 2001 at 12:31:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0 (final i586) patched with reiserfs 3.6.25 produced the following BUG:


the console report (ksymoopsed):

kernel BUG at vmscan.c:452!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01260fd>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c101322c   ecx: c0274608   edx: 00000000
esi: c23acc24   edi: c1013210   ebp: 000000ef   esp: c23d9c80
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 340, stackpage=c23d9000)
Stack: c0225a73 c0225c12 000001c4 c02757a0 c0275a0c 00000001 00000000 c0127a28
       c02757a0 00000000 c0275a10 00000000 00008038 c0127b9d c0275a04 00000000
       00000001 00000001 00000000 00001000 00000000 00008038 00000003 00000001
Call Trace: [<c0127a28>] [<c0127b9d>] [<c012f8e2>] [<c012da24>] [<c012da31>] [<c012de12>] [<c012e022>]
       [<c0184a5b>] [<c0180b2d>] [<c01748d9>] [<c013eacb>] [<c013ecf6>] [<c0174950>] [<c0171351>] [<c0135dcb>]
       [<c0136199>] [<c0136acc>] [<c0133786>] [<c0108e73>]
Code: 0f 0b 83 c4 0c 31 c0 0f b3 47 18 19 c0 85 c0 75 19 68 c5 01

>>EIP; c01260fd <reclaim_page+3a9/41c>   <=====
Trace; c0127a28 <__alloc_pages_limit+7c/ac>
Trace; c0127b9d <__alloc_pages+145/2e0>
Trace; c012f8e2 <grow_buffers+3e/16c>
Trace; c012da24 <refill_freelist+1c/30>
Trace; c012da31 <refill_freelist+29/30>
Trace; c012de12 <getblk+f2/108>
Trace; c012e022 <bread+1a/68>
Trace; c0184a5b <reiserfs_bread+17/1c>
Trace; c0180b2d <search_by_key+75/c80>
Trace; c01748d9 <reiserfs_read_inode2+75/c8>
Trace; c013eacb <get_new_inode+c3/158>
Trace; c013ecf6 <iget4+ba/cc>
Trace; c0174950 <reiserfs_iget+24/64>
Trace; c0171351 <reiserfs_lookup+9d/d8>
Trace; c0135dcb <real_lookup+53/c4>
Trace; c0136199 <path_walk+225/7ac>
Trace; c0136acc <__user_walk+3c/58>
Trace; c0133786 <sys_newstat+16/70>
Trace; c0108e73 <system_call+33/40>
Code;  c01260fd <reclaim_page+3a9/41c>
00000000 <_EIP>:
Code;  c01260fd <reclaim_page+3a9/41c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01260ff <reclaim_page+3ab/41c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0126102 <reclaim_page+3ae/41c>
   5:   31 c0                     xor    %eax,%eax
Code;  c0126104 <reclaim_page+3b0/41c>
   7:   0f b3 47 18               btr    %eax,0x18(%edi)
Code;  c0126108 <reclaim_page+3b4/41c>
   b:   19 c0                     sbb    %eax,%eax
Code;  c012610a <reclaim_page+3b6/41c>
   d:   85 c0                     test   %eax,%eax
Code;  c012610c <reclaim_page+3b8/41c>
   f:   75 19                     jne    2a <_EIP+0x2a> c0126127 <reclaim_page+3d3/41c>
Code;  c012610e <reclaim_page+3ba/41c>
  11:   68 c5 01 00 00            push   $0x1c5

In /var/log/kernlog, this incident was reported as follows:
Jan 10 22:14:54 kernel: kernel BUG at page_alloc.c:74!
Jan 10 22:14:54 kernel: invalid operand: 0000

So long.
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
