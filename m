Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVJLWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVJLWhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJLWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:37:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11401 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932485AbVJLWhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:37:17 -0400
Date: Thu, 13 Oct 2005 00:36:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <1129016558.1728.285.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0510130004330.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509301825290.3728@scrub.home>  <1128168344.15115.496.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Oct 2005, Thomas Gleixner wrote:

> > > As far as I understand SUS timer resolution is equal to clock resolution
> > > and the timer value/interval is rounded up to the resolution.
> > 
> > Please check the rationale about clocks and timers. It talks about clocks 
> > and timer services based on them and their resolutions can be different.
> 
> clock_settime():
> ... Time values that are between two consecutive non-negative integer
> multiples of the resolution of the specified clock shall be truncated
> down to the smaller multiple of the resolution.
> 
> timer_settime():
> ...Time values that are between two consecutive non-negative integer
> multiples of the resolution of the specified timer shall be rounded up
> to the larger multiple of the resolution. Quantization error shall not
> cause the timer to expire earlier than the rounded time value.

Where does it say anything about that their resolution is equal?

> > > Reprogramming interval timers by now + interval is completely wrong.
> > > Reprogramming has to be 
> > > timer->expires + interval and nothing else. 
> > 
> > Where do get the requirement for an explicit rounding from?
> > The point is that the timer should not expire early, but there is more 
> > than one way to do this and can be done implicitly using the timer 
> > resolution.
> 
> See above.

I know it and above is an _interface_ description, but what leads you to 
the conclusion that your _implementation_ is the only correct one?

Thomas, are you even interested in discussing this? Do you just expect 
that everyone accepts your patch and is happy? So far it's difficult 
enough to get you to explain your design, but a serious discussion also 
requires to look at the possible alternatives. It's quite possible I'm 
wrong, but you have to try a little harder at explaining why.

bye, Roman
