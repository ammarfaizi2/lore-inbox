Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130952AbRCJHUV>; Sat, 10 Mar 2001 02:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130953AbRCJHUL>; Sat, 10 Mar 2001 02:20:11 -0500
Received: from relay8.Austria.EU.net ([193.154.160.146]:1186 "EHLO
	relay8.austria.eu.net") by vger.kernel.org with ESMTP
	id <S130952AbRCJHUB>; Sat, 10 Mar 2001 02:20:01 -0500
Message-ID: <3AA9D575.1345EF2@eunet.at>
Date: Sat, 10 Mar 2001 08:19:17 +0100
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep question
In-Reply-To: <3AA607E7.6B94D2D@eunet.at> <3AA936B2.D2F26847@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Michael Reinelt wrote:
> >
> > At the moment I implemented by own delay loop using a small assembler
> > loop similar to the one used in the kernel. This has two disadvantages:
> > assembler isn't that portable, and the loop has to be calibrated.
> 
> Why not use C?  As long as you calibrate it, it should do just fine.
Because the compiler might optimize it away.

> On
> the other hand, since you are looping anyway, why not loop on a system
> time of day call and have the loop exit when you have the required time
> in hand.  These calls have microsecond resolution.
I'm afraid they don't (at least with kernel 2.0, I didn't try this with
2.4). They have microsecond resolution, but increment only every 1/HZ.

Someone gave me a hint to loop on rdtsc. I will look into this.

> > - why are small delays only possible up to 2 msec? what if I needed a
> > delay of say 5msec? I can't get it?
> 
> If you want other times, you can always make more than one call to
> nanosleep.
Good point!

> The question is: Can your task
> stand the loss of the processor to another task?  This is what happens
> at normal SCHED_OTHER priority.

Yes, it can. My delays are 'minimal' values, if it takes longer, there's
no problem apart from the speed of the display update. I have to wait 40
microsecs after every character I send to the display, which makes 3.2
milliseconds for a complete update of a 20x4 display. If every delay
would be 10 msec, the whole update would last 0.8 seconds (which is
unusable).

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
