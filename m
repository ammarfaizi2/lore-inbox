Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJHRyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJHRyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:54:15 -0400
Received: from ltgp.iram.es ([150.214.224.138]:15757 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261601AbTJHRyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:54:08 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 8 Oct 2003 19:50:59 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031008175059.GA31743@iram.es>
References: <1065619951.25818.15.camel@gaston> <20031008154846.GA29868@iram.es> <1065630178.26943.54.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065630178.26943.54.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 06:22:58PM +0200, Benjamin Herrenschmidt wrote:
> 
> > Well, it it affects gettimeofday which has a precision of 1 part in
> > 10000 (100 ppm), it means that our boot time timebase calibration was
> > not very good to start with, on my set of running VME machines I have
> > the following (values in ppm):
> >
> > ../..
> 
> Boot time calibration can't be perfect... 

No, indeed.

> I depends very much on the quality of what your are calibrating against, 
> and the bus path to it.

At the time you it is performed, most devices should not be active
(no long DMA bursts) so the variations should be rather small.
Another solution is to increase the measurement period. I have to 
use one second on some machines because I don't have anything else
reliable (only the RTC which changes every second and its interrupt
pin is not routed), even a 1 to 2 second delay does not significantly
affect boot times.

> 
> On most pmacs, I'm calibrating either against a VIA timer which isn't
> _that_ good or on OF value (which are themselves calibrated, I think,
> against the KeyLargo timer).

On the Macs I have around here, the ntp drift values are:
- on a PB G3/400: +8ppm
- on a PM G4/466: -6ppm

that's not _that_ bad (I believe these come from OF). 

10 ppm of a 10ms jiffy is 0.1 microseconds. Increasing HZ can only 
improve this figure, although it is stupid to run the correction loop 
that often IMNSHO.

I repeat the question: what are the values of drift on the machines
that encounter the problem ? Is this drift stable or unstable? 

> 
> On all cases, those will drift some way from what the NTP server will
> give, either a lot or not, it will. So we may end up adjusting our
> kernel rate and thus opening a window for the problem.

The worst variations of drift I've seen are a few ppm for a given
machine, barring the occasional boot-time calibration problems that
I have encountered.

	Gabriel
