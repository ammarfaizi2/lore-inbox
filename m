Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVLaU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVLaU6y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVLaU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:58:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4538 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932100AbVLaU6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:58:53 -0500
Date: Sat, 31 Dec 2005 21:58:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Bradley Reed <bradreed1@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
In-Reply-To: <1136058696.6039.133.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512312153480.27366@yvahk01.tjqt.qr>
References: <20051231202933.4f48acab@galactus.example.org>
 <1136058696.6039.133.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?

I seriously demand that this be changed into "RTC broekn under..."! :)



>> BTW, other than MPLayer problems, everything else works great.

BTW2, 2.6.15 has an option in ALSA to use RTC as timing source 
(CONFIG_SND_RTCTIMER). I do not have it activated ATM, nor do I use it (as 
said, I used "-ao null" for mplayer), but would use of alsa with this rtc 
timesourcing also crash?


>Bradley and Jan, try the below patch and see if it doesn't deadlock the
>system. I'm not sure why they pulled out the mod_timer add_timer and
>del_timer from the rtc_lock, but there might be a call back to it.

Well, it did not deadlock my system. Interesting! It displayed "BUG", as 
posted multiple times here. Otherwise, it just oopsed. That is, I could 
continue using the system, with the exception, of course, /dev/rtc. Opening 
rtc however did not lock a process trying to do so, but instead (as 
designed in the code) returns -EBUSY.

>
>Index: linux-2.6.15-rc7-rt1/drivers/char/rtc.c

This patch fixes the rtc BUG for me.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
