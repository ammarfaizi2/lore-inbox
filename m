Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268807AbRHBGEO>; Thu, 2 Aug 2001 02:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbRHBGED>; Thu, 2 Aug 2001 02:04:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53998 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268807AbRHBGDx>; Thu, 2 Aug 2001 02:03:53 -0400
Message-ID: <3B68ED37.BB46A1AD@mvista.com>
Date: Wed, 01 Aug 2001 23:03:35 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.33L.0108020126290.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 1 Aug 2001, george anzinger wrote:
> > Chris Friesen wrote:
> > > george anzinger wrote:
> > >
> > > > The testing I have done seems to indicate a lower overhead on a lightly
> > > > loaded system, about the same overhead with some load, and much more
> > > > overhead with a heavy load.  To me this seems like the wrong thing to
> > >
> > > What about something that tries to get the best of both worlds?  How about a
> > > tickless system that has a max frequency for how often it will schedule?  This
> >
> > How would you do this?  Larger time slices?  But _most_ context
> > switches are not related to end of slice.  Refuse to switch?
> > This just idles the cpu.
> 
> Never set the next hit of the timer to (now + MIN_INTERVAL).
> 
> This way we'll get to run the current task until the timer
> hits or until the current task voluntarily gives up the CPU.

The overhead under load is _not_ the timer interrupt, it is the context
switch that needs to set up a "slice" timer, most of which never
expire.  During a kernel compile on an 800MHZ PIII I am seeing ~300
context switches per second (i.e. about every 3 ms.)   Clearly the
switching is being caused by task blocking.  With the ticked system the
"slice" timer overhead is constant.
> 
> We can check for already-expired timers in schedule().

Delaying "alarm" timers is bad form.  
Especially for someone who is working on high-res-timers :)

George
