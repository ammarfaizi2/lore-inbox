Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSE1T0M>; Tue, 28 May 2002 15:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316885AbSE1T0L>; Tue, 28 May 2002 15:26:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:510 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316884AbSE1T0K>;
	Tue, 28 May 2002 15:26:10 -0400
Message-ID: <3CF3D9A4.29493860@mvista.com>
Date: Tue, 28 May 2002 12:25:24 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Manik Raina <manik@cisco.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add i8253 spinlocks where needed.
In-Reply-To: <20020526142142.A17042@ucw.cz> <3CF1E296.41228517@cisco.com>
		<20020527113757.A26574@ucw.cz> <3CF20548.3ED40699@cisco.com> 
		<20020527121001.B26811@ucw.cz> <1022500580.11859.252.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-05-27 at 11:10, Vojtech Pavlik wrote:
> > Well, probably yes, but still hd.c is a glacial relict, a driver nobody
> > (almost - it's for non-IDE "two ribbon" AT harddrives) uses. So this
> > driver is probably not enough justification for a global (as in all
> > archs) spinlock being added.
> 
> It only uses the timer in the case that HD_DELAY > 0. This code is
> ultimately used for timing functions. A better approach would be to
> remove the use of the timer chip from the file entirely and use the
> perfectly adequate udelay() function instead.
> 
> That would also conveniently make it do cpu_relax properly improving the
> performance of your ancient IDE controller when plugged into
> hyperthreading pentium IV 8)
> 
It would also allow the high-res-timers to "mess" with the
timer (as it does) to generate sub-jiffie interrupts. 
Actually, I would prefer moving the timer out of the general
code and making what ever uses it has come thru an
abstraction that hides exactly how it is done or even if it
access the timer chip or uses some other time source.  This
could also be done accross archs.  It is also possible that
code such as udelay() and friends already do all that is
needed.  In short, I think the clock code should "own" the
timer and others should have to use what ever the clock code
exports.


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
