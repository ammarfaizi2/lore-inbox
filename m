Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319336AbSIKVJ1>; Wed, 11 Sep 2002 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319337AbSIKVJ1>; Wed, 11 Sep 2002 17:09:27 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:25231 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S319336AbSIKVJ0>; Wed, 11 Sep 2002 17:09:26 -0400
Date: Wed, 11 Sep 2002 23:14:06 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209102306340.14220-300000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209112300470.22694-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Tobias Ringstrom wrote:

> On Tue, 3 Sep 2002, Ingo Molnar wrote:
> 
> > does -10 make it equivalent to the 2.4 behavior? Could you somehow measure
> > the priority where it's still acceptable? Ie. -8 or -9?
> 
> I've done some more experimenting, and I've found something interesting.  
> I've attached two very simple CPU hog programs.

...and now I've done some code study.  I think the following is what 
happens:

1. hog is sleeping, and is interactive
2. latency is running and is non-interactive
3. hog becomes runnable
4. latency is preemted and put on the expired list
5. hog runs uses it's timeslice (151 ms), but sice
   it is interactive it stays on the active list and
   continues to run.
6. after 4/11*2 s = 0.7 s (and a few expired timeslices)
   hog is no longer interactive and is moved to the
   expired list
7. latency runs after a 0.7 s break.

Do you agree?

In other words:  Any nice-0 task that has been sleeping for two seconds or
more will be able to monololize the CPU for up to 0.7 seconds.  Do you
agree that this is a problem, or am I being too narrow-minded?  :-)

/Tobias

