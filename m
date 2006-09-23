Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWIWQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWIWQov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWIWQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:44:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:12868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751290AbWIWQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:44:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=e9Ht7j2/fNrjxoKm4oTobdYEHlALI8SoH/gpq6ouNaq+/oTnifnWOfUfCVUxOYigYkXW3IlQM1u2UDcYu5RNN+7OCefjQAchuHFfwPpHseBo+5/unqO+TujDhPp5ht6ZMKerbHTY6O4HqByOdgE1demS+3Ti6OS9IKSsTMSz9rU=
Message-ID: <451564A9.5030208@gmail.com>
Date: Sat, 23 Sep 2006 10:45:29 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + doc-lockdep-design-explain-display-of-state-bits.patch added
 to -mm tree
References: <200609191748.k8JHmKAu027921@shell0.pdx.osdl.net> <20060920081903.GA12517@elte.hu> <45115C5E.1060604@gmail.com> <20060920201919.GA24031@elte.hu>
In-Reply-To: <20060920201919.GA24031@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jim Cromie <jim.cromie@gmail.com> wrote:
>
>   
>   
>> btw '?' carries *is this really what you want ?* connotations.  Is 
>> that intended ? If not, maybe '=' is better..  2 lines --> 'both'
>>     
>
> well i dont see '=' any better than '?'.
>
>   
let me rephrase.

for someone who knows intimately what they mean, how the flags are 
rendered is unimportant.

but for someone who is looking to understand what lockdep 
errors/messages mean,
they may look for hints in the the choice of flag-char, which could 
convey 'severity'

! - something went bang, oh shit
* - splatted on landing
? - huh?  - did you mean to do this ?
_ - blank, unspecified ..

It could be that making any such inferences is looking for hints that 
dont exist,
otoh - if some messages are more severe, it would make sense to connote 
that in the
choice of symbols to represent the flags/states.

IOW, were I to find a lockdep errmsg with {--??} vs {--..} in dmesg,
would it warrant any extra attention (as in *fix-me-first*) ?  or just 
investigated



>>> [ btw.: truly '....' locks are candiates for optimization, as they 
>>>  unnecessarily disable interrupts in process context. ]
>>>       
>> is that a future optimization, needing another pair of 
>> functions/macros ?
>>     
>
> it means they dont really have to be spin_lock_irq()/spin_unlock_irq() 
> uses but spin_lock()/spin_unlock() would be enough. (but it's not 
> guaranted - some rare codepath that has not triggered yet might use 
> those locks from IRQ context, at which point the irq-safety in process 
> context is compulsory.)
>   

Thats helpful. So continuing this line..
If joe-hacker were to falsely optimize, and then trigger the rare path 
later,
would the lockdep errmsg contain {  ??}, or do I oversimplify ?

> 	Ingo
>
>   

thanks
