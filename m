Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbVD3AoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbVD3AoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbVD3AoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:44:08 -0400
Received: from fsmlabs.com ([168.103.115.128]:39125 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263099AbVD3AoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:44:00 -0400
Date: Fri, 29 Apr 2005 18:46:21 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
In-Reply-To: <20050429172605.A23722@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0504291844310.15561@montezuma.fsmlabs.com>
References: <20050429172605.A23722@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Venkatesh Pallipadi wrote:

> 
> Background: 
> Local APIC timer stops functioning when CPU is in C3 state. As a
> result the local APIC timer interrupt will fire at uncertain times, depending
> on how long we spend in C3 state. And this has two side effects
> * Idle balancing will not happen as we expect it to.
> * Kernel statistics for idle time will not be proper (as we get less LAPIC
>   interrupts when we are idle). This can result in confusing other parts of
>   kernel (like ondemand cpufreq governor) which depends on this idle stats.
> 
> 
> Proposed Fix: 
> Attached is a prototype patch, that tries to eliminate the dependency on 
> local APIC timer for update_process_times(). The patch gets rid of Local APIC 
> timer altogether. We use the timer interrupt (IRQ 0) configured in 
> broadcast mode in IOAPIC instead (Doesn't work with 8259). 
> As changing anything related to basic timer interrupt is a little bit risky, 
> I have a boot parameter currently ("useapictimer") to switch back to original 
> local APIC timer way of doing things.

This all looks like it'll contend on irq0 related locks really badly, have 
you profiled this?

Thanks,
	Zwane

