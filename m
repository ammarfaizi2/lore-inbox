Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136008AbREJUK1>; Thu, 10 May 2001 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbREJUKQ>; Thu, 10 May 2001 16:10:16 -0400
Received: from dentin.eaze.net ([216.228.128.151]:21252 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S136008AbREJUKC>;
	Thu, 10 May 2001 16:10:02 -0400
Date: Thu, 10 May 2001 15:13:13 -0500
From: SodaPop <soda@xirr.com>
Message-Id: <200105102013.PAA22503@xirr.com>
To: linux-kernel@vger.kernel.org
Subject: null pointer dereference in ibmtr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When inserting the ibmtr.o module in any of the 2.4 series kernels, I get a
null pointer crash.  Latest try was 2.4.4.  Ksymoops:

Unable to handle kernel paging request at virtual address 7a000018
c012861e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012861e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000170   ebx: 00000001     ecx: 00000170       edx: 00000000
esi: c1321080   edi: c13210dc     ebp: c9ca3800       esp: c0203ee8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02030000)
Stack: c0188efd c1321080 00000000 c0188f37 c1321080 c1321080 c0189067 c1321080
       c1321080 c1321080 c01905c3 c1321080 c1321080 c9ff8ca0 c01903bb c1321080
       c9ca3800 c01ff12c c1321080 c01ff12c c0189067 c1321080 c9ca3800 c01ff12c
Call Trace: [<c0188efd>] [<c0188f37>] [<c0189067>] [<c01905c3>] [<c01903bb>] [<c018c219>] [<c018c3f5>]
       [<c0115b7e>] [<c0107ef9>] [<c0105160>] [<c0106be0>] [<c0105160>] [<c0100018>] [<c0105183>] [<c01051de>]
       [<c0105000>] [<c0100198>]
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c012861e <__free_pages+2/1c>   <=====
Trace; c0188efd <skb_release_data+3d/6c>
Trace; c0188f37 <kfree_skbmem+b/54>
Trace; c0189067 <__kfree_skb+e7/f0>
Trace; c01905c3 <snap_rcv+9b/a4>
Trace; c01903bb <p8022_rcv+6b/98>
Trace; c018c219 <deliver_to_old_ones+71/80>
Trace; c018c3f5 <net_rx_action+11d/200>
Trace; c0115b7e <do_softirq+4a/6c>
Trace; c0107ef9 <do_IRQ+a1/b4>
Trace; c0105160 <default_idle+0/28>
Trace; c0106be0 <ret_from_intr+0/20>
Trace; c0105160 <default_idle+0/28>
Trace; c0100018 <startup_32+18/a5>
Trace; c0105183 <default_idle+23/28>
Trace; c01051de <cpu_idle+36/4c>
Trace; c0105000 <init+0/150>
Trace; c0100198 <L6+0/2>
Code;  c012861e <__free_pages+2/1c>
00000000 <_EIP>:
Code;  c012861e <__free_pages+2/1c>   <=====
   0:   8b 41 18                  movl   0x18(%ecx),%eax   <=====
Code;  c0128621 <__free_pages+5/1c>
   3:   85 c0                     testl  %eax,%eax
Code;  c0128623 <__free_pages+7/1c>
   5:   7c 11                     jl     18 <_EIP+0x18> c0128636 <__free_pages+1a/1c>
Code;  c0128625 <__free_pages+9/1c>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c0128628 <__free_pages+c/1c>
   a:   0f 94 c0                  sete   %al
Code;  c012862b <__free_pages+f/1c>
   d:   84 c0                     testb  %al,%al
Code;  c012862d <__free_pages+11/1c>
   f:   74 07                     je     18 <_EIP+0x18> c0128636 <__free_pages+1a/1c>
Code;  c012862f <__free_pages+13/1c>
  11:   89 c8                     movl   %ecx,%eax
Code;  c0128631 <__free_pages+15/1c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0128636 <__free_pages+1a/1c>




Cpu info:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 299.946316
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 299.01



The token ring card is ISA, not pci.  It has worked fine for years under 2.2.*

Any ideas?

-dennis T
