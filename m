Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423225AbWANAXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423225AbWANAXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423226AbWANAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:23:54 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:12982 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1423225AbWANAXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:23:53 -0500
Message-ID: <43C84496.6060506@bigpond.net.au>
Date: Sat, 14 Jan 2006 11:23:50 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andy Whitcroft <apw@shadowen.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C7D4D1.10200@shadowen.org> <43C7E96D.7000003@shadowen.org> <43C81073.1040805@google.com>
In-Reply-To: <43C81073.1040805@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 14 Jan 2006 00:23:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Andy Whitcroft wrote:
> 
>> Andy Whitcroft wrote:
>>
>>> Peter Williams wrote:
>>>
>>>
>>>
>>>> Attached is a new patch to fix the excessive idle problem.  This patch
>>>> takes a new approach to the problem as it was becoming obvious that
>>>> trying to alter the load balancing code to cope with biased load was
>>>> harder than it seemed.
>>>
>>>
>>>
>>> Ok.  Tried testing different-approach-to-smp-nice-problem against the
>>> transition release 2.6.14-rc2-mm1 but it doesn't apply.  Am testing
>>> against 2.6.15-mm3 right now.  Will let you know.
>>
>>
>>
>> Doesn't appear to help if I am analysing the graphs right.  Martin?
> 
> 
> Nope. still broken.

Interesting.  The only real difference between this and Con's original 
patch is the stuff that he did in source_load() and target_load() to 
nobble the bias when nr_running is 1 or less.  With this new model it 
should be possible to do something similar in those functions but I'll 
hold off doing anything until a comparison against 2.6.15-mm3 with the 
patch removed is available (as there are other scheduler changes in -mm3).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
