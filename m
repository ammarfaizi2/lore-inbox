Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVDRI4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVDRI4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVDRI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:56:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:21674 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261976AbVDRI4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:56:43 -0400
Message-ID: <42637607.7050207@in.ibm.com>
Date: Mon, 18 Apr 2005 14:25:35 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: discuss@x86-64.org
Subject: x86_64: How to disable local APIC timer interrupts?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to disable the local APIC timer interrupts on x86_64
machine, but finding that it just doesn't work. I am trying to find out
if I am doing something wrong or if there is a problem with these CPUs.

I have a dual-cpu x86_64 machine and I have booted up with 2.6.11 kernel
and nmi_watchdog=2. I called disable_APIC_timer() function, which seems
to be setting the 16th bit of the APIC timer register, which is what the
AMD document suggests to disable the timer. This function is in fact
__init, but I changed it not to be so. I noticed that we continue to see
local APIC timer interrupts on the very CPU where I called
disable_APIC_timer. I have a printk in smp_apic_timer_interrupt() to
verify this. Booting the machine with maxcpus=1 didn't have any effect
on the outcome. CPUs are of the following type:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 248
stepping        : 8
cpu MHz         : 2193.510
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow
bogomips        : 4325.37
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

Please let me know if I am doing something wrong and if I should do
something else to disable local APIC timer interrupts. I need to disable
these interrupts to solve a problem in LKCD dumping.
smp_apic_timer_interrupt eventually calls update_process_times, which is
causing problem in a particular LKCD dump case I am looking at.

Please copy me on your reply, as I have not subscribed to the list.

Thanks and regards,
Sripathi.
