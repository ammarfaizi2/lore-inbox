Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRHBRFl>; Thu, 2 Aug 2001 13:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRHBRFb>; Thu, 2 Aug 2001 13:05:31 -0400
Received: from waste.org ([209.173.204.2]:9595 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S266723AbRHBRFY>;
	Thu, 2 Aug 2001 13:05:24 -0400
Date: Thu, 2 Aug 2001 12:05:09 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B698177.C12183CF@mvista.com>
Message-ID: <Pine.LNX.4.30.0108021154410.2340-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, george anzinger wrote:

> Ok, but then what?  The head timer expires.  Now what?  Since we are not
> clocking the slice we don't know when it started.  Seems to me we are
> just shifting the overhead to a different place and adding additional
> tests and code to do it. The add_timer() code is fast.  The timing
> tests (800MHZ PIII) show the whole setup taking an average of about 1.16
> micro seconds.  the problem is that this happens, under kernel compile,
> ~300 times per second, so the numbers add up.

As you said, most of those 'time to reschedule' timers never expire - we
hit a rescheduling point first, yes? In the old system, we essentially had
one 'time to reschedule' timer pending at any given time, I'm just trying
to approximate that.

> Note that the ticked
> system timer overhead (interrupts, time keeping, timers, the works) is
> about 0.12% of the available cpu.  Under heavy load this raises to about
> 0.24% according to my measurments.  The tick less system overhead under
> the same kernel compile load is about 0.12%.  No load is about 0.012%,
> but heavy load can take it to 12% or more, most of this comming from the
> accounting overhead in schedule().  Is it worth it?

Does the higher timer granularity cause overall throughput to improve, by
any chance?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

