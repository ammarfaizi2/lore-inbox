Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVLSO43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVLSO43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLSO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:56:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22173 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932123AbVLSO42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:56:28 -0500
Date: Mon, 19 Dec 2005 15:56:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <43A0D505.3080507@mvista.com>
Message-ID: <Pine.LNX.4.61.0512191550460.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de>
 <439E2308.1000600@mvista.com> <Pine.LNX.4.61.0512150141050.1609@scrub.home>
 <43A0D505.3080507@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Dec 2005, George Anzinger wrote:

> > > IMHO then, the result should have the same property, i.e. ABS_TIME.  Sort
> > > of
> > > like adding an offset to a relative address. The result is still relative.
> > 
> > 
> > If the result is relative, why should have a clock set any effect?
> > IMO the spec makes it quite clear that initial timer and the periodic timer
> > are two different types of the timer. The initial timer only specifies how
> > the periodic timer is started and the periodic timer itself is a "relative
> > time service".
> > 
> Well, I guess we will have to agree to disagree.

That's easy for you to say. :)
You don't think the current behaviour is wrong.

>  That which the interval is
> added to is an absolute time, so I, and others, take the result as absolute.
> At this point there really is no "conversion" to an absolute timer.  Once the
> timer initial time is absolute, everything derived from it, i.e. all intervals
> added to it, must be absolute.

With this argumentation, any relative timer could be treated this way, you 
have to base a relative timer on something.
While searching for more information I found the NetBSD code and they 
do exactly this, they just convert everything to absolute values and clock 
set affects all timers equally. Is this now more correct?

> For what its worth, I do think that the standards folks could have done a bit
> better here.  I, for example, would have liked to have seen a discussion about
> what to do with overrun in the face of clock setting.

Maybe they thought it wouldn't be necessary :), because a periodic is a 
relative timer and thus not affected...

bye, Roman
