Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVEDRxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVEDRxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEDRxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:53:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35736 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261165AbVEDRwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:52:12 -0400
Date: Wed, 4 May 2005 10:51:51 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: george@mvista.com, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
Message-ID: <20050504175151.GA2698@us.ibm.com>
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com> <42790A18.4000008@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42790A18.4000008@nortel.com>
X-Operating-System: Linux 2.6.12-rc3-mm2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2005 [11:44:56 -0600], Chris Friesen wrote:
> George Anzinger wrote:
> 
> >The, I think, elegant solution to the timer storm problem is to 
> >not restart the timer until the user picks up the prior expiration.  
> >This dynamically adjusts the timer response to the amount of machine 
> >available at the time.
> 
> The disadvantage is that you then lose accuracy since each timer 
> interval is increased by some random amount based on system scheduling. 
>  What about some kind of ulimit-type thing to specify the minimum 
> recurring interval that can be specified?  If root so specifies, you 
> could have 1usec interval timers and the system would hang.  This is 
> conceptually no different than busy-looping in a SCHED_FIFO task.

If I understand your point correctly, I think this is achieved by
TIMERINTERVAL_BITS in my patch (not to claim my patch is function, but
conceptually). No matter what you actually request, the best you can do
is 2^TIMERINTERVAL_BITS nanoseconds, and usually worse because the
tick-rate and timerinterval length do not necessarily line up.

Thanks,
Nish
