Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVLMVo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVLMVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVLMVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:44:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:59060 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932506AbVLMVo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:44:58 -0500
Message-ID: <439F40CF.3010908@watson.ibm.com>
Date: Tue, 13 Dec 2005 21:44:47 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: john stultz <johnstul@us.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com>	 <43975E6D.9000301@watson.ibm.com>	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>	 <439DD01A.2060803@watson.ibm.com> <1134416962.14627.7.camel@cog.beaverton.ibm.com> <439F1455.7080402@engr.sgi.com>
In-Reply-To: <439F1455.7080402@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> john stultz wrote:
> 
>> On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
>>
>>> Christoph Lameter wrote:
>>>
>>>> On Wed, 7 Dec 2005, Shailabh Nagar wrote:
>>>>
>>>>
>>>>
>>>>> +void getnstimestamp(struct timespec *ts)
>>>>
>>>>
>>>>
>>>> There is already getnstimeofday in the kernel.
>>>>
>>>
>>> Yes, and that function is being used within the getnstimestamp()
>>> being proposed.
>>> However, John Stultz had advised that getnstimeofday could get
>>> affected by calls to
>>> settimeofday and had recommended adjusting the getnstimeofday value
>>> with wall_to_monotonic.
>>>
>>> John, could you elaborate ?
>>
>>
>>
>> I think you pretty well have it covered.
>> getnstimeofday + wall_to_monotonic should be higher-res and more
>> reliable (then TSC based sched_clock(), for example) for getting a
>> timestamp.
> 
> 
> How is this proposed function different from
> do_posix_clock_monotonic_gettime()?
> It calls getnstimeofday(), it also adjusts with wall_to_monotinic.
> 
> It seems to me we just need to EXPORT_SYMBOL_GPL the
> do_posix_clock_monotonic_gettime()?
> 
> Thanks,
>  - jay
> 

Hmmm. Looks like do_posix_clock_monotonic_gettime will suffice for this patch.

Wonder why the clock parameter to do_posix_clock_monotonic_get is needed ?
Doesn't seem to be used.

Any possibility of these set of functions changing their behaviour ?

-- Shailabh







>>
>> There may be performance concerns as you have to access the clock
>> hardware in getnstimeofday(), but there really is no other way for
>> reliable finely grained monotonically increasing timestamps.
>>
>> thanks
>> -john
>>
> 
> 

