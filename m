Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbTFSHTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbTFSHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 03:19:45 -0400
Received: from anumail4.anu.edu.au ([150.203.2.44]:17329 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S265719AbTFSHTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 03:19:38 -0400
Message-ID: <3EF16738.9010104@cyberone.com.au>
Date: Thu, 19 Jun 2003 17:33:12 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
References: <1055983621.1753.23.camel@asgaard.midgaard.us> <200306190043.14291.kernel@kolivas.org> <200306190938.04430.kernel@kolivas.org> <1055983621.1753.23.camel@asgaard.midgaard.us> <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.3)
X-Spam-Tests: DATE_IN_PAST_06_12,EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,SPAM_PHRASE_03_05,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

> At 11:12 AM 6/19/2003 +1000, Con Kolivas wrote:
>
>> On Thu, 19 Jun 2003 10:47, Andreas Boman wrote:
>> > On Wed, 2003-06-18 at 19:38, Con Kolivas wrote:
>> > >
>> > > I had another look at 2.5 and noticed the max sleep avg is set to 10
>> > > seconds instead of 2 seconds in 2.4. This could make a _big_ 
>> difference
>> > > to new forked tasks if they all start out penalised as most
>> > > non-interactive. It can take 5 times longer before they get the 
>> balance
>> > > right. Can you try with this set to 2 or even 1 second on 2.5?
>> >
>> > Ahh, thanks Con, setting MAX_SLEEP_AVG to 2 *almost* removes all xmms
>> > skipping here, a song *may* skip during desktop switches sometime 
>> during
>> > the first 5 sec or so of playback IFF make -j20 is running. On a 
>> mostly
>> > idle box (well LoadAvg 3 or so is mostly idle isnt it? ;) desktop
>> > switching doesnt cause skips anymore 8)
>>
>> That's nice; a MAX_SLEEP_AVG of 1 second will shorten that 5 seconds 
>> to half
>> that as well. What you describe makes perfect sense given that 
>> achieving a
>> balance is an exponential function where the MSA is the time constant.
>
>
> However, that will also send X and friends go off to the expired array 
> _very_ quickly.  This will certainly destroy interactive feel under 
> load because your desktop can/will go away for seconds at a time.  Try 
> to drag a window while a make -j10 is running, and it'll get choppy as 
> heck.  AFAIKT, anything that you do to increase concurrency in a 
> global manner is _going_ to have the side effect of damaging 
> interactive feel to some extent.  The one and only source of desktop 
> responsiveness is the large repository of cpu ticks a task is allowed 
> to save up for a rainy day.
>
> What I would love to figure out is a way to reintroduce back-boost 
> without it having global impact.  I think hogging the cpu is 
> absolutely _wonderful_ when the hogs are the tasks I'm interacting 
> with.  Unfortunately, there seems to be no way to determine whether a 
> human is intimately involved or not other than to specifically tell 
> the scheduler this via renice.


Could certian drivers or subsystems say they are interactive and
provide some input to the scheduler that way? Reads from input
devices for example could increase a processes "interactivity" a
lot, while writes to console or ... no, everything gets multiplexed
through X, doesn't it...

The backboost was quite a good idea. I didn't follow it closely
but what if you impemented the above idea, which increased
an "interactiveness" number, then X clients could simply have
their interactiveness value boosted by X?

Am I rambling? ;)



