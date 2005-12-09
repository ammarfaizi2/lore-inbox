Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVLIIBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVLIIBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 03:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVLIIBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 03:01:08 -0500
Received: from fsmlabs.com ([168.103.115.128]:65200 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932466AbVLIIBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 03:01:06 -0500
X-ASG-Debug-ID: 1134115262-12458-147-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Fri, 9 Dec 2005 00:06:35 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
X-ASG-Orig-Subj: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer
 interrupts on C3 state
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer
 interrupts on C3 state
In-Reply-To: <20051208181040.C32524@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com>
References: <20051208181040.C32524@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6153
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Venkatesh Pallipadi wrote:

> Whenever we see that a CPU is capable of C3 (during ACPI cstate init), we 
> disable local APIC timer and switch to using a broadcast from external timer
> interrupt (IRQ 0).
>
> Index: linux-2.6.15-rc3/include/asm-i386/apic.h
> ===================================================================
> --- linux-2.6.15-rc3.orig/include/asm-i386/apic.h
> +++ linux-2.6.15-rc3/include/asm-i386/apic.h
> @@ -132,6 +132,11 @@ extern unsigned int nmi_watchdog;
>  
>  extern int disable_timer_pin_1;
>  
> +void smp_send_timer_broadcast_ipi(struct pt_regs *regs);
> +void switch_APIC_timer_to_ipi(void *cpumask);
> +void switch_ipi_to_APIC_timer(void *cpumask);

When is this used?
