Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWHYKPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWHYKPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWHYKPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:15:25 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:54475 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750944AbWHYKPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:15:24 -0400
Message-ID: <44EECCF9.7080902@aitel.hist.no>
Date: Fri, 25 Aug 2006 12:12:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] dubious process system time.
References: <20060824121825.GA4425@skybase> <p731wr6fh54.fsf@verdi.suse.de>	 <1156426103.28464.29.camel@localhost>  <200608241718.29406.ak@suse.de> <1156435363.28464.33.camel@localhost>
In-Reply-To: <1156435363.28464.33.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Thu, 2006-08-24 at 17:18 +0200, Andi Kleen wrote:
>   
>>> At the moment hardirq+softirq is just added to a random process, in
>>> general this is completely wrong. 
>>>       
>> It's better than not accounting it at all.
>>     
>
> I think it is worse than not accounting it. You are "charging" a process
> of some user for something that the user has nothing to do with.
>
>   
>>> You just need a system with a cpu hog 
>>> and an i/o bound process and you get queer results.
>>>       
>> Yes, but system load that is invisible to standard monitoring
>> tools is even worse.
>>     
>
> But it isn't invisible. cpustat->hardirq and cpustate->softirq will be
> increased. /proc/stat will show the system time spent in these two
> contexts.
>
>   
>> If you stop accounting it to random processes you have to 
>> account it somewhere else. Preferably somewhere that standard tools
>> automatically pick up.
>>     
>
> Again, why do I have to account non-process related time to a process?
> Ihmo that is completly wrong.
>   
If softirq time have to be accounted to a process (so as to not
get lost), how about accounting it to the softirqd process?  Much
more reasonable than random processes.

Helge Hafting
