Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVHQQK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVHQQK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVHQQK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:10:29 -0400
Received: from mail.aknet.ru ([82.179.72.26]:4109 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751148AbVHQQK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:10:29 -0400
Message-ID: <43036176.7030807@aknet.ru>
Date: Wed, 17 Aug 2005 20:10:30 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] API for timer hooks
References: <42FDF744.2070205@aknet.ru>	 <1124126354.8630.3.camel@cog.beaverton.ibm.com>	 <43024ADA.8030508@aknet.ru> <29495f1d0508161524260a856c@mail.gmail.com>
In-Reply-To: <29495f1d0508161524260a856c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Nish Aravamudan wrote:
>> [PATCH] i386: Selectable Frequency of the Timer Interrupt
>> but it doesn't look like it ended up
>> with some patch applied, or where is it?
> This thread resulted in CONFIG_HZ. You get to choose between 100, 250
> or 1000. It was not meant to allow runtime HZ modifications.
I see, but the thread was long, at one point
a lot have been said about setting HZ at boot -
that's something that most likely could be
usefull for me.

>> 2. It needs its handler to be executed
>> first in the chain. Otherwise the quality
>> is poor because of the latency.
> Yeah, that's a tougher one :)
Yes, but this can wait. Only the ability to
set the higher interrupt rates is vital.
But in fact, what is the problem to introduce
the grabbing timer within the current soft-timer
API? Or some priority scheme? I think it is
actually much easier to achieve than the variable
freq.

> Does the dynamic-tick patch help you at all? I'm not sure if it's
> meant to, admittedly.
I don't think it helps. It seems to be self-
contained. It doesn't add the generic API,
all its functions are using the specific
global structure, AFAICS.

> I'm also not sure if it has any cap on the
> maximum HZ it attempts to reprogram the hardware to... Mucking with HZ
> at run-time is going to break lots of stuff, though...well, not
> necessarily, depends on how you muck with jiffies :)
That's why I thought I should avoid this alltogether.
My patch introduces the grabbing hook, that
can decide to bypass the rest of the chain.
The idea is that it is now up to that hook
to make sure the rest of the chain is being
executed with the *old* frequency. Surely
this is a kind of an ad-hoc, but the change is
very small and seemingly innocent, plus the
cleanup - it may not be that bad after all, I
think:)

