Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269158AbUIBWzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269158AbUIBWzD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUIBWw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:52:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53959 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269185AbUIBWsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:48:46 -0400
Date: Thu, 2 Sep 2004 15:47:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
In-Reply-To: <1094163757.14662.339.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409021544590.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021458140.28532@schroedinger.engr.sgi.com>
 <1094163757.14662.339.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> On Thu, 2004-09-02 at 15:09, Christoph Lameter wrote:
> > > timeofday_hook()
> > > 	now = read();			/* read the timesource */
> > > 	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
> > > 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> > > 	system_time += ntp_ns;		/* add scaled value to system_time */
> > > 	ntp_advance(ns);		/* advance ntp state machine by ns */
> > > 	offset_base = now;		/* set new offset_base */
> >
> > This would only work if the precision of the timer used is
> > <=1ns and if you are actually able to caculate the nanoseconds that have
> > passed. What do you do if the interval is lets say 100ns and the time the
> > timeofday hook is being called can be anytime within this 100ns interval
> > since the time source is not always precise?
>
> Well, with the exception of the TSC, none of the current time sources
> have <=1ns resolution, but I'm not sure I understand the problem you're
> trying to point out. Could you clarify?
>
> > I think its unavoidable to do some correction like provided by the time
> > interpolator if the clock source does not provide ns.
>
> Could you point to the specific correction you describe?

I drop my objections. I was thinking too much in terms of the old code....
This should work fine.
