Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267523AbRGRSvZ>; Wed, 18 Jul 2001 14:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRSvQ>; Wed, 18 Jul 2001 14:51:16 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:19470 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S267523AbRGRSvC>; Wed, 18 Jul 2001 14:51:02 -0400
Date: Wed, 18 Jul 2001 20:51:01 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at inode.c:654!
Message-ID: <20010718205101.A202@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii

I got a few oopses today with 2.4.6.  Someone reported this with
2.4.5 too some time ago, but didn't see anything about it yet.

It always kills the currently running program with a SIGSEGV.

First I got two at the same time, this happened when I was
compiling the kernel.  After some time everything started having
the problem.  The third is from when I tried to run the oops thru
ksymoops.

Output of ksymoops is attached.


Kurt


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops

ksymoops 2.4.1 on i586 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at inode.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013c6c6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001b   ebx: c08e5428   ecx: c3fc2000   edx: 00000000
esi: c08e5420   edi: c08e5608   ebp: c3fc3fa4   esp: c3fc3f7c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c3fc3000)
Stack: c025f7a6 c025f822 0000028e 000000c0 000000ea 00000000 00000000 00000040 
       c0c0cd68 c3556d68 0008e000 c013c76d 000000b3 c01245fb 00000006 000000c0 
       00000006 000000c0 000000c0 00000000 c3fc2000 c025c631 c3fc2239 c012467e 
Call Trace: [<c013c76d>] [<c01245fb>] [<c012467e>] [<c0105410>] 
Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8b 53 04 8b 03 89 50 04 89 02 

>>EIP; c013c6c6 <prune_icache+96/11c>   <=====
Trace; c013c76d <shrink_icache_memory+21/30>
Trace; c01245fb <do_try_to_free_pages+2f/58>
Trace; c012467e <kswapd+5a/e4>
Trace; c0105410 <kernel_thread+28/38>
Code;  c013c6c6 <prune_icache+96/11c>
00000000 <_EIP>:
Code;  c013c6c6 <prune_icache+96/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013c6c8 <prune_icache+98/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013c6cb <prune_icache+9b/11c>
   5:   90                        nop    
Code;  c013c6cc <prune_icache+9c/11c>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c013c6d0 <prune_icache+a0/11c>
   a:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013c6d3 <prune_icache+a3/11c>
   d:   8b 03                     mov    (%ebx),%eax
Code;  c013c6d5 <prune_icache+a5/11c>
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013c6d8 <prune_icache+a8/11c>
  12:   89 02                     mov    %eax,(%edx)

kernel BUG at inode.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013c6c6>]
EFLAGS: 00010282
eax: 0000001b   ebx: c05e32c8   ecx: 00000001   edx: c02a5868
esi: c05e32c0   edi: c25779a8   ebp: c19c1e34   esp: c19c1e0c
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 8926, stackpage=c19c1000)
Stack: c025f7a6 c025f822 0000028e 000000d2 000001ce 00000001 00000000 00000060 
       c2c52a48 c12d1648 00000010 c013c76d 000000a1 c01245fb 00000006 000000d2 
       00000006 000000d2 000000d2 00000001 c19c0000 c02a6a28 00000000 c012474e 
Call Trace: [<c013c76d>] [<c01245fb>] [<c012474e>] [<c0125330>] [<c0125162>] [<c011bcde>] [<c011bd6b>] 
       [<c011be6f>] [<c010ed54>] [<c010eeb4>] [<c010ed54>] [<c01ce796>] [<c01cebcb>] [<c01d2520>] [<c0107c4c>] 
       [<c0109e78>] [<c0107dcd>] [<c0106b74>] 
Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8b 53 04 8b 03 89 50 04 89 02 

>>EIP; c013c6c6 <prune_icache+96/11c>   <=====
Trace; c013c76d <shrink_icache_memory+21/30>
Trace; c01245fb <do_try_to_free_pages+2f/58>
Trace; c012474e <try_to_free_pages+22/2c>
Trace; c0125330 <__alloc_pages+1cc/278>
Trace; c0125162 <_alloc_pages+16/18>
Trace; c011bcde <do_anonymous_page+32/90>
Trace; c011bd6b <do_no_page+2f/dc>
Trace; c011be6f <handle_mm_fault+57/b8>
Trace; c010ed54 <do_page_fault+0/45c>
Trace; c010eeb4 <do_page_fault+160/45c>
Trace; c010ed54 <do_page_fault+0/45c>
Trace; c01ce796 <ide_do_request+282/2c8>
Trace; c01cebcb <ide_intr+12b/14c>
Trace; c01d2520 <ide_dma_intr+0/9c>
Trace; c0107c4c <handle_IRQ_event+30/5c>
Trace; c0109e78 <end_8259A_irq+18/1c>
Trace; c0107dcd <do_IRQ+8d/b0>
Trace; c0106b74 <error_code+34/40>
Code;  c013c6c6 <prune_icache+96/11c>
00000000 <_EIP>:
Code;  c013c6c6 <prune_icache+96/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013c6c8 <prune_icache+98/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013c6cb <prune_icache+9b/11c>
   5:   90                        nop    
Code;  c013c6cc <prune_icache+9c/11c>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c013c6d0 <prune_icache+a0/11c>
   a:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013c6d3 <prune_icache+a3/11c>
   d:   8b 03                     mov    (%ebx),%eax
Code;  c013c6d5 <prune_icache+a5/11c>
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013c6d8 <prune_icache+a8/11c>
  12:   89 02                     mov    %eax,(%edx)

kernel BUG at inode.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013c6c6>]
EFLAGS: 00010282
eax: 0000001b   ebx: c2e70048   ecx: c2200000   edx: c3f28e20
esi: c2e70040   edi: c0c47828   ebp: c2201e34   esp: c2201e0c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 9139, stackpage=c2201000)
Stack: c025f7a6 c025f822 0000028e 000000d2 00000011 00000001 00000000 00000061 
       c3ce69e8 c1a929c8 00000010 c013c76d 0000007e c01245fb 00000006 000000d2 
       00000006 000000d2 000000d2 00000000 c2200000 c02a6a28 00000000 c012474e 
Call Trace: [<c013c76d>] [<c01245fb>] [<c012474e>] [<c0125330>] [<c0125162>] [<c011bcde>] [<c011bd6b>] 
       [<c011be6f>] [<c010ed54>] [<c010eeb4>] [<c010ed54>] [<c011cc34>] [<c01fb8b6>] [<c011cf30>] [<c011c140>] 
       [<c0106b74>] 
Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8b 53 04 8b 03 89 50 04 89 02 

>>EIP; c013c6c6 <prune_icache+96/11c>   <=====
Trace; c013c76d <shrink_icache_memory+21/30>
Trace; c01245fb <do_try_to_free_pages+2f/58>
Trace; c012474e <try_to_free_pages+22/2c>
Trace; c0125330 <__alloc_pages+1cc/278>
Trace; c0125162 <_alloc_pages+16/18>
Trace; c011bcde <do_anonymous_page+32/90>
Trace; c011bd6b <do_no_page+2f/dc>
Trace; c011be6f <handle_mm_fault+57/b8>
Trace; c010ed54 <do_page_fault+0/45c>
Trace; c010eeb4 <do_page_fault+160/45c>
Trace; c010ed54 <do_page_fault+0/45c>
Trace; c011cc34 <do_munmap+58/250>
Trace; c01fb8b6 <sbintr+32/38>
Trace; c011cf30 <do_brk+b0/16c>
Trace; c011c140 <sys_brk+bc/e8>
Trace; c0106b74 <error_code+34/40>
Code;  c013c6c6 <prune_icache+96/11c>
00000000 <_EIP>:
Code;  c013c6c6 <prune_icache+96/11c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013c6c8 <prune_icache+98/11c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013c6cb <prune_icache+9b/11c>
   5:   90                        nop    
Code;  c013c6cc <prune_icache+9c/11c>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c013c6d0 <prune_icache+a0/11c>
   a:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013c6d3 <prune_icache+a3/11c>
   d:   8b 03                     mov    (%ebx),%eax
Code;  c013c6d5 <prune_icache+a5/11c>
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013c6d8 <prune_icache+a8/11c>
  12:   89 02                     mov    %eax,(%edx)


1 error issued.  Results may not be reliable.

--+QahgC5+KEYLbs62--
