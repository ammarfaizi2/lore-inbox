Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750920AbWFEX4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFEX4c (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWFEX4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:56:32 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:4216 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750857AbWFEX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:56:31 -0400
Message-ID: <4484C4AC.7010306@bigpond.net.au>
Date: Tue, 06 Jun 2006 09:56:28 +1000
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
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 5 Jun 2006 23:56:29 +0000
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

A gzipped tar file containing the patch series (against 2.6.17-rc5-mm3) 
in a form suitable for use with quilt is now available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.2-for-2.6.17-rc5-mm3.series.tar.gz?download>

It's still a bit light in the description area but I figured that it's 
better than nothing.  Hopefully, the patch names give some idea of their 
purpose.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
