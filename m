Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbTHaLb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTHaLb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:31:27 -0400
Received: from dyn-ctb-210-9-245-93.webone.com.au ([210.9.245.93]:47624 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261187AbTHaLbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:31:25 -0400
Message-ID: <3F51DC86.8040800@cyberone.com.au>
Date: Sun, 31 Aug 2003 21:31:18 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>	 <3F51CB44.3080805@cyberone.com.au> <1062325465.5171.60.camel@big.pomac.com>	 <3F51D0BD.8030307@cyberone.com.au> <1062326980.9959.65.camel@big.pomac.com>	 <3F51D4A4.4090501@cyberone.com.au> <1062328131.5171.77.camel@big.pomac.com>
In-Reply-To: <1062328131.5171.77.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>[Forgot to CC LKML last time, so i didn't remove old text ]
>
>On Sun, 2003-08-31 at 12:57, Nick Piggin wrote:
>
>
>>Heh, well we discuss stuff sometimes, but we disagree on things.
>>Which is a good thing because now our eggs are in two baskets.
>>
>
>Yes, but sometimes it feels like a merger would be better... As long as
>the propper quantum usage prevails =)
>

Nope. They're going in different directions. We'd slow each other down.

>
>>Yeah quite a lot. Lots included removing the interactivity stuff.
>>
>
>Humm, yeah, that should work automatically with the "used the full
>quantum" if thats still in that is... =)
>

You've lost me here.
My stuff is the opposite of what the interactivity stuff is trying
to do. The interactivity stuff _does_ kind of implement variable
timeslices in the form of re queueing stuff. I think it would be a
nightmare for them to put my variable timeslices on top of that and
then get it to all work properly.

>
>>Yeah it is, but the process will still take a lot of the penalty,
>>and if it is using a lot of CPU in context switching, then it will
>>get a lower priority anyway. Possibly there could be a very small
>>additional penalty per context switch, but so far it hasn't been
>>a big problem AFAIK.
>>
>
>Well my idea was more... The highest pri gets MIN_QUANT and a preemt
>can't happen faster than MIN_QUANT or so.. 
>

My idea is to try to make it as simple as possible, and no
simpler (as a great man put it!). So more is less if you
know what I mean.

I think this is going against how the scheduler (and UNIX
schedulers in general) have generally behaved. Its very likely
that you'd be better off fixing your app / other broken bit
of kernel code though.

I don't know... maybe...

>
>If i remember correctly, 2.6 spends much more time doing the actual
>context switches (not time / context switch but amount during this
>period). The new 1000 HZ thingy doesn't have to have that effect...
>
>And since to many context switches are inefficient imho, some standoffs
>would be good =)
>

I'm not sure. I think the 1000HZ thing is mainly from timer interrupts.
The scheduler should be pretty well agnostic to the 100->1000 change,
other than having higher resolution. Increased context switches might
indicate something is not being scaled with HZ properly though.

Yes context switches are inefficient. The tradeoff is vs scheduling
latency and there is no way around that.


