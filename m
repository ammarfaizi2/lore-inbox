Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbSISKep>; Thu, 19 Sep 2002 06:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271093AbSISKep>; Thu, 19 Sep 2002 06:34:45 -0400
Received: from gw.ima.pl ([195.117.13.12]:32265 "EHLO sentry.eter.tym.pl")
	by vger.kernel.org with ESMTP id <S271072AbSISKem>;
	Thu, 19 Sep 2002 06:34:42 -0400
Date: Thu, 19 Sep 2002 12:39:41 +0200 (CEST)
From: Tomasz Wrona <tw@eter.tym.pl>
To: <linux-kernel@vger.kernel.org>
Subject: kernel bug report [2.4.20-pre7]
Message-ID: <Pine.LNX.4.30.0209191233170.16350-100000@king.klan.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know where to send this bug report therefore I send it here as I
found advise in "oops-tracing.txt".

The bug caused during iptables rules start process.
Maybe this report will be usefull.

->
ksymoops 2.4.6 on i686 2.4.20-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre7/ (default)
     -m /boot/System.map-2.4.20-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at slab.c:1128!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126a84>]  Not tained
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: ffffffff   ebx: cffea0c0     ecx: 000001f0       edx: 00000000
esi: 000001f0   edi: cffea0c0     ebp: 000001f0       esp: cf651cb4
ds: 0018        es: 0018       ss: 0018
Process iptables (pid: 3133, stackpage=cf651000)
Stack:  cffea0c0 cffea0c0 00000246 000001f0 00000000 c0126dcf cffea0c0
000001f0
        00001000 000003e0 00001000 d09b2000 c0125ef7 00000010 000001f0
00001000
        000003e8 d09b6000 d09b2000 001b6000 c012603d 00001000 00000002
00000af0
Call Trace:     [<c0126dcf>] [<c0125ef7>] [<c012603d>] [<d0924502>]
[<c01cbb19>]
    [<c01cc2c9>] [<c01cc78f>] [<c0198cd1>] [<c0198d2a>] [<c01a7717>]
[<c010f5d4>]
    [<c01bcaa8>] [<c01c2382>] [<c018dea1>] [<c018e546>] [<c010852b>]
Code: 0f 0b 68 04 00 e8 1d c0 c7 44 24 10 01 00 00 00 b8 03 00 00


>>EIP; c0126a84 <kmem_cache_grow+44/1d0>   <=====

>>ebx; cffea0c0 <_end+fd7bb0c/10596a4c>
>>edi; cffea0c0 <_end+fd7bb0c/10596a4c>
>>esp; cf651cb4 <_end+f3e3700/10596a4c>

Trace; c0126dcf <kmalloc+eb/110>
Trace; c0125ef7 <get_vm_area+17/b8>
Trace; c012603d <__vmalloc+3d/1d0>
Trace; d0924502 <[imq].bss.end+d9b/1899>
Trace; c01cbb19 <translate_table+2b5/550>
Trace; c01cc2c9 <do_replace+169/42c>
Trace; c01cc78f <do_ipt_set_ctl+3b/54>
Trace; c0198cd1 <nf_sockopt+c5/fc>
Trace; c0198d2a <nf_setsockopt+22/28>
Trace; c01a7717 <ip_setsockopt+6eb/7a8>
Trace; c010f5d4 <do_page_fault+160/480>
Trace; c01bcaa8 <raw_setsockopt+28/58>
Trace; c01c2382 <inet_setsockopt+2a/34>
Trace; c018dea1 <sys_setsockopt+5d/78>
Trace; c018e546 <sys_socketcall+1ae/200>
Trace; c010852b <system_call+33/38>

Code;  c0126a84 <kmem_cache_grow+44/1d0>
00000000 <_EIP>:
Code;  c0126a84 <kmem_cache_grow+44/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126a86 <kmem_cache_grow+46/1d0>
   2:   68 04 00 e8 1d            push   $0x1de80004
Code;  c0126a8b <kmem_cache_grow+4b/1d0>
   7:   c0 c7 44                  rol    $0x44,%bh
Code;  c0126a8e <kmem_cache_grow+4e/1d0>
   a:   24 10                     and    $0x10,%al
Code;  c0126a90 <kmem_cache_grow+50/1d0>
   c:   01 00                     add    %eax,(%eax)
Code;  c0126a92 <kmem_cache_grow+52/1d0>
   e:   00 00                     add    %al,(%eax)
Code;  c0126a94 <kmem_cache_grow+54/1d0>
  10:   b8 03 00 00 00            mov    $0x3,%eax

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
->

Regards
tw

PS. If You want reply please CC me, I am not member of kernel list.
-- 

----------------
 ck.eter.tym.pl

"Never let shooling disturb Your education"

