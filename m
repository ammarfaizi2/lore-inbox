Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUAMLoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbUAMLoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:44:54 -0500
Received: from [135.196.1.218] ([135.196.1.218]:9123 "EHLO
	pat.aberdeen.paradigmgeo.com") by vger.kernel.org with ESMTP
	id S261567AbUAMLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:44:27 -0500
Message-ID: <798DD0DBF172864C8CC752175CF42BA326C8B2@pat.aberdeen.paradigmgeo.com>
From: Paul Symons <PaulS@paradigmgeo.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kernel oops 2.4.24
Date: Tue, 13 Jan 2004 11:44:18 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having a few problems with 2.4.24. I keep suffering oops's when
performing intensive operations. 

Hardware: VIA EPIA 5000 / C3 processor

I am trying to run Gentoo on this hardware, and have had problems from the
start, with respect to compiling things like Gentoo. The hardware is a
little bit of an oddity, because i read that it is classed as i686, yet it
doesn't support the cmov opcode. All my compile optimisations have been at
best i586 as a result.

I'm not sure why ksymoops reports it as i686. I had originally tried running
on 2.6.0, however I kept getting oops's with the via-rhine driver, so I
thought I'd try with 2.4.24. The only difference with my config between
2.6.0 and 2.4.24 was that 2.6.0 was optimised for VIA-C3 processor type,
while 2.4.24 was optimised for i586.

An example of the intensive operations (well, I just mean non-idling to be
honest) is emerging mysql (e.g. gcc compiling quite large applications) or
grep'ing through the kernel source tree.

I hope there's some relevant information here. If not, what is the best way
for me to obtain more relevant/contextual information to make a meaningful
bug report? I did some searches on google for some of the trace methods, and
I got the impression that my problems may have stemmed from a corrupt swap
partition, which I've since remade and turned back on. I should also add
that when the kernel oops's, the system does not crash, but some things
become unreliable, ssh seems to die a lot for example. postfix stays alive
though.

Kind Regards,

Paul Symons




ksymoops 2.4.9 on i686 2.4.24.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.24/ (specified)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel paging request at virtual address 001da454
c012b12c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__lru_cache_del+92/128]    Not tainted
EIP:    0010:[<c012b12c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c11e0074   ebx: c11ddd74   ecx: c11ddd90   edx: 001da454
esi: 00004000   edi: 00000000   ebp: 00006000   esp: c9ae1ee0
ds: 0018   es: 0018   ss: 0018
Process gcc (pid: 26185, stackpage=c9ae1000)
Stack: c11ddd74 c012c23f c02f3f88 4013df5c cb5d54f4 0aae6067 c02f3ed8
c102c01c 
       00000216 ffffffff 00004c3f 0adc2065 00004000 d2ca9ff8 00006000
c0122bd1 
       c11ddd74 c11ddd74 00000005 c0000000 cac6dc00 c0000000 00000000
c01213f0 
Call Trace:    [__free_pages_ok+47/800] [zap_pte_range+257/294]
[zap_page_range+128/256] [exit_mmap+172/288] [mmput+68/144]
Call Trace:    [<c012c23f>] [<c0122bd1>] [<c01213f0>] [<c012400c>]
[<c0112ba4>]
  [<c01171ad>] [<c011738f>] [<c01070c3>]
Code: 89 02 c7 41 04 00 00 00 00 c7 43 1c 00 00 00 00 6a ff 53 e8 


>>EIP; c012b12c <__lru_cache_del+5c/80>   <=====

>>eax; c11e0074 <_end+e62bd0/17cf1bbc>
>>ebx; c11ddd74 <_end+e608d0/17cf1bbc>
>>ecx; c11ddd90 <_end+e608ec/17cf1bbc>
>>esp; c9ae1ee0 <_end+9764a3c/17cf1bbc>

Trace; c012c23f <__free_pages_ok+2f/320>
Trace; c0122bd1 <zap_pte_range+101/126>
Trace; c01213f0 <zap_page_range+80/100>
Trace; c012400c <exit_mmap+ac/120>
Trace; c0112ba4 <mmput+44/90>
Trace; c01171ad <do_exit+7d/230>
Trace; c011738f <sys_exit+f/10>
Trace; c01070c3 <system_call+33/40>

Code;  c012b12c <__lru_cache_del+5c/80>
00000000 <_EIP>:
Code;  c012b12c <__lru_cache_del+5c/80>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b12e <__lru_cache_del+5e/80>
   2:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c012b135 <__lru_cache_del+65/80>
   9:   c7 43 1c 00 00 00 00      movl   $0x0,0x1c(%ebx)
Code;  c012b13c <__lru_cache_del+6c/80>
  10:   6a ff                     push   $0xffffffff
Code;  c012b13e <__lru_cache_del+6e/80>
  12:   53                        push   %ebx
Code;  c012b13f <__lru_cache_del+6f/80>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b12c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__lru_cache_del+92/128]    Not tainted
EIP:    0010:[<c012b12c>]    Not tainted
EFLAGS: 00010246
eax: c124f98c   ebx: c11e0058   ecx: c11e0074   edx: 001da454
esi: 00001000   edi: 00000000   ebp: 00006000   esp: caed1ee0
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 26059, stackpage=caed1000)
Stack: c11e0058 c012c23f c02f3f88 000167f0 c100001c c124bc14 c02f3ed8
c102c01c 
       00000216 ffffffff 00006299 0ae8d067 00001000 c9c92fec 00006000
c0122bd1 
       c11e0058 c11e0058 00000002 c0000000 cd88bc00 c0000000 00000000
c01213f0 
Call Trace:    [__free_pages_ok+47/800] [zap_pte_range+257/294]
[zap_page_range+128/256] [exit_mmap+172/288] [mmput+68/144]
Call Trace:    [<c012c23f>] [<c0122bd1>] [<c01213f0>] [<c012400c>]
[<c0112ba4>]
  [<c01171ad>] [<c011738f>] [<c01070c3>]
Code: 89 02 c7 41 04 00 00 00 00 c7 43 1c 00 00 00 00 6a ff 53 e8 


>>EIP; c012b12c <__lru_cache_del+5c/80>   <=====

>>eax; c124f98c <_end+ed24e8/17cf1bbc>
>>ebx; c11e0058 <_end+e62bb4/17cf1bbc>
>>ecx; c11e0074 <_end+e62bd0/17cf1bbc>
>>esp; caed1ee0 <_end+ab54a3c/17cf1bbc>

Trace; c012c23f <__free_pages_ok+2f/320>
Trace; c0122bd1 <zap_pte_range+101/126>
Trace; c01213f0 <zap_page_range+80/100>
Trace; c012400c <exit_mmap+ac/120>
Trace; c0112ba4 <mmput+44/90>
Trace; c01171ad <do_exit+7d/230>
Trace; c011738f <sys_exit+f/10>
Trace; c01070c3 <system_call+33/40>

Code;  c012b12c <__lru_cache_del+5c/80>
00000000 <_EIP>:
Code;  c012b12c <__lru_cache_del+5c/80>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b12e <__lru_cache_del+5e/80>
   2:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c012b135 <__lru_cache_del+65/80>
   9:   c7 43 1c 00 00 00 00      movl   $0x0,0x1c(%ebx)
Code;  c012b13c <__lru_cache_del+6c/80>
  10:   6a ff                     push   $0xffffffff
Code;  c012b13e <__lru_cache_del+6e/80>
  12:   53                        push   %ebx
Code;  c012b13f <__lru_cache_del+6f/80>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b12c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__lru_cache_del+92/128]    Not tainted
EIP:    0010:[<c012b12c>]    Not tainted
EFLAGS: 00010246
eax: c12525e4   ebx: c124f970   ecx: c124f98c   edx: 001da454
esi: 0001c000   edi: 00000000   ebp: 000a6000   esp: caf2dee0
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 26180, stackpage=caf2d000)
Stack: c124f970 c012c23f c02f3f88 000167f0 c100001c c11ec6b0 c02f3ed8
c102c01c 
       00000217 fffffffe 000028c3 0d71f065 0001c000 cb15d448 000a6000
c0122bd1 
       c124f970 c124f970 0000001d 08400000 caac9084 0819c000 00000000
c01213f0 
Call Trace:    [__free_pages_ok+47/800] [zap_pte_range+257/294]
[zap_page_range+128/256] [exit_mmap+172/288] [mmput+68/144]
Call Trace:    [<c012c23f>] [<c0122bd1>] [<c01213f0>] [<c012400c>]
[<c0112ba4>]
  [<c01171ad>] [<c011738f>] [<c01070c3>]
Code: 89 02 c7 41 04 00 00 00 00 c7 43 1c 00 00 00 00 6a ff 53 e8 


>>EIP; c012b12c <__lru_cache_del+5c/80>   <=====

>>eax; c12525e4 <_end+ed5140/17cf1bbc>
>>ebx; c124f970 <_end+ed24cc/17cf1bbc>
>>ecx; c124f98c <_end+ed24e8/17cf1bbc>
>>esp; caf2dee0 <_end+abb0a3c/17cf1bbc>

Trace; c012c23f <__free_pages_ok+2f/320>
Trace; c0122bd1 <zap_pte_range+101/126>
Trace; c01213f0 <zap_page_range+80/100>
Trace; c012400c <exit_mmap+ac/120>
Trace; c0112ba4 <mmput+44/90>
Trace; c01171ad <do_exit+7d/230>
Trace; c011738f <sys_exit+f/10>
Trace; c01070c3 <system_call+33/40>

Code;  c012b12c <__lru_cache_del+5c/80>
00000000 <_EIP>:
Code;  c012b12c <__lru_cache_del+5c/80>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b12e <__lru_cache_del+5e/80>
   2:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c012b135 <__lru_cache_del+65/80>
   9:   c7 43 1c 00 00 00 00      movl   $0x0,0x1c(%ebx)
Code;  c012b13c <__lru_cache_del+6c/80>
  10:   6a ff                     push   $0xffffffff
Code;  c012b13e <__lru_cache_del+6e/80>
  12:   53                        push   %ebx
Code;  c012b13f <__lru_cache_del+6f/80>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 00000001   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1429f54
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1429000)
Stack: c1428000 00000c6e 00002c74 000001d0 00000013 00000020 000001d0
c02f3ed8 
       c02f3ed8 c012b86f c1429f98 0000003c 000001d0 00000020 c012b8d0
c1429f98 
       00000000 00000000 c02f3ed8 00000001 c1428000 00000000 c012ba7c
c02f3e00 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[kswapd_balance_pgdat+92/160] [kswapd_balance+22/48] [kswapd+157/192]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012ba7c>] [<c012bad6>]
[<c012bbfd>]
  [<c0105000>] [<c0105686>] [<c012bb60>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1429f54 <_end+10acab0/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012ba7c <kswapd_balance_pgdat+5c/a0>
Trace; c012bad6 <kswapd_balance+16/30>
Trace; c012bbfd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105686 <arch_kernel_thread+26/30>
Trace; c012bb60 <kswapd+0/c0>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 0000784d   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9dd3c
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 27040, stackpage=c1e9d000)
Stack: c1e9c000 00000c1c 00002cca 000000f0 0000001f 0000001f 000000f0
c02f3ed8 
       c02f3ed8 c012b86f c1e9dd80 0000003c 000000f0 00000020 c012b8d0
c1e9dd80 
       00000000 00000000 00000000 c1e9c000 00000001 c02f3ed8 c012c85e
d76d9400 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624] [__get_free_pages+88/96]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c012cd08>]
  [<c012a69b>] [<c012ae8e>] [<c012a82f>] [<c0134994>] [<c0134a7d>]
[<c0134ca7>]
  [<c0135584>] [<c012b0ca>] [<c0159e6f>] [<c0159290>] [<c0124c19>]
[<c01252d9>]
  [<c0125663>] [<c0125b20>] [<c0125c6a>] [<c0125b20>] [<c01329f5>]
[<c01070c3>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9dd3c <_end+1b20898/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c012cd08 <__get_free_pages+58/60>
Trace; c012a69b <kmem_cache_grow+ab/230>
Trace; c012ae8e <__kmem_cache_alloc+ae/e0>
Trace; c012a82f <kmem_cache_alloc+f/20>
Trace; c0134994 <get_unused_buffer_head+34/80>
Trace; c0134a7d <create_buffers+1d/d0>
Trace; c0134ca7 <create_empty_buffers+17/60>
Trace; c0135584 <block_read_full_page+264/280>
Trace; c012b0ca <lru_cache_add+5a/60>
Trace; c0159e6f <ext3_readpage+f/20>
Trace; c0159290 <ext3_get_block+0/70>
Trace; c0124c19 <page_cache_read+99/c0>
Trace; c01252d9 <generic_file_readahead+c9/170>
Trace; c0125663 <do_generic_file_read+2b3/470>
Trace; c0125b20 <file_read_actor+0/b0>
Trace; c0125c6a <generic_file_read+9a/180>
Trace; c0125b20 <file_read_actor+0/b0>
Trace; c01329f5 <sys_read+85/100>
Trace; c01070c3 <system_call+33/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 00007858   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9de24
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 27041, stackpage=c1e9d000)
Stack: c1e9c000 00000c80 00002cca 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c1e9de68 0000003c 000001d2 00000020 c012b8d0
c1e9de68 
       00000000 00000000 00000000 c1e9c000 00000001 c02f3ed8 c012c85e
c014061b 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [filldir64+171/256] [__alloc_pages+363/624]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c014061b>]
[<c012cbab>]
  [<c01223b1>] [<c01226c6>] [<c0110843>] [<c0123e0b>] [<c0122d89>]
[<c01106f0>]
  [<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9de24 <_end+1b20980/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c014061b <filldir64+ab/100>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c01223b1 <do_anonymous_page+61/130>
Trace; c01226c6 <handle_mm_fault+56/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0123e0b <do_brk+11b/210>
Trace; c0122d89 <sys_brk+d9/110>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 00007867   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9de24
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 27042, stackpage=c1e9d000)
Stack: c1e9c000 00000c80 00002cc9 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c1e9de68 0000003c 000001d2 00000020 c012b8d0
c1e9de68 
       00000000 00000000 00000000 c1e9c000 00000001 c02f3ed8 c012c85e
c01264b1 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [filemap_nopage+401/512] [__alloc_pages+363/624]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c01264b1>]
[<c012cbab>]
  [<c01223b1>] [<c01226c6>] [<c0110843>] [<c0123636>] [<c0123457>]
[<c010bed3>]
  [<c01106f0>] [<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9de24 <_end+1b20980/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c01264b1 <filemap_nopage+191/200>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c01223b1 <do_anonymous_page+61/130>
Trace; c01226c6 <handle_mm_fault+56/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0123636 <get_unmapped_area+c6/110>
Trace; c0123457 <do_mmap_pgoff+467/580>
Trace; c010bed3 <sys_mmap2+63/90>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 0000784d   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9dd28
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 27043, stackpage=c1e9d000)
Stack: c1e9c000 00000c80 00002cc9 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c1e9dd6c 0000003c 000001d2 00000020 c012b8d0
c1e9dd6c 
       00000000 00000000 00000000 c1e9c000 00000001 c02f3ed8 c012c85e
c1e9ddb0 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624]
[do_anonymous_page+97/304]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c01223b1>]
  [<c01226c6>] [<c0110843>] [<c015934e>] [<c012b05d>] [<c01263dc>]
[<c01264b1>]
  [<c01224dd>] [<c01106f0>] [<c01071d4>] [<c0125b92>] [<c01255bc>]
[<c0125b20>]
  [<c0125c6a>] [<c0125b20>] [<c01329f5>] [<c01070c3>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9dd28 <_end+1b20884/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c01223b1 <do_anonymous_page+61/130>
Trace; c01226c6 <handle_mm_fault+56/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c015934e <ext3_getblk+4e/280>
Trace; c012b05d <activate_page+8d/a0>
Trace; c01263dc <filemap_nopage+bc/200>
Trace; c01264b1 <filemap_nopage+191/200>
Trace; c01224dd <do_no_page+5d/1f0>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>
Trace; c0125b92 <file_read_actor+72/b0>
Trace; c01255bc <do_generic_file_read+20c/470>
Trace; c0125b20 <file_read_actor+0/b0>
Trace; c0125c6a <generic_file_read+9a/180>
Trace; c0125b20 <file_read_actor+0/b0>
Trace; c01329f5 <sys_read+85/100>
Trace; c01070c3 <system_call+33/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 00007858   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c2197e20
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 27019, stackpage=c2197000)
Stack: c2196000 00000c80 00002cc8 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c2197e64 0000003c 000001d2 00000020 c012b8d0
c2197e64 
       00000000 00000000 00000000 c2196000 00000001 c02f3ed8 c012c85e
000153e4 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624] [do_wp_page+178/672]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c0121e82>]
  [<c0122719>] [<c0110843>] [<c0123f44>] [<c0113aae>] [<c0105827>]
[<c011256b>]
  [<c01135f9>] [<c011d1a0>] [<c01106f0>] [<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c2197e20 <_end+1e1a97c/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c0121e82 <do_wp_page+b2/2a0>
Trace; c0122719 <handle_mm_fault+a9/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0123f44 <build_mmap_rb+44/60>
Trace; c0113aae <dup_mmap+9e/181>
Trace; c0105827 <copy_thread+77/90>
Trace; c011256b <wake_up_process+b/10>
Trace; c01135f9 <do_fork+4d9/720>
Trace; c011d1a0 <sys_rt_sigprocmask+100/170>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 0000786c   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9de20
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 27044, stackpage=c1e9d000)
Stack: c1e9c000 00000c80 00002cc8 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c1e9de64 0000003c 000001d2 00000020 c012b8d0
c1e9de64 
       00000000 00000000 00000000 c1e9c000 00000001 c02f3ed8 c012c85e
00013600 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624] [do_wp_page+178/672]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c0121e82>]
  [<c0122719>] [<c0110843>] [<c0125b20>] [<c011da72>] [<c01106f0>]
[<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9de20 <_end+1b2097c/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c0121e82 <do_wp_page+b2/2a0>
Trace; c0122719 <handle_mm_fault+a9/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0125b20 <file_read_actor+0/b0>
Trace; c011da72 <sys_rt_sigaction+82/a0>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 000077b7   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c21a3e20
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 27053, stackpage=c21a3000)
Stack: c21a2000 00000c80 00002cc8 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c21a3e64 0000003c 000001d2 00000020 c012b8d0
c21a3e64 
       00000000 00000000 00000000 c21a2000 00000001 c02f3ed8 c012c85e
c13d9634 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624] [do_wp_page+178/672]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c0121e82>]
  [<c0122719>] [<c0110843>] [<c0123f44>] [<c0113aae>] [<c0105827>]
[<c011256b>]
  [<c01135f9>] [<c0132187>] [<c01106f0>] [<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c21a3e20 <_end+1e2697c/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c0121e82 <do_wp_page+b2/2a0>
Trace; c0122719 <handle_mm_fault+a9/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0123f44 <build_mmap_rb+44/60>
Trace; c0113aae <dup_mmap+9e/181>
Trace; c0105827 <copy_thread+77/90>
Trace; c011256b <wake_up_process+b/10>
Trace; c01135f9 <do_fork+4d9/720>
Trace; c0132187 <filp_close+37/60>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 000077c2   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c21a3e20
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 27061, stackpage=c21a3000)
Stack: c21a2000 00000c80 00002cc8 000001d2 00000020 00000020 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c21a3e64 0000003c 000001d2 00000020 c012b8d0
c21a3e64 
       00000000 00000000 00000000 c21a2000 00000001 c02f3ed8 c012c85e
00013600 
Call Trace:    [shrink_caches+47/64] [try_to_free_pages_zone+80/208]
[balance_classzone+78/560] [__alloc_pages+363/624] [do_wp_page+178/672]
Call Trace:    [<c012b86f>] [<c012b8d0>] [<c012c85e>] [<c012cbab>]
[<c0121e82>]
  [<c0122719>] [<c0110843>] [<c0123f44>] [<c0113aae>] [<c0105827>]
[<c011256b>]
  [<c01135f9>] [<c011d0ea>] [<c01106f0>] [<c01071d4>]
Code: 89 02 c7 03 00 00 00 00 89 50 04 a1 2c 3d 2f c0 89 03 89 1d 


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c21a3e20 <_end+1e2697c/17cf1bbc>

Trace; c012b86f <shrink_caches+2f/40>
Trace; c012b8d0 <try_to_free_pages_zone+50/d0>
Trace; c012c85e <balance_classzone+4e/230>
Trace; c012cbab <__alloc_pages+16b/270>
Trace; c0121e82 <do_wp_page+b2/2a0>
Trace; c0122719 <handle_mm_fault+a9/c0>
Trace; c0110843 <do_page_fault+153/4b7>
Trace; c0123f44 <build_mmap_rb+44/60>
Trace; c0113aae <dup_mmap+9e/181>
Trace; c0105827 <copy_thread+77/90>
Trace; c011256b <wake_up_process+b/10>
Trace; c01135f9 <do_fork+4d9/720>
Trace; c011d0ea <sys_rt_sigprocmask+4a/170>
Trace; c01106f0 <do_page_fault+0/4b7>
Trace; c01071d4 <error_code+34/40>

Code;  c012b3eb <shrink_cache+9b/3b0>
00000000 <_EIP>:
Code;  c012b3eb <shrink_cache+9b/3b0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b3ed <shrink_cache+9d/3b0>
   2:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012b3f3 <shrink_cache+a3/3b0>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012b3f6 <shrink_cache+a6/3b0>
   b:   a1 2c 3d 2f c0            mov    0xc02f3d2c,%eax
Code;  c012b3fb <shrink_cache+ab/3b0>
  10:   89 03                     mov    %eax,(%ebx)
Code;  c012b3fd <shrink_cache+ad/3b0>
  12:   89 1d 00 00 00 00         mov    %ebx,0x0

 <1>Unable to handle kernel paging request at virtual address 001da454
c012b3eb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[shrink_cache+155/944]    Not tainted
EIP:    0010:[<c012b3eb>]    Not tainted
EFLAGS: 00010246
eax: c02f3d2c   ebx: c12525e4   ecx: 000077d0   edx: 001da454
esi: c12525c8   edi: 00000000   ebp: c02f3ed8   esp: c1e9de20
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 27060, stackpage=c1e9d000)
Stack: c1e9c000 00000c1c 00002cc8 000001d2 0000001f 0000001f 000001d2
c02f3ed8 
       c02f3ed8 c012b86f c1e9de64 0000003c 000001d2 00000020 c012b8d
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c012b3eb <shrink_cache+9b/3b0>   <=====

>>eax; c02f3d2c <inactive_list+0/8>
>>ebx; c12525e4 <_end+ed5140/17cf1bbc>
>>esi; c12525c8 <_end+ed5124/17cf1bbc>
>>ebp; c02f3ed8 <contig_page_data+d8/3c0>
>>esp; c1e9de20 <_end+1b2097c/17cf1bbc>


1 warning issued.  Results may not be reliable.
