Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbRFVFUP>; Fri, 22 Jun 2001 01:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265340AbRFVFT4>; Fri, 22 Jun 2001 01:19:56 -0400
Received: from web11208.mail.yahoo.com ([216.136.131.190]:27909 "HELO
	web11208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265336AbRFVFTq>; Fri, 22 Jun 2001 01:19:46 -0400
Message-ID: <20010622051945.17358.qmail@web11208.mail.yahoo.com>
Date: Thu, 21 Jun 2001 22:19:45 -0700 (PDT)
From: Chester Lott <sjdevnull@yahoo.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
To: linux-kernel@vger.kernel.org
Cc: rok.papez@kiss.uni-lj.si
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rok papez <rok.papez@kiss.uni-lj.si> wrote:
>On Tuesday 19 June 2001 18:09, Larry McVoy wrote:
>> "If you think you need threads then your processes are too fat"
>> ``Think of it this way: threads are like salt, not like pasta You
>> like salt, I like salt, we all like salt. But we eat more pasta.''

> Here are more from the same basket you obviously got the first 
> quote from:
[SNIP]
> Protected memory is a constant 10% CPU hog needed only by
undisciplined
> programmers who can't keep their memory writes in their own process
space.

Now that's the primary reason to avoid threads, IMO.  People
spent years trying to get protected memory; the only real
difference between threads and processes is that you throw
protected memory out the window.  Yes, the pthread API sucks;
yes, there are times when threads are appropriate.

If only:
1) Microsoft, Sun, and others didn't have such abysmal
context switch numbers that people view threads vs. 
processes as a performance argument;
2) MS didn't conflate fork() and exec() into one 
CreateProcess() call; and
3) Java and others exposed rational event-driven APIs that
didn't require multiple contexts of execution in weird places
(1.4 is finally fixing this one anyway)

then people might be able to really see that:
1) You usually don't need that many contexts of execution; and
2) Processes should be considered the primary COEs and threads
only used when you really need to share almost all of your
memory.

That's aside from all the arguments against multithreading
just based on elegance and code correctness POVs.  Even if
writing multithreaded code is marginally easier than writing
poll()-based code, actually debugging it is a royal PITA.
Coroutines (which aren't Alan's, Knuth had them long before
Alan and even he was just rehashing old news) and state
machines really are better in many cases.

About the only criticism I have of Alan's statement that
"threads are for people who can't program state machines" is
the implication that threads are an easier API to get right.
They aren't.  They seem that way, but by tossing protected
memory and introducing multiple COEs you get into a whole
world of non-obvious problems that are very difficult to
debug and often nearly impossible to reproduce in 
non-production environments.

The salt quote I like; it allows for the sparing use of
threads, but warns against their over(ab)use.

Ah, well.

  Sumner

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
