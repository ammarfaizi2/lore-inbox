Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbUADIt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 03:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUADItz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 03:49:55 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:22977
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264464AbUADItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 03:49:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Date: Sun, 4 Jan 2004 19:49:27 +1100
User-Agent: KMail/1.5.3
Cc: Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401041242.47410.kernel@kolivas.org> <1073203762.9851.394.camel@localhost>
In-Reply-To: <1073203762.9851.394.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401041949.27408.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 19:09, Soeren Sonnenburg wrote:
> On Sun, 2004-01-04 at 02:42, Con Kolivas wrote:
> > Not quite. The scheduler retains high priority for X for longer so it's
> > no new dynamic adjustment of any sort, just better cpu usage by X (which
> > is why it's smoother now at nice 0 than previously).
>
> But why is i.e. running the command a second or third time much faster
> compared with the first run ? Does X get less priority then ?

Yes. X retains high priority for longer than previous scheduler designs.

> > > If either the scheduler or xterm was a bit smarter or
> > > used different thresholds, the problem would go away. It would also
> > > explain why there are people who cannot reproduce it. Perhaps a
> > > somewhat faster or slower system makes the problem go away. Honnestly,
> > > it's the first time that I notice that my xterms are jump-scrolling, it
> > > was so much fluid anyway.
> >
> > Very thorough but not a scheduler problem as far as I'm concerned. Can
> > you not disable smooth scrolling and force jump scrolling?
>
> I think it is a schedulers problem as it works if you run the program in
> question often enough (dmesg/find/whatever). Suddenly it comes back to
> full scrolling speed.
>
> Judging from the xfree4.3 xterm sources this is the function that gets
> called when there is something to scroll. And it looks perfectly ok to
> *me* as it scrolls amount lines at once. So the output of (dmesg/...)
> seems to be received slower or xterm updates more often than in 2.4.
> leading to fewer lines to scroll (== amount). It cannot be xterm
> updating more often as it would a) be faster than and b) amount would be

It's a timing issue. X gets more priority for longer than previously so X gets 
to do more work.

> >>> 1 on later on which would lead to high scrolling speed again.
>
> So IMHO it must be the output of the program that is coming in slowly.
>
> I added a fprintf(stderr, "%d\n", amount); to that code and indeed
> amount was *always* 1 no matter what I did (it even was 1 when the
> (dmesg/...) output came in fast). And jump scrolling would take place if
> amount > 59 in my case... can this still be not a schedulers issue ?
>

> Looking at that how can it not be a scheduling problem ....

Scheduling problem, yes; of a sort.

Solution by altering the scheduler, no. 

My guess is that turning the xterm graphic candy up or down will change the 
balance. Trying to be both gui intensive and a console is where it's 
happening. On some hardware you are falling on both sides of the fence with 
2.6 where previously you would be on one side.

Con

