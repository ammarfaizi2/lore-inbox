Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCZXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCZXWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 18:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCZXWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 18:22:21 -0500
Received: from alog0209.analogic.com ([208.224.220.224]:9403 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261331AbVCZXWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 18:22:16 -0500
Date: Sat, 26 Mar 2005 18:21:30 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <1111825958.6293.28.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Arjan van de Ven wrote:

> On Fri, 2005-03-25 at 17:29 -0500, linux-os wrote:
>> Isn't it expensive of CPU time to call kfree() even though the
>> pointer may have already been freed?
>
> nope
>
> a call instruction is effectively half a cycle or less, the branch

Wrong!

> predictor of the cpu can predict perfectly where the next instruction is
> from. The extra if() you do in front is a different matter, that can
> easily cost 100 cycles+. (And those are redundant cycles because kfree
> will do the if again anyway). So what you propose is to spend 100+
> cycles to save half a cycle. Not a good tradeoff ;)
>

Wrong!

Pure unmitigated bull-shit. I measure (with hardware devices)
the execution time of real code in modern CPUs. I do this for
a living so you don't have to stand in line for a couple of
hours to have your baggage scanned at the airport.

Always, always, a call will be more expensive than a branch
on condition. It's impossible to be otherwise. A call requires
that the return address be written to memory (the stack),
using register indirection (the stack-pointer).

If somebody said; "I think that the code will look better
and the few cycles lost will not be a consequence with modern
CPUs...", then there is a point. But coming up with this
disingenuous bullshit is something else.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
