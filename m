Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269210AbRHBWsZ>; Thu, 2 Aug 2001 18:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269207AbRHBWsQ>; Thu, 2 Aug 2001 18:48:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29692 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269203AbRHBWsI>; Thu, 2 Aug 2001 18:48:08 -0400
Message-ID: <3B69D88E.1928D287@mvista.com>
Date: Thu, 02 Aug 2001 15:47:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer ! & the tq_timer
In-Reply-To: <Pine.LNX.4.30.0108021641250.2340-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Thu, 2 Aug 2001, george anzinger wrote:
> 
> > I guess I am confused.  How is it that raising HZ improves throughput?
> > And was that before or after the changes in the time slice routines that
> > now scale with HZ and before were fixed?  (That happened somewhere
> > around 2.2.14 or 2.2.16 or so.)
> 
> My guess is that processes that are woken up for whatever reason get to
> run sooner, reducing latency, and thereby increasing throughput when not
> compute-bound. Presumably this was with shorter time slices.
> 
The only timer dependency I can see on a wake up is related to the
"tq_timer".  This is a tasklet queue that is checked each tick. 
Tasklets that are in it are then run on interrupt exit.  IMHO this whole
list should go away.  If a deferred action is actually needed, a timer
should be used to kick it off.  It should not be hooked to the tick the
way it is.  Better yet, why is it needed at all?

Comments anyone?

George
