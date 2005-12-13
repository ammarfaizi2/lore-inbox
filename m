Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVLMWOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVLMWOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVLMWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:14:22 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:41974 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030192AbVLMWOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:14:21 -0500
Message-ID: <439F477B.7010501@mvista.com>
Date: Tue, 13 Dec 2005 14:13:15 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Jay Lan <jlan@engr.sgi.com>, john stultz <johnstul@us.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com>	 <43975E6D.9000301@watson.ibm.com>	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>	 <439DD01A.2060803@watson.ibm.com> <1134416962.14627.7.camel@cog.beaverton.ibm.com> <439F1455.7080402@engr.sgi.com> <439F40CF.3010908@watson.ibm.com>
In-Reply-To: <439F40CF.3010908@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
>>john stultz wrote:
>>
>>
>>>On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
>>>
>>>
>>>>Christoph Lameter wrote:
>>>>
>>>>
>>>>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>+void getnstimestamp(struct timespec *ts)
>>>>>
>>>>>
>>>>>
>>>>>There is already getnstimeofday in the kernel.
>>>>>
>>>>
>>>>Yes, and that function is being used within the getnstimestamp()
>>>>being proposed.
>>>>However, John Stultz had advised that getnstimeofday could get
>>>>affected by calls to
>>>>settimeofday and had recommended adjusting the getnstimeofday value
>>>>with wall_to_monotonic.
>>>>
>>>>John, could you elaborate ?
>>>
>>>
>>>
>>>I think you pretty well have it covered.
>>>getnstimeofday + wall_to_monotonic should be higher-res and more
>>>reliable (then TSC based sched_clock(), for example) for getting a
>>>timestamp.
>>
>>
>>How is this proposed function different from
>>do_posix_clock_monotonic_gettime()?
>>It calls getnstimeofday(), it also adjusts with wall_to_monotinic.
>>
>>It seems to me we just need to EXPORT_SYMBOL_GPL the
>>do_posix_clock_monotonic_gettime()?
>>
>>Thanks,
>> - jay
>>
> 
> 
> Hmmm. Looks like do_posix_clock_monotonic_gettime will suffice for this patch.
> 
> Wonder why the clock parameter to do_posix_clock_monotonic_get is needed ?

Because it is called indirectly by the table driven posix clocks and 
timers code where the clock, usually, is needed.

> Doesn't seem to be used.
> 
> Any possibility of these set of functions changing their behaviour ?

Always :), but things are pretty stable now.  Might want to add a 
comment that it is being used outside of the posix "box".


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
