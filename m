Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311068AbSCHUlx>; Fri, 8 Mar 2002 15:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311079AbSCHUlo>; Fri, 8 Mar 2002 15:41:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49395 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311068AbSCHUli>;
	Fri, 8 Mar 2002 15:41:38 -0500
Message-ID: <3C8921AB.6DC37849@mvista.com>
Date: Fri, 08 Mar 2002 12:40:11 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: gettimeofday() system call timing curiosity
In-Reply-To: <Pine.LNX.3.95.1020308134552.6627A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 8 Mar 2002, Jamie Lokier wrote:
> 
> > Jamie Lokier wrote:
> > > It takes the median of 1000 samples of the TSC time taken to do a
> > > rdtsc/gettimeofday/rdtsc measurement, then uses that as the threshold
> > > for deciding which of the subsequent 1000000 measurements are accepted.
> > > Then linear regression through the accepted points.
> > >
> > > I see a couple of results there which suggests a probable fault in the
> > > filtering algorithm.  Perhaps it should simply use the smallest TSC time
> > > taken as the threshold.
> >
> > I've looked more closely.  Of all the machines I have access to, only my
> > laptop shows the anomolous measurements.
> >
> > It turns out that the median of "time in TSC cycles to do a
> > rdtsc+gettimeofday+rdtsc measurement" varies from run to run.  It only
> > varies between two values, though.
> >
> [SNIPPED...]
> 
> The following program clearly shows that Linux will not return the
> same gettimeofday values twice in succession. Since it provably takes
> less than 1 microsecond to make a system call on a modern machine,
> Linux must be waiting within the gettimeofday procedure long enough
> to make certain that the time has changed. This may be screwing up
> any performance measurments made with gettimeofday().
> 
Balderdash!!  It is easy to do if you machine is fast enough.  On my
800MHZ PIII gettimeofday take about 0.7 micro seconds min. over about
100 calls, NO loop overhead.  

-g

> #include <stdio.h>
> #include <sys/time.h>
> 
> int main(void);
> int main()
> {
>    struct timeval tv, pv;
>    tv.tv_sec  = tv.tv_usec = pv.tv_sec = pv.tv_usec = 0;
>    for(;;)
>    {
>         (void)gettimeofday(&tv, NULL);
>         if((tv.tv_sec != pv.tv_sec) || (tv.tv_usec != pv.tv_usec))
>             printf("sec = %ld usec = %ld\n", tv.tv_sec, tv.tv_usec);
>          else
>             puts("The same!");
>          pv = tv;
>    }
>    return 0;
> }
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> 
>         Bill Gates? Who?

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
