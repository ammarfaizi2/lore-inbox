Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136653AbRATGaT>; Sat, 20 Jan 2001 01:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136725AbRATGaJ>; Sat, 20 Jan 2001 01:30:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47371 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136653AbRATG35>; Sat, 20 Jan 2001 01:29:57 -0500
Date: Fri, 19 Jan 2001 22:29:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mark I Manning IV <mark4@purplecoder.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding Style
In-Reply-To: <3A68E309.2540A5E1@purplecoder.com>
Message-ID: <Pine.LNX.4.10.10101192217390.9361-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Mark I Manning IV wrote:
> 
> Two spaces are perfect, they delineate the blocks very nicely and dont
> eat up the comments real estate.

WHAT "comments real estate". You have tons of real estate - up and down.
Don't try to move it sideways where it won't fit anyway.

Write comments before your function. If your function is so long and
complicated that you think it needs comments after the lines, then you
should have split it up. See "function growth hormone imbalance".

> > And two spaces is not enough. If you write code that needs comments at
> > the end of a line, your code is crap.
> 
> Might i ask you to qualify that statement ?

Ok. I'll qualify it. Add a "unless you write in assembly language" to the
end. I have to admit that most assembly languages are terse and hard to
read enough that you often want to comment at the end. In assembly you
just don't tend to have enough flexibility to make the code readable, so
you must live with unreadable code that is commented.

> I disagree, comments should be associated with the code they are
> describing, putting a block of comments before a function telling people
> waht it does does nothign to tell them HOW it does it.  

Just add a "how it does it" section to your comment.

Or add your comments inside the function if you really want to localize
them, but do it something like this:

	/*
	 * my_integer_pi()
	 *
	 * This function calculates the value of PI, and returns
	 * 3. It does so by adding "1" in a loop three times.
	 */
	int my_integer_pi(void)
	{
		int i, pi;

		/*
		 * This is the main loop.
		 */
		pi = 0;
		for (i = 0; i < 3; i++)
			pi++;

		/* Ok, return it */
		return pi;
	}

Notice? Not AFTER the statements. 

Why? Because you are likely to want to change the statements. You don't
want to keep moving the comments around to line them up. And trying to
have a multi-line comment with code is just HORRIBLE:

		pi = 0;			/* Initialize our counter  */
		for (i = 0; i < 3; i++)	/* to zero before the loop */
			pi++;		/* Increment it.	   */

because the above turns into absolute mush if you change your code a bit
(maybe you decide to move the initialization up a bit, because you make
your function start off with a better approximation, and you want to use
another algorithm to calculate PI to more than zero decimal points. Now
you need to move the two-line comment around, and break it up etc etc.

In contrast, when you have comments on lines of their own, you just move
the whole comment block when you re-organize the code.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
