Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUIFGK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUIFGK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIFGK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:10:26 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:1937 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S266578AbUIFGKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:10:21 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Albert Cahalan <albert@users.sourceforge.net>
Date: Mon, 06 Sep 2004 08:08:50 +0200
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
CC: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-ID: <413C1B13.27464.157279@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1094224071.431.7758.camel@cube>
References: <413850B9.15119.BA95FD@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93227@20040906.060317Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2004 at 11:07, Albert Cahalan wrote:

> On Fri, 2004-09-03 at 05:08, Ulrich Windl wrote:
> > On 3 Sep 2004 at 2:42, Albert Cahalan wrote:
> 
> > > HZ not being HZ is the source of many foul problems.
> > > 
> > > NTP should be able to correct for the error. For systems
> > > not running NTP, provide a fake NTP to make corrections
> > > based on the expected frequency error.
> > > 
> > > Based on that, skip or double-up on the ticks to make
> > > them be exactly HZ over long periods of time.
> > 
> > I think nobody wants a sawtooth-like timing. Time should
> > proceed as smoothly as possible.
> 
> Of course, and all hardware should have ideal clocks.
> Now, back to the real world...

Albert,

I am serious.

> 
> The kernel is broken if:
> 
> a. HZ is not really HZ

HZ is an integer however.

> b. Timekeeping is via 2 unrelated clocks. (jiffies+offset)

What do you do if one clock lacks resolution, and the other clock lacks digits? 
The interrupt clock may suck, but the TSC sucks even more.

> c. HZ is not an integer

HZ is HZ, but the true interrupt frequency is something completely different.

> 
> So on box using only clock ticks, steer jiffies
> toward HZ using NTP (or default frequency error value).

Are you saying you are happy with a lcok that less than 1 HZ off? That would be -- 
in a extreme case -- about 86000 seconds off per day.

> On a box with high-res time, use that instead, and make
> jiffies follow it to satisfy various kernel-internal
> uses of jiffies.

Make jiffies follow variable CPU clock? Are you serious?

> 
> Look, if HZ won't be HZ then you can just remove
> the "HZ" define from the kernel. It's useless.

It's not useless, it's a historic standard.

> 
> I think we're all sick of the recent time-related
> bugs. I could go for ripping out all the fancy and

Yes.

> broken stuff that was added recently, replacing it
> with the simple Linux 2.4.xx or 2.2.xx code. Swiping

It depends on what you want. The kernel really needs a working framework for 
nanoseconds; at least regarding the variables' precision.

> code from DragonflyBSD would be worth investigating.
> 
> 
> 

Regards,
Ulrich



