Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVHQHlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVHQHlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHQHlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:41:12 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:13989 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750946AbVHQHlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:41:11 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Wed, 17 Aug 2005 09:40:37 +0200
MIME-Version: 1.0
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <43030614.30883.58B75E3@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1124241449.8630.137.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.61.0508162337130.3728@scrub.home>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=107623@20050817.073300Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2005 at 18:17, john stultz wrote:

[...]
> Maybe to focus this productively, I'll try to step back and outline the
> goals at a high level and you can address those. 
> 
> My Assumptions:
> 1. adjtimex() sets/gets NTP state values

One of the greatest mistakes in the past which still affects us now was the 
decision to piggy-back ntp_adjtime and ntp_gettime on top of adjtime() and thus 
creating adjtimex(). Only to save a system-call number or two. WE REALLY SHOULD 
GET RID OF THAT going back to Linux 0.something.

> 2. Every tick we adjust those state values

... which require it. 

> 3. Every tick we use those values to make a nanosecond adjustment to
> time.

...or even more frequent. In my code I tried to scale the tick interpolation as 
well, thus effectively making adjustments even within timer ticks (so far the 
theory...). I was assuming however that ticks and interpolation clocks are derived 
from one single source and would "float" the same way relative to each other.

> 4. Those state values are otherwise unused.

What is "otherwise"? Outside the "NTP clock model", or "between ticks"?

> 
> Goals:
> 1. Isolate NTP code to clean up the tick based timekeeping, reducing the
> spaghetti-like code interactions.

First you need a new clock model that's compatible with NTP. Then you can consider 
how to implement the NTP stuff. So the clock even without NTP has to be strictly 
monotonic for any interval it is read, be it nanoseconds, microseconds, 
milliseconds, seconds, minutes, hours, days, ... The clock delta (=increase of 
time) over time should be as constant as possible (i.e. time shouldn't go up like 
stairs).

> 2. Add interfaces to allow for continuous, rather then tick based,
> adjustments (much how ppc64 does currently, only shareable).

Adjustments to the clock _model_ are asynchronous by definition, while adjustments 
to the clock itself are, well, periodic. Whatever the period.

Maybe this helps and can be agreed on.

Regards,
Ulrich

