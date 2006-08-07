Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWHGPBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWHGPBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWHGPBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:01:12 -0400
Received: from colin.muc.de ([193.149.48.1]:64004 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750930AbWHGPBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:01:10 -0400
Date: 7 Aug 2006 17:01:08 +0200
Date: Mon, 7 Aug 2006 17:01:08 +0200
From: Andi Kleen <ak@muc.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807150108.GB85602@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz> <20060807125639.GA88155@muc.de> <d120d5000608070632p7452ed72ja92b1eb3673372f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000608070632p7452ed72ja92b1eb3673372f8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 09:32:29AM -0400, Dmitry Torokhov wrote:
> On 8/7/06, Andi Kleen <ak@muc.de> wrote:
> >On Mon, Aug 07, 2006 at 02:48:55PM +0200, Vojtech Pavlik wrote:
> >> On Mon, Aug 07, 2006 at 02:28:45PM +0200, Andi Kleen wrote:
> >> > On Mon, Aug 07, 2006 at 01:09:31PM +0200, Vojtech Pavlik wrote:
> >> > > On Mon, Aug 07, 2006 at 10:48:50AM +0200, Andi Kleen wrote:
> >> > > > On Sun, Aug 06, 2006 at 10:43:44PM -0400, Dmitry Torokhov wrote:
> >> > > > > On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> >> > > > > > This whole thing is broken, e.g. on a preemptive kernel when 
> >the
> >> > > > > > code can switch CPUs
> >> > > > > >
> >> > > > >
> >> > > > > Would not preempt_disable fix that?
> >> > > >
> >> > > > Partially, but you still have other problems. Please just get rid
> >> > > > of it. Why do we have timer code in the kernel if you then chose
> >> > > > not to use it?
> >> > >
> >> > > The problem is that gettimeofday() is not always fast.
> >> >
> >> > When it is not fast that means it is not reliable and then you're
> >> > also not well off using it anyways.
> >>
> >> I assume you wanted to say "When gettimeofday() is slow, it means TSC is
> >> not reliable", which I agree with.
> >>
> >> But I need, in the driver, in the no-TSC case use i/o counting, not a
> >> slow but reliable method. And I can't say, from outside the timing
> >> subsystem, whether gettimeofday() is fast or slow.
> >
> >Hmm if that is the only obstacle I can export a "slow gettimeofday" flag.
> >
> >However it would be some work to implement it for all architectures.
> >
> 
> Hmm, would it be easier to export "fast gettimeofday" and assume that
> we have slow gettimeofday by default (so gameport will fall back on io
> counting)?

I would expect fast gettimeofday to be more common than slow.

-Andi
