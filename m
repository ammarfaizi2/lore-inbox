Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBSA5n>; Mon, 18 Feb 2002 19:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSBSA5X>; Mon, 18 Feb 2002 19:57:23 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:48017 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289099AbSBSA5E>;
	Mon, 18 Feb 2002 19:57:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Date: Tue, 19 Feb 2002 02:01:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, davem@redhat.com,
        rwhron@earthlink.net
In-Reply-To: <20020217090111.GF832@holomorphy.com> <E16cwJZ-0000jZ-00@starship.berlin> <20020219003450.GF3511@holomorphy.com>
In-Reply-To: <20020219003450.GF3511@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cyeq-0000y5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 01:34 am, William Lee Irwin III wrote:
> On February 17, 2002 10:01 am, William Lee Irwin III wrote:
> >> After distilling with hpa's help the results of some weeks-old
> >> numerological experiments^W^Wnumber crunching, I've devised a patch
> >> here for -rmap to make the waitqueue hashing somewhat more palatable
> >> for SPARC and several others.
> >> 
> >> This patch uses some operator-sparse Fibonacci hashing primes in order
> >> to allow shift/add implementations of the hash function used for hashed
> >> waitqueues.
> >> 
> >> Dan, Dave, could you take a look here and please comment?
> 
> On Mon, Feb 18, 2002 at 11:31:15PM +0100, Daniel Phillips wrote:
> > Could you explain in very simple terms, suitable for Aunt Tillie (ok, not
> > *that* simple) how the continued fraction works, how it's notated, and how
> > the terms of the expansion relate to good performance as a hash?
> 
> Do you want it just in a post or in-line?
> 
> Here's the posted brief version:
> 
> Numbers have "integer parts" and "fractional parts", for instance, if
> you have a number such as 10 1/2 (ten and one half) the integer part
> is 10 and the fractional part is 1/2. The fractional part of a number
> x is written {x}.
> 
> Now, there is something called the "spectrum" of a number, which for
> a number x is the set of all the numbers of the form n * x, where n
> is an integer. So we have {1*x}, {2*x}, {3*x}, and so on.
> 
> If we want to measure how well a number distributes things we can try
> to see how uniform the spectrum is as a distribution. There is a
> theorem which states the "most uniform" distribution results from the
> number phi = (sqrt(5)-1)/2, which is related to Fibonacci numbers.
> 
> The continued fraction of phi is
> 
> 0 + 1
>    -----
>    1 + 1
>       -----
>       1 + 1
>          -----
>          1 + 1
>             -----
>             1 + 1
>                 ...
> 
> where it's 1's all the way down. Some additional study also revealed
> that how close the continued fraction of a number is to phi is related
> to how uniform the spectrum is. For brevity, I write continued fractions
> in-line, for instance, 0,1,1,1,1,... for phi, or 0,1,2,3,4,... for
> 
> 0 + 1
>    -----
>    1 + 2
>       -----
>       1 + 3
>          -----
>          1 + 4
>             ....
> 
> One way to evaluate these is to "chop off" the fraction at some point
> (for instance, where I put ...) and then reduce it like an ordinary
> fraction expression.
> 
> Fibonacci hashing considers the number p/2^n where n is BITS_PER_LONG
> and p is a prime number, and this is supposed to have a relationship
> to how evenly-distributed all the n-bit numbers multiplied by p in
> n-bit arithmetic are. Which is where the hash functions come in, since
> you want hash functions to evenly distribute things. There are reasons
> why primes are better, too.
> 
> And I think that covers most of what you had in mind.

Yes, it sure does, thanks a lot.

> In my own opinion, this stuff borders on numerology, but it seems to be
> a convenient supply of hash functions that pass chi^2 tests on the
> bucket distributions, so I sort of tolerate it. If I'm not using a strict
> enough test then I'm all ears...

/me resolves to get back to htree hashing very soon.

-- 
Daniel
