Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVEDX1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVEDX1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVEDX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 19:27:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6334 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261955AbVEDX1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 19:27:05 -0400
Subject: Re: Help with the high res timers
From: john stultz <johnstul@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <42795125.9030905@mvista.com>
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net>
	 <20050503024336.GA4023@ict.ac.cn>  <4277EEF7.8010609@mvista.com>
	 <1115158804.13738.56.camel@cog.beaverton.ibm.com>
	 <427805F8.7000309@mvista.com>
	 <1115166592.13738.96.camel@cog.beaverton.ibm.com>
	 <42790A5C.4050403@mvista.com>
	 <1115244798.13738.127.camel@cog.beaverton.ibm.com>
	 <42795125.9030905@mvista.com>
Content-Type: text/plain
Date: Wed, 04 May 2005 16:27:02 -0700
Message-Id: <1115249222.13738.138.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 15:48 -0700, George Anzinger wrote:
> john stultz wrote:
> > Here is my possible solution: Still keeping Nish's soft-timer rework
> > where we use nanoseconds instead of ticks or jiffies, provide an
> > expected interrupt-period value, which gives you the maximum interval
> > length between ticks. Thus you schedule a regular-low-res timer for the
> > nanosecond value (exp_ns - expected_interrupt_period). When that timer
> > expires, you move the timer to the HR timer list and schedule an
> > interrupt for the remaining time.
> 
> Oh, I have been thinking along these same lines.  I don't recall at the moment, 
> but I depend on the timer retaining the absolute expire time as I set it.  This 
> is used both by the secondary timer, and by the rearm code.  I need to look more 
> closely at that.  

Glad we're on similar wavelengths. :)

> But this is picking things apart at a very low level and does 
> not, I think, address timer ordering to the point where I feel completely safe. 
>   I.e. will such a scheme allow a LR time at time X to expire after a HR timer 
> for time X+y.

Hmm. That sounds like an interesting problem as well, although I'm not
familiar enough with it to make a reasonable comment. Let me ponder it
for awhile and see what can be done.

thanks
-john



