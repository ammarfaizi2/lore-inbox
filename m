Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbSAHT6n>; Tue, 8 Jan 2002 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSAHT6g>; Tue, 8 Jan 2002 14:58:36 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:13627 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284979AbSAHT6a>; Tue, 8 Jan 2002 14:58:30 -0500
Date: Tue, 8 Jan 2002 21:58:18 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.21pre2 oops
Message-ID: <20020108215818.J1331@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops while stress testing 2.2.21pre2 and ide subsystem.

The kernel has ide, raid and e2compr patches applied. Of those ide and raid
were in use at the time of oops - no e2compr'ed fs had been mounted after
boot.

It's noteworthy that I have done a LOT of testing with _very_ similar work
loads on 2.2.20 + ide + raid + e2compr and have seen no oopses. The only
difference between this kernel and the 2.2.20 one was the -pre2 patch.

So while this most likely is a merging error of my part, or just some
incompability between the patches, I figured you might want to take a look.

When the oops happened, I was reading two IDE drives in raid0. This was
essentially cat /dev/md0 > /dev/null kind of test to stress the Via KT133
pci transfers.

Rootfs is on ide cdrom, the harddrives had no fs on them.

ksymoops 0.7c on i686 2.2.21pre2-ide+e2compr+raid.  Options
used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.21pre2-ide+e2compr+raid+gibbs+patches/ (default)
     -m ./System.map (specified)

kmem_free: Bad obj addr (objp=c1a0c420, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000003d   ebx: c1a0c420   ecx: ffffffff   edx: 0000003c
esi: cffef740   edi: 00000282   ebp: e82e0b92   esp: cffd5f68
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, process nr: 4, stackpage=cffd5000)
Stack: c756dea0 c02bb728 c1a0c47c cffd5f80 c0126d35 cffef740 c1a0c420
c1a0c420 
       c756dea0 c012777b c1a0c420 c1a0c420 c02bb728 0000332f cffd4000
00000030 
       c011c6a7 c02bb728 00000030 00000004 00000005 00000030 0008e000
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c01eec2e>]
[<c
01215d3>] [<c0106000>] 
       [<c010749f>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c01eec2e <tvecs+182e/31a0>
Trace; c01215d3 <kswapd+63/98>
Trace; c0106000 <get_options+0/74>
Trace; c010749f <kernel_thread+23/30>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e

 kmem_free: Bad obj addr (objp=c1a0ca20, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 0f073000, %cr3 = 0f073000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
EFLAGS: 00010282
eax: 0000003d   ebx: c1a0ca20   ecx: c02276e8   edx: 00000021
esi: cffef740   edi: 00000282   ebp: e82e0b92   esp: cf74bc40
ds: 0018   es: 0018   ss: 0018
Process wrchk (pid: 690, process nr: 25, stackpage=cf74b000)
Stack: c7af2d40 c02c2ff0 c1a0ca7c ffffff0a c0126d35 cffef740 c1a0ca20
c1a0ca20 
       c7af2d40 c012777b c1a0ca20 c1a0ca20 c02c2ff0 0000332f cf74a000
00000005 
       c011c6a7 c02c2ff0 00000005 0000000b 00000005 00000005 00000900
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c0121fb2>]
[<c
01275fc>] [<c012679e>] 
       [<c012695a>] [<c0129ac1>] [<c0188f2d>] [<c0124ece>] [<c0108924>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c0121fb2 <__get_free_pages+9a/2ac>
Trace; c01275fc <grow_buffers+3c/fc>
Trace; c012679e <refill_freelist+a/38>
Trace; c012695a <getblk+11e/144>
Trace; c0129ac1 <block_read+2c1/4f4>
Trace; c0188f2d <md_read+41/48>
Trace; c0124ece <sys_read+ae/c4>
Trace; c0108924 <system_call+34/38>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e

kmem_free: Bad obj addr (objp=c1a0c480, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 0f97f000, %cr3 = 0f97f000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
EFLAGS: 00010282
eax: 0000003d   ebx: c1a0c480   ecx: c02276e8   edx: 00000021
esi: cffef740   edi: 00000282   ebp: e82e0b92   esp: cebbbc38
ds: 0018   es: 0018   ss: 0018
Process wrchk (pid: 795, process nr: 17, stackpage=cebbb000)
Stack: c1a0c480 c02f0b80 c1a0c4dc c967df00 c0126d35 cffef740 c1a0c480
c1a0c480 
       c1a0c480 c012777b c1a0c480 c1a0c480 c02f0b80 0000332e cebba000
00000005 
       c011c6a7 c02f0b80 00000005 00000008 00000005 00000005 00000900
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c0121fb2>]
[<c
01275fc>] [<c012679e>] 
       [<c012695a>] [<c012947d>] [<c012a7f6>] [<c012afc0>] [<c011af63>]
[<c011af
a4>] [<c0112e37>] [<c012bf7c>] 
       [<c012c0ff>] [<c01424a5>] [<c012bf7c>] [<c012c0ff>] [<c012bd73>]
[<c01256
33>] [<c01ef8ad>] [<c01258f6>] 
       [<c0188f75>] [<c0124fc9>] [<c0188f34>] [<c0108924>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c0121fb2 <__get_free_pages+9a/2ac>
Trace; c01275fc <grow_buffers+3c/fc>
Trace; c012679e <refill_freelist+a/38>
Trace; c012695a <getblk+11e/144>
Trace; c012947d <block_write+1b5/538>
Trace; c012a7f6 <read_exec+c2/13c>
Trace; c012afc0 <search_binary_handler+60/120>
Trace; c011af63 <do_anonymous_page+73/84>
Trace; c011afa4 <do_no_page+30/c4>
Trace; c0112e37 <update_process_times+5b/64>
Trace; c012bf7c <do_follow_link+9c/a8>
Trace; c012c0ff <lookup_dentry+177/200>
Trace; c01424a5 <ext2_follow_link+5d/78>
Trace; c012bf7c <do_follow_link+9c/a8>
Trace; c012c0ff <lookup_dentry+177/200>
Trace; c012bd73 <permission+27/2c>
Trace; c0125633 <get_blkfops+1b/20>
Trace; c01ef8ad <tvecs+24ad/31a0>
Trace; c01258f6 <blkdev_open+32/40>
Trace; c0188f75 <md_write+41/48>
Trace; c0124fc9 <sys_write+e5/118>
Trace; c0188f34 <md_write+0/48>
Trace; c0108924 <system_call+34/38>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e

kmem_free: Bad obj addr (objp=c1a0c300, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 03620000, %cr3 = 03620000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
EFLAGS: 00010286
eax: 0000003d   ebx: c1a0c300   ecx: c02276e8   edx: 00000021
esi: cffef740   edi: 00000286   ebp: e82e0b92   esp: c5683d6c
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 1892, process nr: 34, stackpage=c5683000)
Stack: c2d31ea0 c031cb68 c1a0c35c 00000000 c0126d35 cffef740 c1a0c300
c1a0c300 
       c2d31ea0 c012777b c1a0c300 c1a0c300 c031cb68 0000332e c5682000
00000013 
       c011c6a7 c031cb68 00000013 00000002 00000005 00000013 00000ff2
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c0121fb2>]
[<c
012a580>] [<c012b1cc>] 
       [<c0107923>] [<c0108924>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c0121fb2 <__get_free_pages+9a/2ac>
Trace; c012a580 <copy_strings+114/1c0>
Trace; c012b1cc <do_execve+14c/224>
Trace; c0107923 <sys_execve+2f/58>
Trace; c0108924 <system_call+34/38>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e

kmem_free: Bad obj addr (objp=c1a0cba0, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 03620000, %cr3 = 03620000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
EFLAGS: 00010286
eax: 0000003d   ebx: c1a0cba0   ecx: c02276e8   edx: 00000021
esi: cffef740   edi: 00000286   ebp: e82e0b92   esp: c5683d6c
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 1912, process nr: 34, stackpage=c5683000)
Stack: c1a0cba0 c031cd70 c1a0cbfc 00000000 c0126d35 cffef740 c1a0cba0
c1a0cba0 
       c1a0cba0 c012777b c1a0cba0 c1a0cba0 c031cd70 0000332f c5682000
00000013 
       c011c6a7 c031cd70 00000013 0000001a 00000005 00000013 00000ff2
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c0121fb2>]
[<c
012a580>] [<c012b1cc>] 
       [<c0107923>] [<c0108924>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c0121fb2 <__get_free_pages+9a/2ac>
Trace; c012a580 <copy_strings+114/1c0>
Trace; c012b1cc <do_execve+14c/224>
Trace; c0107923 <sys_execve+2f/58>
Trace; c0108924 <system_call+34/38>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e

kmem_free: Bad obj addr (objp=c1a0cb40, name=buffer_head)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 03620000, %cr3 = 03620000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120871>]
EFLAGS: 00010282
eax: 0000003d   ebx: c1a0cb40   ecx: c02276e8   edx: 00000021
esi: cffef740   edi: 00000282   ebp: e82e0b92   esp: c5683d6c
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 1915, process nr: 34, stackpage=c5683000)
Stack: c1a0c000 c031cde8 c1a0cb9c 00000000 c0126d35 cffef740 c1a0cb40
c1a0cb40 
       c1a0c000 c012777b c1a0cb40 c1a0cb40 c031cde8 0000332d c5682000
00000013 
       c011c6a7 c031cde8 00000013 00000020 00000005 00000013 00000ff2
c012150a 
Call Trace: [<c0126d35>] [<c012777b>] [<c011c6a7>] [<c012150a>] [<c0121fb2>]
[<c
012a580>] [<c012b1cc>] 
       [<c0107923>] [<c0108924>] 
Code: c7 05 00 00 00 00 00 00 00 00 eb 12 8d 76 00 56 53 68 3e ea 

>>EIP; c0120871 <kmem_cache_free+14d/174>   <=====
Trace; c0126d35 <put_unused_buffer_head+21/4c>
Trace; c012777b <try_to_free_buffers+3b/a4>
Trace; c011c6a7 <shrink_mmap+103/160>
Trace; c012150a <try_to_free_pages+26/8c>
Trace; c0121fb2 <__get_free_pages+9a/2ac>
Trace; c012a580 <copy_strings+114/1c0>
Trace; c012b1cc <do_execve+14c/224>
Trace; c0107923 <sys_execve+2f/58>
Trace; c0108924 <system_call+34/38>
Code;  c0120871 <kmem_cache_free+14d/174>
00000000 <_EIP>:
Code;  c0120871 <kmem_cache_free+14d/174>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0120878 <kmem_cache_free+154/174>
   7:   00 00 00 
Code;  c012087b <kmem_cache_free+157/174>
   a:   eb 12                     jmp    1e <_EIP+0x1e> c012088f
<kmem_cache_fre
e+16b/174>
Code;  c012087d <kmem_cache_free+159/174>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120880 <kmem_cache_free+15c/174>
   f:   56                        push   %esi
Code;  c0120881 <kmem_cache_free+15d/174>
  10:   53                        push   %ebx
Code;  c0120882 <kmem_cache_free+15e/174>
  11:   68 3e ea 00 00            push   $0xea3e



3 warnings issued.  Results may not be reliable.

 
-- v --

v@iki.fi
