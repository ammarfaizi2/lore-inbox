Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUJMB1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUJMB1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJMB1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:27:14 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:48101 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268182AbUJMB1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:27:06 -0400
References: <1097542651.2666.7860.camel@cube> <cone.1097626558.804486.12364.502@pc.kolivas.org> <1097630263.2674.9508.camel@cube>
Message-ID: <cone.1097630806.503792.12364.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       ankitjain1580@yahoo.com, mingo@elte.hu, rml@tech9.net
Subject: Re: Difference in priority
Date: Wed, 13 Oct 2004 11:26:46 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan writes:

> On Tue, 2004-10-12 at 20:15, Con Kolivas wrote:
>> Albert Cahalan writes:
>> 
>> > Con Kolivas writes:
>> >> Ankit Jain wrote:
>> > 
>> >>> if somebody knows the difference b/w /PRI of both
>> >>> these commands because both give different results
>> >>>
>> >>> ps -Al
>> >>> & top
>> >>>
>> >>> as per priority rule we can set priority upto 0-99
>> >>> but top never shows this high priority
>> >>
>> >> Priority values 0-99 are real time ones and 100-139 are normal 
>> >> scheduling ones. RT scheduling does not change dynamic priority while 
>> >> running wheras normal scheduling does (between 100-139). top shows the 
>> >> value of the current dynamic priority in the PRI column as the current 
>> >> dynamic priority-100. If you have a real time task in top it shows as a 
>> >> -ve value. ps -Al seems to show the current dynamic priority+60.
>> > 
>> > What would you like to see? There are numerous
>> > competing ideas of reality. There's also the matter
>> > of history and standards. I'd gladly "fix" ps, if
>> > people could agree on what "fix" would mean.
>> > 
>> > Various desirable but conflicting traits include:
>> > 
>> > a. for normal idle processes, PRI matches NI
>> > b. for RT processes, PRI matches RT priority
>> > c. for RT processes, PRI is negative of RT priority
>> > d. PRI is the unmodified value seen in /proc
>> > e. PRI is never negative
>> > f. low PRI is low priority (SysV "pri" keyword)
>> > g. low PRI is high priority (UNIX "PRI", SysV "opri")
>> > h. PRI matches some kernel-internal value
>> > i. PRI is in the range -99 to 999 (not too wide)
>> 
>> I can't say I've ever felt strongly about it. Wish I knew what was the best 
>> way. If we change the range of RT priority range by increasing it from 100 
>> to say 1000 then any arbitrary value to subtract will be wrong. How about 
>> just leaving the absolute dynamic priority value? Then we don't have any 
>> negative values confusing it, it isn't affected by increasing the range of 
>> RT priorities, and better priority values still are lower in value.
> 
> That's not convincing enough to overcome inertia.
> 
> I can't see why the RT priority range would be increased.
> It's overkill already, especially since Linux doesn't have
> priority inheritance. Since POSIX requires 32 levels, that
> is the right number. Actually using more than one level
> (remember: NO priority inheritance) might not be wise.
> If we stuck to 32 levels, RT and non-RT could both fit
> within a 2-digit positive number. Also, there'd be fewer
> bits for the scheduler to examine.

As I said; I don't feel strongly. There was an option to change the range of 
real time priorities in 2.4 which is why I mention it. Let others speak 
cause I care not what you do as long as we understand it. I'm not changing 
the scheduler to suit userspace tools.

Cheers,
Con
