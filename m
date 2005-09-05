Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVIERHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVIERHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVIERHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:07:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18851 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932350AbVIERHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:07:06 -0400
Date: Mon, 5 Sep 2005 10:06:58 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, johnstul@us.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905170658.GL25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905084425.B24051@flint.arm.linux.org.uk> <20050905081935.GB7924@in.ibm.com> <20050905093221.E24051@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905093221.E24051@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [09:32:21 +0100], Russell King wrote:
> On Mon, Sep 05, 2005 at 01:49:35PM +0530, Srivatsa Vaddagiri wrote:
> > This is precisely what I have done. I have made cur_timer->mark-offset() to 
> > return the lost ticks and update wall-time from the callee, which
> > can be either timer_interrupt handler or in dyn-tick case the dyn-tick
> > code (I have called it dyn_tick_interrupt) which is called before processing 
> > _any_ interrupt.
> 
> When you have a timer which constantly increments from 0 to MAX and
> wraps, and you can set the value to match to cause an interrupt,
> it makes more sense to handle it the way we're doing it (which
> incidentally leads to no loss of precision.)

This is the way ppc works, I believe (match register).

> Calculating the number of ticks missed, updating the kernel time,
> and updating the timer match will cause problems with these - if
> the timer has already past the number of ticks you originally
> calculated, you may not get another interrupt for a long time.

Yes, this is the source of much bugginess, especially with bad hardware
:)

> > If ARM had a timer_opts equivalent we could have followed 
> 
> I think your timer_opts is effectively our struct sys_timer.

I agree, in looking over the two. Perhaps those structures could be
served to be unified as well? John Stultz would be the one to talk to,
though.

Thanks,
Nish
