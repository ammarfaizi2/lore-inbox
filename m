Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHBRrb>; Thu, 2 Aug 2001 13:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269029AbRHBRrV>; Thu, 2 Aug 2001 13:47:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20729 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S267534AbRHBRrK>; Thu, 2 Aug 2001 13:47:10 -0400
Message-ID: <3B699207.84058325@mvista.com>
Date: Thu, 02 Aug 2001 10:46:47 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.30.0108021154410.2340-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Thu, 2 Aug 2001, george anzinger wrote:
> 
> > Ok, but then what?  The head timer expires.  Now what?  Since we are not
> > clocking the slice we don't know when it started.  Seems to me we are
> > just shifting the overhead to a different place and adding additional
> > tests and code to do it. The add_timer() code is fast.  The timing
> > tests (800MHZ PIII) show the whole setup taking an average of about 1.16
> > micro seconds.  the problem is that this happens, under kernel compile,
> > ~300 times per second, so the numbers add up.
> 
> As you said, most of those 'time to reschedule' timers never expire - we
> hit a rescheduling point first, yes? In the old system, we essentially had
> one 'time to reschedule' timer pending at any given time, I'm just trying
> to approximate that.
> 
> > Note that the ticked
> > system timer overhead (interrupts, time keeping, timers, the works) is
> > about 0.12% of the available cpu.  Under heavy load this raises to about
> > 0.24% according to my measurments.  The tick less system overhead under
> > the same kernel compile load is about 0.12%.  No load is about 0.012%,
> > but heavy load can take it to 12% or more, most of this comming from the
> > accounting overhead in schedule().  Is it worth it?
> 
> Does the higher timer granularity cause overall throughput to improve, by
> any chance?
> 
Good question.  I have not run any tests for this.  You might want to do
so.  To do these tests you would want to build the system with the tick
less timers only and with the instrumentation turned off.  I would like
to hear the results.

In the mean time, here is a best guess.  First, due to hardware
limitations, the longest time you can program the timer for is ~50ms. 
This means you are reducing the load by a factor of 5.  Now the load
(i.e. timer overhead) is ~0.12%, so it would go to ~0.025%.  This means
that you should have about 0.1% more available for thru put.  Even if we
take 10 times this to cover the cache disruptions that no longer occur,
I would guess a thru put improvement of no more than 1%.  Still,
measurements are better that guesses...

George
