Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRDJQkH>; Tue, 10 Apr 2001 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132429AbRDJQj6>; Tue, 10 Apr 2001 12:39:58 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:26300 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132428AbRDJQjm>; Tue, 10 Apr 2001 12:39:42 -0400
Message-ID: <3AD33732.C4C513CE@mvista.com>
Date: Tue, 10 Apr 2001 09:39:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.21.0104101308320.11038-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 9 Apr 2001, george anzinger wrote:
> > SodaPop wrote:
> > >
> > > I too have noticed that nicing processes does not work nearly as
> > > effectively as I'd like it to.  I run on an underpowered machine,
> > > and have had to stop running things such as seti because it steals too
> > > much cpu time, even when maximally niced.
> 
> > In kernel/sched.c for HZ < 200 an adjustment of nice to tick is set up
> > to be nice>>2 (i.e. nice /4).  This gives the ratio of nice to time
> > slice.  Adjustments are made to make the MOST nice yield 1 jiffy, so
>         [snip 2.4 nice scale is too limited]
> 
> I'll try to come up with a recalculation change that will make
> this thing behave better, while still retaining the short time
> slices for multiple normal-priority tasks and the cache footprint
> schedule() and friends currently have...
> 
> [I've got some vague ideas ... give me a few hours to put them
> into code ;)]

You might check out this:

http://rtsched.sourceforge.net/

I did some work on leveling out the recalculation overhead.  I think, as
the code shows, that it can be done without dropping the run queue lock.

I wonder if the wave nature of the recalculation cycle is a problem.  By
this I mean after a recalculation tasks run for relatively long times
(50 ms today) but as the recalculation time approaches, the time reduces
to 10 ms.  Gets one to thinking about a way to come up with a more
uniform, over time, mix.

George

George
