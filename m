Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSBKGip>; Mon, 11 Feb 2002 01:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSBKGif>; Mon, 11 Feb 2002 01:38:35 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:8896 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S287289AbSBKGiT>; Mon, 11 Feb 2002 01:38:19 -0500
Message-ID: <3C67666B.2060507@nyc.rr.com>
Date: Mon, 11 Feb 2002 01:36:27 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C674CFA.2030107@nyc.rr.com>	<3C6750CD.46575DAA@mandrakesoft.com>  <3C675E6B.4010605@nyc.rr.com> <1013408447.806.409.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Mon, 2002-02-11 at 01:02, John Weber wrote:
> 
> 
>>The function thread_saved_pc() is a mystery to me.  It is declared with 
>>a return type of unsigned long, and yet return this:
>>
>>((unsigned long *)tsk->thread->esp)[3]
>>
>>This is confusing to me in many ways:
>>- the "thread" member of task struct is not a pointer
>>- esp is of type unsigned long, so I don't understand the cast, and
>>I certainly don't understand the [3] here.
>>
>>Can anyone explain this code to me?
>>
> 
> The problem is an interdependency between processor.h and sched.h.
> 
> The old code was the same, except it did
> 
> 	t->esp
> 
> where t was a thread_struct, instead of what we do now
> 
> 	t->thread->esp
> 
> where t is a task_struct.  And thus whereby before we passed
> 
> 	p->thread
>

I understand all this, but thread is not a pointer.
So shouldn't it be t->thread.esp ?

> as the argument, now you pass just `p'.  I.e., its the same net-affect. 
> The error is because the function needs access to both task_struct (in
> sched.h) and thread_struct (in processor.h) but the two are interrelated
> so we can't include them in each other.

Hmm... OK.

> The contents of esp is a memory address, so typecasting it to (unsigned
> long *) is OK.
> 
> As for the [3], p[3] is the same as
> 	*(p+3)
> ie,
> 	*(p+sizeof(p))
> so that is legal.

*(p + (3*sizeof(p))) ?

I understand the syntax, but I don't understand why one would want to 
return the address of something 3 longs away.  What is this function
supposed to be doing?



