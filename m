Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbULHUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbULHUPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULHUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:15:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32171 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261341AbULHUPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:15:30 -0500
Date: Wed, 8 Dec 2004 12:14:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102535891.1281.148.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com> 
 <1102533066.1281.81.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
 <1102535891.1281.148.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, john stultz wrote:

> > With the improved scaling factor one should be able to come very close to
> > ntp scaled time without invoking ntp_scale itself. Tick processing will
> > then update time to be ntp scaled by fine tuning the scaling factor (with
> > the bit shifting we can get very fine tuning) and eventually skip a few
> > nanoseconds. Its basically some piece of interpolator logic in there so
> > that the heavyweight calculations can just be done once in a while.
>
> No. I agree ntp_scale() is a performance concern. However I'm not sure
> how your suggestion of just slowing or tweaking the timesource
> mult/shift frequency values will allow us to implement the expected
> behavior of adjtimex().  We need to be able to implement the following
> adjustments within a single tick:
>
> 1. Adjust the frequency by 500ppm for 10usecs
> 2. After that adjust the frequency by 30ppm for the rest of the tick.

Frequency adjustments just means an adjustment of the scaling factor.
Am I missing something?

> We can see how much of this can be fudged or generalized, but I'm
> hesitant to be too flippant about changing the NTP behavior for fear
> that the astronomers who so dearly care about leap seconds and minute
> time adjustments will "forget" to mention the asteroid heading towards
> my home. :)

I am not sure what NTP behavior needs to be fudged. Sorry about my limited
NTP knowledge. Could you elaborate on what the problem is?
>
> I may have asked this before, but w/ 32 bit mult and shifts, how
> granular can these adjustments be?

Yes. 128bit would be great for this. 64bit is fine though as
far as I can see and allows granularity up to fractions of
nanoseconds if applied between 1ms intervals.

> Also additional complications arise when we have multiple things (like
> cpufreq) playing with the timesource frequency values as well.

I think these could all be taken into account by a scaling factor off a
certain base established at a tick-like event that does the ntp scaling.
The scaling between tick-like event needs to be just a scaling factor for
performance reasons.


