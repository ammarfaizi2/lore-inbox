Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBWWhn>; Fri, 23 Feb 2001 17:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129510AbRBWWhe>; Fri, 23 Feb 2001 17:37:34 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:33035 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129249AbRBWWhU>;
	Fri, 23 Feb 2001 17:37:20 -0500
Message-ID: <20010223233717.B13627@win.tue.nl>
Date: Fri, 23 Feb 2001 23:37:17 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Ralph Loader <suckfish@ihug.co.nz>, Andries.Brouwer@cwi.nl
Cc: Linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <UTC200102230152.CAA138669.aeb@vlet.cwi.nl> <200102232143.f1NLhG202360@sucky.fish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102232143.f1NLhG202360@sucky.fish>; from Ralph Loader on Sat, Feb 24, 2001 at 10:43:16AM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 10:43:16AM +1300, Ralph Loader wrote:

> A while ago I did some experimentation with simple bit-op based string
> hash functions.  I.e., no multiplications / divides in the hash loop.
> 
> The best I found was:
> 
> int hash_fn (char * p)
> {
>   int hash = 0;
>   while (*p) {
>      hash = hash + *p;
>      // Rotate a 31 bit field 7 bits:
>      hash = ((hash << 7) | (hash >> 24)) & 0x7fffffff;
>   }
>   return hash;
> }

Hmm. This one goes in the "catastrophic" category.

For actual names:

N=557398, m=51 sz=2048, min 82, max 4002, av 272.17, stddev 45122.99

For generated names:

N=557398, m=51 sz=2048, min 0, max 44800, av 272.17, stddev 10208445.83

A very non-uniform distribution.

> The rotate is equivalent to a multiplication by x**7 in Z_2[P=0],
> where P is the polynomial x**31 - 1 (over Z_2).
> Presumably the "best" P would be irreducible - but that would have more
> bits set in the polynomial, making reduction harder.  A compromise is to
> choose P in the form x**N - 1 but with relatively few factors.
> X**31 - 1 is such a P.

It has seven irreducible factors. Hardly "almost irreducible".

Shifting the 7-bit ASCII characters over 7 bits makes sure that there
is very little interaction to start with. And the final AND that truncates
to the final size of the hash chain kills the high order bits.
No good.

Andries


