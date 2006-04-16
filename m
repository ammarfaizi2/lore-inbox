Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWDPIcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDPIcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 04:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDPIcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 04:32:53 -0400
Received: from dial169-143.awalnet.net ([213.184.169.143]:40199 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751085AbWDPIcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 04:32:53 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 11:31:02 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604121825.55054.a1426z@gawab.com> <200604161602.22177.kernel@kolivas.org>
In-Reply-To: <200604161602.22177.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604161131.02585.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thursday 13 April 2006 01:25, Al Boldi wrote:
> > Con Kolivas wrote:
> > > mean 68.7 seconds
> > >
> > > range 63-73 seconds.
> >
> > Could this 10s skew be improved to around 1s to aid smoothness?
>
> It turns out to be dependant on accounting of system time which only
> staircase does at the moment btw. Currently it's done on a jiffy basis. To
> increase the accuracy of this would incur incredible cost which I don't
> consider worth it.

Is this also related to that?

> > Much smoother, but I still get this choke w/ 2 eatm 9999 loops running:
> >
> > 9 MB 783 KB eaten in 130 msec (74 MB/s)
> > 9 MB 783 KB eaten in 2416 msec (3 MB/s)		<<<<<<<<<<<<<
> > 9 MB 783 KB eaten in 197 msec (48 MB/s)
> >
> > You may have to adjust the kb to get the same effect.
>
> I've seen it. It's an artefact of timekeeping that it takes an
> accumulation of data to get all the information. Not much I can do about
> it except to have timeslices so small that they thrash the crap out of cpu
> caches and completely destroy throughput.

So why is this not visible in other schedulers?

Are you sure this is not a priority boost problem?

> The current value, 6ms at 1000HZ, is chosen because it's the largest value
> that can schedule a task in less than normal human perceptible range when
> two competing heavily cpu bound tasks are the same priority. At 250HZ it
> works out to 7.5ms and 10ms at 100HZ. Ironically in my experimenting I
> found the cpu cache improvements become much less significant above 7ms so
> I'm very happy with this compromise.

Would you think this is dependent on cache-size and cpu-speed?

Also, what's this iso_cpu thing?

> Thanks!

Thank you!

--
Al

