Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTA1NQU>; Tue, 28 Jan 2003 08:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTA1NQU>; Tue, 28 Jan 2003 08:16:20 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40205 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265400AbTA1NQS>; Tue, 28 Jan 2003 08:16:18 -0500
Date: Tue, 28 Jan 2003 14:25:17 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP instability in 2.4.21-pre3-ac4, oops provided
Message-ID: <20030128132517.GA6509@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030128073030.GA1032@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128073030.GA1032@middle.of.nowhere>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan <thunder7@xs4all.nl>
Date: Tue, Jan 28, 2003 at 08:30:30AM +0100
> I'm seeing instability in my new system, a dual Intel P3/1400 tualatin
> system.

I just had another fine specimen. Written down by hand, omitted the
stack values. Can this kmem_cache_alloc_batch function have anything to
do with the 512 K cache size of these Pentium/3 Tualatin CPU's as
opposed to 256 K for normal Pentium/3 Coppermine CPU's?

ksymoops 2.4.8 on i686 2.4.21-pre3-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac4/ (default)
     -m /boot/System.map-2.4.21-pre3-ac4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 594e94b8
c013e564
*pde = 00000000
Oops: 000
CPU:    0
EIP:    0010:[<c013e564>]      Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c013f4ab>] [<c014db03>] [<c014dc4b>] [<c014df46>] [<c014e852>]
 [<c01371d4>] [<c0137328>] [<c01873b0>] [<c0137585>] [<c0137c17>] [<c0138053>]
 [<c013859a>] [<c0138470>] [<c014a2e6>] [<c011724c>] [<c0107abf>]
Code: 8b 44 81 18 0f af 5a 18 8b 51 0c 89 41 14 01 d3 40 74 57 86


>>EIP; c013e564 <kmem_cache_alloc_batch+84/140>   <=====

Trace; c013f4ab <__kmem_cache_alloc+5b/1c0>
Trace; c014db03 <get_unused_buffer_head+d3/180>
Trace; c014dc4b <create_buffers+2b/160>
Trace; c014df46 <create_empty_buffers+26/70>
Trace; c014e852 <block_read_full_page+262/280>
Trace; c01371d4 <add_to_page_cache_unique+b4/f0>
Trace; c0137328 <page_cache_read+118/140>
Trace; c01873b0 <reiserfs_get_block+0/11c0>
Trace; c0137585 <__lock_page+b5/d0>
Trace; c0137c17 <generic_file_readahead+c7/160>
Trace; c0138053 <do_generic_file_read+363/520>
Trace; c013859a <generic_file_read+9a/150>
Trace; c0138470 <file_read_actor+0/90>
Trace; c014a2e6 <sys_read+96/1d0>
Trace; c011724c <smp_apic_timer_interrupt+13c/140>
Trace; c0107abf <system_call+33/38>

Code;  c013e564 <kmem_cache_alloc_batch+84/140>
00000000 <_EIP>:
Code;  c013e564 <kmem_cache_alloc_batch+84/140>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013e568 <kmem_cache_alloc_batch+88/140>
   4:   0f af 5a 18               imul   0x18(%edx),%ebx
Code;  c013e56c <kmem_cache_alloc_batch+8c/140>
   8:   8b 51 0c                  mov    0xc(%ecx),%edx
Code;  c013e56f <kmem_cache_alloc_batch+8f/140>
   b:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c013e572 <kmem_cache_alloc_batch+92/140>
   e:   01 d3                     add    %edx,%ebx
Code;  c013e574 <kmem_cache_alloc_batch+94/140>
  10:   40                        inc    %eax
Code;  c013e575 <kmem_cache_alloc_batch+95/140>
  11:   74 57                     je     6a <_EIP+0x6a>
Code;  c013e577 <kmem_cache_alloc_batch+97/140>
  13:   86 00                     xchg   %al,(%eax)


1 warning issued.  Results may not be reliable.
-- 
Whoever thought that one up should have his head examined. Bloody minstrels...
	Simon R Green - Blue Moon Rising
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2824 bogomips load av: 0.33 0.49 0.23
