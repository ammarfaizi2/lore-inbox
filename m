Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTIIJA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTIIJA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:00:59 -0400
Received: from mail.igrin.co.nz ([202.49.244.12]:32994 "EHLO mail.igrin.co.nz")
	by vger.kernel.org with ESMTP id S263477AbTIIJA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:00:56 -0400
Message-ID: <2306.202.49.246.52.1063098049.squirrel@webmail.igrin.co.nz>
Date: Tue, 9 Sep 2003 21:00:49 +1200 (NZST)
Subject: Cannot get Hyperthreading working on Asus P4PE-X
From: "Simon Byrnand" <simon@igrin.co.nz>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I have a P4 2.4C with 800Mhz FSB in an Asus P4PE-X. (BIOS version 1.03)
Everything I can find suggests that it should support hyperthreading but
so far I'm unable to activate it in Linux.

According to the intel site the specific model of CPU and the chipset
support hyperthreading. The BIOS option to enable and disable
hyperthreading works, when it is activated it shows two processors on the
post screen during boot.

I did a clean install of Redhat 7.3, and obviously the installer *thought*
it detected an SMP machine because it installed the SMP version of the
kernel instead of the UP version, but hyperthreading support wasn't
working.

So I compiled my own kernel using 2.4.22 and made sure that P4 was
selected for the processor type and SMP support was selected, and after
reading some suggestions I also tried acpismp=force all to no avail.
/proc/cpuinfo shows:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.121
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

An excerpt from dmesg:

Kernel command line: auto BOOT_IMAGE=linux ro root=303
BOOT_FILE=/boot/vmlinuz-2.4.22 acpismp=force
Found and enabled local APIC!
Initializing CPU#0
Detected 2400.121 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 515212k/524208k available (1282k kernel code, 8608k reserved, 344k
data, 276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1462.38 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2400.1025 MHz.
..... host bus clock speed is 200.0083 MHz.
cpu: 0, clocks: 2000083, slice: 1000041
CPU0<T0:2000080,T1:1000032,D:7,S:1000041,C:2000083>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle

After spending hours searching the net I'm totally confused by the
conflicting information regarding Linux support for Hyperthreading.

Some people say any kernel since 2.4.17 supports hyperthreading (with
improved support sine 2.4.20) while other sources say that the mainline
kernel doesn't support hyperthreading.

Some messages (admitedly out of date ones) on this list suggest that only
the Xeon's really have hyperthreading, while others say that desktop P4's
now support hyperthreading too.

(For what its worth, the box the CPU came in said it supported
hyperthreading, but I've also seen the box of a P4 2.4B 533Mhz FSB CPU say
it supports hyperthreading too, while the intel site says it doesnt :)

Can anyone clear up all this conflicting and confusing information and
perhaps suggest what I might be doing wrong ? (Or at least let me know
"yes, you won't get hyperthreading working with that motherboard, yet" or
similar)

I'm not subscribed to the list, so please CC any replies.

Regards,
Simon Byrnand

