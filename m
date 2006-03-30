Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWC3J1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWC3J1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWC3J1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:27:16 -0500
Received: from tornado.reub.net ([202.89.145.182]:55226 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932145AbWC3J1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:27:14 -0500
Message-ID: <442BA46F.5040601@reub.net>
Date: Thu, 30 Mar 2006 21:27:11 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060321)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm2
References: <20060328003508.2b79c050.akpm@osdl.org>
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2006 8:35 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/
> 
> 
> - It seems to compile.

I've just upgraded from an i386 to an x86_64.  It was an.... ordeal, but the 
kernel was the least of the worries.  Userland upgrades were a pain.

Using the same config as on i386 apart from the differences that a 'make 
oldconfig' threw up on the new architecture, I am now seeing some problems with 
the x86_64 that I was not seeing on i386 on this release.

Kernel messages like this when booting up:

time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 3000.283 MHz processor.
Console: colour VGA+ 80x25
time.c: Lost 85 timer tick(s)! rip 10:start_kernel+0x14c/0x220
last clier stext+0x7fdff0e8/0xe8 caller stext+0x7fdff0e8/0xe8
time.c: Lost 5 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
last clier stext+0x7fdff0e8/0xe8 caller stext+0x7fdff0e8/0xe8
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
time.c: Lost 2 timer tick(s)! rip 10:release_console_sem+0x1a5/0x228
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1023528k/1046716k available (2399k kernel code, 22328k reserved, 1365k 
data, 196k init)
Calibrating delay using timer specific routine.. 6007.62 BogoMIPS (lpj=12015240)
Security Framework v1.0.0 initialized

and more:

CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
result 12501113
Detected 12.501 MHz APIC timer.
time.c: Lost 11 timer tick(s)! rip 10:setup_boot_APIC_clock+0x173/0x177
last clier setup_boot_APIC_clock+0x47/0x177 caller smp_prepare_cpus+0x36e/0x399
time.c: Lost 5 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
last clier setup_boot_APIC_clock+0x47/0x177 caller smp_prepare_cpus+0x36e/0x399
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.56 BogoMIPS (lpj=12001127)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K

and..

md: running: <sdb2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 68 bits, status: 0
time.c: Lost 2 timer tick(s)! rip 10:handle_IRQ_event+0x24/0x74
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
created bitmap (187 pages) for device md0
time.c: Lost 1 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
time.c: Lost 5 timer tick(s)! rip 10:handle_IRQ_event+0x24/0x74
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
time.c: Lost 2 timer tick(s)! rip 10:serial8250_interrupt+0x1/0x100
last clier handle_IRQ_event+0x62/0x74 caller __do_IRQ+0xb3/0x119
time.c: Lost 6 timer tick(s)! rip 10:handle_IRQ_event+0x24/0x74
last clier handle_IRQ_event+0x62/0x74 caller __do_IRQ+0xb3/0x119
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
time.c: Lost 1 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
time.c: Lost 5 timer tick(s)! rip 10:handle_IRQ_event+0x24/0x74
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
audit(1143698568.416:2): selinux=0 auid=4294967295
time.c: Lost 1 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
time.c: Lost 5 timer tick(s)! rip 10:handle_IRQ_event+0x24/0x74
last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
hw_random hardware driver 1.0.0 loaded

They're not appearing all the time, so far mainly at boot time.

I've posted the full dmesg and config up at http://www.reub.net/files/kernel/

As this is the first release I've run on x86_64 I can't say how long this one 
has been showing up for ;)

Thanks,
Reuben

