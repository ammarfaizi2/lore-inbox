Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135325AbRDLVTj>; Thu, 12 Apr 2001 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135326AbRDLVT3>; Thu, 12 Apr 2001 17:19:29 -0400
Received: from anarchy.io.com ([199.170.88.101]:3869 "EHLO anarchy.io.com")
	by vger.kernel.org with ESMTP id <S135325AbRDLVTN>;
	Thu, 12 Apr 2001 17:19:13 -0400
Date: Thu, 12 Apr 2001 16:19:10 -0500 (CDT)
From: Bret Indrelee <bret@io.com>
To: george anzinger <george@mvista.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer!
In-Reply-To: <3AD5E852.687DBC09@mvista.com>
Message-ID: <Pine.LNX.4.21.0104121606360.10006-100000@fnord.io.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, george anzinger wrote:
> Bret Indrelee wrote:
> > Keep all timers in a sorted double-linked list. Do the insert
> > intelligently, adding it from the back or front of the list depending on
> > where it is in relation to existing entries.
> 
> I think this is too slow, especially for a busy system, but there are
> solutions...

It is better than the current solution.

The insert takes the most time, having to scan through the list. If you
had to scan the whole list it would be O(n) with a simple linked list. If
you insert it from the end, it is almost always going to be less than
that.

The time to remove is O(1).

Fetching the first element from the list is also O(1), but you may have to
fetch several items that have all expired. Here you could do something
clever. Just make sure it is O(1) to determine if the list is empty.

[ snip ]
> > The real trick is to do a lot less processing on every tick than is
> > currently done. Current generation PCs can easily handle 1000s of
> > interrupts a second if you keep the overhead small.
> 
> I don't see the logic here.  Having taken the interrupt, one would tend
> to want to do as much as possible, rather than schedule another
> interrupt to continue the processing.  Rather, I think you are trying to
> say that we can afford to take more interrupts for time keeping.  Still,
> I think what we are trying to get with tick less timers is a system that
> takes FEWER interrupts, not more.

The system should be CAPABLE of handling 1000s of interrupts without
excessive system load.

The actual number of interrupts would be reduced if we adjusted the
interrupt interval based on the head of the list.

Two different things.

-Bret

------------------------------------------------------------------------------
Bret Indrelee |  Sometimes, to be deep, we must act shallow!
bret@io.com   |  -Riff in The Quatrix

