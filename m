Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbTFSJAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265739AbTFSJAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:00:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:11419 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265736AbTFSJAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:00:36 -0400
Message-Id: <5.2.0.9.2.20030619110525.00cff138@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 11:18:49 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
Cc: Con Kolivas <kernel@kolivas.org>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3EF17B11.1080002@cyberone.com.au>
References: <5.2.0.9.2.20030619103935.023f5648@pop.gmx.net>
 <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
 <1055983621.1753.23.camel@asgaard.midgaard.us>
 <200306190043.14291.kernel@kolivas.org>
 <200306190938.04430.kernel@kolivas.org>
 <1055983621.1753.23.camel@asgaard.midgaard.us>
 <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
 <5.2.0.9.2.20030619103935.023f5648@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:57 PM 6/19/2003 +1000, Nick Piggin wrote:


>Mike Galbraith wrote:
>
>>At 05:33 PM 6/19/2003 +1000, Nick Piggin wrote:
>>
>>>Mike Galbraith wrote:
>>>
>>>>
>>>>However, that will also send X and friends go off to the expired array 
>>>>_very_ quickly.  This will certainly destroy interactive feel under 
>>>>load because your desktop can/will go away for seconds at a time.  Try 
>>>>to drag a window while a make -j10 is running, and it'll get choppy as 
>>>>heck.  AFAIKT, anything that you do to increase concurrency in a global 
>>>>manner is _going_ to have the side effect of damaging interactive feel 
>>>>to some extent.  The one and only source of desktop responsiveness is 
>>>>the large repository of cpu ticks a task is allowed to save up for a rainy day.
>>>>
>>>>What I would love to figure out is a way to reintroduce back-boost 
>>>>without it having global impact.  I think hogging the cpu is absolutely 
>>>>_wonderful_ when the hogs are the tasks I'm interacting 
>>>>with.  Unfortunately, there seems to be no way to determine whether a 
>>>>human is intimately involved or not other than to specifically tell the 
>>>>scheduler this via renice.
>>>
>>>
>>>
>>>Could certian drivers or subsystems say they are interactive and
>>>provide some input to the scheduler that way? Reads from input
>>>devices for example could increase a processes "interactivity" a
>>>lot, while writes to console or ... no, everything gets multiplexed
>>>through X, doesn't it...
>>
>>
>>The mouse and keyboard are wonderful candidates for this... there's 
>>always a human connected.  It's too bad there's no way to tell if a human 
>>is staring at the display.  If I'm mesmerized by xmms gl eye-candy, it's 
>>a highly interactive cpu hog.
>
>
>Thats right, but console / DRI / whatever could probably provide a small
>interactivity boost.

Yes.  I was thinking about the wastage when I get bored and minimize or 
cover up eye-candy.  For that kind of stuff, the existing scheduler 
syscalls would probably be much more efficient, because userland knows if I 
can see cpu oinker's output.

>>>The backboost was quite a good idea. I didn't follow it closely
>>>but what if you impemented the above idea, which increased
>>>an "interactiveness" number, then X clients could simply have
>>>their interactiveness value boosted by X?
>>
>>
>>Sounds good.  What I'm trying within the current framework is to let 
>>tasks which are extremely light weight (and not kernel threads) do 
>>backboost.  Dunno if anything good will come out of it.
>
>
>OK, the backboost is what? A dynamic priority boost? This is so
>X for example can be made interactive through its clients even
>if its hogging a lot of CPU, right?

Exactly.  That's what made backboost so wonderful... X/KDE wiggies boosted 
each other.

>I think it might be a good idea to introduce an "interactiveness"
>measurement which could be boosted by interactive devices, and a
>forwardboost would be able to increase an X client's interactivenss
>through X.

Yes.

>in

(messagus interruptus?)

         -Mike 

