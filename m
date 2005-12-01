Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbVLAVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbVLAVMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbVLAVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:12:32 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9947 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751730AbVLAVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:12:31 -0500
Date: Thu, 1 Dec 2005 22:11:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <1133464097.7130.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512012048140.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512010118200.1609@scrub.home>  <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
  <Pine.LNX.4.61.0512011352590.1609@scrub.home> 
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> 
 <20051201165144.GC31551@flint.arm.linux.org.uk>  <Pine.LNX.4.61.0512011828150.1609@scrub.home>
 <1133464097.7130.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Steven Rostedt wrote:

> It should just be documented simply as: If you need to set some timed
> event to happen that you don't expect to occur then use a ktimeout.
> Where this timed event is an event that lets you know that another event
> hasn't happened in a given time. (I want to know if x didn't happen by
> this time).
> 
> If a timed event is expected to occur then use ktimer.  Where it is
> mostly used for the event itself (I want x to happen at this time).

If that is really _the_ defining difference, then we are _seriously_ 
screwed.

Here are a few items I would consider in choosing a timer:

- reading time: to program a timer you have to read the time first, 
reading jiffies is practically free, whereas reading the precise time can 
be very expensive. With the right hardware it can be optimized to be quite 
cheap, but if portability is important you may want to avoid the extra 
cost.

- calculations: jiffies is a long integer whereas ktime_t is 64bit, so if 
you need a lot of complex time calculation, you should take the cost for 
32bit archs into account.

- resolution: how precise must the timer be? jiffies can't represent time 
values less than 1ms, but if time is e.g. measured in 10th of a second,
jiffies may be enough.

- timer life time: if only a short interval is needed (e.g. a fraction of 
a second) timer_list is often a lot cheaper.

> So Roman, please have someone else speak up and let us know that they
> are just as confused on these names as you are.

Let's ignore the name for a moment, let's instead prioritize the above 
list.
If your item of whether a timer does expire or not is really the most 
important criteria for choosing a timer, I will accept any name you want.

bye, Roman
