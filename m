Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTBXWeg>; Mon, 24 Feb 2003 17:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTBXWeg>; Mon, 24 Feb 2003 17:34:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38417 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261495AbTBXWee>; Mon, 24 Feb 2003 17:34:34 -0500
Date: Mon, 24 Feb 2003 14:39:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Schwab <schwab@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <jeu1et5o4i.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Andreas Schwab wrote:
> 
> But that's not the point.  It's the runtime value of i that gets converted
> (to unsigned), not the compile time value of COUNT.  Thus if i ever gets
> negative you have a problem.

The point is that the compiler should see that the run-time value of i is 
_obviously_never_negative_ and as such the warning is total and utter 
crap.

The compiler actually does end up doing some of that kind of analysis when
optimizing, since it is required for some of the loop optimizations 
anyway. But the warning is emitted before the analysis has taken place.

In other words, gcc is stupidly warning about something that is obviously 
not an error. And it is obviously not an error because:

 - array indexes are "int". They aren't size_t, and never have been. Thus 
   it is _correct_ to use "int" for the index. You write

	int array[5];

   and you do NOT write

	int array[5UL];

   and anybody who writes 'array[5UL]' is considered a stupid git and a 
   geek. Face it.

   Claiming that you should index an array with a size_t is crap.

 - the way this has traditionally always been done is the example I 
   posted. Warning about correct, obvious, and traditional code is WRONG, 
   if it causes the programmer to have to write something _less_ obvious
   just to make a stupid compiler warning go away makes the warnign WORSE 
   THAN USELESS.

And yes, gcc could do the work necessary to only give the warning if it 
actually has reason to believe that the code is wrong. As it is, it gives 
the warning for code that is good.

		Linus

