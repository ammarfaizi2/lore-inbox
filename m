Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267952AbTBYPU2>; Tue, 25 Feb 2003 10:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbTBYPU2>; Tue, 25 Feb 2003 10:20:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27659 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267952AbTBYPU0>; Tue, 25 Feb 2003 10:20:26 -0500
Date: Tue, 25 Feb 2003 07:27:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Schwab <schwab@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <je7kbo5y9y.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0302250712110.10210-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Andreas Schwab wrote:
> |> 
> |> The point is that the compiler should see that the run-time value of i is 
> |> _obviously_never_negative_ and as such the warning is total and utter 
> |> crap.
> 
> This requires a complete analysis of the loop body, which means that the
> warning must be moved down from the front end (the common type of the
> operands only depends on the type of the operands, not of any current
> value of the expressions).

So? Gcc does that anyway. _Any_ good compiler has to.

And if the compiler isn't good enough to do it, then the compiler 
shouldn't be warning about something that it hasn't got a clue about.

> |>    and anybody who writes 'array[5UL]' is considered a stupid git and a 
> |>    geek. Face it.
> 
> But array[-1] is wrong.  An array can never have a negative index (I'm
> *not* talking about pointers).

You're wrong.

Yes, when declaring an array, you cannot use "array[-1]". But that's not 
because the thing is unsigned: the standard says that the array 
declaration has to be a "integer value larger than zero". It is not 
unsigned: it's _positive_.

However, in _indexing_ an array (as opposed to declaring it), "array[-1]" 
is indeed perfectly fine, and is defined by the C language to be exactly 
the same as "*(array-1)". And negative values are perfectly fine, even for 
arrays. Trivial example:

	int x[2][2];

	int main(int argc, char **argv)
	{
		return x[1][-1];
	}


the above is actually a well-defined C program, and 100%
standards-conforming ("strictly conforming").

		Linus

