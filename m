Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKKXsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKKXsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKKXsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:48:18 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:60865 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750712AbVKKXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:48:17 -0500
Message-ID: <43752DC0.1050404@comcast.net>
Date: Fri, 11 Nov 2005 18:48:16 -0500
From: Gautam Thaker <gthaker@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gthaker@comcast.net
Subject: 2.6.14-rt9 nanosleep() behavior..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that nanosleep() on 2.6.14-rt9 built with real-time
options listed at bottom of this page has unexpected behavior.  In
2.6.13-RC4-RT53 if  one called

nanosleep(20msec)

than actual sleep durations were very close to 20msec. (average  number
over 1 million samples yielded  20.008msec with minimum of  20.007msec
and maximum of 20.060 msec).
(2.6.13-RC4-RT53 nanosleep(20msec) histogram can be viewed at:

http://www.atl.external.lmco.com/projects/QoS/compare/j_data/linux/2.6.13-RC4-RT-53-07/basement_prio_95_noload_with_chrt_on_pid_8_to_p97_20msec.out.png

with 2.6.14-rt9, nanosleep(20msec) returns average sleep interval of 21 
msec.

Is the previously seen behavior in 2.6.13-RC4-RT-53-07 possible now 
under latest kernels?

New  kernel (2.6.14-rt9) was built with:

Subarchitecture Type (PC-compatible)  --->
    Processor family (Pentium-Pro)  --->
[*] Generic x86 support
[*] HPET Timer Support
[ ] Ktimers 64bit scalar representation
[*] High Resolution Timer Support
(1000) High Resolution Timer resolution (nanoseconds)
[ ] Symmetric multi-processing support
    Preemption Mode (Complete Preemption (Real-Time))  --->
--- Thread Softirqs
--- Thread Hardirqs
--- Preemptible RCU
[*]   /proc stats for preemptible RCU read-side critical sections
[ ] /proc torture tests for RCU
[ ] Local APIC support on uniprocessors
[*] Machine Check Exception
< >   Check for non-fatal errors on AMD Athlon/Duron / Intel Pentium
<M> Toshiba Laptop support
<M> Dell laptop support
[ ] Enable X86 board specific fixups for reboot
<M> /dev/cpu/microcode - Intel IA32 CPU microcode support
<M> /dev/cpu/*/msr - Model-specific register support
<M> /dev/cpu/*/cpuid - CPU information support
    Firmware Drivers  --->
    High Memory Support (4GB)  --->
    Memory model (Flat Memory)  --->
[*] Allocate 3rd-level pagetables from highmem
[ ] Math emulation
[*] MTRR (Memory Type Range Register) support
[ ] Boot from EFI support (EXPERIMENTAL)
[*] Use register arguments (EXPERIMENTAL)
[*] Enable seccomp to safely compute untrusted bytecode
    Timer frequency (1000 HZ)  --->
[ ] kexec system call (EXPERIMENTAL)

