Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273440AbRINRYz>; Fri, 14 Sep 2001 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273443AbRINRYq>; Fri, 14 Sep 2001 13:24:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52212 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273440AbRINRYc>; Fri, 14 Sep 2001 13:24:32 -0400
Message-ID: <3BA23D51.B456C9EE@mvista.com>
Date: Fri, 14 Sep 2001 10:24:33 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Antonios G. Danalis" <danalis@udel.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: increasing HZ in Linux kernel
In-Reply-To: <3BA134F3.FA661E9E@udel.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonios G. Danalis" wrote:
> 
> Hello,
> 
> I want to increase the frequency of the clock interrupt up
> to ~10000 to run some experiments.
> 
> In the kernel I'm using (2.4.2-2) I've noticed that
> if you increase HZ above 1536 you get a conflict with
> .../include/linux/timex.h:75-77
> and if you add some lines there, you get a problem with
> .../include/net/tcp.h:377
> when HZ is above 4096.
> 
> Is there an easy way to increase clock interrupt freq, or
> do I have to mess with the whole kernel ?
> 
The approach we are taking in the high-res-timers project
(http://sourceforge.net/projects/high-res-timers) is to leave HZ alone
and schedule timer interrupts as needed between the 1/HZ ticks.  I have
an kernel with most of the infrastructure ready to put on the
sourceforge site (today I hope), that you may want to look at.  Be
aware, however, it is not really a simple change.  You may also want to
look at the UTIME patch from the University of Kansas, which, to some
extent, is where I started.  We both leave HZ alone and schedule timer
ticks as needed to get high resolution.

As you have noted, changing HZ impacts other sub systems.  There is also
an issue of jiffie rollover which affects the longest time you can set
timers for.  Currently with HZ =100 and 32-bit integers, this is about
248.55 days.  If you move HZ to 1000, this moves to 24.855 days, and the
10,000 you want moves it to 2.4855 days which will give problems with at
least the cron sub system and probably a lot of others.

George
