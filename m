Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSGZDQD>; Thu, 25 Jul 2002 23:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGZDQD>; Thu, 25 Jul 2002 23:16:03 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:25085 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316728AbSGZDQC>;
	Thu, 25 Jul 2002 23:16:02 -0400
Date: Thu, 25 Jul 2002 23:19:14 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.28: "bad: schedule() with irqs disabled!"
Message-ID: <20020726031914.GA32749@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.28 compiled for SMP+preempt (and running on 2 CPU SMP box) I get...

bad: schedule() with irqs disabled!

...followed by a backtrace early in the boot process. Without preempt this 
notice does not appear. Below is a decoded version followed by the original
with several lines of context in case that is of use.

--Adam

ksymoops 2.4.1 on i686 2.5.28.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.28/ (default)
     -m /boot/System.map-2.5.28 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol GPLONLY___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
c9fd1f84 c0288240 c0346436 c0313900 c0119844 00000000 00000001 00000000 
       c02dd7fe c028723d 00000001 00000000 00000000 00000000 00000000 c02dfac5 
       00000bd1 c02d8000 00000286 c02c0724 c02d9f94 c01154ec 00000000 c02d8000 
Call Trace: [<c0119844>] [<c01154ec>] [<c0115505>] [<c0119850>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0119844 <printk+144/180>
Trace; c01154ec <__wake_up+2c/50>
Trace; c0115505 <__wake_up+45/50>
Trace; c0119850 <printk+150/180>


6 warnings issued.  Results may not be reliable.


CPU0: Intel 00/01 stepping 09
per-CPU timeslice cutoff: 730.16 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
bad: schedule() with irqs disabled!
c9fd1f84 c0288240 c0346436 c0313900 c0119844 00000000 00000001 00000000 
       c02dd7fe c028723d 00000001 00000000 00000000 00000000 00000000 c02dfac5 
       00000bd1 c02d8000 00000286 c02c0724 c02d9f94 c01154ec 00000000 c02d8000 
Call Trace: [<c0119844>] [<c01154ec>] [<c0115505>] [<c0119850>] 
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 397.31 BogoMIPS
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
CPU:             Common caps: 0000fbff 00000000 00000000 00000000
CPU1: Intel 00/01 stepping 09
Total of 2 processors activated (787.45 BogoMIPS).

