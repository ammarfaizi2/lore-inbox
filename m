Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUJMAQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUJMAQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUJMAQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:16:36 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:447 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267921AbUJMAQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:16:16 -0400
References: <1097542651.2666.7860.camel@cube>
Message-ID: <cone.1097626558.804486.12364.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, ankitjain1580@yahoo.com, mingo@elte.hu,
       rml@tech9.net
Subject: Re: Difference in priority
Date: Wed, 13 Oct 2004 10:15:58 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan writes:

> Con Kolivas writes:
>> Ankit Jain wrote:
> 
>>> if somebody knows the difference b/w /PRI of both
>>> these commands because both give different results
>>>
>>> ps -Al
>>> & top
>>>
>>> as per priority rule we can set priority upto 0-99
>>> but top never shows this high priority
>>
>> Priority values 0-99 are real time ones and 100-139 are normal 
>> scheduling ones. RT scheduling does not change dynamic priority while 
>> running wheras normal scheduling does (between 100-139). top shows the 
>> value of the current dynamic priority in the PRI column as the current 
>> dynamic priority-100. If you have a real time task in top it shows as a 
>> -ve value. ps -Al seems to show the current dynamic priority+60.
> 
> What would you like to see? There are numerous
> competing ideas of reality. There's also the matter
> of history and standards. I'd gladly "fix" ps, if
> people could agree on what "fix" would mean.
> 
> Various desirable but conflicting traits include:
> 
> a. for normal idle processes, PRI matches NI
> b. for RT processes, PRI matches RT priority
> c. for RT processes, PRI is negative of RT priority
> d. PRI is the unmodified value seen in /proc
> e. PRI is never negative
> f. low PRI is low priority (SysV "pri" keyword)
> g. low PRI is high priority (UNIX "PRI", SysV "opri")
> h. PRI matches some kernel-internal value
> i. PRI is in the range -99 to 999 (not too wide)

I can't say I've ever felt strongly about it. Wish I knew what was the best 
way. If we change the range of RT priority range by increasing it from 100 
to say 1000 then any arbitrary value to subtract will be wrong. How about 
just leaving the absolute dynamic priority value? Then we don't have any 
negative values confusing it, it isn't affected by increasing the range of 
RT priorities, and better priority values still are lower in value.

Cheers,
Con

