Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVLISHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVLISHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLISHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:07:41 -0500
Received: from mail.suse.de ([195.135.220.2]:31179 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964820AbVLISHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:07:40 -0500
Date: Fri, 9 Dec 2005 19:07:39 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051209180739.GH11190@wotan.suse.de>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com> <20051209095243.A22139@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209095243.A22139@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick comment - didn't review the full patch.

> +#ifdef ARCH_APICTIMER_STOPS_ON_C3
> +			if (c->x86_vendor == X86_VENDOR_INTEL) {
> +				on_each_cpu(switch_APIC_timer_to_ipi, 
> +						&mask, 1, 1);
> +			}
> +#endif

Better make it a runtime variable instead of an ifdef with a boot option.
I found at least one non Intel system so far with the same issue
(although it wasn't multi processor) 

-Andi 
