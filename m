Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVC3VUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVC3VUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVC3VUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:20:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21634 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262199AbVC3VRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:17:49 -0500
Message-ID: <424B18A1.2060502@tmr.com>
Date: Wed, 30 Mar 2005 16:22:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
   (2.6.11)
References: <4249D06F.30802@tmr.com><4249D06F.30802@tmr.com> <4249DAD4.9020602@pobox.com>
In-Reply-To: <4249DAD4.9020602@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Bill Davidsen wrote:
> 
>> Herbert Xu wrote:
>>
>>> You missed the point.  This has nothing to do with the crypto API.
>>> Jeff is saying that if this is disabled by default, then only a few
>>> users will enable it and therefore use this API.
>>>
>>> Since we can't afford to enable it by default as hardware RNG may
>>> fail which can lead to catastrophic consequences, there is no point
>>> for this API at all.
>>
>>
>>
>> Wait a minute, if it fails the system drops back to software, which is 
>> not as good in a pedantic analysis, but perhaps falls a good bit short 
>> of "catastrophic consequences" as most people would characterize that 
>> phrase. And more to the point, now that many CPUs and chipsets are the 
>> RNG of choice, what is the actual probability of a failure of the RNG 
>> leaving a functional system (that's a real question seeking response 
>> from someone who has some actual data).
> 
> 
> As I've said, in the past the Intel RNGs in particular -have- failed, 
> but the rest of the system keeps on working just fine.

People have been hit by meteors, too. I wasn't questioning that it was 
possible in practice, or even that it did happen, but trying to get some 
quantitative values for failure rates. I guess that wasn't clear, I know 
entropy is scarse on embedded systems, I don't know what the magnitude 
of the RNG failure is, so I'm coming from the "router in a cigar box" 
point of view.
> 
> It probably depends on the hardware implementation; I think the Intel 
> RNG was based on a thermal diode, or somesuch.
> 
> In the cases where an RNG has failed in the past, the system has worked 
> as expected:  rngd stopped feeding data into the entropy pool.

If the hardware RNG always fails to all zeros it should be possible to 
detect that it failed with the need for userspace daemons.  While true 
random bits might legitimately have 10k zeros in a row, I will bet that 
if it happens the device isn't working.

I'm assuming that the hardware RNG is only read when a read on 
/dev/random occurs and there isn't enough entropy available to satisfy 
the read. I realize that may not be true, I just haven't had time to go 
study the code.
> 
> If the VIA RNG (on-CPU) fails, that's probably indicative of a larger 
> problem, though.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
