Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFJFaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFJFav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:30:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40183 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262361AbTFJFav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:30:51 -0400
Message-ID: <3EE5700B.2020608@mvista.com>
Date: Mon, 09 Jun 2003 22:43:39 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, Eric.Piel@Bull.Net
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

Yep, thanks for catching that.
> 
> Is there any reasonable way to avoid breaking existing
> do_settimeofday() implementations? That's just more grief all round.
> 
> 
Of course there is a way.  The question is which way leads to the most 
grief :).  The test could be made in the calling routines, but then it 
would need to be made in both posix-timer.c and time.c.  I suppose it 
would be better to do it that way as both are in common code and the 
"arch" warnning would go away.   Tomorrow...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

