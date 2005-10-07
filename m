Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVJGAcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVJGAcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 20:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJGAcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 20:32:17 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:11758 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S932222AbVJGAcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 20:32:16 -0400
Subject: 2.6.14-rc3-rt10 crashes on boot
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-Id: <E1ENgFH-00017G-HI@localhost.localdomain>
Date: Fri, 07 Oct 2005 01:37:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that rt kernels are compiling again on x86_64 I'm getting
a recurrence of a boot problem I had with 2.6.13-rt4 on a dual
Opteron. If I enable latency tracing it crashes during boot, but 
if I use exactly the same .config except with latency tracing 
disabled it boots and runs fine. Every version of rt I've managed 
to compile since then has crashed in the same place with latency
tracing enabled. 
Below are excerpts from .config and from boot messages via serial 
console.
                      ________________________

CONFIG_SMP=y
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
CONFIG_PREEMPT_RCU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_IRQ_FLAGS=y
CONFIG_WAKEUP_TIMING=y
CONFIG_WAKEUP_LATENCY_HIST=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
CONFIG_LATENCY_TIMING=y
CONFIG_LATENCY_HIST=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
CONFIG_RT_DEADLOCK_DETECT=y
# CONFIG_DEBUG_RT_LOCKING_MODE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_FRAME_POINTER=y
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_KPROBES is not set
                     ______________________________

<snip>
Bootdata ok (command line is root=/dev/hda7 ro console=tty0 console=ttyS0,38400 )
Linux version 2.6.14-rc3-rt10-mindriv-debug-amd64-k8-smp (jqr@mj0lnir) (gcc version 4.0.2 20050917 (prerelease) (Debian 4.0.1-8)) #1 SMP PREEMPT Thu Oct 6 22:43:49 UTC 2005
</snip>
...

<snip>
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
umount: devfs: not mounted
mount: unknown filesystem type 'devfs'
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
umount: devfs: not mounted
INIT: version 2.86 booting
hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffff8bee68 error 15
hotplug[878]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffb1a408 error 15
hotplug[879]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffff878408 error 15
hotplug[880]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffad36d8 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffc00b10 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffc003b8 error 15
rcS[882]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffff967428 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffc003b8 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp 00007fffffc003b8 error 15
</snip>

After this point the same error message is repeated in an infinite loop and a 
hard reboot is required. 
If I get time in the next few days I'll try and find the earliest
version of rt that does this (haven't tried anything earlier than 2.6.13-rt4).

John
