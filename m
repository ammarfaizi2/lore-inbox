Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTK1Fnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 00:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTK1Fnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 00:43:50 -0500
Received: from 3-116.ipplanet.com ([81.199.3.116]:63638 "EHLO
	nairobi.skyweb.co.ke") by vger.kernel.org with ESMTP
	id S262001AbTK1Fnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 00:43:47 -0500
Message-ID: <3FC6E0FC.6060604@skyweb.co.ke>
Date: Fri, 28 Nov 2003 08:45:32 +0300
From: Anderson Levi <anderson@skyweb.co.ke>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My linux box keeps crashing every 24 hours or so. It's running kernel 
version 2.4.21. I ran the oops message through ksymoops and got this result:

ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -M (specified)

Nov 28 07:27:56 myweb kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000024
Nov 28 07:27:56 myweb kernel: c01288a9
Nov 28 07:27:56 myweb kernel: *pde = 00000000
Nov 28 07:27:56 myweb kernel: Oops: 0000
Nov 28 07:27:56 myweb kernel: CPU:    0
Nov 28 07:27:56 myweb kernel: EIP:    0010:[<c01288a9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 28 07:27:56 myweb kernel: EFLAGS: 00010246
Nov 28 07:27:56 myweb kernel: eax: 00000000   ebx: c13f5570   ecx: 
f6e19224   edx: 00000000
Nov 28 07:27:56 myweb kernel: esi: f6e19224   edi: 00000004   ebp: 
0000179a   esp: f7fc3f24
Nov 28 07:27:56 myweb kernel: ds: 0018   es: 0018   ss: 0018
Nov 28 07:27:56 myweb kernel: Process kswapd (pid: 4, stackpage=f7fc3000)
Nov 28 07:27:56 myweb kernel: Stack: 00000000 c13f5570 c012f91f c13f5570 
c67ac580 f7fc2000 0000001a 000001d0
Nov 28 07:27:56 myweb kernel:        c02a9e40 c1c0d2b0 d2d45a00 c1c0d2b0 
00000004 0000000f 000001d0 00000005
Nov 28 07:27:56 myweb kernel:        0000000f c012fac2 00000005 0000002f 
c02a9e40 00000005 000001d0 c02a9e40
Nov 28 07:27:56 myweb kernel: Call Trace:    [<c012f91f>] [<c012fac2>] 
[<c012fb3c>] [<c012fc4f>] [<c012fcc6>]
Nov 28 07:27:57 myweb kernel:   [<c012fe01>] [<c012fd60>] [<c0105000>] 
[<c0107156>] [<c012fd60>]
Nov 28 07:27:57 myweb kernel: Code: 8b 40 24 85 c0 74 04 53 ff d0 5a 8b 
53 04 8b 03 89 50 04 89


 >>EIP; c01288a9 <do_brk+519/590>   <=====

 >>ebx; c13f5570 <___strtok+10946dc/385aa16c>
 >>ecx; f6e19224 <___strtok+36ab8390/385aa16c>
 >>esi; f6e19224 <___strtok+36ab8390/385aa16c>
 >>esp; f7fc3f24 <___strtok+37c63090/385aa16c>

Trace; c012f91f <kmem_find_general_cachep+e1f/19f0>
Trace; c012fac2 <kmem_find_general_cachep+fc2/19f0>
Trace; c012fb3c <kmem_find_general_cachep+103c/19f0>
Trace; c012fc4f <kmem_find_general_cachep+114f/19f0>
Trace; c012fcc6 <kmem_find_general_cachep+11c6/19f0>
Trace; c012fe01 <kmem_find_general_cachep+1301/19f0>
Trace; c012fd60 <kmem_find_general_cachep+1260/19f0>
Trace; c0105000 <empty_zero_page+1000/2dd0>
Trace; c0107156 <machine_power_off+166/300>
Trace; c012fd60 <kmem_find_general_cachep+1260/19f0>

Code;  c01288a9 <do_brk+519/590>
00000000 <_EIP>:
Code;  c01288a9 <do_brk+519/590>   <=====
   0:   8b 40 24                  mov    0x24(%eax),%eax   <=====
Code;  c01288ac <do_brk+51c/590>
   3:   85 c0                     test   %eax,%eax
Code;  c01288ae <do_brk+51e/590>
   5:   74 04                     je     b <_EIP+0xb> c01288b4 
<do_brk+524/590>
Code;  c01288b0 <do_brk+520/590>
   7:   53                        push   %ebx
Code;  c01288b1 <do_brk+521/590>
   8:   ff d0                     call   *%eax
Code;  c01288b3 <do_brk+523/590>
   a:   5a                        pop    %edx
Code;  c01288b4 <do_brk+524/590>
   b:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01288b7 <do_brk+527/590>
   e:   8b 03                     mov    (%ebx),%eax
Code;  c01288b9 <do_brk+529/590>
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c01288bc <do_brk+52c/590>
  13:   89 00                     mov    %eax,(%eax)

What could be the problem? Any help would be highly appreciated.

Thanks.

