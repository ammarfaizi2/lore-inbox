Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263128AbRFCRYQ>; Sun, 3 Jun 2001 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263686AbRFCRYG>; Sun, 3 Jun 2001 13:24:06 -0400
Received: from [213.128.193.148] ([213.128.193.148]:44305 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263128AbRFCRXw>;
	Sun, 3 Jun 2001 13:23:52 -0400
Date: Sun, 3 Jun 2001 21:23:31 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac7 SMP crash (hotplug race?)
Message-ID: <20010603212331.A1619@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Today, while playing with sleep mode of USB device I have, I got
   kernel hang on my SMP box (2xP3-667, 386M RAM, Abit VP6).
   Scenario was like this: background mpg123 over esd to
   00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
   minicom over ttyS1 to device, USB netlink (usbnet.c) to device over USB.

   I told device to go to sleep, it reported (over serial console that I
   looked at with minicom), that it turned off internal devices
   (including USB client), reported it is going to sleep, and turned
   serial and itself off.
   Suddenly mp3 playing stopped and I got this (decoded) diagnostics
   from kernel:

ksymoops 2.4.0 on i686 2.4.5-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac7/ (default)
     -m /boot/System.map-2.4.5-ac7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

wait_on_irq, CPU 1
irq: 1 [1 0]
bh:  1 [0 1]
CPU 0: <unknown>
CPU 1: c167fe68 c01d805d ... (not recorded full stack)
Call Trace: [<c0108522>] [<c0170f97>] [<c0170f60>] [<c011d706>] [<c011a56c>] [<c011a423>] [<c011a2ab>] [<c0108935>] [<c0108525>] [<c01617e8>] [<c011a67d>] [<c0121c35>] [<c0121670>] [<c0105000>] [<c0105556>] [<c0121670>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0108522 <__global_cli+e2/170>
Trace; c0170f97 <rs_timer+37/110>
Trace; c0170f60 <rs_timer+0/110>
Trace; c011d706 <timer_bh+256/2b0>
Trace; c011a56c <bh_action+4c/b0>
Trace; c011a423 <tasklet_hi_action+53/90>
Trace; c011a2ab <do_softirq+6b/a0>
Trace; c0108935 <do_IRQ+e5/f0>
Trace; c0108525 <__global_cli+e5/170>
Trace; c01617e8 <flush_to_ldisc+d8/120>
Trace; c011a67d <__run_task_queue+5d/70>
Trace; c0121c35 <context_thread+c5/200>
Trace; c0121670 <exec_usermodehelper+3c0/400>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c0105556 <kernel_thread+26/30>
Trace; c0121670 <exec_usermodehelper+3c0/400>

2 warnings issued.  Results may not be reliable.

Bye,
    Oleg
