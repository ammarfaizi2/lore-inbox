Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVLMAzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVLMAzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVLMAzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:55:50 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:53497 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932252AbVLMAzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:55:50 -0500
Message-ID: <439E1BBE.4040405@mvista.com>
Date: Mon, 12 Dec 2005 16:54:22 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com>	 <43975E6D.9000301@watson.ibm.com>	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>	 <439DD01A.2060803@watson.ibm.com>	 <1134416962.14627.7.camel@cog.beaverton.ibm.com>	 <439DD6E8.7010802@watson.ibm.com> <1134418034.14627.14.camel@cog.beaverton.ibm.com>
In-Reply-To: <1134418034.14627.14.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2005-12-12 at 20:00 +0000, Shailabh Nagar wrote:
> 
>>john stultz wrote:
>>
>>>On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
>>>
>>>
>>>>Christoph Lameter wrote:
>>>>
>>>>
>>>>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
>>>>>
>>>>>>+void getnstimestamp(struct timespec *ts)
>>>>>
>>>>>There is already getnstimeofday in the kernel.
>>>>
>>>>Yes, and that function is being used within the getnstimestamp() being proposed.
>>>>However, John Stultz had advised that getnstimeofday could get affected by calls to
>>>>settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.
>>>>
>>>>John, could you elaborate ?
>>>
>>>I think you pretty well have it covered. 
>>>
>>>getnstimeofday + wall_to_monotonic should be higher-res and more
>>>reliable (then TSC based sched_clock(), for example) for getting a
>>>timestamp.
>>>
>>>There may be performance concerns as you have to access the clock
>>>hardware in getnstimeofday(), but there really is no other way for
>>>reliable finely grained monotonically increasing timestamps.
>>>
> 
> 
>>Thanks, that clarifies. I guess the other underlying concern here would be whether these
>>improvements (in resolution and reliability) should be going into getnstimeofday()
>>itself (rather than creating a new func for the same) ? Or is it better to leave
>>getnstimeofday as it is ?
> 
> 
> No, getnstimeofday() is very much needed to get a nanosecond grained
> wall-time clock, so a new function is needed for the monotonic clock.
> 
> In my timeofday re-work I have used the name "get_monotonic_clock()" and
> "get_monotonic_clock_ts()" for basically the same functionality
> (providing a ktime and a timespec respectively). You might consider
> naming it as such, but resolving these naming collisions shouldn't be
> too difficult either way.

Indeed.  Lets use a name with "monotonic" in it, please.  And, 
possibly not "clock".  How about get_nsmonotonic_time() or some such?


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
