Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTH1N6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTH1N6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:58:41 -0400
Received: from dyn-ctb-210-9-246-251.webone.com.au ([210.9.246.251]:29192 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264030AbTH1N6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:58:37 -0400
Message-ID: <3F4E0A85.1040208@cyberone.com.au>
Date: Thu, 28 Aug 2003 23:58:29 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O18.1int
References: <A00409NJIDDBTRJI86KG96C8BZX3VHF.3f4e071c@monpc>
In-Reply-To: <A00409NJIDDBTRJI86KG96C8BZX3VHF.3f4e071c@monpc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guillaume Chazarain wrote:

>28/08/03 14:34:15, Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Guillaume Chazarain wrote:
>>
>>
>>>Hi Con (and linux-kernel),
>>>
>>>I noticed a regression wrt 2.6.0-test4 and 2.4.22 with this
>>>big context-switcher:
>>>
>>>
>>Hi Guillaume,
>>If you get the time, would you be able to try my patch? Thanks.
>>
>
>Here are the results for Nick's v8:
>
>top(1):
>
>  639 g         30   0  1336  260 1308 R 51.2  0.1   0:03.80 a.out
>  638 g         22   0  1336  260 1308 S 47.3  0.1   0:03.39 a.out
>
>User time (seconds): 0.57
>System time (seconds): 2.72
>Elapsed (wall clock) time (h:mm:ss or m:ss): 0:06.85
>Minor (reclaiming a frame) page faults: 17
>
>

Thanks Guillaume, so not very good. Its interesting that there can
be such a big difference in performance, but its a very simple app
so makes a good test for the specific regression.

In both Con's and my patches, the reader gets a bit more CPU. This
might be due to it preempting the writer more often on wakeups,
which would lead to more scheduling per work done and a regression.

If this is the case, I'm not sure the behaviour is too undesirable
though: its often very important for woken processes to be run
quickly. Its not clear that this workload is something we would
want to optimize for. Assuming the problem is what I guess.

I will take a look into it further when I get time tomorrow.


