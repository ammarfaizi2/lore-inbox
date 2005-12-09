Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVLIMuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVLIMuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVLIMuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:50:09 -0500
Received: from fmr21.intel.com ([143.183.121.13]:51653 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751110AbVLIMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:50:07 -0500
Date: Fri, 9 Dec 2005 04:49:39 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051209044938.A26619@unix-os.sc.intel.com>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Fri, Dec 09, 2005 at 12:06:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 12:06:35AM -0800, Zwane Mwaikambo wrote:
> On Thu, 8 Dec 2005, Venkatesh Pallipadi wrote:
> 
> > Whenever we see that a CPU is capable of C3 (during ACPI cstate init), we 
> > disable local APIC timer and switch to using a broadcast from external timer
> > interrupt (IRQ 0).
> >
> > +void smp_send_timer_broadcast_ipi(struct pt_regs *regs);
> > +void switch_APIC_timer_to_ipi(void *cpumask);
> > +void switch_ipi_to_APIC_timer(void *cpumask);
> 
> When is this used?

+void smp_send_timer_broadcast_ipi(struct pt_regs *regs);
This is called by the IRQ0 timer interrupt handler, to check whether any CPUs 
have enrolled for this broadcast.

+void switch_APIC_timer_to_ipi(void *cpumask);
Called by acpi processor driver when it find out that a particular CPU can
support C3 state (and it is an Intel CPU).

+void switch_ipi_to_APIC_timer(void *cpumask);
Called by acpi processor driver again to reset to APIC_timer when C3 is not 
supported by the CPU.

The acpi processor driver calls can be at the boot time, or can be at run time
if BIOS enables/disables C3 at run time.

Thanks,
Venki

