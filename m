Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTF1SId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTF1SId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 14:08:33 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:55566 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265325AbTF1SIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 14:08:31 -0400
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Martin Schlemmer <azarah@gentoo.org>,
       Roberto Orenstein <rstein@brturbo.com>
In-Reply-To: <200306290230.40059.kernel@kolivas.org>
References: <200306281516.12975.kernel@kolivas.org>
	 <200306290230.40059.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056824563.597.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 28 Jun 2003 20:22:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 18:30, Con Kolivas wrote:
> On Sat, 28 Jun 2003 15:16, Con Kolivas wrote:
> > For my sins I've included what I thought was necessary for this patch.
> >
> > The interactivity for tasks is based on the sleep avg accumulated divided
> > by the running time of the task. However since the accumulated time is not
> > linear with time it now works on the premise that running time is an
> > exponential function entirely. Pat Erley was the genius who implemented
> > this simple exponential function in surprisingly low overhead integer
> > maths.
> >
> > Also added was some jiffy wrap logic (as if anyone would still be running
> > my patch in 50 days :P).
> >
> > Long sleepers were reclassified as idle according to the new exponential
> > logic.
> >
> > If you test, please note this works better at 1000Hz.
> >
> > Attached also is my bastardised version of Ingo's timeslice granularity
> > patch. This round robins tasks on the active array every 10ms, which
> > _might_ be detrimental in throughput applications but has not been
> > benchmarked. However for desktops it does wonders to smoothing out the
> > jerkiness of X and I highly recommend using this in combination with the
> > O1int patch.
> >
> > This is very close to all the logic I wanted to implement. It might need
> > more tuning... Note parent penalty, child penalty and exit weight
> > (uppercase) no longer do anything.
> >
> > Please test and comment.
> >
> > Con
> >
> > P.S. In the words of Zwane - there is always a corner case. Corner case I
> > think I still need to tackle is the application that spins madly waiting
> > for it's child to start, and in the process it is the parent that is
> > starving the child by being higher priority than it. This seems to be a
> > coding style anomaly brought out by the scheduler.
> 
> And just for good measure here is the latest with a slight addition that helps 
> X smoothness over time. It gives the sleep_avg a little headroom so it 
> doesn't drop from interactive as easily with bursts of cpu activity.

OK, now testing this one :-)
2.5.73-mm2 + latest patch-O1int + patch-granularity + 1000HZ...
Feels a little bit better than the previous one. X under load is
smoother. This is starting to get interesting ;-)

