Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRKVKnM>; Thu, 22 Nov 2001 05:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKVKnC>; Thu, 22 Nov 2001 05:43:02 -0500
Received: from [194.213.32.133] ([194.213.32.133]:36225 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276982AbRKVKmt>;
	Thu, 22 Nov 2001 05:42:49 -0500
Date: Wed, 21 Nov 2001 02:31:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011121023137.D37@toy.ucw.cz>
In-Reply-To: <E165QhG-00035D-00@the-village.bc.nu> <Pine.LNX.4.33.0111181756260.7482-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111181756260.7482-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 18, 2001 at 06:02:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why is it a compiler bug. You've not declared that variable to be volatile
> > therefore it is only touched in the code flow the compiler is analysing.
> 
> Even without volatile, the compiler is very arguably buggy if it writes
> values to your variables that were never supposed to be there.
> 
> Take this, for example:
> 
> 	sig_atomic_t value = 1;
> 
> 	int fn()
> 	{
> 		value = 2;
> 	}
> 
> And a signal comes in. Even without the volatile, if gcc has written
> _anything_ else than 1 or 2 into the variable, gcc is BROKEN.

imagine 

typedef volatile int sig_atomic_t;

> There's no point being a language lawyer and saying that gcc "could write
> anything to value before it writes the final 2". Tha's not true. A compile
> rthat does that is
> 
>  (a) buggy as hell from a POSIX standpoint
>  (b) even apart from POSIX, from a Q-of-I standpoint complete and utter
>      crap.

Imagine this:

if (likely(foo))
	c = 1
else	c = 2

I could see it optimized as

c = 1
if (unlikely(foo))
	c = 2

Given enough register pressure.... I've seen similar optimalizations proposed
in "advanced compilers" book.
								Pavel
PS: but wrapping access to current->flags in macro is probably okay for now.
I just wanted to show that writing unwanted value is not as broken as you
think.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

