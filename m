Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVD3BK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVD3BK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 21:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVD3BK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 21:10:58 -0400
Received: from fsmlabs.com ([168.103.115.128]:35798 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263109AbVD3BKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 21:10:53 -0400
Date: Fri, 29 Apr 2005 19:13:20 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
In-Reply-To: <20050429172605.A23722@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0504291902440.15561@montezuma.fsmlabs.com>
References: <20050429172605.A23722@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Venkatesh Pallipadi wrote:

> Proposed Fix: 
> Attached is a prototype patch, that tries to eliminate the dependency on 
> local APIC timer for update_process_times(). The patch gets rid of Local APIC 
> timer altogether. We use the timer interrupt (IRQ 0) configured in 
> broadcast mode in IOAPIC instead (Doesn't work with 8259). 
> As changing anything related to basic timer interrupt is a little bit risky, 
> I have a boot parameter currently ("useapictimer") to switch back to original 
> local APIC timer way of doing things.

I'm rather reluctant to advocate the broadcast scheme as i can see it 
breaking on a lot of systems, e.g. SMP systems which use i8259 (as you 
noted), IBM x440 and ES7000. If anything the default mode should be APIC 
timer and have a parameter to disable it. Regarding things like variable 
timer ticks, reprogramming the PIT is slow, and using it extensively for 
such sounds like a step in the wrong direction. Is this feature/bug going 
to proliferate amongst newer processor local APICs?

Thanks,
	Zwane

