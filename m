Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUA2UNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUA2UNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:13:19 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:41856 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S266256AbUA2UNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:13:17 -0500
Date: Thu, 29 Jan 2004 22:13:15 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040129201315.GA9814@elektroni.ee.tut.fi>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi> <20040127155254.GA1656@elektroni.ee.tut.fi> <1075342912.1592.72.camel@cog.beaverton.ibm.com> <20040129143847.GA4544@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129143847.GA4544@elektroni.ee.tut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 04:38:47PM +0200, Petri Kaukasoina wrote:
> I'll do an experiment and boot to linux-2.6.1 without ntpd next...

The problem does not seem to be connected to ntpd. btime goes backwards and
ps process start times forwards even without ntp.

I tried both linux-2.6.1 and linux-2.4.24 without ntpd. I read the values of
several variables, waited some time, read them again, and subtracted to
obtain the differences. Results below. The references to ntp time were taken
using 'ntpdate -q', so the clock was running freely and not controlled by
ntp.

Linux-2.6.1 without ntpd:
 passed time according to 'date':               1988.941515 s
 timer interrupts:                              1989244
 interrupts per second:                         1000.152
 error compared to 1000 interrupts per second:  +152 ppm
 (ps times go towards future about 2.1 s in 13479 s of uptime: about 160 ppm)
 (Bootup time 'btime' similarly goes backwards about 2 s in the same time)
 clock too fast compared to ntp time by:        +0.045162 s
 so 'date' is too fast compared to UT by:       +22.7 ppm

Linux-2.4.24 without ntpd:
 passed time according to 'date':               2711.294952 s
 timer interrupts:                              271129
 interrupts per second:                         100.000
 error compared to 100 interrupts per second:   0 ppm
 (ps times stay correct)
 (btime stays constant)
 clock too fast compared to ntp time by:        +0.019216 s
 so 'date' is too fast compared to UT by:       +7.1 ppm


I would like to interpret these numbers so that in linux-2.6.1 the constant
HZ is 152 ppm too large and when procps doesn't know it, it calculates
process start times wrong in ps output. The timeofday somehow is not
affected because time goes only 15.6 ppm faster compared to linux-2.4.24.
 
Thanks,

-Petri
