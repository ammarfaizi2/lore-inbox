Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSFRSUX>; Tue, 18 Jun 2002 14:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSFRSUW>; Tue, 18 Jun 2002 14:20:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1022 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317538AbSFRSUT>;
	Tue, 18 Jun 2002 14:20:19 -0400
Message-ID: <3D0F79CA.A0FAC230@mvista.com>
Date: Tue, 18 Jun 2002 11:19:54 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <200206180516.JAA11563@sex.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > This patch replaces the timer_bh with a tasklet.
> 
> But this is impossible, timers must not race with another BHs,
> all the code using BHs depends on this. That's why they are BHs.

If indeed they do "race" the old code had the timer_bh being first.
So does this patch.
> 
> Also, looping for timers seems to be pure pathalogy.
> It can be raised only if you looped in softirq for a jiffie,
> in this case waking ksoftirqd is not unusual.

This is one of the most hard to control paths in the system as ALL it 
does is execute functions that are unknown as to size, duration, etc.
One would hope that they never run for long, but...

> 
> I feel your goal is high res timers, right? You can do them separately
> to avoid conflicts with classic timers.

Not really.  One REALLY expects timers to expire in timed order :)  Using
a separate procedure to deliver a timer just because it is of a different
resolution opens one up to a world of pathology.
> 
> Alexey

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
