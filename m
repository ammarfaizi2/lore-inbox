Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDWQVX>; Mon, 23 Apr 2001 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132801AbRDWQVN>; Mon, 23 Apr 2001 12:21:13 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:52405 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S131669AbRDWQVE>; Mon, 23 Apr 2001 12:21:04 -0400
Message-ID: <3AE4564D.30141A58@mvista.com>
Date: Mon, 23 Apr 2001 09:20:29 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Ramos <marcus@ansp.br>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the precision of usleep ?
In-Reply-To: <3AE07A5A.C5BBE59C@ansp.br> <3AE2B6CC.1D1F8A10@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Marcus Ramos wrote:
> >
> > Hello,
> >
> > I am using usleep in an application under RH7 kernel 2.4.2. However,
> > when I bring its argument down to 20 miliseconds (20.000 microseconds)
> > or less, this seems to be ignored by the function (or the machine's hw
> > timer), which behaves as if 20 ms where its lowest acceptable value. How
> > can I measure the precision of usleep in my box ? I am currently using
> > an Dell GX110 PIII 866 MHz.
> >
> > Thanks in advance.
> > Marcus.
> 
> Well, first, your issue is resolution, not precision.  Current
> resolution on most all timers is 1/HZ.  So this should get a min.
> nanosleep of 10 ms.
> 
> So, could someone explain this line from sys_nanosleep() (
> kernel/timer.c):
> 
>         expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
> 
> It seems to me this should just be:
> 
>         expire = timespec_to_jiffies(&t)
> 
Oh darn!  Must NOT do posts at 4AM!  

The standard says nanosleep MUST wait at LEAST the requested time. 
Since we are dealing with a 1/HZ time resolution (tick) the actual time
waited MUST fall between 10 and 20 ms.  Depending on if your code is
synced to the system clock or not you may see times closer to one end of
this range.  If you are not synced to the clock the average wait should
be about 15 ms.  (Note, locking to the clock in some way is relatively
hard to get away from.  After all this is the same clock that is used
for time slicing.)

George
