Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVJDH7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVJDH7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVJDH7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:59:48 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:45449 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S964784AbVJDH7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:59:47 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Tue, 04 Oct 2005 09:58:54 +0200
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Message-ID: <4342525D.31706.708950@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0509271809460.3728@scrub.home>
References: <1127419198.8195.10.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=108591@20051004.075630Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2005 at 18:37, Roman Zippel wrote:

> Hi,
> 
> On Thu, 22 Sep 2005, john stultz wrote:
> 
> > +
> > +	/* calculate the total continuous ppm adjustment */
> > +	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
> > +	total_sppm += offset_adj_ppm << SHIFT_USEC;
> > +	total_sppm += tick_adj_ppm << SHIFT_USEC;
> > +	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
> >  }
> 
> I'm not sure, why you still need this.
> As I already said, I don't think you need to change the kernel NTP model. 
> This means in particular that the NTP time is still incremented in fixed 
> intervals (although it's not necessary to do it at HZ frequency).
> I showed you how to do most of the calculation, so I'm a little confused, 
> why the above is still used.

Hi all!

As playing with "tick" is considered obsolete by the NTP people, frequency errors 
up to 500 PPM are corrected by the NTP kernel code. Thus, to provide continuous 
time, you might be interested in adjusting tick interpolation (i.e. _use_ the 
adjusted value whenever the clock is read).

Ulrich

> 
> In general I would prefer to see the introduction of the timesource 
> abstraction, which will first replace the arch callbacks do_gettimeofday/ 
> do_settimeofday.
> 
> bye, Roman


