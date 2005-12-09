Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVLIXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVLIXGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLIXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:06:53 -0500
Received: from fmr24.intel.com ([143.183.121.16]:61084 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932485AbVLIXGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:06:53 -0500
Date: Fri, 9 Dec 2005 15:06:24 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Rohit Seth <rohit.seth@intel.com>, Len Brown <len.brown@intel.com>
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051209150624.A19415@unix-os.sc.intel.com>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com> <20051209095243.A22139@unix-os.sc.intel.com> <20051209180739.GH11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051209180739.GH11190@wotan.suse.de>; from ak@suse.de on Fri, Dec 09, 2005 at 07:07:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 07:07:39PM +0100, Andi Kleen wrote:
> Just a quick comment - didn't review the full patch.
> 
> > +#ifdef ARCH_APICTIMER_STOPS_ON_C3
> > +			if (c->x86_vendor == X86_VENDOR_INTEL) {
> > +				on_each_cpu(switch_APIC_timer_to_ipi, 
> > +						&mask, 1, 1);
> > +			}
> > +#endif
> 
> Better make it a runtime variable instead of an ifdef with a boot option.
> I found at least one non Intel system so far with the same issue
> (although it wasn't multi processor) 

Actually, that particular ifdef ARCH_APICTIMER_STOPS_ON_C3 is always set for
i386 and x86-64 and local APIC is enabled. I only added that ifdef to skip 
this code for IA-64, which can also use acpi processor_idle.c.

For any other CPU in i386 or x86-64, we can just add runtime check along with
VENDOR_INTEL. 

Thanks,
Venki


