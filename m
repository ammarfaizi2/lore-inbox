Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281614AbRKUGOC>; Wed, 21 Nov 2001 01:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281617AbRKUGNw>; Wed, 21 Nov 2001 01:13:52 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2944 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281614AbRKUGNr>; Wed, 21 Nov 2001 01:13:47 -0500
Date: Wed, 21 Nov 2001 00:16:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Message-ID: <20011121001639.A813@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Here's really strange one.  Building a module against 2.4.15-pre7 
seems to generate invalid opcodes (???) from the kernel includes.
THe code looks very strange.  Perhaps someone who owns kmem_cache_create
has some idea?

Oops attached.

Jeff


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kmem.oops"

ksymoops 2.4.0 on i686 2.4.15-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre7/ (default)
     -m /boot/System.map-2.4.15-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov 21 00:11:14 vger kernel: invalid operand: 0000
Nov 21 00:11:14 vger kernel: CPU:    0
Nov 21 00:11:14 vger kernel: EIP:    0010:[<c012b0eb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 21 00:11:14 vger kernel: EFLAGS: 00010246
Nov 21 00:11:14 vger kernel: eax: 00000000   ebx: c13da430   ecx: c13da590   edx: c13da684
Nov 21 00:11:14 vger kernel: esi: c13da58d   edi: cc9d8a40   ebp: c13da590   esp: c90e9ef8
Nov 21 00:11:14 vger kernel: ds: 0018   es: 0018   ss: 0018
Nov 21 00:11:14 vger kernel: Process nwfs-async0 (pid: 657, stackpage=c90e9000)
Nov 21 00:11:14 vger kernel: Stack: c90e9efc 00000040 c9265a90 cc9ed5c0 00000000 00000000 cc9b8f17 cc9d8a2f 
Nov 21 00:11:14 vger kernel:        00000060 00000020 00002000 00000000 00000000 00000000 00000000 00000000 
Nov 21 00:11:14 vger kernel:        00000000 00000000 cc9b97c5 00000008 00000200 00000008 c1242bc0 c930c818 
Nov 21 00:11:14 vger kernel: Call Trace: [<cc9ed5c0>] [<cc9b8f17>] [<cc9d8a2f>] [<cc9b97c5>] [<cc9ed5c0>] 
Nov 21 00:11:14 vger kernel:    [<cc9b6314>] [<cc9b6241>] [<cc9ddea0>] [<c0105bdc>] [<cc9ac4e7>] [<cc9d4f69>] 
Nov 21 00:11:14 vger kernel:    [<c0105616>] [<cc9ac478>] 
Nov 21 00:11:14 vger kernel: Code: 0f 0b 89 d1 8b 01 89 c2 0f 18 02 81 f9 4c 2b 2e c0 75 d2 8d 

>>EIP; c012b0eb <kmem_cache_create+2fb/340>   <=====
Trace; cc9ed5c0 <[nwfs]__module_using_checksums+9772/1c771>
Trace; cc9b8f17 <[nwfs]nwfs_get_bh+27/64>
Trace; cc9d8a2f <[nwfs].rodata.start+398f/8d3f>
Trace; cc9b97c5 <[nwfs]aReadDiskSectors+c9/210>
Trace; cc9ed5c0 <[nwfs]__module_using_checksums+9772/1c771>
Trace; cc9b6314 <[nwfs]process_asynch_io+174/274>
Trace; cc9b6241 <[nwfs]process_asynch_io+a1/274>
Trace; cc9ddea0 <[nwfs]asynch_io_sem0+8/14>
Trace; c0105bdc <__down+bc/d0>
Trace; cc9ac4e7 <[nwfs]nwfs_asynch_io_process+6f/cc>
Trace; cc9d4f69 <[nwfs].text.end+2e/165>
Trace; c0105616 <kernel_thread+26/30>
Trace; cc9ac478 <[nwfs]nwfs_asynch_io_process+0/cc>
Code;  c012b0eb <kmem_cache_create+2fb/340>
00000000 <_EIP>:
Code;  c012b0eb <kmem_cache_create+2fb/340>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b0ed <kmem_cache_create+2fd/340>
   2:   89 d1                     mov    %edx,%ecx
Code;  c012b0ef <kmem_cache_create+2ff/340>
   4:   8b 01                     mov    (%ecx),%eax
Code;  c012b0f1 <kmem_cache_create+301/340>
   6:   89 c2                     mov    %eax,%edx
Code;  c012b0f3 <kmem_cache_create+303/340>
   8:   0f 18 02                  prefetchnta (%edx)
Code;  c012b0f6 <kmem_cache_create+306/340>
   b:   81 f9 4c 2b 2e c0         cmp    $0xc02e2b4c,%ecx
Code;  c012b0fc <kmem_cache_create+30c/340>
  11:   75 d2                     jne    ffffffe5 <_EIP+0xffffffe5> c012b0d0 <kmem_cache_create+2e0/340>
Code;  c012b0fe <kmem_cache_create+30e/340>
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.

--envbJBWh7q8WU6mo--
