Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317956AbSGWGBH>; Tue, 23 Jul 2002 02:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSGWGBG>; Tue, 23 Jul 2002 02:01:06 -0400
Received: from [196.26.86.1] ([196.26.86.1]:43710 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317956AbSGWGBF>; Tue, 23 Jul 2002 02:01:05 -0400
Date: Tue, 23 Jul 2002 08:22:02 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: rml@tech9.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>
Subject: 2.5-ide24-preempt scheduling in interrupt context
Message-ID: <Pine.LNX.4.44.0207230820030.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Andre, Robert
 	The box is 2.5.25-dj2 w/ 2.4-IDE and preempt running on 4-way 
SMP. I have walked the entire call path manually and verified that it is 
correct. Andre i do know your stance on this but please check it out 
regardless, i'm willing to help in any way. For my own curiosity is that 
thread flag check for TIF_NEED_RESCHED correct in this context?

Cheers,
	Zwane

kernel BUG at sched.c:808!
invalid operand: 0000
CPU:    2
EIP:    0010:[<c0116828>]    Not tainted
EFLAGS: 00010002
eax: 00000001   ebx: c11fc000   ecx: 00000000   edx: 00000040
esi: c027c800   edi: 0000509a   ebp: c11fdddc   esp: c11fddb0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c11fc000 task=c10c2680)
Stack: c028ec80 00000000 00000000 00000000 00000000 00000002 00000020 00000001
       c11fc000 c027c800 0000509a c11fdde8 c0116d0e c11fde04 c11fde14 c0115b6e
       c11fde04 c027c800 c11fde04 c027c800 00000001 00000086 00000000 c02bd4e0
Call Trace: [<c0116d0e>] [<c0115b6e>] [<c0116d51>] [<c0116def>] [<c0148f1c>]
   [<c0149018>] [<c01b21c3>] [<c014d364>] [<c01b2677>] [<c01164bd>] [<c01cc008>]   [<c01cb118>] [<c01c51cf>] [<c01caea0>] [<c010b44e>] [<c010b7bb>] [<c0106f00>]   [<c0109a7a>] [<c0106f00>] [<c0106f00>] [<c0106f2a>] [<c0106fd2>] [<c011c52e>]

Code: 0f 0b 28 03 3f 38 23 c0 e8 6b cd 02 00 bb 00 e0 ff ff 21 e3
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; c0116828 <schedule+28/4f0>   <=====
Trace; c0116d0e <preempt_schedule+1e/40>
Trace; c0115b6e <try_to_wake_up+31e/330>
Trace; c0116d51 <default_wake_function+21/40>
Trace; c0116def <__wake_up+7f/f0>
Trace; c0148f1c <unlock_buffer+3c/40>
Trace; c0149018 <end_buffer_io_sync+28/30>
Trace; c01b21c3 <end_bio_bh_io_sync+13/20>
Trace; c014d364 <bio_endio+24/30>
Trace; c01b2677 <end_that_request_first+187/270>
Trace; c01164bd <scheduler_tick+12d/460>
Trace; c01cc008 <idedisk_end_request+98/150>
Trace; c01cb118 <read_intr+278/2d0>
Trace; c01c51cf <ide_intr+1ff/2f0>
Trace; c01caea0 <read_intr+0/2d0>
Trace; c010b44e <handle_IRQ_event+5e/90>
Trace; c010b7bb <do_IRQ+11b/1e0>
Trace; c0106f00 <default_idle+0/40>
Trace; c0109a7a <common_interrupt+22/28>
Trace; c0106f00 <default_idle+0/40>
Trace; c0106f00 <default_idle+0/40>
Trace; c0106f2a <default_idle+2a/40>
Trace; c0106fd2 <cpu_idle+52/70>
Trace; c011c52e <printk+1ae/210>
Code;  c0116828 <schedule+28/4f0>
00000000 <_EIP>:
00000000 <_EIP>:
Code;  c0116828 <schedule+28/4f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011682a <schedule+2a/4f0>
   2:   28 03                     sub    %al,(%ebx)
Code;  c011682c <schedule+2c/4f0>
   4:   3f                        aas
Code;  c011682d <schedule+2d/4f0>
   5:   38 23                     cmp    %ah,(%ebx)
Code;  c011682f <schedule+2f/4f0>
   7:   c0 e8 6b                  shr    $0x6b,%al
Code;  c0116832 <schedule+32/4f0>
   a:   cd 02                     int    $0x2
Code;  c0116834 <schedule+34/4f0>
   c:   00 bb 00 e0 ff ff         add    %bh,0xffffe000(%ebx)
Code;  c011683a <schedule+3a/4f0>
  12:   21 e3                     and    %esp,%ebx

 <0>Kernel panic: Aiee, killing interrupt handler!


-- 
function.linuxpower.ca

