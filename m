Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTAIXHR>; Thu, 9 Jan 2003 18:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTAIXGp>; Thu, 9 Jan 2003 18:06:45 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:62191
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S268039AbTAIXFu>; Thu, 9 Jan 2003 18:05:50 -0500
Message-ID: <3E1E0285.4070303@aslab.com>
Date: Thu, 09 Jan 2003 15:15:17 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following oops while running the Cerberus stress test on 
2.4.21-pre3-ac2.  The  hardware is an ASUS A7N8X  single AMD Athlon XP 
motherboard with the Nvidia nforce2 chipset.  The test was only running 
for about 5 minutes when the oops occurred.  Running the stress test for 
more than 24 hours on 2.4.21-pre3 + 2.4.21-pre3-2420ide-1 was successful.

ksymoops 2.4.4 on i686 2.4.21-pre3-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2/ (default)
     -m /boot/System.map-2.4.21-pre3-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01354e2
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01354e2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
esi: c1a6e950   edi: 00000000   ebp: 00001550   esp: f79fbbac
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 124, stackpage=f79fb000)
Stack: c01415f2 0017a908 c03c9390 f7e7ee40 c03c92e0 00000000 c1a6e950 
00000000
       c1a6e950 00000020 00001550 c0134ad7 0000052a f79fa000 00000200 
00000070
       c02fab34 f79fa000 00000000 00000000 00000000 00000020 00000070 
00000006
Call Trace:    [<c01415f2>] [<c0134ad7>] [<c0134c70>] [<c0134cec>] 
[<c01357d0>]
  [<c0135a8b>] [<c013b110>] [<c013b36e>] [<c013b26c>] [<c020182c>] 
[<c02018b1>]
  [<c0201b77>] [<c0201e4f>] [<c013f276>] [<c0201ec1>] [<c0202057>] 
[<c013f297>]
  [<c0173393>] [<c0172aad>] [<c0171c1f>] [<c01747d6>] [<c0174680>] 
[<c01071d6>]
  [<c01746a0>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 83 c4 1c

 >>EIP; c01354e2 <__free_pages_ok+282/2a0>   <=====
Trace; c01415f2 <try_to_free_buffers+d2/160>
Trace; c0134ad7 <shrink_cache+387/3b0>
Trace; c0134c70 <shrink_caches+50/90>
Trace; c0134cec <try_to_free_pages_zone+3c/60>
Trace; c01357d0 <balance_classzone+60/200>
Trace; c0135a8b <__alloc_pages+11b/170>
Trace; c013b110 <alloc_bounce_page+10/a0>
Trace; c013b36e <create_bounce+12e/15c>
Trace; c013b26c <create_bounce+2c/15c>
Trace; c020182c <__make_request+ac/5b0>
Trace; c02018b1 <__make_request+131/5b0>
Trace; c0201b77 <__make_request+3f7/5b0>
Trace; c0201e4f <generic_make_request+11f/140>
Trace; c013f276 <__refile_buffer+56/60>
Trace; c0201ec1 <submit_bh+51/70>
Trace; c0202057 <ll_rw_block+177/1c0>
Trace; c013f297 <refile_buffer+17/20>
Trace; c0173393 <__try_to_free_cp_buf+33/40>
Trace; c0172aad <journal_brelse_array+1d/30>
Trace; c0171c1f <journal_commit_transaction+3af/10dd>
Trace; c01747d6 <kjournald+136/210>
Trace; c0174680 <commit_timeout+0/10>
Trace; c01071d6 <kernel_thread+26/30>
Trace; c01746a0 <kjournald+0/210>
Code;  c01354e2 <__free_pages_ok+282/2a0>
00000000 <_EIP>:
Code;  c01354e2 <__free_pages_ok+282/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c01354e5 <__free_pages_ok+285/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01354e7 <__free_pages_ok+287/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01354ea <__free_pages_ok+28a/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01354ed <__free_pages_ok+28d/2a0>
   b:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c01354f0 <__free_pages_ok+290/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c01354f3 <__free_pages_ok+293/2a0>
  11:   83 c4 1c                  add    $0x1c,%esp


1 warning issued.  Results may not be reliable.


