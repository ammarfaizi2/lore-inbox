Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTHTCmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTHTCmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:42:10 -0400
Received: from dyn-ctb-210-9-246-104.webone.com.au ([210.9.246.104]:9221 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261521AbTHTCmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:42:07 -0400
Message-ID: <3F42DFEB.9010404@cyberone.com.au>
Date: Wed, 20 Aug 2003 12:41:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au> <20030819175105.GA19465@matchmail.com>
In-Reply-To: <20030819175105.GA19465@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

>On Tue, Aug 19, 2003 at 01:06:49PM +1000, Nick Piggin wrote:
>
>>Its done this way because this is really how the priorities are
>>enforced. With some complicated exceptions, every task will be
>>allowed to complete 1 timeslice before any task completes 2
>>(assuming they don't block).
>>
>>So higher priority tasks need bigger timeslices.
>>
>>
>>>also, i think dynamic priority should be used for timeslice calculation
>>>instead of static priority. the reason is, if a low priority task get a
>>>priority boost (to prevent starvation, for example) it should use the
>>>small timeslice corresponding to it's new priority level, instead of
>>>using it's original large timeslice that can ruin the interactive feel.
>>>
>>>
>>Among other things, yes, I think this is a good idea too. I'll be
>>addressing both these issues in my scheduler fork.
>>
>>I do have dynamic timeslices, but currently high priority tasks
>>still get big timeslices.
>>
>
>TS = Time Slice
>
>What needs to be changed is the 1TS per pass through the active array
>concept. 
>
>Devide the time slice into smaller Time Units, so that you can add one unit
>per priority level.
>
>TU = Time Units
>
>Then you account these TUs instead of slices.
>
>so, if nice -19 has 1 TU, and nice -19 has 40 TUs (maybe ranging from 1ms -
>200ms with a TU of 5ms).
>
>So nice -19 can have a long time slice and run until it expires if it
>doesn't get preempted.
>
>The more I think this through, the harder it gets to take this concept to
>completion, but the basic idea is to have multiple TSes per slice, and to
>account on TSes as well as slices.  That way, you have longer slices for
>nicer tasks, but I'm not sure how it would fit into the two array scheduler
>we have now.  You'd have to have another list for the processes that are
>have used up their slice, but haven't waited long enough for them to get
>another slice (because you want to give more total CPU percentage to the
>higher priorities, while still giving them smaller slices).
>
>Anyway, if anyone can take this idea and make it into a working scheduler,
>I'd be most interested in the results...
>

My idea is just to modify timeslices. It should achieve a similar
effect to what you describe I think.


