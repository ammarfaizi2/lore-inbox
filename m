Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTHZOmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTHZOmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:42:18 -0400
Received: from fistfulofdollars.mr.itd.umich.edu ([141.211.14.50]:15305 "EHLO
	fistfulofdollars.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262695AbTHZOkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:40:23 -0400
Subject: debian 2.4.18 fatal oopses (hardware related?)
From: Greg Fischer <gregfi@umich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: University of Michigan
Message-Id: <1061908804.7621.1.camel@main>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 10:40:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
I have K6-2 based machine using an obscure motherboard which has been
crashing with seemingly increasing frequency (it happens almost daily
now). The motherboard is a California Graphics Photon 100 HC, that
company doesn't exist anymore. The oopses I get vary widely, but I have
attached a sample oops and its ksymoops output. They all ultimately end
up killing the interrupt handler. I am strongly suspicous of hardware
problems, but memtest86 ran for approximately 7 hours or so and didn't
find the memory at fault.
 
If there is any other information I should post, I'd be more than happy
to provide it.  Thanks.
 
the oops:
 
Unable to handle kernel paging request virtual address d9236264
printing eip:
c010a8b3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010a8b3>]       Not tainted
EFLAGS: 00010a03
eax: 002f47a6   ebx: c27938e0   ecx: 00000000   edx: 00000fdd
esi: c5115bab   edi: 00000000   ebp: 0000004f   esp: c0201ef8
ds: 0018        es: 0018        ss: 0018
Process swapper (pid: 0, stackpage=c0201000)
Stack:  c0186d74 c27938f0 c27938e0 c5115bab c3d1ae01 c88b659e c27938e0
c27938e0
        c63f6400 00000001 c88bc000 c63f6400 c63f6540 00000053 00005b58
c5110000
        c88b682d c63f6400 c63f6540 c88bc000 c636b480 04000001 0000000b
c0201fa8
Call Trace: [<c0186d74>] [<c88b659e>] [<c88b682d>] [<c0107f9c>]
[<c0108102>]
   [<c0105360>] [<c0109ee8>] [<c0105360>] [<c0105383>] [<c01053e7>]
[<c0105000>]
   [<c0105027>]
  
Code: 62 23 c0 a1 a4 d9 23 c0 03 15 64 62 23 c0 2b 05 68 ea 23 c0
 <0>Kernel panic: Aiee, killing interrupt handler!
 
----
 
ksymoops output:
 
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/drivers/ide/ide-disk.o for module ide-disk
has changed since load
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/drivers/ide/ide-probe-mod.o for module
ide-probe-mod has changed since load
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/drivers/ide/ide-mod.o for module ide-mod
has changed since load
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/fs/ext2/ext2.o for module ext2 has changed
since load
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/fs/ext3/ext3.o for module ext3 has changed
since load
Warning (expand_objects): object
/lib/modules/2.4.18-k6/kernel/fs/jbd/jbd.o for module jbd has changed
since load
Unable to handle kernel paging request virtual address d9236264
c010a8b3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010a8b3>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a03
eax: 002f47a6   ebx: c27938e0     ecx: 00000000       edx: 00000fdd
esi: c5115bab   edi: 00000000     ebp: 0000004f       esp: c0201ef8
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c0201000)
Stack:  c0186d74 c27938f0 c27938e0 c5115bab c3d1ae01 c88b659e c27938e0
c27938e0
        c63f6400 00000001 c88bc000 c63f6400 c63f6540 00000053 00005b58
c5110000
        c88b682d c63f6400 c63f6540 c88bc000 c636b480 04000001 0000000b
c0201fa8
Call Trace: [<c0186d74>] [<c88b659e>] [<c88b682d>] [<c0107f9c>]
[<c0108102>]
   [<c0105360>] [<c0109ee8>] [<c0105360>] [<c0105383>] [<c01053e7>]
[<c0105000>]
   [<c0105027>]
Code: 62 23 c0 a1 a4 d9 23 c0 03 15 64 62 23 c0 2b 05 68 ea 23 c0
  
  
>>EIP; c010a8b3 <do_gettimeofday+13/5c>   <=====
  
>>eax; 002f47a6 Before first symbol
>>ebx; c27938e0 <_end+2529f54/85a36d4>
>>edx; 00000fdd Before first symbol
>>esi; c5115bab <_end+4eac21f/85a36d4>
>>esp; c0201ef8 <init_task_union+1ef8/2000>
  
Trace; c0186d74 <netif_rx+18/ec>
Trace; c88b659e <[8139too]rtl8139_rx_interrupt+196/264>
Trace; c88b682d <[8139too]rtl8139_interrupt+6d/dc>
Trace; c0107f9c <handle_IRQ_event+30/5c>
Trace; c0108102 <do_IRQ+6a/a8>
Trace; c0105360 <default_idle+0/28>
Trace; c0109ee8 <call_do_IRQ+5/d>
Trace; c0105360 <default_idle+0/28>
Trace; c0105383 <default_idle+23/28>
Trace; c01053e7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>
  
Code;  c010a8b3 <do_gettimeofday+13/5c>
00000000 <_EIP>:
Code;  c010a8b3 <do_gettimeofday+13/5c>   <=====
   0:   62 23                     bound  %esp,(%ebx)   <=====
Code;  c010a8b5 <do_gettimeofday+15/5c>
   2:   c0 a1 a4 d9 23 c0 03      shlb   $0x3,0xc023d9a4(%ecx)
Code;  c010a8bc <do_gettimeofday+1c/5c>
   9:   15 64 62 23 c0            adc    $0xc0236264,%eax
Code;  c010a8c1 <do_gettimeofday+21/5c>
   e:   2b 05 68 ea 23 c0         sub    0xc023ea68,%eax
  
 <0>Kernel panic: Aiee, killing interrupt handler!
  
7 warnings issued.  Results may not be reliable.
 
--Greg

