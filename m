Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269903AbTGOXxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbTGOXxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:53:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40954 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269903AbTGOXxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:53:33 -0400
Message-ID: <3F149747.3090107@mvista.com>
Date: Tue, 15 Jul 2003 17:07:35 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bernie@develer.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
Subject: Re: do_div64 generic
References: <3F1360F4.2040602@mvista.com>	<200307150717.54981.bernie@develer.com>	<20030714223805.4e5bee3f.akpm@osdl.org>	<200307150823.01602.bernie@develer.com>	<3F1477B2.6090106@mvista.com> <20030715150645.4fa11de7.akpm@osdl.org>
In-Reply-To: <20030715150645.4fa11de7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>>George, do you agree? May I go on and post a patch killing
>>>div_long_long_rem() everywhere?
>>
>>The issue is that div is a very long instruction and the do_div() 
>>thing uses 2 or three of them, while the div_long_long_rem() is just 
>>1.  Also, a lot of archs already have the required div by a different 
>>name.  It all boils down to a performance thing.
> 
> 
> It is only used in nanosleep(), and then only in the case where the sleep
> terminated early.
> 
> If someone is calling nanosleep() so frequently for this to matter, the
> time spent in divide is the least of their problems.  Unless you have some
> real-worldish benchmarks to demonstrate otherwise?

It is also used in the jiffies to timespec and jiffies to timeval code 
in timer.h, if memory serves.
> 
> You know what they say about premtur optmstns, and having to propagate
> funky new divide primitives across N architectures is indeed evil.

Hm.  I only want the simple div.  64-bit/32-bit in two 32-bit results. 
  Is this funky?  And the "evil" #ifdef allows archs to not do it.
> 
> Bernardo, can you do the patch please?
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

