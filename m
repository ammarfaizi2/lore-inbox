Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSDIPzR>; Tue, 9 Apr 2002 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDIPzQ>; Tue, 9 Apr 2002 11:55:16 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:41170 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S293196AbSDIPzP>;
	Tue, 9 Apr 2002 11:55:15 -0400
Message-ID: <3CB30EE1.4020407@acm.org>
Date: Tue, 09 Apr 2002 10:55:13 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Radez <rob@osinvestor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.33.0204091103070.17511-100000@pita.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Radez wrote:

>On Tue, 9 Apr 2002, Corey Minyard wrote:
>
>>Why is that too fine grained?  You would just set the values from 1000
>>to 255000 instead of 1 to 255, and round up.
>>
>>I have a board that sets the time value in wierd times (like 225ms,
>>450ms, 900ms, 1800ms, 3600ms, etc.).  I wouldn't be against the
>>WDIOS_TIMEINMILLI option, but milliseconds should be good enough for anyone.
>>
>
>Yet Another Brainfart.  I've been having a lot of them recently.
>
>I don't feel comfortable changing the API that much in a stable kernel
>series.  Also, some other boards that have very small timeout windows
>emulate a larger userspace timeout since it's quite possible that a
>process won't get scheduled every 250ms.  I guess the only reason I can see
>for such a small timeout window is if one needs 99.9999% uptime and the 29
>extra seconds that the watchdog waits before kicking off is important.
>
The actual reason for a small timeout is if the system is in a 
high-throughput highly available application, to get the board out of 
commission as soon as possible and avoid a big delay in message handling 
and/or lose as little traffic as possible.  Or if the system can fail 
and start misbehaving, to kill it as soon as possible to minimize the 
damage.  With the preemptable kernel and real-time processes, it's not 
unreasonable to schedule something every 250ms.

-Corey

