Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270971AbUJUVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbUJUVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbUJUVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:22:18 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:44526 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S270971AbUJUVSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:18:22 -0400
Message-ID: <41782771.3060404@mvista.com>
Date: Thu, 21 Oct 2004 14:17:37 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: root@chaos.analogic.com, "Brown, Len" <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
>>From: Richard B. Johnson
>>
>>You need that hardware interrupt for more than time-keeping.
>>Without a hardware-interrupt, to force a new time-slice,
>>
>> 	for(;;)
>>            ;
>>
>>... would allow a user to grab the CPU forever ...
> 
> 
> But you can also schedule, before switching to the new task, 
> a local interrupt on the running processor to mark the end 
> of the timeslice. When you enter the scheduler, you just need 
> to remove that; devil is in the details, but it should be possible
> to do in a way that doesn't take too much overhead.

Well, that is part of the accounting overhead the increases with context switch 
rate.  You also need to include the time it takes to figure out which of the 
time limits is closes (run time limit, profile time, slice time, etc).  Then, 
you also need to remove the timer when switching away.  No, it is not a lot, but 
it is way more than the nothing we do when we can turn it all over to the 
periodic tick.  The choice is load sensitive overhead vs flat overhead.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

