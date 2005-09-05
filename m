Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVIEQdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVIEQdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVIEQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:33:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7868 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932336AbVIEQdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:33:40 -0400
Date: Mon, 5 Sep 2005 09:33:34 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905163334.GH25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905083728.A24051@flint.arm.linux.org.uk> <20050905074928.GA7924@in.ibm.com> <20050905090028.D24051@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905090028.D24051@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [09:00:28 +0100], Russell King wrote:
> On Mon, Sep 05, 2005 at 01:19:28PM +0530, Srivatsa Vaddagiri wrote:
> > > Despite that, the timers as implemented on the hardware are not
> > > suitable for dyntick use - attempting to use them, you lose long
> > > term precision of the timer interrupts.
> > 
> > Thats one of the problems I am seeing on x86 as well. Recovering
> > wall-time precisely after sleep is tough esepcially if the interrupt
> > source (PIT) and backing-time source (TSC/PM Timer/HPET) can drift
> > wrt each other. PPC64 should be much better I hope (which is what I
> > intend to take up next).
> 
> This is why the config option to enable it on ARM has a warning in
> there about it.  Some hardware timer implementations just aren't
> suitable for this, so users should be warned about it (and are on
> ARM.)

And this is where almost all of the bugs are going to come from in the
x86 implementation. John Stultz's rework helps remove some of the
interrupt dependency of the timeofday code, but he's reworking it now.

> > Tony was using it to signal that all CPUs are idle and timer are
> > being skipped. With the SMP changes I made, I felt it can be
> > substituted with the nohz_cpu_mask bitmap and hence I removed
> > it.
> 
> Well, consider that definition removed from ARM.  Forget it was even
> saw it in there. 8)

Yes, the cpu_mask covers the same concept, I think it's a good choice.

Thanks,
Nish
