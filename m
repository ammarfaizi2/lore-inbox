Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273144AbRI3JAW>; Sun, 30 Sep 2001 05:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRI3JAG>; Sun, 30 Sep 2001 05:00:06 -0400
Received: from scorpio.gold.ac.uk ([158.223.1.1]:16581 "EHLO
	scorpio.gold.ac.uk") by vger.kernel.org with ESMTP
	id <S273144AbRI3I7o>; Sun, 30 Sep 2001 04:59:44 -0400
Date: Sun, 30 Sep 2001 10:00:00 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mas01mb: 
To: <linux-kernel@vger.kernel.org>
Subject: (VM?) oops in 2.4.9-ac10
Message-ID: <Pine.GSO.4.33.0109300952580.24574-100000@scorpio.gold.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this occurred on our main fileserver overnight.

SMP PIII Coppermine; Debian "potato" + bunk 2.4 debs; 2.4.9-ac10 + ext3
0.9.9 + ext3 speedup + ext3 "experimental VM patch" + jfs-1.0.4; gdth;
acenic; everything modular; gcc 2.96-85

We have a number of servers running the same kernel build (hence the many
bug reports with this kernel). I'll try to build a newer 2.4-ac later today,
with less added frills. Is there a particularly stable one I should try?

As usual, I'm happy to provide more information if need be.

Matt


ksymoops 2.4.1 on i686 2.4.9-ac10-jfs.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.9-ac10-jfs/ (default)
     -m /boot/System.map-2.4.9-ac10-jfs (default)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 00000001   edi: c0231d60   ebp: 0008e000   esp: c1923f7c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1923000)
Stack: db2ce000 c190ebe0 c190ec04 0008e000 000000c0 0000018e c0162c75 0000000f
       c0139316 00000006 000000c0 c190ebe0 000000c0 c190eac0 000000c0 000000c0
       00000000 c1922000 ffffffff c01393ae 000000c0 00000000 c0105000 0008e000
Call Trace: [<c0162c75>] [<c0139316>] [<c01393ae>] [<c0105000>] [<c0105000>]
   [<c0105926>] [<c0139340>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c01393ae <kswapd+6e/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105926 <kernel_thread+26/30>
Trace; c0139340 <kswapd+0/f0>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 00000070   esp: cd523d60
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29908, stackpage=cd523000)
Stack: ffffffff 000001fc c1011e38 c1011e38 00000070 0000057e c0162c75 0000000d
       c0139316 00000006 00000070 00000000 00000070 00000000 00000070 00000070
       00000001 cd522000 00000010 c0139488 00000070 00000001 cd522000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c0147c7c>]
   [<c0144dba>] [<c0145703>] [<c0145b08>] [<c0131994>] [<e08399b2>] [<c015d543>]
   [<e0836dbb>] [<c015d970>] [<e0836ef9>] [<e083a773>] [<c014f4d4>] [<c01500e5>]
   [<c01509ca>] [<c014c2b3>] [<c010772b>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c0147c7c <grow_buffers+3c/1f0>
Trace; c0144dba <refill_freelist+a/20>
Trace; c0145703 <getblk+293/2a0>
Trace; c0145b08 <bread+18/70>
Trace; c0131994 <read_cache_page+44/1b0>
Trace; e08399b2 <END_OF_CODE+2056c2ea/????>
Trace; c015d543 <get_new_inode+143/210>
Trace; e0836dbb <END_OF_CODE+205696f3/????>
Trace; c015d970 <iget4+180/190>
Trace; e0836ef9 <END_OF_CODE+20569831/????>
Trace; e083a773 <END_OF_CODE+2056d0ab/????>
Trace; c014f4d4 <real_lookup+a4/180>
Trace; c01500e5 <path_walk+8b5/bc0>
Trace; c01509ca <__user_walk+3a/60>
Trace; c014c2b3 <sys_newlstat+13/70>
Trace; c010772b <system_call+33/38>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000f0   esp: c961dd7c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 29993, stackpage=c961d000)
Stack: 00000001 00000001 000000f0 c190ebe0 000000f0 0000057e c0162c75 0000000d
       c0139316 00000006 000000f0 c190ebe0 000000f0 c190eac0 000000f0 000000f0
       00000001 c961c000 00000010 c0139488 000000f0 00000001 c961c000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c013a1e0>]
   [<c013501d>] [<e0800859>] [<c0135bf1>] [<e0836992>] [<c015d420>] [<e0836dbb>]
   [<c015d970>] [<e0836ef9>] [<e083a773>] [<c014f4d4>] [<c01500e5>] [<c014f3c0>]
   [<c01509ca>] [<c014c2b3>] [<c010772b>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c013a1e0 <__get_free_pages+10/20>
Trace; c013501d <kmem_cache_grow+14d/4a0>
Trace; e0800859 <END_OF_CODE+20533191/????>
Trace; c0135bf1 <kmem_cache_alloc+2c1/2e0>
Trace; e0836992 <END_OF_CODE+205692ca/????>
Trace; c015d420 <get_new_inode+20/210>
Trace; e0836dbb <END_OF_CODE+205696f3/????>
Trace; c015d970 <iget4+180/190>
Trace; e0836ef9 <END_OF_CODE+20569831/????>
Trace; e083a773 <END_OF_CODE+2056d0ab/????>
Trace; c014f4d4 <real_lookup+a4/180>
Trace; c01500e5 <path_walk+8b5/bc0>
Trace; c014f3c0 <path_release+10/30>
Trace; c01509ca <__user_walk+3a/60>
Trace; c014c2b3 <sys_newlstat+13/70>
Trace; c010772b <system_call+33/38>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000d2   esp: cb4b5ce4
ds: 0018   es: 0018   ss: 0018
Process diff (pid: 30001, stackpage=cb4b5000)
Stack: 00000000 00000000 000000d2 c190ebe0 000000d2 0000057e c0162c75 0000000d
       c0139316 00000006 000000d2 c190ebe0 000000d2 c190eac0 000000d2 000000d2
       00000001 cb4b4000 00000010 c0139488 000000d2 00000001 cb4b4000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c012b9ee>]
   [<c012bb92>] [<c012bd7b>] [<e082436c>] [<c0114510>] [<c0114746>] [<c018f0da>]
   [<c018f13f>] [<c0146ddc>] [<c013a090>] [<c0114510>] [<c0107828>] [<c012fbe0>]
   [<c012f7a9>] [<c012fcc2>] [<c012fb60>] [<c0142586>] [<c010772b>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c012b9ee <do_anonymous_page+6e/1e0>
Trace; c012bb92 <do_no_page+32/180>
Trace; c012bd7b <handle_mm_fault+9b/150>
Trace; e082436c <END_OF_CODE+20556ca4/????>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0114746 <do_page_fault+236/550>
Trace; c018f0da <__make_request+3da/800>
Trace; c018f13f <__make_request+43f/800>
Trace; c0146ddc <block_read_full_page+2cc/2f0>
Trace; c013a090 <__alloc_pages+110/250>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0107828 <error_code+38/40>
Trace; c012fbe0 <file_read_actor+80/100>
Trace; c012f7a9 <do_generic_file_read+279/630>
Trace; c012fcc2 <generic_file_read+62/80>
Trace; c012fb60 <file_read_actor+0/100>
Trace; c0142586 <sys_read+96/d0>
Trace; c010772b <system_call+33/38>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000d2   esp: ddb15ea8
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 30092, stackpage=ddb15000)
Stack: 00000001 0000000b 000000d2 c190ebe0 000000d2 0000057e c0162c75 0000000d
       c0139316 00000006 000000d2 c190ebe0 000000d2 c190eac0 000000d2 000000d2
       00000001 ddb14000 00000010 c0139488 000000d2 00000001 ddb14000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c0131f0b>]
   [<c014e471>] [<c0142656>] [<c01128bc>] [<c010772b>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c0131f0b <generic_file_write+35b/610>
Trace; c014e471 <pipe_read+1f1/220>
Trace; c0142656 <sys_write+96/d0>
Trace; c01128bc <smp_apic_timer_interrupt+ec/110>
Trace; c010772b <system_call+33/38>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 00000007   edi: 00000000   ebp: 000000d2   esp: cafadd78
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 557, stackpage=cafad000)
Stack: 00000001 00000000 000000d2 c190ebe0 000000d2 0000057e c0162c75 0000000f
       c0139316 00000006 000000d2 c190ebe0 000000d2 c190eac0 000000d2 000000d2
       00000001 cafac000 00000010 c0139488 000000d2 00000001 cafac000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c012f485>]
   [<c012f793>] [<c015d970>] [<c012fcc2>] [<c012fb60>] [<e097b574>] [<e083edc0>]
   [<e098070b>] [<e0988420>] [<e0977661>] [<e0988420>] [<e095b85a>] [<e0987dd8>]
   [<e0987df8>] [<e097747a>] [<e0987dc0>] [<e0987dc0>] [<c0105926>] [<e0977190>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c012f485 <generic_file_readahead+265/310>
Trace; c012f793 <do_generic_file_read+263/630>
Trace; c015d970 <iget4+180/190>
Trace; c012fcc2 <generic_file_read+62/80>
Trace; c012fb60 <file_read_actor+0/100>
Trace; e097b574 <END_OF_CODE+206adeac/????>
Trace; e083edc0 <END_OF_CODE+205716f8/????>
Trace; e098070b <END_OF_CODE+206b3043/????>
Trace; e0988420 <END_OF_CODE+206bad58/????>
Trace; e0977661 <END_OF_CODE+206a9f99/????>
Trace; e0988420 <END_OF_CODE+206bad58/????>
Trace; e095b85a <END_OF_CODE+2068e192/????>
Trace; e0987dd8 <END_OF_CODE+206ba710/????>
Trace; e0987df8 <END_OF_CODE+206ba730/????>
Trace; e097747a <END_OF_CODE+206a9db2/????>
Trace; e0987dc0 <END_OF_CODE+206ba6f8/????>
Trace; e0987dc0 <END_OF_CODE+206ba6f8/????>
Trace; c0105926 <kernel_thread+26/30>
Trace; e0977190 <END_OF_CODE+206a9ac8/????>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000d2   esp: dbf09df4
ds: 0018   es: 0018   ss: 0018
Process java (pid: 30188, stackpage=dbf09000)
Stack: 00000001 00000014 000000d2 c190ebe0 000000d2 0000057e c0162c75 0000000d
       c0139316 00000006 000000d2 c190ebe0 000000d2 c190eac0 000000d2 000000d2
       00000001 dbf08000 00000010 c0139488 000000d2 00000001 dbf08000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c012b9ee>]
   [<c012bb92>] [<c012bd7b>] [<c0114510>] [<c0114746>] [<c012cf74>] [<c0123256>]
   [<c01234fe>] [<c011efaf>] [<c011ee6c>] [<c011ebeb>] [<c0114510>] [<c0107828>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c012b9ee <do_anonymous_page+6e/1e0>
Trace; c012bb92 <do_no_page+32/180>
Trace; c012bd7b <handle_mm_fault+9b/150>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0114746 <do_page_fault+236/550>
Trace; c012cf74 <do_munmap+64/2d0>
Trace; c0123256 <update_wall_time+16/50>
Trace; c01234fe <timer_bh+5e/3c0>
Trace; c011efaf <bh_action+4f/100>
Trace; c011ee6c <tasklet_hi_action+6c/a0>
Trace; c011ebeb <do_softirq+7b/e0>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0107828 <error_code+38/40>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000d2   esp: d66cddf4
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 1037, stackpage=d66cd000)
Stack: 00000001 00000008 000000d2 c190ebe0 000000d2 00000bc7 c0162c75 0000000d
       c0139316 00000006 000000d2 c190ebe0 000000d2 c190eac0 000000d2 000000d2
       00000001 d66cc000 00000010 c0139488 000000d2 00000001 d66cc000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c012b9ee>]
   [<c012bb92>] [<c012bd7b>] [<c012eddb>] [<c013a090>] [<c0114510>] [<c0114746>]
   [<c012cf74>] [<c012fcc2>] [<c012fb60>] [<c012d2e4>] [<c012c20a>] [<c0141deb>]
   [<c0114510>] [<c0107828>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c012b9ee <do_anonymous_page+6e/1e0>
Trace; c012bb92 <do_no_page+32/180>
Trace; c012bd7b <handle_mm_fault+9b/150>
Trace; c012eddb <___wait_on_page+ab/c0>
Trace; c013a090 <__alloc_pages+110/250>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0114746 <do_page_fault+236/550>
Trace; c012cf74 <do_munmap+64/2d0>
Trace; c012fcc2 <generic_file_read+62/80>
Trace; c012fb60 <file_read_actor+0/100>
Trace; c012d2e4 <do_brk+b4/160>
Trace; c012c20a <sys_brk+aa/e0>
Trace; c0141deb <sys_open+cb/130>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0107828 <error_code+38/40>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0

 <1>Unable to handle kernel paging request at virtual address 5c6a2fc0
c0162bf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0162bf0>]
EFLAGS: 00010202
eax: 5c6a2fbc   ebx: d9b693cc   ecx: d9b693dc   edx: b90c8a79
esi: 0000000d   edi: 00000000   ebp: 000000f0   esp: cd2d5e50
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 1596, stackpage=cd2d5000)
Stack: 00000001 00000002 000000f0 c190ebe0 000000f0 000011e9 c0162c75 0000000d
       c0139316 00000006 000000f0 c190ebe0 000000f0 c190eac0 000000f0 000000f0
       00000001 cd2d4000 00000010 c0139488 000000f0 00000001 cd2d4000 c013a13e
Call Trace: [<c0162c75>] [<c0139316>] [<c0139488>] [<c013a13e>] [<c013a1e0>]
   [<c0155ad3>] [<c01be1de>] [<c0114510>] [<c0114746>] [<c019d72f>] [<c0155d57>]
   [<c01561d9>] [<c010772b>]
Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 0e 68 c0

>>EIP; c0162bf0 <prune_dqcache+20/90>   <=====
Trace; c0162c75 <shrink_dqcache_memory+15/30>
Trace; c0139316 <do_try_to_free_pages+36/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c013a1e0 <__get_free_pages+10/20>
Trace; c0155ad3 <__pollwait+33/90>
Trace; c01be1de <tcp_listen_start+24e/270>
Trace; c0114510 <do_page_fault+0/550>
Trace; c0114746 <do_page_fault+236/550>
Trace; c019d72f <sock_sendmsg+2f/90>
Trace; c0155d57 <do_select+147/260>
Trace; c01561d9 <sys_select+339/480>
Trace; c010772b <system_call+33/38>
Code;  c0162bf0 <prune_dqcache+20/90>
00000000 <_EIP>:
Code;  c0162bf0 <prune_dqcache+20/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0162bf3 <prune_dqcache+23/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0162bf5 <prune_dqcache+25/90>
   5:   89 59 f0                  mov    %ebx,0xfffffff0(%ecx)
Code;  c0162bf8 <prune_dqcache+28/90>
   8:   89 59 f4                  mov    %ebx,0xfffffff4(%ecx)
Code;  c0162bfb <prune_dqcache+2b/90>
   b:   8b 53 10                  mov    0x10(%ebx),%edx
Code;  c0162bfe <prune_dqcache+2e/90>
   e:   39 ca                     cmp    %ecx,%edx
Code;  c0162c00 <prune_dqcache+30/90>
  10:   75 0e                     jne    20 <_EIP+0x20> c0162c10 <prune_dqcache+40/90>
Code;  c0162c02 <prune_dqcache+32/90>
  12:   68 c0 00 00 00            push   $0xc0



