Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWELNDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWELNDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWELNDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:03:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19697 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751269AbWELNDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:03:40 -0400
Date: Fri, 12 May 2006 09:03:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
In-Reply-To: <44648532.8080200@compro.net>
Message-ID: <Pine.LNX.4.58.0605120902460.30264@gandalf.stny.rr.com>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
 <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
 <4464740C.8060305@compro.net> <20060512115614.GA28377@elte.hu>
 <44648532.8080200@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Mark Hounschell wrote:

> >
> > Mark, does this fix the problem?
> >
> > 	Ingo
> >
> > Index: linux-rt.q/drivers/net/3c59x.c
> > ===================================================================
> > --- linux-rt.q.orig/drivers/net/3c59x.c
> > +++ linux-rt.q/drivers/net/3c59x.c
> > @@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
> >
> >  	if (vp->medialock)
> >  		goto leave_media_alone;
> > -	disable_irq(dev->irq);
> > +	/* hack! */
> > +	disable_irq_nosync(dev->irq);
> >  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
> >  	EL3WINDOW(4);
> >  	media_status = ioread16(ioaddr + Wn4_Media);
> >
>
> Yes it does.
>


It fixes it for both "complete preemption" and "normal preemption"?

-- Steve

