Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCVD7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCVD7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWCVD7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:59:46 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:24400 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750723AbWCVD7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:59:45 -0500
Message-ID: <4420CBAD.8030002@bigpond.net.au>
Date: Wed, 22 Mar 2006 14:59:41 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, bugsplatter@gmail.com
Subject: Re: interactive task starvation
References: <1142592375.7895.43.camel@homer>	 <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>	 <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>	 <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu>	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>	 <1142942878.7807.9.camel@homer>  <20060321125900.GA25943@w.ods.org>	 <1142947456.7807.53.camel@homer>  <44208355.1080200@bigpond.net.au> <1142999382.11047.34.camel@homer>
In-Reply-To: <1142999382.11047.34.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 22 Mar 2006 03:59:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Wed, 2006-03-22 at 09:51 +1100, Peter Williams wrote:
> 
>>Mike Galbraith wrote:
>>
>>>On Tue, 2006-03-21 at 13:59 +0100, Willy Tarreau wrote:
>>>
>>>>That would suit me perfectly. I think I would set them both to zero.
>>>>It's not clear to me what workload they can help, it seems that they
>>>>try to allow a sometimes unfair scheduling.
>>>
>>>
>>>Correct.  Massively unfair scheduling is what interactivity requires.
>>>
>>
>>Selective unfairness not massive unfairness is what's required.  The 
>>hard part is automating the selectiveness especially when there are 
>>three quite different types of task that need special treatment: 1) the 
>>X server, 2) normal interactive tasks and 3) media streamers; each of 
>>which has different behavioural characteristics.  A single mechanism 
>>that classifies all of these as "interactive" will unfortunately catch a 
>>lot of tasks that don't belong to any one of these types.
> 
> 
> Yes, selective would be nice, but it's still massively unfair that is
> required.  There is no criteria available for discrimination, so my
> patches don't even try to classify, they only enforce the rules.  I
> don't classify X as interactive, I merely provide a mechanism which
> enables X to accumulate the cycles an interactive task needs to be able
> to perform by actually _being_ interactive, by conforming to the
> definition of sleep_avg.

That's what I mean by classification :-)

>  Fortunately, it uses that mechanism.  I do
> nothing more than trade stout rope for good behavior.  I anchor one end
> to a boulder, the other to a task's neck.  The mechanism is agnostic.
> The task determines whether it gets hung or not, and the user determines
> how long the rope is.

I view that as a modification (hopefully an improvement) of the 
classification rules :-).  In particular, a variation in the persistence 
of a classification and the criteria for losing/downgrading it.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
