Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318713AbSG0JDZ>; Sat, 27 Jul 2002 05:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSG0JDY>; Sat, 27 Jul 2002 05:03:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:8990 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318713AbSG0JDX>; Sat, 27 Jul 2002 05:03:23 -0400
Date: Sat, 27 Jul 2002 12:06:26 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5.29: oops on boot
Message-ID: <20020727090625.GO1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.27 and 2.5.28 wouldn't boot at all (they hung at ide probe). 2.5.29
boots, but oopses after freeing unused memory.

Again, root = hdc = cdrom with ext2 fs on it. 

HW is vmware, which may be the cause of the problem (but frankly I don't
dare to run 2.5 on real hw at this point :).


<...>
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Unable to handle kernel paging request at virtual address 645f00ad
c013f646
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f646>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: 00000000   ebx: c109d138   ecx: c109d138   edx: c109d138
esi: 00000000   edi: 645f0065   ebp: c10cda68   esp: c10cda0c
ds: 0018   es: 0018   ss: 0018
Stack: 00000002 00000060 fffffff5 00000000 c3ee1090 000224b3 00000000 00000000 
       000001d0 c10cda50 00112538 645f0065 c11e2620 0000000c c10cda54 c01a68ce 
       0000000c 00000000 c10cda68 c015923c c109d138 00000000 0000000c c10cdaf8 
Call Trace: [<c01a68ce>] [<c015923c>] [<c0159512>] [<c0168c10>] [<c017a136>] 
   [<c017a16f>] [<c012a457>] [<c0159675>] [<c0168c10>] [<c0168e57>] [<c0168c10>]
   [<c0138d26>] [<c0138e06>] [<c0138ecc>] [<c012ab54>] [<c012adb0>] [<c012afa8>] 
   [<c012adb0>] [<c0144db1>] [<c0144e36>] [<c015bda7>] [<c0107afb>] [<c0138ecc>]
   [<c012ac98>] [<c0131ba1>] [<c015b1c0>] [<c0145624>] [<c01459ae>] [<c0107c1d>] 
   [<c01094df>] [<c0105147>] [<c0105000>] [<c01076be>] [<c0105060>] 
Code: 8b 5f 48 c7 45 c4 01 00 00 00 8b 7d 08 88 d9 d3 65 c4 8b 47 

>>EIP; c013f646 <block_read_full_page+36/2b0>   <=====
Trace; c01a68ce <submit_bio+3e/80>
Trace; c015923c <mpage_bio_submit+3c/50>
Trace; c0159512 <do_mpage_readpage+222/2c0>
Trace; c0168c10 <ext2_get_block+0/1e0>
Trace; c017a136 <radix_tree_reserve+e6/100>
Trace; c017a16f <radix_tree_insert+1f/40>
Trace; c012a457 <add_to_page_cache+c7/f0>
Trace; c0159675 <mpage_readpages+c5/d0>
Trace; c0168c10 <ext2_get_block+0/1e0>
Trace; c0168e57 <ext2_readpages+27/30>
Trace; c0168c10 <ext2_get_block+0/1e0>
Trace; c0138d26 <read_pages+96/a0>
Trace; c0138e06 <do_page_cache_readahead+d6/130>
Trace; c0138ecc <page_cache_readahead+6c/180>
Trace; c012ab54 <do_generic_file_read+84/2e0>
Trace; c012adb0 <file_read_actor+0/a0>
Trace; c012afa8 <generic_file_read+158/180>
Trace; c012adb0 <file_read_actor+0/a0>
Trace; c0144db1 <open_exec+c1/e0>
Trace; c0144e36 <kernel_read+66/70>
Trace; c015bda7 <load_elf_binary+be7/c50>
Trace; c0107afb <__switch_to+10b/110>
Trace; c0138ecc <page_cache_readahead+6c/180>
Trace; c012ac98 <do_generic_file_read+1c8/2e0>
Trace; c0131ba1 <rmqueue+2b1/2f0>
Trace; c015b1c0 <load_elf_binary+0/c50>
Trace; c0145624 <search_binary_handler+94/210>
Trace; c01459ae <do_execve+20e/230>
Trace; c0107c1d <sys_execve+4d/80>
Trace; c01094df <syscall_call+7/b>
Trace; c0105147 <init+e7/1a0>
Trace; c0105000 <_stext+0/0>
Trace; c01076be <kernel_thread+2e/40>
Trace; c0105060 <init+0/1a0>
Code;  c013f646 <block_read_full_page+36/2b0>
00000000 <_EIP>:
Code;  c013f646 <block_read_full_page+36/2b0>   <=====
   0:   8b 5f 48                  mov    0x48(%edi),%ebx   <=====
Code;  c013f649 <block_read_full_page+39/2b0>
   3:   c7 45 c4 01 00 00 00      movl   $0x1,0xffffffc4(%ebp)
Code;  c013f650 <block_read_full_page+40/2b0>
   a:   8b 7d 08                  mov    0x8(%ebp),%edi
Code;  c013f653 <block_read_full_page+43/2b0>
   d:   88 d9                     mov    %bl,%cl
Code;  c013f655 <block_read_full_page+45/2b0>
   f:   d3 65 c4                  shll   %cl,0xffffffc4(%ebp)
Code;  c013f658 <block_read_full_page+48/2b0>
  12:   8b 47 00                  mov    0x0(%edi),%eax

 <0>Kernel panic: Attempted to kill init!



-- v --

v@iki.fi
