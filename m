Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318725AbSG0Jaq>; Sat, 27 Jul 2002 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318727AbSG0Jap>; Sat, 27 Jul 2002 05:30:45 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:287 "EHLO twilight.cs.hut.fi")
	by vger.kernel.org with ESMTP id <S318724AbSG0Jan>;
	Sat, 27 Jul 2002 05:30:43 -0400
Date: Sat, 27 Jul 2002 12:33:44 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.29: oops on boot
Message-ID: <20020727093344.GP1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com> <20020727090625.GO1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020727090625.GO1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 12:06:26PM +0300, you [Ville Herva] wrote:
> 2.5.27 and 2.5.28 wouldn't boot at all (they hung at ide probe). 2.5.29
> boots, but oopses after freeing unused memory.
> 
> Again, root = hdc = cdrom with ext2 fs on it. 
> 
> HW is vmware, which may be the cause of the problem (but frankly I don't
> dare to run 2.5 on real hw at this point :).
> 
> 
> <...>
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 8192)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> ds: no socket drivers loaded!
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 216k freed
> Unable to handle kernel paging request at virtual address 645f00ad
> c013f646
> *pde = 00000000

That was with gcc (GCC) 3.1 20020620. With 2.96.110, I get this:

<...>
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

>>EIP; c013f646 <real_lookup+56/d0>   <=====
Trace; c01a68ce <ray_interrupt+de/280>
Trace; c015923c <msdos_partition+1dc/320>
Trace; c0159512 <driverfs_get_inode+72/f0>
Trace; c0168c10 <shm_close+60/e0>
Trace; c017a136 <uart_line_info+6/340>
Trace; c017a16f <uart_line_info+3f/340>
Trace; c012a457 <__kmem_cache_shrink+27/b0>
Trace; c0159675 <driverfs_symlink+15/b0>
Trace; c0168c10 <shm_close+60/e0>
Trace; c0168e57 <newseg+117/170>
Trace; c0168c10 <shm_close+60/e0>
Trace; c0138d26 <__block_commit_write+66/b0>
Trace; c0138e06 <block_read_full_page+96/270>
Trace; c0138ecc <block_read_full_page+15c/270>
Trace; c012ab54 <kfree+44/c0>
Trace; c012adb0 <kmem_cache_reap+1a0/230>
Trace; c012afa8 <s_show+a8/1e0>
Trace; c012adb0 <kmem_cache_reap+1a0/230>
Trace; c0144db1 <fifo_open+1d1/2bd>
Trace; c0144e36 <fifo_open+256/2bd>
Trace; c015bda7 <ext2_set_link+57/e0>
Trace; c0107afb <__down_trylock+3b/50>
Trace; c0138ecc <block_read_full_page+15c/270>
Trace; c012ac98 <kmem_cache_reap+88/230>
Trace; c0131ba1 <bounce_end_io_write+61/90>
Trace; c015b1c0 <ext2_new_block+4f0/740>
Trace; c0145624 <locks_delete_lock+94/d0>
Trace; c01459ae <locks_mandatory_locked+1e/80>
Trace; c0107c1d <sys_sigsuspend+dd/e0>
Trace; c01094df <do_device_not_available+f/80>
Trace; c0105147 <init+f7/190>
Trace; c0105000 <_stext+0/0>
Trace; c01076be <get_wchan+1e/70>
Trace; c0105060 <init+10/190>
Code;  c013f646 <real_lookup+56/d0>
00000000 <_EIP>:
Code;  c013f646 <real_lookup+56/d0>   <=====
   0:   8b 5f 48                  mov    0x48(%edi),%ebx   <=====
Code;  c013f649 <real_lookup+59/d0>
   3:   c7 45 c4 01 00 00 00      movl   $0x1,0xffffffc4(%ebp)
Code;  c013f650 <real_lookup+60/d0>
   a:   8b 7d 08                  mov    0x8(%ebp),%edi
Code;  c013f653 <real_lookup+63/d0>
   d:   88 d9                     mov    %bl,%cl
Code;  c013f655 <real_lookup+65/d0>
   f:   d3 65 c4                  shll   %cl,0xffffffc4(%ebp)
Code;  c013f658 <real_lookup+68/d0>
  12:   8b 47 00                  mov    0x0(%edi),%eax

 <0>Kernel panic: Attempted to kill init!





-- v --

v@iki.fi
