Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVAYM3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVAYM3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVAYM3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:29:51 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:34770 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261916AbVAYM3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:29:49 -0500
Date: Tue, 25 Jan 2005 13:25:15 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Christoph Lameter <clameter@sgi.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
In-Reply-To: <Pine.LNX.4.58.0501241748090.18859@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.53.0501251315530.28866@gockel.physik3.uni-rostock.de>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com> 
 <1106611416.30884.22.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501241606240.17986@schroedinger.engr.sgi.com>
 <1106613222.30884.34.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0501241748090.18859@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I'd think that adding nanoseconds to ns_at_last_tick is not a good idea.
It might minimize the error shortly after the tick, but not the total 
error average over the whole tick period. And it introduces clock jumps.
Tiny, but unnecessary.

Just as you say,

> With the appropiate shift_factor one should be able to fine tune time much
> more accurately than ntp_scale would do. Over time the necessary
> corrections could be minimized to just adding a few ns once in a while.

finetuning the scaling factor should be enough.

Tim
