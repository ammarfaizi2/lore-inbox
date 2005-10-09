Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVJIQYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVJIQYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJIQYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:24:30 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:37079 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750817AbVJIQYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:24:30 -0400
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-Id: <E1EOe44-00018F-Uq@localhost.localdomain>
Date: Sun, 09 Oct 2005 17:30:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 9 2005 John Rigg wrote:
>Steve, thanks for these patches. I got it to compile with 2.6.14-rc3-rt12
>but had to change the assembly lines in (patched) latency.c to
>
>        __asm__ __volatile__("and %%rsp,%0" :
> 				"=r" (stack_left) : "0" (THREAD_SIZE - 1));
>
>ie. `and' instead of `andl' and `%%rsp' instead of `%%esp'.
>Somebody who understands x86_64 assembly better than I do should probably check 
>this before anyone tries using it.
>While I was at it I changed a printk arg in line 335 of (patched)
>latency.c - I think the last %d should be %ld, ie. 
>
>printk("| new stack-footprint maximum: %s/%d, %ld bytes (out of %ld bytes).\n",
>	worst_stack_comm, worst_stack_pid, MAX_STACK-worst_stack_left, MAX_STACK);

Ingo, thanks to help from Steve Rostedt I got 2.6.14-rc3-rt12 to compile
with CONFIG_DEBUG_STACKOVERFLOW=y on x86_64 smp. Unfortunately if I enable 
it along with latency tracing (which is causing the crash during boot) 
it crashes so early that I can't get anything from the serial console,
even using earlyprintk. All I get is a blank screen for a few seconds
then the machine reboots.
I have all other debugging options disabled (apart from necessary dependencies 
for these two). This of course means that I can't confirm whether the crash
is caused by stack overflow.
With latency tracing disabled but CONFIG_DEBUG_STACKOVERFLOW=y the kernel 
boots and runs fine.
BTW this is still with initrd. If the stack footprint is likely to
be smaller with initramfs I'll give it a try, but it'll be a few days
before I can set this up (I still have to work out how to use initramfs).

John
