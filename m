Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRHBE2Q>; Thu, 2 Aug 2001 00:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268696AbRHBE2G>; Thu, 2 Aug 2001 00:28:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34570 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268691AbRHBE2B>; Thu, 2 Aug 2001 00:28:01 -0400
Date: Thu, 2 Aug 2001 01:28:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: george anzinger <george@mvista.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B68728C.7D23FFBC@mvista.com>
Message-ID: <Pine.LNX.4.33L.0108020126290.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, george anzinger wrote:
> Chris Friesen wrote:
> > george anzinger wrote:
> >
> > > The testing I have done seems to indicate a lower overhead on a lightly
> > > loaded system, about the same overhead with some load, and much more
> > > overhead with a heavy load.  To me this seems like the wrong thing to
> >
> > What about something that tries to get the best of both worlds?  How about a
> > tickless system that has a max frequency for how often it will schedule?  This
>
> How would you do this?  Larger time slices?  But _most_ context
> switches are not related to end of slice.  Refuse to switch?
> This just idles the cpu.

Never set the next hit of the timer to (now + MIN_INTERVAL).

This way we'll get to run the current task until the timer
hits or until the current task voluntarily gives up the CPU.

We can check for already-expired timers in schedule().

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

