Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRDMMPW>; Fri, 13 Apr 2001 08:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRDMMPM>; Fri, 13 Apr 2001 08:15:12 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:44732 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S129669AbRDMMPE>; Fri, 13 Apr 2001 08:15:04 -0400
Message-ID: <002d01c0c414$346b2140$6501a8c0@gonar.com>
From: "Mark Salisbury" <gonar@mediaone.net>
To: "george anzinger" <george@mvista.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andre Hedrick" <andre@linux-ide.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        <high-res-timers-discourse@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org> <m1snjdtgcc.fsf@frodo.biederman.org> <3AD6B894.39848F3F@mvista.com>
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
Date: Fri, 13 Apr 2001 08:20:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it makes the most sense to keep jiffie as a simple unsigned
> int.  If we leave drivers, and other code as is they can deal with
> single word (32 bit) values and get reasonable results.  If we make HZ
> too high (say 10,000 to get micro second resolution) we will start
> limiting the max time we can handle, in this case to about 71.5 hours.
> (Actually 1/2 this value would start giving us trouble.)  HZ only
> affects the kernel internals (the user API is either seconds/micro
> seconds or seconds/nano seconds).  For those cases where we want a higer
> resolution we just add a sub jiffie component.  Another way of looking
> at this is to set up HZ as the "normal" resolution.  This would be the
> resolution (as it is today) of the usual API calls.  Only calls to the
> POSIX 1b timers would be allowed to have higher resolution.  I propose
> that we use the POSIX standard to define "CLOCKS" with various
> resolution, with the understanding that the higher resolutions will have
> higher overhead.  An yet another consideration, to get high resolution
> with a reasonable maximum timer interval we will need to use two words
> in the timer.  I think it makes sense to use the jiffie (i.e. 1/HZ) as
> the high order part of the timer's time.
>
> Note that all of these considerations on jiffie size hold with or with
> out a tick less system.

inner loop, i.e. interrupt timer code should never have to convert from some
real time value into number of decrementer ticks in order to set up the next
interrupt as that requires devides (and 64 bit ones at that) in a tickless
system.

this is why any variable interval list/heap/tree/whatever should be kept in
local ticks.  frequently used values can be pre-computed at boot time to
speed up certain calculations (like how many local ticks/proc quantum)



