Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUA2CWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 21:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUA2CWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 21:22:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10204 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266142AbUA2CWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 21:22:30 -0500
Subject: Re: 2.6.1: process start times by procps
From: john stultz <johnstul@us.ibm.com>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040127155254.GA1656@elektroni.ee.tut.fi>
References: <20040123194714.GA22315@elektroni.ee.tut.fi>
	 <20040125110847.GA10824@elektroni.ee.tut.fi>
	 <20040127155254.GA1656@elektroni.ee.tut.fi>
Content-Type: text/plain
Message-Id: <1075342912.1592.72.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jan 2004 18:21:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 07:52, Petri Kaukasoina wrote:
> On Sun, Jan 25, 2004 at 01:08:47PM +0200, I wrote:
> > On Fri, Jan 23, 2004 at 09:47:14PM +0200, I wrote:
> > > For example, I started this bash process really at 21:24 (date showed 21:24
> > > then):
> > > 
> > > kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash
> > 
> > OK, I would like to make my bug report more accurate: the problem seems to
> > be that the value of btime in /proc/stat is not correct.
> 
> btime in /proc/stat does not stay constant but decreases at a rate of 15
> secs/day. (So I thought that that's why there is that four minute error in
> ps output after uptime of a couple of weeks.) Maybe this has something to do
> with the fact that the 'timer' line in /proc/interrupts does not seem to
> increase at an exact rate of 1000 steps per second but about 1000.18 steps
> per second, instead. (The relative error is the same: 0.18 divided by 1000
> is equal to 15 seconds divided by 24 hours).
> 
> I made an experiment shown below. I know nothing about kernel programming,
> so this is probably not correct, but at least btime seemed to stay constant.
> (I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
> guess ps can't possibly get its calculations involving HZ right. But at
> least the bootup time reported by procinfo stays constant.)


Uh, what does your /etc/ntp/drift file show?

The basic equation is: 
btime ~= gettimeodfay() - uptime

Thus if your time of day is adjusted by NTP, btime will change as well.
Uptime is calculated calculated by jiffies/HZ, and HZ is not NTP
adjusted, so if your system is running 180ppm too fast or slow, btime
would be expected to change. 

I'm not yet sure how that is related to the ps start time being wrong.

thanks
-john

