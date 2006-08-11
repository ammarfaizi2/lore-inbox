Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWHKIRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHKIRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWHKIRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:17:15 -0400
Received: from mx01.stofanet.dk ([212.10.10.11]:56539 "EHLO mx01.stofanet.dk")
	by vger.kernel.org with ESMTP id S1750802AbWHKIRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:17:13 -0400
Date: Fri, 11 Aug 2006 10:16:56 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Robert Crocombe <rcrocomb@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re:
 Problems with 2.6.17-rt8
In-Reply-To: <20060811010646.GA24434@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.64.0608111010420.11448@frodo.shire>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
 <1154541079.25723.8.camel@localhost.localdomain>
 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
 <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org>
 <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
 <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Aug 2006, Bill Huey wrote:

> On Wed, Aug 09, 2006 at 07:18:35PM -0700, Bill Huey wrote:
>> On Thu, Aug 10, 2006 at 12:05:57AM +0200, Esben Nielsen wrote:
>>> I had a long discussion with Paul McKenney about this. I opposed the patch
>>> from a latency point of view: Suddenly a high-priority RT task could be
>>> made into releasing a task_struct. It would be better for latencies to
>>> defer it to a low priority task.
>>>
>>> The conclusion we ended up with was that it is not a job for the RCU
>>> system, but it ought to be deferred to some other low priority task to
>>> free the task_struct.
>>
>> I agree. It's just hack to get it not to crash at this time. It really
>> should be done in another facility or utilizing another threading context.
>
> Esben and company,
>
> This is the second round of getting rid of the locking problems with free_task()
>
> This extends the mmdrop logic with desched_thread() to also handle free_task()
> requests as well. I believe this address your concerns and I'm open to review
> of this patch.
>
> Patch included:
>
> bill
>
>
Without applying the patch and only skimming it it looks like what Paul 
and I concluded :-)

But is there really no generic way of defering this kind of thing? It 
looks like a hell of a lot work where a kind of "message" infrastructure 
could have solved it in a few lines.

Esben
