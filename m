Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUGHI1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUGHI1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUGHI1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:27:37 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:63937 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265913AbUGHI1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:27:33 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <20040708001027.7fed0bc4.akpm@osdl.org> <cone.1089273505.418287.4554.502@pc.kolivas.org> <20040708010842.2064a706.akpm@osdl.org>
Message-ID: <cone.1089275229.304355.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
Date: Thu, 08 Jul 2004 18:27:09 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> Andrew Morton writes:
>> 
>> > Con Kolivas <kernel@kolivas.org> wrote:
>> >>
>> >>  Ah what the heck. They can only be knocked back to where they already are.
>> > 
>> > hm.  You get an eGrump for sending two patchs in one email.  Surprisingly
>> > nice numbers though.
>> > 
>> > How come vm_swappiness gets squared?  That's the mysterious "bias
>> > downwards", yes?  What's the theory there?
>> 
>> No real world feedback mechanism is linear. As the pressure grows the 
>> positive/negative feedback grows exponentially.
> 
> That takes me back.  The classic control system is PID:
> Proportional/Integral/Derivative - they refer to the way in which the error
> term (output-desired output) is fed back to the input:
> 
> Proportional: the bigger the error, the more input drive
> 
> Integral: feeding back a bit of the integral of the error prevents
> permanent output skew due to non-infinite forward gain.
> 
> Derivative: feeding back -(rate of change) provides damping.
> 
> You can live without I and D - the main thing is to feed back the -error.
> 
> IOW: linear works just fine :)

/me hides

Umm sorry the control systems I look at are physiological and tend to be 
exponential, so ignore me.

> Your answer didn't help me understand the design though.

Ok I'll just describe it. I should have just said that when mapped pages are 
low the best seems to be a very low swappiness, but not zero as zero seems 
to get bogged down easily (kswapd gets busy and basic things take longer) as 
occasionally slipping some pages onto swap helps. Generally it's when what I 
called the application pages (blush) get to around 75% that allowing things 
to swap at the rate equivalent to swappiness==60 is helpful. Once the mapped 
pages went greater than 75% the machine would start bogging down again if 
the swappiness remained at 60. I guess I made up the maths to fill the way 
the design worked best. Linear brought up the swappiness too easily and 
under swap thrash made things worse. It looked nicer but didn't really 
behave well.

>> > Please define this new term "application pages"?
>> 
>> errm it's fuzzy to say the least. It's the closest I can come to 
>> representing what end users understand as "non-cached" pages.
> 
> Isn't that mapped pages?

I'm all ears.

>> > Those si_swapinfo() and si_meminfo() calls need to come out of there.
>> 
>> I'm game. I had the idea but not the skill. Anyone wanna help me with that?
> 
> Need to work out what cen be removed first.  The freeswap/totalswap can go.
>  That leaves us needing what?  totalram and freeram.  If the algorithm can
> be flipped over to use nr_mapped, we'd be looking good.

Ok. I need some time to clean up this mess and try and figure out what to do 
then.

Con

