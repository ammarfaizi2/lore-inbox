Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317873AbSGKTOd>; Thu, 11 Jul 2002 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSGKTOc>; Thu, 11 Jul 2002 15:14:32 -0400
Received: from iris.mc.com ([192.233.16.119]:17609 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S317873AbSGKTO3>;
	Thu, 11 Jul 2002 15:14:29 -0400
Message-Id: <200207111916.PAA08197@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: george anzinger <george@mvista.com>, dank@kegel.com
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as  small as possible)
Date: Thu, 11 Jul 2002 15:19:01 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3D2DB5F3.3C0EF4A2@kegel.com> <3D2DD734.5A3CA6EB@mvista.com>
In-Reply-To: <3D2DD734.5A3CA6EB@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george, 

	with the HRT is there any reason to have 10 timer interrupts per process 
quantum anymore? (10 ms ticks, 100 ms proc quantum)



On Thursday 11 July 2002 15:06, george anzinger wrote:
> Ah, but you haven't looked at all that happens on a 1/HZ
> tick.  The high-res-timers patch does NOT eliminate the 1/HZ
> tick.  That tick is used to do a LOT of accounting activity
> which IMHO is best done by a periodic tick.  In particular,
> the time slice and execution time management depend on the
> periodic tick.  As a test we put together a tickless system,
> much as suggested above, and put enough stuff in it to see
> what the overhead was and how it changed.  The conclusion
> was that the timer over head increased far beyond the
> current overhead as soon as the system load (actually the
> number of context switches per second) increased beyond what
> a moderately busy system experiences.  In other words, the
> system was overload prone.  The current accounting activity
> is flat WRT to context switching which is IMHO just what it
> should be.  For those who want to know, a patch to put that
> test system together is still on the HRT sourceforge site.
>
> -g
>
> > OK, so I'm just an ignorant member of the peanut gallery, but
> > I'd like to hear a real kernel hacker explain why this isn't
> > the way to go.
> >
> > - Dan

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
