Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289832AbSAPDEg>; Tue, 15 Jan 2002 22:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289835AbSAPDE1>; Tue, 15 Jan 2002 22:04:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289832AbSAPDEQ>; Tue, 15 Jan 2002 22:04:16 -0500
Date: Tue, 15 Jan 2002 19:04:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>,
        Ed Tomlinson <tomlins@cam.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
In-Reply-To: <1011149980.8756.180.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201151857460.1357-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 Jan 2002, Robert Love wrote:
>
> I looked it up; its called class IA.  I don't know if it grows from a
> limitation of their scheduler (i.e. they can't calculate priority and be
> as fair to interactive tasks as us) or if it offers a fundamental
> advantage.  I suspect their are a myriad of things things we can do with
> an interactive/GUI scheduling policy.

I really doubt there is a _single_ interesting case apart from X itself.

X is kind of special, in that the X server can use a lot of CPU time if
you have people scrolling data on the screen etc, yet you want it to be
interactive because it does its own scheduling of actual user input etc.

So you can have the X server showing all the signs of a CPU hog, while
still being really important.

The current scheduler is pretty good at handling it, and since I don't
believe it is a generic problem, and since there _is_ a specific answer
for the specific case of X (ie "renice -10 X") already, I see no real
reason to have a new scheduling class.

(That said, I personally had running X _without_ the renice as my test of
scheduler interactivity goodness. It breaks down in the cases where X
really becomes CPU-bound, but if you ignore the really pathological case
where X is a CPU-hog it's a really good interactivity tester. The current
scheduler passes at least my personal criteria with flying colors in this
sense).

In short: I don't want to need to renice X to get good interactive
behaviour under any normal load, but I want even _less_ to start making up
scheduler classes for it.

		Linus

