Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270269AbUJTBIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270269AbUJTBIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270260AbUJTBGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:06:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3323 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269536AbUJTBAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:00:52 -0400
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1098233967.20778.93.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 19 Oct 2004 17:59:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 17:42, Tim Schmielau wrote:
> On Tue, 19 Oct 2004, john stultz wrote:
> 
> > On Tue, 2004-10-19 at 11:21, Jerome Borsboom wrote:
> > > Starting with kernel 2.6.9 the process start time is set wrongly for 
> > > processes that get started early in the boot process. Below is a dump from 
> > > my 'ps' command. Note the start time for processes 1-12. After process 12 
> > > the start time is set right.
> > 
> > How reproducible is this? Are the correct and incorrect time values
> > always off by the same amount? 
> > 
> > Are you running NTP? I'm curious if you are changing your system time
> > during boot. 
> 
> I'd bet that some process early in the boot adjusts your system time.

He claims that's not the case (you weren't CC'ed on his reply, but its
on lkml). He believes the time changes before NTP starts up. Might be
something else, but I'm not sure.

> Then this is expected behavior. This is why I would have preferred the 
> simple back-out patch for the boot times problem.
> 
> I'm sorry I fell of the net for so long and didn't stand up for the 
> simpler change in this case. Oh well.
> 
> I'll probably supply a back-out patch for -mm then, after wading through
> my multi-megabyte email backlog (sorry John, still need to read your time
> keeping proposal and all its discussion).

I've begun to agree with you about this issue. It seems that until we
can catch every use of jiffies for time, doing one by one is going to
cause consistency problems.  So I'd support the full backout of the
do_posix_clock_monotonic_gettime changes to the proc interface. 

George, would you protest this?

As for the timeofday overhaul, I've had zero time to work on it
recently. I hate that I dropped code and then went missing for weeks.
I'll have to see if I can get a few cycles at home to sync up my current
tree and send it out. 

thanks
-john


