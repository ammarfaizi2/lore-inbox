Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTLWC5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTLWC5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:57:47 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:52882 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264893AbTLWC5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:57:44 -0500
Message-ID: <3FE7AF24.40600@cyberone.com.au>
Date: Tue, 23 Dec 2003 13:57:40 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <200312231138.21734.kernel@kolivas.org> <200312231224.49069.kernel@kolivas.org> <3FE79C32.6050104@cyberone.com.au> <200312231342.56724.kernel@kolivas.org>
In-Reply-To: <200312231342.56724.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 23 Dec 2003 12:36, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>>I discussed this with Ingo and that's the sort of thing we thought of.
>>>Perhaps a relative crossover of 10 dynamic priorities and an absolute
>>>crossover of 5 static priorities before things got queued together. This
>>>is really only required for the UP HT case.
>>>
>>Well I guess it would still be nice for "SMP HT" as well. Hopefully the
>>code can be generic enough that it would just carry over nicely. 
>>
>
>I disagree. I can't think of a real world scenario where 2+ physical cpus 
>would benefit from this.
>

Well its the same problem. A nice -20 process can still lose 40-55% of its
performance to a nice 19 process, a figure of 10% is probably too high and
we'd really want it <= 5% like what happens with a single logical processor.

>
>>It does 
>>have complications though because the load balancer would have to be taught
>>about it, and those architectures that do hardware priorities probably
>>don't even want it.
>>
>
>Probably the simple relative/absolute will have to suffice. However it still 
>doesn't help the fact that running something cpu bound concurrently at nice 0 
>with something interactive nice 0 is actually slower if you use a UP HT 
>processor in SMP mode instead of UP.
>

It will be based on dynamic priorities, possibly with some feedback from
nice as well, but it probably still won't be perfect and it will probably
be very complex *cough* hardware priorities *cough* ;)

I might try to fit it into a more general priority balancing system because
we currently have similar sorts of failings on regular SMP as well.


