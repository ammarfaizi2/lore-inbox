Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSECJSE>; Fri, 3 May 2002 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315617AbSECJSD>; Fri, 3 May 2002 05:18:03 -0400
Received: from Expansa.sns.it ([192.167.206.189]:14597 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S315616AbSECJR5>;
	Fri, 3 May 2002 05:17:57 -0400
Date: Fri, 3 May 2002 11:17:52 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: ext2 related,two oops with 2.5.12 on ATA66 disk.
Message-ID: <Pine.LNX.4.44.0205031112060.6202-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

this morning, going at work, I found those two oops (repeated a lto of
times), on the Pentium III 512MB ram, i810 chipset, Maxtor 32049H2 ATA66
disk.

buffer layer error at buffer.c:1380

c893dee8 c0236aa0 c0236a6c c0236ad0 00000544 c0137a5c c0236ad0 00000544
       c11518e0 00000000 c9607000 d6740970 00000000 00000000 00000000
c013898c
       d6740970 c11518e0 c0169f8c c11518e0 c893c000 d6740a08 d6740a30
c016a30b
Call Trace: [<c0137a5c>] [<c013898c>] [<c0169f8c>] [<c016a30b>]
[<c0169f8c>]
   [<c01336fd>] [<c016a2fc>] [<c01270ad>] [<c0132957>] [<c0132a52>]
[<c0106e5f>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0137a5c <__block_write_full_page+ec/330>
Trace; c013898c <block_write_full_page+a0/a8>
Trace; c0169f8c <ext2_get_block+0/370>
Trace; c016a30a <ext2_writepage+e/14>
Trace; c0169f8c <ext2_get_block+0/370>
Trace; c01336fc <generic_writeback_mapping+120/1c0>
Trace; c016a2fc <ext2_writepage+0/14>
Trace; c01270ac <filemap_fdatawrite+20/28>
Trace; c0132956 <msync_interval+7a/dc>
Trace; c0132a52 <sys_msync+9a/e8>
Trace; c0106e5e <syscall_call+6/a>


AND

kernel BUG at ll_rw_blk.c:1409!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01d04f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000045   ebx: d06ec5e0   ecx: c1489a80   edx: dfd89a60
esi: 00000001   edi: c11518e0   ebp: d06ecb20   esp: c893def4
ds: 0018   es: 0018   ss: 0018
Stack: d06ec5e0 d06ec620 c0137ba7 00000001 d06ec5e0 c11518e0 00000000
c9607000
       d6740970 00000001 00000000 00000000 c013898c d6740970 c11518e0
c0169f8c
       c11518e0 c893c000 d6740a08 d6740a30 c016a30b c11518e0 c0169f8c
c01336fd
Call Trace: [<c0137ba7>] [<c013898c>] [<c0169f8c>] [<c016a30b>]
[<c0169f8c>]
   [<c01336fd>] [<c016a2fc>] [<c01270ad>] [<c0132957>] [<c0132a52>]
[<c0106e5f>]
Code: 0f 0b 81 05 2a 4d 25 c0 83 7b 20 00 75 0a 0f 0b 82 05 2a 4d

>>EIP; c01d04f8 <submit_bh+20/f0>   <=====
Trace; c0137ba6 <__block_write_full_page+236/330>
Trace; c013898c <block_write_full_page+a0/a8>
Trace; c0169f8c <ext2_get_block+0/370>
Trace; c016a30a <ext2_writepage+e/14>
Trace; c0169f8c <ext2_get_block+0/370>
Trace; c01336fc <generic_writeback_mapping+120/1c0>
Trace; c016a2fc <ext2_writepage+0/14>
Trace; c01270ac <filemap_fdatawrite+20/28>
Trace; c0132956 <msync_interval+7a/dc>
Trace; c0132a52 <sys_msync+9a/e8>
Trace; c0106e5e <syscall_call+6/a>
Code;  c01d04f8 <submit_bh+20/f0>
00000000 <_EIP>:
Code;  c01d04f8 <submit_bh+20/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01d04fa <submit_bh+22/f0>
   2:   81 05 2a 4d 25 c0 83      addl   $0x207b83,0xc0254d2a
Code;  c01d0500 <submit_bh+28/f0>
   9:   7b 20 00
Code;  c01d0504 <submit_bh+2c/f0>
   c:   75 0a                     jne    18 <_EIP+0x18> c01d0510
<submit_bh+38/f0>
Code;  c01d0506 <submit_bh+2e/f0>
   e:   0f 0b                     ud2a
Code;  c01d0508 <submit_bh+30/f0>
  10:   82                        (bad)
Code;  c01d0508 <submit_bh+30/f0>
  11:   05 2a 4d 00 00            add    $0x4d2a,%eax



The system was just running xscreensaver full night, with openGL morph3D
(ok, very very slow on i810, but I like it) at 16bpp.

I could not make a clean shutdown, since I had a freeze at umount, but
strangelly during e2fsck no corruption was detected.

I Hope this helps

Luigi

