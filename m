Return-Path: <linux-kernel-owner+w=401wt.eu-S1753060AbXABQ5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbXABQ5h (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXABQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:57:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44380 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbXABQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:57:36 -0500
Date: Tue, 2 Jan 2007 08:57:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [ARM] Regression somewhere between 2.6.19 and 2.6.19-rc1
In-Reply-To: <20070102163923.GB12902@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0701020850150.4473@woody.osdl.org>
References: <20070102163923.GB12902@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2007, Russell King wrote:
>
> How do I tell git bisect "I can't test this, this is neither good nor bad,
> please choose another to try" ?  Or is git bisect hopeless given the large
> amount of unbuildable commits thanks to our weekly merges?

The easiest way to do this is to start off with

	git bisect visualize

which will just show you all the potentially interesting commits, and you 
can just browse it for commits that you deem to be (a) ok to try and (b) 
hopefully _somewhat_ central to bisection (ie if you pick something that 
is very close to one of the already-checked points, the efficiency of 
bisection drops a lot - it will still _work_, but if it's not "near the 
middle of the pack" it simply won't be very efficient any more.

And then just do

	git reset --hard <hand-picked-point>

and off you go. Compile, test, and do "git bisect bad/good" (at which 
point "git bisect" will again pick a half-way point automatically for you, 
but hopefully you'll have gotten out of the problematic region so you 
don't need to override it by hand any more. But you _can_ always override 
it, of course).

You can also use the "git reset --hard xyzzy" overrides in case you have a 
suspicion about where things happen, and you want to narrow things down by 
hand by testing a point closer to the suspicious area. Usually the 
bisection is very efficient, but if you have a good clue where the problem 
happens, pointing in the right direction and trying to force bisection to 
look at a special place will obviously help further.

Of course, if your "good clue" was actually garbage, you'll just make 
bisection take longer instead ;)

		Linus
