Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTFRGa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 02:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFRGa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 02:30:56 -0400
Received: from netmagic.net ([206.14.125.10]:33478 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S264469AbTFRGax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 02:30:53 -0400
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Per Nystrom <pnystrom@netmagic.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1055807219.1483.9.camel@spike.sunnydale>
References: <1055722972.1502.39.camel@spike.sunnydale>
	 <1055728825.1482.8.camel@spike.sunnydale>
	 <1055731591.2028.4.camel@spike.sunnydale>
	 <200306161259.h5GCxBj04115@polaris.relay>
	 <1055807219.1483.9.camel@spike.sunnydale>
Content-Type: text/plain
Organization: 
Message-Id: <1055918682.1711.22.camel@spike.sunnydale>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 23:44:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should probably just start a new thread with a more correct
description of the problem, but for the sake of thread continuity I
won't just yet.

First, a recap:

What's actually happening is that 2.4.21 crashes hard when magicdev
(part of Red Hat's gnome) is polling the cdrom drive to auto mount/play
a disk when it's inserted, and I try to burn a disk with cdrecord at the
same time.  The problem did not show up until 2.4.21; I was burning cds 
just fine on 2.4.20 with magicdev polling at the same time.  The crash
happens 100% of the time with this combination, and my temporary
solution is to turn off magicdev before burning a cd.

My system is mostly Red Hat 8.  The details can be found in the parent
of this thread, and I'm happy to provide more info -- just ask.

Now, the latest:

I was finally able to get an oops report (I had to copy it by hand from
virtual term tty0; try as I might, it would not show up on the serial
console -- though everything else up to that point did).  I ran it
through ksymoops, and the output is below.  I'm not sure what the
warning is all about; this is exactly the same kernel and .map file that
generated the oops.

This looks a lot like Roland Mas' problem, please see his post titled
"[Roland Mas] Still [OOPS] ide-scsi panic, now in 2.4.21 too" sent
16-June.

Thanks,
Per

---------------

ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (specified)

Warning (compare_maps): ksyms_base symbol
__io_virt_debug_R__ver___io_virt_debug not found in System.map. 
Ignoring ksyms_base entry
kernel BUG at ide-iops.c:1262!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01ee226>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: d096f640   ebx: 00000000   ecx: 00000032   edx: c135e37c
esi: ca3f2800   edi: c031bd84   ebp: c02dfeb4   esp: c02dfe8c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02df000)
Stack: 00000086 c02fb68e 00000082 ca3f2800 c031bcd4 c135e37c 00000092
00000000
       ca3f2800 00000000 c02dfec4 c01ee439 c031bd84 00000000 c02dfed0
d097089b
       c031bd84 c02dfef4 d095beaf ca3f2800 00000002 00000000 cf8c53f4
ca3f2800
Call Trace:    [<c01ee439>] [<d097089b>] [<d095beaf>] [<d095b2f5>]
[<d095b280>]
  [<c011f5cb>] [<c011ecc6>] [<c011baf2>] [<c011b9e6>] [<c011b816>]
[<c010a9ad>]
  [<c0107220>] [<c010d058>] [<c0107220>] [<c0107246>] [<c01072e2>]
[<c0105000>]
Code: 0f 0b ee 04 3f 64 28 c0 80 bf f9 00 00 00 20 74 0b 8b 45 0c


>>EIP; c01ee226 <do_reset1+26/220>   <=====

>>eax; d096f640 <[ide-scsi]idescsi_pc_intr+0/370>
>>edx; c135e37c <_end+103d844/104f5528>
>>esi; ca3f2800 <_end+a0d1cc8/104f5528>
>>edi; c031bd84 <ide_hwifs+504/2b48>
>>ebp; c02dfeb4 <init_task_union+1eb4/2000>
>>esp; c02dfe8c <init_task_union+1e8c/2000>

Trace; c01ee439 <ide_do_reset+19/20>
Trace; d097089b <[ide-scsi]idescsi_reset+1b/30>
Trace; d095beaf <[scsi_mod]scsi_reset+ff/370>
Trace; d095b2f5 <[scsi_mod]scsi_old_times_out+75/140>
Trace; d095b280 <[scsi_mod]scsi_old_times_out+0/140>
Trace; c011f5cb <run_timer_list+10b/170>
Trace; c011ecc6 <update_wall_time+16/40>
Trace; c011baf2 <bh_action+22/50>
Trace; c011b9e6 <tasklet_hi_action+46/70>
Trace; c011b816 <do_softirq+a6/b0>
Trace; c010a9ad <do_IRQ+bd/f0>
Trace; c0107220 <default_idle+0/40>
Trace; c010d058 <call_do_IRQ+5/d>
Trace; c0107220 <default_idle+0/40>
Trace; c0107246 <default_idle+26/40>
Trace; c01072e2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c01ee226 <do_reset1+26/220>
00000000 <_EIP>:
Code;  c01ee226 <do_reset1+26/220>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01ee228 <do_reset1+28/220>
   2:   ee                        out    %al,(%dx)
Code;  c01ee229 <do_reset1+29/220>
   3:   04 3f                     add    $0x3f,%al
Code;  c01ee22b <do_reset1+2b/220>
   5:   64                        fs
Code;  c01ee22c <do_reset1+2c/220>
   6:   28 c0                     sub    %al,%al
Code;  c01ee22e <do_reset1+2e/220>
   8:   80 bf f9 00 00 00 20      cmpb   $0x20,0xf9(%edi)
Code;  c01ee235 <do_reset1+35/220>
   f:   74 0b                     je     1c <_EIP+0x1c>
Code;  c01ee237 <do_reset1+37/220>
  11:   8b 45 0c                  mov    0xc(%ebp),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

-- 
Per Nystrom <pnystrom@netmagic.net>

