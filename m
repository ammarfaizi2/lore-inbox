Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbTCKCEt>; Mon, 10 Mar 2003 21:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTCKCEt>; Mon, 10 Mar 2003 21:04:49 -0500
Received: from smtp0.euronet.nl ([194.134.35.141]:34753 "EHLO smtp0.euronet.nl")
	by vger.kernel.org with ESMTP id <S262785AbTCKCEs>;
	Mon, 10 Mar 2003 21:04:48 -0500
Message-ID: <3E6D469C.8060209@koffie.nl>
Date: Tue, 11 Mar 2003 03:14:52 +0100
From: Segher Boessenkool <segher@koffie.nl>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, afleming@motorola.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] oprofile for ppc
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>		<1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube>	<1047136206.12202.85.camel@zion.wanadoo.fr>  <3E6C0B93.5040205@koffie.nl> <1047277876.2012.360.camel@cube>
In-Reply-To: <1047277876.2012.360.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
> 
>>Benjamin Herrenschmidt wrote:
> 
> 
>>>Beware though that some G4s have a nasty bug that
>>>prevents using the performance counter interrupt
>>>(and the thermal interrupt as well).
>>
>>MPC7400 version 1.2 and lower have this problem.
> 
> 
> MPC7410 you mean, right? Are those early revisions
> even popular?

7400 and 7410 core versions are identical, afaik.  I don't
think any 7410 core lower than version 2.0 was ever used
in any consumer machines.  ymmv.

> I'm wondering if the MPC7400 is also affected.
> The MPC7400 has some significant differences.
> The pipeline length changed.

Between 7400 and 7410?  That's news to me...

>>>The problem is that if any of those fall at the same
>>>time as the DEC interrupt, the CPU messes up it's
>>>internal state and you lose SRR0/SRR1, which means
>>>you can't recover from the exception.
>>
>>But the worst that happens is that you lose that
>>process, isn't it?  Not all that big a problem,
>>esp. since the window in which this can happen is
>>very small.
> 
> I think you'd get an infinite loop of either
> the decrementer or performance monitor. That's
> mostly fixable by checking for the condition and
> killing the affected process, but that process
> could be one of the ones built into the kernel.

That would be a problem, yes :-(

> So the use of oprofile comes down to a choice:
> 
> a. Ignore the problem.
>    rare crashes

As long as its rare, that's not _too_ big of a problem,
really.  Just document it ;)

> b. The decrementer goes much faster for profiling.
>    high overhead, awkwardness in non-time measurement

Bad idea, I think.

> c. The performance monitor is used for clock ticks.
>    hard choices about sharing or frequency

I'd go for this option.


Segher


