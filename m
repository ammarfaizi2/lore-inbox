Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVAYHzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVAYHzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVAYHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:55:27 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:3280 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261861AbVAYHw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:52:58 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Christoph Lameter <clameter@sgi.com>
Date: Tue, 25 Jan 2005 08:50:01 +0100
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Message-ID: <41F6083A.26775.13508D2B@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.58.0501241748090.18859@schroedinger.engr.sgi.com>
References: <1106613222.30884.34.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=98396@20050125.074219Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2005 at 17:54, Christoph Lameter wrote:

> On Mon, 24 Jan 2005, john stultz wrote:
> 
> > We talked about this last time. I do intend to re-work ntp_scale() so
> > its not a function call, much as you describe above.
> >
> > hopelessly endeavoring,
> 
> hehe.... But seriously: The easiest approach may be to modify the time
> sources to allow a fine tuning of the scaling factor. That way ntp_scale
> may be moved into tick processing where it would adjust the scaling of the
> time sources up or downward. Thus no ntp_scale in the monotonic clock
> processing anymore.

It depends what you want to have between ticks: If your ticks are too wide, the 
clock will do a little jump forward at the start of a new tick; if they are too 
narrow, the clock will jump back a bit at the start of a new tick (assuming tick 
interpolation and tick generation are correlated. (The old kernel code uses a 
constant to scale the timer's register to a tick. However if the time is too fast 
or slow, the interpolation will also be). Those being blessed with a GPS or better 
clock will be able to demonstrate the quality of the code as well as the tuning 
possibilities against frequency errors.

> 
> Monotonic clocks could be calculated
> 
> monotime = ns_at_last_tick + (time_source_cycles_since_tick *
> current_scaling_factor) >> shift_factor.
> 
> This would also be easy to implement in asm if necessary.
> 
> tick processing could then increment or decrement the current scaling
> factor to minimize the error between ticks. It could also add
> nanoseconds to ns_at_last_tick to correct the clock forward.

Is that what corresponds to "adjust_nanoscale()" in my PPSkit?

> 
> With the appropiate shift_factor one should be able to fine tune time much
> more accurately than ntp_scale would do. Over time the necessary
> corrections could be minimized to just adding a few ns once in a while.
> 

Regards,
Ulrich

