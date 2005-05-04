Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVEDUgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVEDUgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVEDUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:34:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54005 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261529AbVEDUcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:32:02 -0400
Message-ID: <42793134.7000407@mvista.com>
Date: Wed, 04 May 2005 13:31:48 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com> <42790A18.4000008@nortel.com>
In-Reply-To: <42790A18.4000008@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> George Anzinger wrote:
> 
>> The, I think, elegant solution to the timer storm problem is to not 
>> restart the timer until the user picks up the prior expiration.  This 
>> dynamically adjusts the timer response to the amount of machine 
>> available at the time.
> 
> 
> The disadvantage is that you then lose accuracy since each timer 
> interval is increased by some random amount based on system scheduling. 
>  What about some kind of ulimit-type thing to specify the minimum 
> recurring interval that can be specified?  If root so specifies, you 
> could have 1usec interval timers and the system would hang.  This is 
> conceptually no different than busy-looping in a SCHED_FIFO task.

The standard comes to the rescue here.  The standard defines timer_getoverrun() 
which returns the number of additional timeouts you _would_ have seen if you had 
been fast enough.

I tried a limit thing.  It is MUCH too fragile for the real world.
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
