Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVLLUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVLLUAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLLUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:00:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:13968 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932189AbVLLUAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:00:49 -0500
Message-ID: <439DD6E8.7010802@watson.ibm.com>
Date: Mon, 12 Dec 2005 20:00:40 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
References: <43975D45.3080801@watson.ibm.com>	 <43975E6D.9000301@watson.ibm.com>	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>	 <439DD01A.2060803@watson.ibm.com> <1134416962.14627.7.camel@cog.beaverton.ibm.com>
In-Reply-To: <1134416962.14627.7.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
> 
>>Christoph Lameter wrote:
>>
>>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
>>>
>>>
>>>
>>>>+void getnstimestamp(struct timespec *ts)
>>>
>>>
>>>There is already getnstimeofday in the kernel.
>>>
>>
>>Yes, and that function is being used within the getnstimestamp() being proposed.
>>However, John Stultz had advised that getnstimeofday could get affected by calls to
>>settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.
>>
>>John, could you elaborate ?
> 
> 
> I think you pretty well have it covered. 
> 
> getnstimeofday + wall_to_monotonic should be higher-res and more
> reliable (then TSC based sched_clock(), for example) for getting a
> timestamp.
> 
> There may be performance concerns as you have to access the clock
> hardware in getnstimeofday(), but there really is no other way for
> reliable finely grained monotonically increasing timestamps.
> 
> thanks
> -john

Thanks, that clarifies. I guess the other underlying concern here would be whether these
improvements (in resolution and reliability) should be going into getnstimeofday()
itself (rather than creating a new func for the same) ? Or is it better to leave
getnstimeofday as it is ?

Thanks,
Shailabh

