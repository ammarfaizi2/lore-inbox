Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWE3XWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWE3XWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWE3XWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:22:17 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:24260 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964821AbWE3XWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:22:16 -0400
Message-ID: <447CD3A4.906@bigpond.net.au>
Date: Wed, 31 May 2006 09:22:12 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net> <447B7FD6.6020405@bigpond.net.au> <447BA8ED.3080904@vilain.net> <447BB1C6.9050901@bigpond.net.au> <447CC19D.4020603@vilain.net>
In-Reply-To: <447CC19D.4020603@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 30 May 2006 23:22:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Peter Williams wrote:
> 
>> They shouldn't interfere as which scheduler to use is a boot time 
>> selection and only one scheduler is in force.  It's mainly a coding 
>> matter and in particular whether the "scheduler driver" interface would 
>> need to be modified or whether your scheduler can be implemented using 
>> the current interface.
>>  
>>
> 
> Yes, that's the key issue I think - the interface now has more inputs.
> 
>>> I guess the big question is - is there a corresponding concept in
>>>> PlugSched?  for instance, is there a reference in the task_struct to the
>>>> current scheduling domain, or is it more CKRM-style with classification
>>>> modules?
>>>    
>>>
>> It uses the standard run queue structure with per scheduler
>> modifications (via a union) to handle the different ways that the
>> schedulers manage priority arrays (so yes). As I said it restricts
>> itself to scheduling matters within each run queue and leaves the
>> wider aspects to the normal code.
> 
> 
> Ok, so there is no existing "classification" abstraction?  The
> classification is tied to the scheduler implementation?

Yes.

> 
>> At first guess, it sounds like adding your scheduler could be as simple 
>> as taking a copy of ingosched.c (which is the implementation of the 
>> standard scheduler within PlugSched) and then making your modifications. 
>>  You could probably even share the same run queue components but 
>> there's nothing to stop you adding new ones.
>>
>> Each scheduler can also have its own per task data via a union in the 
>> task struct.
>>  
>>
> 
> Ok, sounds like that problem is solved - just the classification one
> remaining.
> 
>> OK.  I'm waiting for the next -mm kernel before I make the next release.
>>  
>>
> 
> Looking forward to it.

Andrew released 2.6.17-rc5-mm1 yesterday so I should have a new version 
in a day or two.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
