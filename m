Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263344AbVGORY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbVGORY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGORYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:24:55 -0400
Received: from fmr23.intel.com ([143.183.121.15]:65427 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S263344AbVGORYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:24:48 -0400
Date: Fri, 15 Jul 2005 10:23:49 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715102349.A15791@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <p73y8889f4v.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73y8889f4v.fsf@bragg.suse.de>; from ak@suse.de on Fri, Jul 15, 2005 at 07:02:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 07:02:24PM +0200, Andi Kleen wrote:
> 
> At least on multi processor systems LAPIC has to work anyways (otherwise
> you cannot schedule other CPUs), so it is fine to use there.
> 
> AFAIK there are no x86 CPUs right now that do both C3
> and SMP. If they ever do then they will need to keep the
> LAPIC ticking in C3.
> 
> This has nothing even to do with advanced power saving,
> but is pretty much a hard requirement for Linux (and I would
> be surprise if it wasn't one for other OS too). Without it
> scheduling and local timers on APs will not work at all.
> 
> In theory it could be replaced with HPET if HPET had enough banks (one
> for each CPU - most implementations today usually only have 2 or 4), but
> that would severly limit scalability for lazy tick schemes because
> they would depend on a common resource in the southbridge. Also the
> max number of banks needed on a big system would be huge
> (128? 256?) because you couldn't have more CPUs than that.
> 
> With PIC only it's absolutely impossible.
> 

I wouldn't say it is totally impossible. There are ways in which Linux can work
without a reliable Local APIC timer. One option being - make one CPU that gets 
the external timer interrupt multicast an IPI to all the other CPUs that
wants to get periodic timer interrupt.

Thanks,
Venki


