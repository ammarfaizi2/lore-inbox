Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265807AbRGDJ6b>; Wed, 4 Jul 2001 05:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRGDJ6W>; Wed, 4 Jul 2001 05:58:22 -0400
Received: from smarty.smart.net ([207.176.80.102]:15111 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S265807AbRGDJ6N>;
	Wed, 4 Jul 2001 05:58:13 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107041010.GAA01979@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Jul 2001 06:10:55 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>Cort Dugan
>> There isn't such a crippling difference between straight-line and code
>>with>
>> unconditional branches in it with modern processors.  In fact, there's>
>>very
>> little measurable difference.
>>
>> If you're looking for something to blame hurd performance on I'd
>>suggest
>> the entire design of Mach, not inline asm vs procedure calls.  Tossing
>>a
>> few context switches into calls is a lot more expensive.
>
hpa
>That's not where the bulk of the penalty of a function call comes in
>(and it's a call/return, not an unconditional branch.)  The penalty
>comes in because of the additional need to obey the calling
>convention, and from the icache discontinuity.
>

call/return is two unconditional branches and a push and a pop (is that
right?), which is I think what CD means, i.e. in terms of branch
prediction. The push/pop is a hit on old CPUs, donno about >386. You're
right though. The big hit is you can't lose the pushes to set up the args
for a separately assembled function, or the frame drop that follows it.

>Not to mention that certain things simply cannot be done that way.
>

Don't tell me that. Then I can't use my subroutine-threaded Forth
variant, in which + is a subroutine call.  ;o)

Anyway, yes it's a performance hit to not inline asms. Is it worth the
bletchery? It's worth asking that once in a while. I've looked at set_bit
both ways. Now I'm curious how it does as straight C.

Rick Hohensee
