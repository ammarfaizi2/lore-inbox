Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSBTGCF>; Wed, 20 Feb 2002 01:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291665AbSBTGBq>; Wed, 20 Feb 2002 01:01:46 -0500
Received: from CPE00403333780e.cpe.net.cable.rogers.com ([24.112.22.235]:17414
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id <S291664AbSBTGBk>; Wed, 20 Feb 2002 01:01:40 -0500
Date: Wed, 20 Feb 2002 00:42:14 -0500
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.4.17] HD/FS Problems
Message-ID: <20020220054213.GA10558@tentacle.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lately I have been having alot of oopses running 2.4.17, I think it
has something to do with my hd or fs. I am running debian unstable
with 2.4.17 kernel. I am using ext3, but I was having the same problem
running rieserfs aswell. What will happen is I will get an oops and a lockup
access a certain file all the time. So I reboot booting with "init=/bin/bash"
and run fsck on the partition. I almost always get an oops running
fsck. I am able to get by the oopsing by saying yes just a couple
times and then sysrq-s to sync the disc sometimes, I don't get an oops
and I can eventually (after many lockups and reboots) get fsck to run
through without any problems. The reason I think this is my hd is in
the past month or so I have been hearing it stop running and then power
back up. I have all apm related options turned off in my bios.
I hand wrote an oops that I got the other day in single user mode running
fsck Here it is:

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c01107d0
*pde = 00001063
Oops: 0000
CPU:    0
EIP: 0010:[<c01107d0>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: dfff4108 ebx: ffff410c ecx: 00000001 edx: 00000003
esi: dfff4108 edi: 00000001 ebp: c026beb8 esp: c026beb8
ds: 0018 es: 0018 ss: 0018
Process Swapper (pid: 0, stackpage=c026b000)
Stack: dfff4108 00000002 c17ffd40 000001f6 00000082 00000003 00000001 c012e16a 
    dfff40c0 c012eafe dfff40c0 c1a211c0 00000008 c01898b1 dfff40c0 
    00000001 c1a211c0 00000286 c1a28080 c02c7160 c019698a c1a211c0 00000001
    c02c7280
Call Trace: [<c012e16a>] [<c012eafe>] [<c01898b1>] [<c019698a>] [<c019b2d8>] [<c0198297>] [<c019b270>] [<c0107f6f>] [<c01080ee>] [<c0105170>] [<c0105170>] [<c0109fe8>] [<c0105170>] [<c0105170>] [<c0105193>] [<c0105202>] [<c0105000>] [<c0105027>]
Code: 8b 03 0f 0d 00 83 c6 04 89 75 f4 39 f3 74 64 90 8b 4b fc 8b

>>EIP; c01107d0 <__wake_up+20/a0>   <=====
Trace; c012e16a <unlock_buffer+3a/40>
Trace; c012eafe <end_buffer_io_async+3e/90>
Trace; c01898b0 <end_that_request_first+60/c0>
Trace; c019698a <ide_end_request+5a/90>
Trace; c019b2d8 <ide_dma_intr+68/b0>
Trace; c0198296 <ide_intr+f6/150>
Trace; c019b270 <ide_dma_intr+0/b0>
Trace; c0107f6e <handle_IRQ_event+2e/60>
Trace; c01080ee <do_IRQ+6e/b0>
Trace; c0105170 <default_idle+0/30>
Trace; c0105170 <default_idle+0/30>
Trace; c0109fe8 <call_do_IRQ+6/e>
Trace; c0105170 <default_idle+0/30>
Trace; c0105170 <default_idle+0/30>
Trace; c0105192 <default_idle+22/30>
Trace; c0105202 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/30>
Code;  c01107d0 <__wake_up+20/a0>
00000000 <_EIP>:
Code;  c01107d0 <__wake_up+20/a0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c01107d2 <__wake_up+22/a0>
   2:   0f 0d 00                  prefetch (%eax)
Code;  c01107d4 <__wake_up+24/a0>
   5:   83 c6 04                  add    $0x4,%esi
Code;  c01107d8 <__wake_up+28/a0>
   8:   89 75 f4                  mov    %esi,0xfffffff4(%ebp)
Code;  c01107da <__wake_up+2a/a0>
   b:   39 f3                     cmp    %esi,%ebx
Code;  c01107dc <__wake_up+2c/a0>
   d:   74 64                     je     73 <_EIP+0x73> c0110842 <__wake_up+92/a0>
Code;  c01107de <__wake_up+2e/a0>
   f:   90                        nop    
Code;  c01107e0 <__wake_up+30/a0>
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c01107e2 <__wake_up+32/a0>
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.

Also when running dselect and upgrading some packages ext3 issued this
error to kern.log:

Feb 20 00:41:00 golbez kernel: ext3_free_blocks: Freeing blocks not in datazone
- block = 538082710, count = 1

My filesystem was then remount read only. So can anyone help me out 
tracking down the source of my problem?

My hardware: AMD Thunderbird (UNDER-clocked), ASUS A7V133 motherboard 
and a IBM-DPTA-372050 20GB Hard drive.

John
