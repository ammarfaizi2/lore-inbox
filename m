Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVIEHuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVIEHuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVIEHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:50:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3480 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932304AbVIEHuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:50:03 -0400
Date: Mon, 5 Sep 2005 13:19:28 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905074928.GA7924@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905083728.A24051@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905083728.A24051@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:37:28AM +0100, Russell King wrote:
> That's because, like x86, we've been ignoring each other.  ARM
> doesn't handle dyntick SMP yet - ARM is fairly young as far as
> SMP issues goes, and as yet doesn't include a full SMP
> implementation in mainline.



> 
> Despite that, the timers as implemented on the hardware are not
> suitable for dyntick use - attempting to use them, you lose long
> term precision of the timer interrupts.

Thats one of the problems I am seeing on x86 as well. Recovering
wall-time precisely after sleep is tough esepcially if the interrupt
source (PIT) and backing-time source (TSC/PM Timer/HPET) can
drift wrt each other. PPC64 should be much better I hope (which is what I 
intend to take up next).

> > 5. Don't see how DYN_TICK_SKIPPING is being used. In SMP scenario,
> >    it doesnt make sense since it will have to be per-cpu. The bitmap
> >    that I talked of exactly tells that (whether a CPU is skipping
> >    ticks or not).
> 
> What's DYN_TICK_SKIPPING and what's it used for?  It looks like
> a redundant definition left over from Tony's original implementation.

Tony was using it to signal that all CPUs are idle and timer are
being skipped. With the SMP changes I made, I felt it can be
substituted with the nohz_cpu_mask bitmap and hence I removed
it.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
