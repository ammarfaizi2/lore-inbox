Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277545AbRJJXuo>; Wed, 10 Oct 2001 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJJXuf>; Wed, 10 Oct 2001 19:50:35 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:25676 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277545AbRJJXuS>; Wed, 10 Oct 2001 19:50:18 -0400
Date: Thu, 11 Oct 2001 00:50:58 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.9
Message-ID: <20011011005058.H1358@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overnight I had a couple of oopsen on my Athlon box, now I've had some
more when running rpm and ksymoops.

System is RedHat 7.1, Athlon 800, Abit KA7-100 m/b.

The 5th August CVS snapshot of the ieee1394 code had been applied (and
worked without incident for a month or so).

First, the one just now, when running rpm:


ksymoops 2.4.3 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /boot/System.map-2.4.9 (specified)

kernel BUG at inode.c:677!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e3d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: d91824c8   ecx: 00000005   edx: dee91cc0
esi: d91824c0   edi: 64646120   ebp: cb187e7c   esp: cb187e54
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 15330, stackpage=cb187000)
Stack: c0247819 c02478b5 000002a5 00000000 000001d3 d918da48 c9834388 00000004
       000000d2 00000028 00000001 c0141f1d 00000077 c0128a40 00000006 000000d2
       00000006 000000d2 cb186000 00000010 00000000 000000d2 c0128ba8 000000d2
Call Trace: [<c0141f1d>] [<c0128a40>] [<c0128ba8>] [<c012979e>] [<c0150120>]
   [<c01223e1>] [<c0122627>] [<c01229f0>] [<c0122930>] [<c012ed05>] [<c014f110>]
   [<c012eb7e>] [<c0106ecb>]
Code: 0f 0b 83 c4 0c 8b 86 f4 00 00 00 90 8d b4 26 00 00 00 00 0b

>>EIP; c0141e3c <prune_icache+5c/120>   <=====
Trace; c0141f1c <shrink_icache_memory+1c/30>
Trace; c0128a40 <do_try_to_free_pages+60/c0>
Trace; c0128ba8 <try_to_free_pages+28/40>
Trace; c012979e <__alloc_pages+1be/270>
Trace; c0150120 <ext2_get_block+0/400>
Trace; c01223e0 <generic_file_readahead+1b0/240>
Trace; c0122626 <do_generic_file_read+1b6/4c0>
Trace; c01229f0 <generic_file_read+60/80>
Trace; c0122930 <file_read_actor+0/60>
Trace; c012ed04 <sys_read+94/d0>
Trace; c014f110 <ext2_file_lseek+0/b0>
Trace; c012eb7e <sys_lseek+6e/80>
Trace; c0106eca <system_call+32/38>
Code;  c0141e3c <prune_icache+5c/120>
00000000 <_EIP>:
Code;  c0141e3c <prune_icache+5c/120>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0141e3e <prune_icache+5e/120>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0141e40 <prune_icache+60/120>
   5:   8b 86 f4 00 00 00         mov    0xf4(%esi),%eax
Code;  c0141e46 <prune_icache+66/120>
   b:   90                        nop    
Code;  c0141e48 <prune_icache+68/120>
   c:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0141e4e <prune_icache+6e/120>
  13:   0b 00                     or     (%eax),%eax

now the first one which happened overnight just as the updatedb cron job
was running:


ksymoops 2.4.3 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /boot/System.map-2.4.9 (specified)

Unable to handle kernel paging request at virtual address 30303050
c0141f4a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[find_inode+26/80]
EIP:    0010:[<c0141f4a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: dff80000   ebx: 30303030   ecx: 0000000f   edx: 00001ca2
esi: 30303030   edi: 000437f5   ebp: dff8e510   esp: cb1e7e8c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 8921, stackpage=cb1e7000)
Stack: d659ca40 dff8e510 000437f5 df976a00 c0142331 df976a00 00043
       00000000 00000000 00000000 c9d22080 c9d22080 c0994340 d659c
       c9d22080 c0994340 c0151822 df976a00 000437f5 00000000 00000
Call Trace: [iget4+65/192] [ext2_lookup+66/112] [real_lookup+77/19
Call Trace: [<c0142331>] [<c0151822>] [<c0138b2d>] [<c013921c>] [<
   [<c01368f2>] [<c0106ecb>] 
Code: 39 7e 20 75 f1 8b 44 24 14 39 86 8c 00 00 00 75 e5 8b 4c 24 

>>EIP; c0141f4a <find_inode+1a/50>   <=====
Trace; c0142330 <iget4+40/c0>
Trace; c0151822 <ext2_lookup+42/70>
Trace; c0138b2c <real_lookup+4c/c0>
Trace; c013921c <path_walk+57c/7c0>
Trace; c01368f2 <sys_lstat64+12/70>
Trace; c0106eca <system_call+32/38>
Code;  c0141f4a <find_inode+1a/50>
00000000 <_EIP>:
Code;  c0141f4a <find_inode+1a/50>   <=====
   0:   39 7e 20                  cmp    %edi,0x20(%esi)   <=====
Code;  c0141f4c <find_inode+1c/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c0141f40 <find_inode+10/50>
Code;  c0141f4e <find_inode+1e/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c0141f52 <find_inode+22/50>
   9:   39 86 8c 00 00 00         cmp    %eax,0x8c(%esi)
Code;  c0141f58 <find_inode+28/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c0141f40 <find_inode+10/50>
Code;  c0141f5a <find_inode+2a/50>
  11:   8b 4c 24 00               mov    0x0(%esp,1),%ecx


