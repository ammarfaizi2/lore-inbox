Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268960AbRHBOju>; Thu, 2 Aug 2001 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268961AbRHBOjk>; Thu, 2 Aug 2001 10:39:40 -0400
Received: from waste.org ([209.173.204.2]:35418 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S268960AbRHBOjW>;
	Thu, 2 Aug 2001 10:39:22 -0400
Date: Thu, 2 Aug 2001 09:39:02 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B68ED37.BB46A1AD@mvista.com>
Message-ID: <Pine.LNX.4.30.0108020928230.2340-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, george anzinger wrote:

> > Never set the next hit of the timer to (now + MIN_INTERVAL).
>
> The overhead under load is _not_ the timer interrupt, it is the context
> switch that needs to set up a "slice" timer, most of which never
> expire.  During a kernel compile on an 800MHZ PIII I am seeing ~300
> context switches per second (i.e. about every 3 ms.)   Clearly the
> switching is being caused by task blocking.  With the ticked system the
> "slice" timer overhead is constant.

Can you instead just not set up a reschedule timer if the timer at the
head of the list is less than MIN_INTERVAL?

if(slice_timer_needed)
{
	if(time_until(next_timer)>TASK_SLICE)
	{
		next_timer=jiffies()+TASK_SLICE;
		add_timer(TASK_SLICE);
	}
	slice_timer_needed=0;
}

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

