Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFJP1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFJPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:24:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5367 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263239AbTFJPXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:23:52 -0400
Message-ID: <3EE5FB06.1060207@mvista.com>
Date: Tue, 10 Jun 2003 08:36:38 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Eric Piel <Eric.Piel@Bull.Net>
Subject: Re: [PATCH] Some clean up of the time code.
References: <3EE52CA7.9010007@mvista.com> <20030609182213.2072ca24.akpm@digeo.com>
In-Reply-To: <20030609182213.2072ca24.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>-void do_settimeofday(struct timeval *tv)
>> +int do_settimeofday(struct timespec *tv)
>>  {
>> +	if ((unsigned long)tv->tv_nsec > NSEC_PER_SEC)
>> +		return -EINVAL;
>> +
> 
> 
> Should that be ">="?
> 
> Is there any reasonable way to avoid breaking existing
> do_settimeofday() implementations? That's just more grief all round.

Hm. Giving this more thought, the main reason for the change was to 
move to the timespec from the timeval, i.e. nanoseconds instead of 
microseconds.  The error check was put in because the function was 
already being changed.  The reason to move to the timespec is to 
complete the change made to xtime and to more correctly align with the 
POSIX clock_settime, both of which use timespec.

I suspect Linus would prefer this direction...

Comments?
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

