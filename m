Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265735AbTFSIq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbTFSIq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:46:58 -0400
Received: from dialup-221.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.221]:25604
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265735AbTFSIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:46:47 -0400
Message-ID: <3EF17BAB.9020403@cyberone.com.au>
Date: Thu, 19 Jun 2003 19:00:27 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
References: <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net> <1055983621.1753.23.camel@asgaard.midgaard.us> <200306190043.14291.kernel@kolivas.org> <200306190938.04430.kernel@kolivas.org> <1055983621.1753.23.camel@asgaard.midgaard.us> <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net> <5.2.0.9.2.20030619103935.023f5648@pop.gmx.net> <3EF17B11.1080002@cyberone.com.au>
In-Reply-To: <3EF17B11.1080002@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Mike Galbraith wrote:
>
>> At 05:33 PM 6/19/2003 +1000, Nick Piggin wrote:
>>
>>> Mike Galbraith wrote:
>>>
>>>>
>>>> However, that will also send X and friends go off to the expired 
>>>> array _very_ quickly.  This will certainly destroy interactive feel 
>>>> under load because your desktop can/will go away for seconds at a 
>>>> time.  Try to drag a window while a make -j10 is running, and it'll 
>>>> get choppy as heck.  AFAIKT, anything that you do to increase 
>>>> concurrency in a global manner is _going_ to have the side effect 
>>>> of damaging interactive feel to some extent.  The one and only 
>>>> source of desktop responsiveness is the large repository of cpu 
>>>> ticks a task is allowed to save up for a rainy day.
>>>>
>>>> What I would love to figure out is a way to reintroduce back-boost 
>>>> without it having global impact.  I think hogging the cpu is 
>>>> absolutely _wonderful_ when the hogs are the tasks I'm interacting 
>>>> with.  Unfortunately, there seems to be no way to determine whether 
>>>> a human is intimately involved or not other than to specifically 
>>>> tell the scheduler this via renice.
>>>
>>>
>>>
>>>
>>> Could certian drivers or subsystems say they are interactive and
>>> provide some input to the scheduler that way? Reads from input
>>> devices for example could increase a processes "interactivity" a
>>> lot, while writes to console or ... no, everything gets multiplexed
>>> through X, doesn't it...
>>
>>
>>
>> The mouse and keyboard are wonderful candidates for this... there's 
>> always a human connected.  It's too bad there's no way to tell if a 
>> human is staring at the display.  If I'm mesmerized by xmms gl 
>> eye-candy, it's a highly interactive cpu hog.
>
>
>
> Thats right, but console / DRI / whatever could probably provide a small
> interactivity boost.


Soundcard even...

