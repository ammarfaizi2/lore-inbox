Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTHLL6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTHLL6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:58:16 -0400
Received: from dyn-ctb-210-9-241-99.webone.com.au ([210.9.241.99]:63750 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S270093AbTHLL6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:58:10 -0400
Message-ID: <3F38D64C.2030109@cyberone.com.au>
Date: Tue, 12 Aug 2003 21:58:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308120629.31476.rob@landley.net> <3F38CAC6.7010808@cyberone.com.au> <200308120735.04035.rob@landley.net>
In-Reply-To: <200308120735.04035.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>On Tuesday 12 August 2003 07:08, Nick Piggin wrote:
>
>
>>>>I don't quite understand what you are getting at, but if you don't want
>>>>to sleep you should be able to use a non blocking syscall.
>>>>
>>>So you can then block on poll instead, you mean?
>>>
>>Well if thats what you intend, yes. Or set poll to be non-blocking.
>>
>
>So you're still blocking for an unknown amount of time waiting for your 
>outstanding requests to get serviced, now you're just hiding it to 
>intentionally give the scheduler less information to work with.
>

Where are you blocking?

>
>>>These are hogs, often both of CPU time and I/O bandwidth.  Being blocked
>>>on I/O does not stop them from being hogs, it just means they're juggling
>>>their hoggishness.
>>>
>>This is the CPU scheduler though. A program could be a disk/network
>>hog and use a few % cpu. Its obviously not a cpu hog, and should get
>>the cpu again soon after it is woken. Sooner than non running cpu hogs,
>>anyway.
>>
>
>A program that waits for a known amount of time (I.E. on a timer) cares about 
>when it gets woken up.  A program that blocks on an event that's going to 
>take an unknown amount of time can't be too upset if its wakeup is after an  
>unknown amount of time.
>
>Beyond that there's blocking for input from the user (latency matters) and 
>blocking for input from something else (latency doesn't matter), but we can't 
>tell that directly and have to fake our way around it with heuristics.
>
>
>>>That's what Con's detecting.  It's a heuristic.  But it's a good
>>>heuristic.  A process that plays nice and yields the CPU regularly gets a
>>>priority boost. (That's always BEEN a heuristic.)
>>>
>>>The current scheduler code has moved a bit beyond this, but this is the
>>>bit I was talking about when I disagreed with you earlier.
>>>
>>Yeah, I know Con is trying to detect this. Its just that detecting
>>it using TASK_INTERRUPTIBLE/TASK_UNINTERRUPTIBLE may not be the best
>>way.
>>
>
>Okay, if this isn't the "best way", then what is?  You have yet to suggest an 
>alternative, and this heuristic is obviously better than nothing.
>

Well I'm not sure what the best way is, but I'm pretty sure its not
this ;)

I have been hearing of people complaining the scheduler is worse than
2.4 so its not entirely obvious to me. But yeah lots of it is trial and
error, so I'm not saying Con is wasting his time.

>
>>Suddenly your kernel compile on an NFS mount becomes interactive
>>for example.
>>
>
>Translation: Suppose the heuristics fail.  If it can't fail, it's not a 
>heuristic, is it?  Failure of heuristics must be survivable.  The kernel 
>compile IS a rampant CPU hog, and if it's mis-identified as interactive for 
>some reason it'll get demoted again after using up too many time slices.  In 
>the mean time, your PVR (think home-browed Tivo clone) skips recording your 
>buffy rerun.  This is something to be minimized, but the scheduler isn't 
>psychic.  If it happens to once out of every million hours of use, you're 
>going to see more hard drive failures due and dying power supplies than 
>problems caused by this.  (This is not sufficient for running a nuclear power 
>plant or automated factory, but those guys need hard realtime anyway, which 
>this isn't pretending to be.)
>

Of course. I the problem is people think that the failure
cases are currently too common and or types of failure are
unacceptable.

>
>>Then again, the way things are, Con might not have any
>>other option.
>>
>
>You're welcome to suggest a better alternative, but criticizing the current 
>approach without suggesting any alternative at all may not be that helpful.
>

I have been trying half hartedly over the past week or two.


