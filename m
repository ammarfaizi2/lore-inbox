Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbRCBUNF>; Fri, 2 Mar 2001 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCBUM4>; Fri, 2 Mar 2001 15:12:56 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:55232 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129456AbRCBUMn>; Fri, 2 Mar 2001 15:12:43 -0500
Message-ID: <3A9FFDE4.ADC8A7AB@mvista.com>
Date: Fri, 02 Mar 2001 12:09:08 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Christopher Friesen <cfriesen@nortelnetworks.com>,
        John Being <olonho@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen  
 similar          problem on PPC
In-Reply-To: <Pine.LNX.3.95.1010302141102.9090A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 2 Mar 2001, george anzinger wrote:
> 
> > "Richard B. Johnson" wrote:
> 
~snip~

> > > Note that two subsequent calls to gettimeofday() must not return the
> > > same time even if your CPU runs infinitely fast. I haven't seen any
> > > kernel in the past few years that fails this test.
> >
> > Oh!  With only micro second resolution how is this avoided?  The only
> > "legal" thing to do to avoid this is for the fast boxes to loop until
> > the requirement is satisfied.  Is this really done?
> >
> > George
> >
> 
> Yes and no. It takes microseconds to call the kernel for anything (time
> getpid() ), so it seldom loops. All the kernel has to do is remember
> the last value returned. If the time isn't past that time yet, bump
> that value and return it instead of waiting.
> 
Well, "has to do" and "does" are two different animals.  My reading of
the code shows that it does not.  I have a bit of code that does
gettimeofday() calls as fast as possible and on some boxes (ix86) have
seen the difference as low as 1 micro second.  It is not beyond
imagination that a box might return the same time two times in a row
given the processors performance increases we are seeing.  I, for one,
don't find this objectionable.  I WILL take exception to time running
backward, however.  (I don't see how this is avoided on the leap second
delete, but I have just started looking at this issue.)  As to returning
a time in the future as you suggest, I think this is a bad policy.  If
the box can actually do two gettimeofdays in one micro second or less,
it SHOULD return the same time (given the resolution can not resolve the
difference).  If this becomes an issue, and it will, those that care
should use the clock_gettime() call which should return time in nano
seconds.  This is part of the POSIX standard code for which we are
working on at:


http://sourceforge.net/projects/high-res-timers/

George
