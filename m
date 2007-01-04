Return-Path: <linux-kernel-owner+w=401wt.eu-S965067AbXADSgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbXADSgg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXADSgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:36:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:34252 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbXADSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:36:35 -0500
In-Reply-To: <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>  <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d913acf949f84c6dec496a1f52c1f9f5@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 19:34:46 +0100
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll happily turn off compiler features that are "clever optimizations
> that never actually matter in practice, but are just likely to possible
> cause problems".

The "signed wrap is undefined" thing doesn't fit in this category
though:

-- It is an important optimisation for loops with a signed
    induction variable;
-- "Random code" where it causes problems is typically buggy
    already (i.e., code that doesn't take overflow into account
    at all won't expect wraparound either);
-- Code that explicitly depends on signed overflow two's complement
    wraparound can be trivially converted to use unsigned arithmetic
    (and in almost all cases it really should have used that already).

If GCC can generate warnings for things in the second bullet point
(and it probably will, but nothing is finalised yet), I don't see
a reason for the kernel to turn off the optimisation.  Why not try
it out and only _if_ it causes troubles (after the compiler version
is stable) turn it off.

to take is not to add the compiler flag, but to fix the code.
>>
>> Nope, unless we decide that the performance advantages of
>> a language change are worth the risk and pain.

But it's not a language change -- GCC has worked like this
for a _long_ time already, since May 2003 if I read the
ChangeLog correctly -- it's just that it starts to optimise
some things more aggressively now.

> With integer overflow optimizations, the same situation may be true. 
> The
> kernel has never been "strict ANSI C". We've always used C extensions. 
> The
> extension of "signed integer arithmetic follows 
> 2's-complement-arithmetic"
> is a perfectly sane extension to the language, and quite possibly worth
> it.

Could be.  Who knows, without testing.  I'm just saying to
not add -fwrapv purely as a knee-jerk reaction.

> And the fact that it's not "strict ANSI C" has absolutely _zero_
> relevance.

I certainly never claimed so, that's all in Albert's mind it seems :-)


Segher

